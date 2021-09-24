首先定义了一个  license cert 作为基础的cert

拿到它的公钥 publicKey,

拿到公钥的算法 pubKeyAlg

计算HashAlg

根据HashAlg和pubKeyAlg 组装 signAlg

signature.initVerify    根据公钥执行初始化验签操作

从用户的license中解析出签名原文 plainTxt

对plainTxt执行update操作，貌似是得到了一个签名结果，跟license中的签名结果进行对比，验证签名结果的有效性



```java
 private JSONObject verifyLicense(String b64License) throws CertApiException {
        byte[] plaintext = null;
        byte[] data = TCAUtil.decode(b64License);
        ASN1ObjectIdentifier pkcs7Type = null;
        CMSSignedData cmsSignedData = null;
        ASN1Sequence seq = ASN1Sequence.getInstance(data);
        ASN1ObjectIdentifier contentType = (ASN1ObjectIdentifier)seq.getObjectAt(0);
        if (!contentType.equals(CMSObjectIdentifiers.signedData) && !contentType.equals(CMSObjectIdentifiers.gm_signedData)) {
            throw new CertApiException(TCAErrCode.ERR_CONTENTTYPE);
        } else {
            pkcs7Type = PKCSObjectIdentifiers.signedData;

            try {
                cmsSignedData = new CMSSignedData(data);
            } catch (CMSException var26) {
                throw new CertApiException(TCAErrCode.ERR_CMS_BADSIGN, var26);
            }

            if (cmsSignedData.getSignedContent() == null) {
                throw new CertApiException(TCAErrCode.ERR_PKCS7_VERIFY_NOPLAIN);
            } else {
                //签名原文
                byte[] plaintext = (byte[])((byte[])cmsSignedData.getSignedContent().getContent());
                //签名证书信息
                ArrayList signerInfoList = (ArrayList)cmsSignedData.getSignerInfos().getSigners();
                if (signerInfoList.size() == 0) {
                    throw new CertApiException(TCAErrCode.ERR_PKCS7_NOSIGNER);
                } else {
                    //特定公钥证书
                    X509Certificate cert = TCAUtil.convB64Str2Cert(licCert);
                    PublicKey pubKey = cert.getPublicKey();

                    for(int i = 0; i < signerInfoList.size(); ++i) {
                        SignerInformation signerInfo = (SignerInformation)signerInfoList.get(i);
                        String pubKeyAlg = pubKey.getAlgorithm().equalsIgnoreCase("SM2") ? "SM2" : "RSA";
                        String hashAlg;
                        if (signerInfo.getDigestAlgOID().equals(AlgorithmId.SM3_oid.toString())) {
                            hashAlg = "SM3";
                        } else if (signerInfo.getDigestAlgOID().equals(AlgorithmId.SHA_oid.toString())) {
                            hashAlg = "SHA1";
                        } else {
                            if (!signerInfo.getDigestAlgOID().equals(AlgorithmId.SHA256_oid.toString())) {
                                throw new CertApiException(TCAErrCode.ERR_INVALID_ALGPARAMET);
                            }

                            hashAlg = "SHA256";
                        }

                        String signAlg = hashAlg + "With" + pubKeyAlg;

                        Signature sig;
                        try {
                            if (pubKeyAlg.equalsIgnoreCase("SM2")) {
                                sig = Signature.getInstance(signAlg, TCAUtil.getSm2Provider());
                            } else {
                                sig = Signature.getInstance(signAlg, TCAUtil.getBcProvider());
                            }
							//根据公钥证书初始化验签对象
                            sig.initVerify(pubKey);
                        } catch (NoSuchAlgorithmException var24) {
                            throw new CertApiException(TCAErrCode.ERR_UNKNOWN_ALG, var24);
                        } catch (InvalidKeyException var25) {
                            throw new CertApiException(TCAErrCode.ERR_INVALID_KEY, var25);
                        }

                        byte[] verifyPlain = plaintext;
                        if (signerInfo.getSignedAttributes() != null) {
                            AttributeTable authAttrs = signerInfo.getSignedAttributes();
                            if (authAttrs.size() != 3) {
                                throw new CertApiException(TCAErrCode.ERR_PKCS7_ATTR_ERR);
                            }

                            if (authAttrs.get(CMSAttributes.contentType) == null) {
                                throw new CertApiException(TCAErrCode.ERR_PKCS7_NOFOUND_CT);
                            }

                            if (authAttrs.get(CMSAttributes.signingTime) == null) {
                                throw new CertApiException(TCAErrCode.ERR_PKCS7_NOFOUND_ST);
                            }

                            if (authAttrs.get(CMSAttributes.messageDigest) == null) {
                                throw new CertApiException(TCAErrCode.ERR_PKCS7_NOFOUND_MD);
                            }

                            DEROctetString octString = (DEROctetString)signerInfo.getSignedAttributes().get(CMSAttributes.messageDigest).getAttrValues().getObjectAt(0);
                            byte[] messageDigest = octString.getOctets();
                            authAttrs.get(CMSAttributes.messageDigest).getAttrValues().getObjectAt(0).getDERObject().toASN1Object();
                            byte[] plainHash;
                            if (hashAlg.equalsIgnoreCase("SM3")) {
                                plainHash = TCAUtil.SM3(plaintext);
                            } else if (hashAlg.equalsIgnoreCase("SHA1")) {
                                plainHash = TCAUtil.SHA1(plaintext);
                            } else {
                                if (!hashAlg.equalsIgnoreCase("SHA256")) {
                                    throw new CertApiException(TCAErrCode.ERR_INVALID_ALGPARAMET);
                                }

                                plainHash = TCAUtil.SHA256(plaintext);
                            }

                            if (!Arrays.equals(messageDigest, plainHash)) {
                                throw new CertApiException(TCAErrCode.ERR_PKCS7_MD_VERIFY);
                            }

                            try {
                                verifyPlain = signerInfo.getEncodedSignedAttributes();
                            } catch (IOException var23) {
                                throw new CertApiException(TCAErrCode.ERR_STREAM, var23);
                            }
                        }

                        try {
                            //对数据进行验签操作
                            sig.update(verifyPlain);
                            if (sig.verify(signerInfo.getSignature())) {
                                return new JSONObject(new String(plaintext, "UTF-8"));
                            }
                        } catch (SignatureException var27) {
                            throw new CertApiException(TCAErrCode.ERR_PKCS7_VERIFY_FAILD, var27);
                        } catch (JSONException var28) {
                            throw new CertApiException(TCAErrCode.ERR_JSON_PARSING, var28);
                        } catch (UnsupportedEncodingException var29) {
                            throw new CertApiException(TCAErrCode.ERR_ENCODE, var29);
                        }
                    }

                    return null;
                }
            }
        }
    }

```



