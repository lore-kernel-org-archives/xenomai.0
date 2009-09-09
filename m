From: Andreas Glatz <andreasglatz@domain.hid>
Content-Type: multipart/mixed; boundary="=-nk/ESpEs/pT1bXNBOXA/"
Date: Wed, 09 Sep 2009 17:48:40 -0400
Message-Id: <1252532920.10115.9.camel@domain.hid>
Mime-Version: 1.0
Subject: [Xenomai-core] nucleus/pipe.c patch: check for lingering close at
	xnpipe_connect()
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org


--=-nk/ESpEs/pT1bXNBOXA/
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,

Currently, you can destroy RT_PIPE while a non-rt application is
connected. If that happens the pipe won't be fully closed but
some parts will be leftover for cleanup when closing the RT_PIPE
from the non-rt application (lingering close).

For us it would be very convenient if we didn't have to close
the non-rt side before restarting the rt-side (currently, the 
rt-side complains bc the non-rt side didn't resolve the lingering
close).

Here is a patch where the rt-side resolves the lingering close
when connecting to the RT_PIPE. I tested it and it seems to work 
fine. Do you have any concerns?

Andreas



--=-nk/ESpEs/pT1bXNBOXA/
Content-Disposition: attachment; filename=lclose.patch
Content-Type: text/x-patch; name=lclose.patch; charset=UTF-8
Content-Transfer-Encoding: base64

LS0tIHBpcGUub3JpZy5jCTIwMDktMDktMDkgMTc6MjM6MTAuMDAwMDAwMDAwIC0wNDAwDQorKysg
cGlwZS5jCTIwMDktMDktMDkgMTc6MzI6NDguMDAwMDAwMDAwIC0wNDAwDQpAQCAtMzA5LDE3ICsz
MDksMzUgQEANCiBpbnQgeG5waXBlX2Nvbm5lY3QoaW50IG1pbm9yLCBzdHJ1Y3QgeG5waXBlX29w
ZXJhdGlvbnMgKm9wcywgdm9pZCAqeHN0YXRlKQ0KIHsNCiAJc3RydWN0IHhucGlwZV9zdGF0ZSAq
c3RhdGU7DQotCWludCBuZWVkX3NjaGVkID0gMCwgcmV0Ow0KKwlpbnQgbmVlZF9zY2hlZCA9IDAs
IHRlc3RfbGNsb3NlID0gMCwgcmV0Ow0KIAlzcGxfdCBzOw0KIA0KLQltaW5vciA9IHhucGlwZV9t
aW5vcl9hbGxvYyhtaW5vcik7DQotCWlmIChtaW5vciA8IDApDQorCXJldCA9IHhucGlwZV9taW5v
cl9hbGxvYyhtaW5vcik7DQorCWlmIChyZXQgPj0gMCkNCisJCW1pbm9yID0gcmV0Ow0KKwllbHNl
IA0KKwlpZihyZXQgPT0gLUVCVVNZKQ0KKwkJdGVzdF9sY2xvc2UgPSAxOw0KKwllbHNlIA0KIAkJ
cmV0dXJuIG1pbm9yOw0KIA0KIAlzdGF0ZSA9ICZ4bnBpcGVfc3RhdGVzW21pbm9yXTsNCiANCiAJ
eG5sb2NrX2dldF9pcnFzYXZlKCZua2xvY2ssIHMpOw0KIA0KKwlpZih0ZXN0X2xjbG9zZSkgew0K
KwkJaWYodGVzdGJpdHMoc3RhdGUtPnN0YXR1cywgWE5QSVBFX0tFUk5fTENMT1NFKSkgew0KKwkJ
CWNscmJpdHMoc3RhdGUtPnN0YXR1cywgWE5QSVBFX0tFUk5fTENMT1NFKTsNCisJCQl4bmxvY2tf
cHV0X2lycXJlc3RvcmUoJm5rbG9jaywgcyk7DQorCQkJc3RhdGUtPm9wcy5yZWxlYXNlKHN0YXRl
LT54c3RhdGUpOw0KKwkJfSBlbHNlIHsNCisJCQl4bmxvY2tfcHV0X2lycXJlc3RvcmUoJm5rbG9j
aywgcyk7DQorCQkJcmV0dXJuIC1FQlVTWTsNCisJCX0NCisJfQ0KKwkJCQ0KKwl4bmxvY2tfZ2V0
X2lycXNhdmUoJm5rbG9jaywgcyk7DQorDQogCXJldCA9IHhucGlwZV9zZXRfb3BzKHN0YXRlLCBv
cHMpOw0KIAlpZiAocmV0KSB7DQogCQl4bmxvY2tfcHV0X2lycXJlc3RvcmUoJm5rbG9jaywgcyk7
DQo=


--=-nk/ESpEs/pT1bXNBOXA/--

