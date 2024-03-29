$.fn.bMap = function (h) {
    h = $.extend({
        name: "map"
    }, h);
    var j = $(this),
        b = h.name,
        p, m = 116.331398,
        l = 39.897445,
        q, a, n = $("<div class='map-warp' id='Map_" + b + "'></div>"),
        o = $("<input type='text' style='min-width: 100%;' class='form-control' placeholder='详细地址' name='" + b + "' id='Map_input_" + b + "'/>"),
        g = $("<input type='hidden' name='location_" + b + "' id='Map_location_" + b + "'/>"),
        f = $('<svg t="1495288306982" class="icon" style="position: absolute;right:5px;top:50%;margin-top: -10px;" viewBox="0 0 1000 1000" version="1.1" xmlns="http://www.w3.org/2000/svg" p-id="2378" xmlns:xlink="http://www.w3.org/1999/xlink" width="20" height="20"><defs><style type="text/css"></style></defs><path d="M883.3663 412.6822c0-203.9497-165.3527-369.3186-369.3347-369.3186-203.9811 0-369.3337 165.3679-369.3337 369.3186 0 114.989 52.5405 217.6864 134.9211 285.4175l190.8474 200.2232c9.8307 13.246 25.5877 21.8352 43.3424 21.8352 16.3706 0 31.0232-7.2981 40.9139-18.8023h0.006995543838574828l200.5313-208.9993c17.6088-15.1997 33.7645-32.0373 48.2363-50.2719l8.1298-8.4733h-1.5949839951950608C856.0917 572.0042 883.3663 495.532 883.3663 412.6822zM513.9646 596.0299c-112.971 0-204.5377-91.5619-204.5377-204.5073 0-112.9674 91.5667-204.5293 204.5377-204.5293 112.9501 0 204.5157 91.5629 204.5157 204.5293C718.4813 504.468 626.9157 596.0299 513.9646 596.0299z" p-id="2379" fill="#666666"></path></svg>');
    j.append(o).append(g).append(n).append(f);
    if (h.location || h.address) {
        if (h.location) {
            p = new BMap.Point(h.location[0], h.location[1]);
            m = h.location[0];
            l = h.location[1];
            g.val(m + "," + l);
            if (!h.address) {
                c(p, null, false)
            } else {
                o.val(h.address)
            }
        } else {
            o.val(h.address);
            var i = new BMap.Geocoder();
            i.getPoint(h.address, function (r) {
                p = r;
                m = r.lng;
                l = r.lat;
                g.val(m + "," + l)
            })
        }
    } else {
        var k = new BMap.Geolocation();
        k.getCurrentPosition(function (t) {
            if (this.getStatus() == BMAP_STATUS_SUCCESS) {
                var s = new BMap.Marker(t.point);
                p = t.point;
                m = t.point.lng;
                l = t.point.lat
            }
        }, {
            enableHighAccuracy: true
        })
    }
    o.focus(function (r) {
        n.show().css("zIndex", 999);
        d()
    });
    o.blur(function (r) {
        n.hide().css("zIndex", 0)
    });
    f.focus(function (r) {
        n.show().css("zIndex", 999);
        d()
    });
    f.blur(function (r) {
        n.hide().css("zIndex", 0)
    });

    function d() {
        if (a) {
            return false
        }
        a = new BMap.Map("Map_" + b, {
            enableMapClick: false
        });
        a.centerAndZoom(new BMap.Point(m, l), 15);
        a.enableScrollWheelZoom();
        a.enableContinuousZoom();
        e(p);
        a.addEventListener("click", function (s) {
            e(s.point);
            c(s.point)
        });
        var r = o.val();
        q = new BMap.Autocomplete({
            input: "Map_input_" + b,
            location: a
        });
        q.setInputValue(r);
        q.addEventListener("onconfirm", function (v) {
            var t = v.item.value;
            if(t.province != t.city){
                myValue = t.province + t.city + t.district + t.street + t.business;
            }else{
                myValue = t.city + t.district + t.street + t.business;
            }
            function s() {
                var w = u.getResults().getPoi(0).point;
                a.centerAndZoom(w, 15);
                c(w, t);
                e(w)
            }
            var u = new BMap.LocalSearch(a, {
                onSearchComplete: s
            });
            u.search(myValue)
        })
    }

    function c(r, s, u) {
        var t = new BMap.Geocoder();
        g.val(r.lng + "," + r.lat);
        t.getLocation(r, function (v) {
            var w = v.addressComponents;
            if (s) {
                w = $.extend(s, w)
            }
            w.business = w.business ? w.business : "";
            if (q) {
                if(w.province != w.city) {
                    q.setInputValue(w.province + w.city + w.district + w.street + w.streetNumber + w.business)
                }else{
                    q.setInputValue(w.city + w.district + w.street + w.streetNumber + w.business)
                }
            } else {
                t.getLocation(r, function (x) {
                    o.val(x.address)
                })
            } if (h.callback && !u) {
                h.callback(w, r)
            }
        })
    }

    function e(r) {
        a.clearOverlays();
        var s = new BMap.Marker(r);
        a.addOverlay(s);
        s.enableDragging();
        s.addEventListener("dragend", function (t) {
            c(t.point)
        })
    }
};