MIME-Version: 1.0
Date: Tue, 26 Jan 2010 15:16:10 +0100
Message-ID: <b88603c31001260616wf2194d3t193de281af1318ad@domain.hid>
From: Henri Roosen <henriroosen@domain.hid>
Content-Type: multipart/mixed; boundary=0016e6d783728286aa047e11ed22
Subject: [Xenomai-help] Xenomai 2.5.0: rt_task_shadow fails when libnative
	is statically linked.
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

--0016e6d783728286aa047e11ed22
Content-Type: text/plain; charset=ISO-8859-1

Hi all,

I get segmentation fault when calling rt_task_shadow. Actually
somewhere in the pthread library called from sigshadow_install_once();

This only happens on Xenomai 2.5 when libnative is statically linked.
Tested ok on 2.4.10 both dynamically and statically linked. I use
kernel version 2.6.30.10, xenomai 2.5.0 on x86.

Any idea what is wrong?

Reproduced it with basic app that is attached to this email. Compiled with:
gcc -D_GNU_SOURCE -D_REENTRANT -Wall -pipe -D__XENO__
-I/usr/xenomai/include tst_basic.c -o tst_basic
/usr/xenomai/lib/libnative.a -lpthread

Segfailt in dmesg on xenomai 2.5.0:
tst_basic_2.5[1351]: segfault at 0 ip b7ff5a54 sp bfc9b46c error 4 in
libpthread-2.9.so[b7feb000+13000]

--0016e6d783728286aa047e11ed22
Content-Type: text/x-csrc; charset=US-ASCII; name="tst_basic.c"
Content-Disposition: attachment; filename="tst_basic.c"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g4wru6wv0

I2luY2x1ZGUgPHN0ZGxpYi5oPgojaW5jbHVkZSA8c3RkaW8uaD4KI2luY2x1ZGUgPHN5cy9tbWFu
Lmg+CiNpbmNsdWRlIDxuYXRpdmUvdGFzay5oPgoKc3RhdGljIFJUX1RBU0sgcnRfdGFza19kZXNj
OwoKaW50IG1haW4odm9pZCkKewoJaW50IHJldDsKCglyZXQgPSBtbG9ja2FsbChNQ0xfQ1VSUkVO
VCB8IE1DTF9GVVRVUkUpOwoJaWYgKHJldCkgewoJCWZwcmludGYoc3RkZXJyLCAibWxvY2thbGwg
ZmFpbGVkICVkIiwgcmV0KTsKCQlleGl0KDEpOwoJfQoKCXJldCA9IHJ0X3Rhc2tfc2hhZG93KCZy
dF90YXNrX2Rlc2MsICJNQUlOIiwgOTksIDApOwoJaWYgKHJldCkgewoJCWZwcmludGYoc3RkZXJy
LCAicnRfdGFza19zaGFkb3cgZmFpbGVkICVkIiwgcmV0KTsKCQlleGl0KDEpOwoJfQoKCXdoaWxl
ICgxKQoJCXJ0X3Rhc2tfc2xlZXAoMTAwMDAwMDBMTCk7CgoJcmV0dXJuIDA7Cn0KCg==
--0016e6d783728286aa047e11ed22--

