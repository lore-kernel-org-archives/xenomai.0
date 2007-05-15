Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C796E5.92898183"
Date: Tue, 15 May 2007 11:38:34 -0000
Message-ID: <DD39B5C3F4963040ADC9768BE7E430CB01EB2004@domain.hid>
From: "Daniel Schnell" <daniel.schnell@domain.hid>
Subject: [Xenomai-help] memcpy performance on Xenomai
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

This is a multi-part message in MIME format.

------_=_NextPart_001_01C796E5.92898183
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,
=20
=20
I am testing the memcpy() performance of Xenomai on my board in
comparision to the memcpy() performance of native linux and I get
significant differences.

Attached find a program which compiles on native linux simply with
(-lrt).
It gives me the following output:

=3D=3D=3D=3D=3D=3D=3D
bash-2.05b# ./memcpy_perf
Test (10000) memcpy of sizes (1024) ....
10000 memcpy. Time per memcpy: 1567 [nsec] (653 MB/sec)
 finished.
Test (10000) memcpy of sizes (2048) ....
10000 memcpy. Time per memcpy: 2939 [nsec] (696 MB/sec)
 finished.
Test (10000) memcpy of sizes (4096) ....
10000 memcpy. Time per memcpy: 5706 [nsec] (717 MB/sec)
 finished.
Test (10000) memcpy of sizes (8192) ....
10000 memcpy. Time per memcpy: 17077 [nsec] (479 MB/sec)
 finished.
Test (10000) memcpy of sizes (16384) ....
10000 memcpy. Time per memcpy: 133314 [nsec] (122 MB/sec)
 finished.
Test (1000) memcpy of sizes (32768) ....
1000 memcpy. Time per memcpy: 243417 [nsec] (134 MB/sec)
 finished.
Test (1000) memcpy of sizes (51200) ....
1000 memcpy. Time per memcpy: 403455 [nsec] (126 MB/sec)
 finished.
Test (1000) memcpy of sizes (102400) ....
1000 memcpy. Time per memcpy: 713316 [nsec] (143 MB/sec)
 finished.
Test (100) memcpy of sizes (1048576) ....
100 memcpy. Time per memcpy: 7210570 [nsec] (145 MB/sec)
 finished.
Test (10) memcpy of sizes (10485760) ....
10 memcpy. Time per memcpy: 78162400 [nsec] (134 MB/sec)
 finished.
Test (5) memcpy of sizes (52428800) ....
5 memcpy. Time per memcpy: 425281800 [nsec] (123 MB/sec)
 finished.

=3D=3D=3D=3D=3D=3D

Spawning the function testMemcpy() as a POSIX thread inside another
program
yields the following results:

bash-2.05b# bin/testspecs
Test (10000) memcpy of sizes (1024) ....
10000 memcpy. Time per memcpy: 1566 [nsec] (653 MB/sec)
 finished.
Test (10000) memcpy of sizes (2048) ....
10000 memcpy. Time per memcpy: 2943 [nsec] (695 MB/sec)
 finished.
Test (10000) memcpy of sizes (4096) ....
10000 memcpy. Time per memcpy: 5696 [nsec] (719 MB/sec)
 finished.
Test (10000) memcpy of sizes (8192) ....
10000 memcpy. Time per memcpy: 17325 [nsec] (472 MB/sec)
 finished.
Test (10000) memcpy of sizes (16384) ....
10000 memcpy. Time per memcpy: 200892 [nsec] (81 MB/sec)
 finished.
Test (1000) memcpy of sizes (32768) ....
1000 memcpy. Time per memcpy: 400213 [nsec] (81 MB/sec)
 finished.
Test (1000) memcpy of sizes (51200) ....
1000 memcpy. Time per memcpy: 555240 [nsec] (92 MB/sec)
 finished.
Test (1000) memcpy of sizes (102400) ....
1000 memcpy. Time per memcpy: 1253123 [nsec] (81 MB/sec)
 finished.
Test (100) memcpy of sizes (1048576) ....
100 memcpy. Time per memcpy: 12413170 [nsec] (84 MB/sec)
 finished.
Test (10) memcpy of sizes (10485760) ....
10 memcpy. Time per memcpy: 124039572 [nsec] (84 MB/sec)
 finished.
Test (5) memcpy of sizes (52428800) ....
5 memcpy. Time per memcpy: 596899212 [nsec] (87 MB/sec)
 finished.

As long as the memcpy works on the cache line only, the results are
identical. As soon as the real DDR memory is used, performance drops by
66% !

I am assuming because of different linked-in time functions
(clock_gettime())) I am measuring somehow differently. But I am clueless
at the moment where and if the performance is eaten up.

Please can anybody try to reproduce this behaviour on its board ?


Best regards,

Daniel Schnell.

------_=_NextPart_001_01C796E5.92898183
Content-Type: application/octet-stream;
	name="memcpy_perf.c"
Content-Transfer-Encoding: base64
Content-Description: memcpy_perf.c
Content-Disposition: attachment;
	filename="memcpy_perf.c"

I2luY2x1ZGUgPHN0ZGlvLmg+CiNpbmNsdWRlIDxzdGRsaWIuaD4KI2luY2x1ZGUgPHN5cy90aW1l
Lmg+CiNpbmNsdWRlIDxwdGhyZWFkLmg+CgppbnQgb3NhX25vd190aW1lc3BlYyhzdHJ1Y3QgdGlt
ZXNwZWMqIHQpCnsKCXJldHVybiBjbG9ja19nZXR0aW1lIChDTE9DS19SRUFMVElNRSwgdCk7Cn0K
CgppbnQgb3NhX3RpbWVkaWZmKGNvbnN0IHN0cnVjdCB0aW1lc3BlYyogdDEsIGNvbnN0IHN0cnVj
dCB0aW1lc3BlYyogdDIsIHN0cnVjdCB0aW1lc3BlYyogZGlmZikKewoJaWYgKHQxIT1OVUxMICYm
IHQyIT1OVUxMICYmIGRpZmYhPU5VTEwpCgl7CgkJdW5zaWduZWQgbG9uZyBsb25nIGFfbnNlYywg
Yl9uc2VjLCBkaWZmX25zZWM7IAoKCQkvLyBjYWxjdWxhdGUgZGlmZmVyZW5jZSB0aW1lCgkJYV9u
c2VjID0gdDEtPnR2X3NlYyoxMDAwMDAwMDAwVUxMICsgdDEtPnR2X25zZWM7CgkJYl9uc2VjID0g
dDItPnR2X3NlYyoxMDAwMDAwMDAwVUxMICsgdDItPnR2X25zZWM7CgkJZGlmZl9uc2VjID0gYl9u
c2VjIC0gYV9uc2VjOwoJCWRpZmYtPnR2X3NlYyA9ICBkaWZmX25zZWMvMTAwMDAwMDAwMFVMTDsK
CQlkaWZmLT50dl9uc2VjID0gZGlmZl9uc2VjJTEwMDAwMDAwMDBVTEw7CgkJcmV0dXJuIDA7Cgl9
CglyZXR1cm4gLTE7Cn0KCgp1bnNpZ25lZCBsb25nIGxvbmcgb3NhX3RvX25zKGNvbnN0IHN0cnVj
dCB0aW1lc3BlYyogdCkKewoJIHJldHVybiAodC0+dHZfc2VjKjEwMDAwMDAwMDBVTEwgKyB0LT50
dl9uc2VjKTsKfQoKCmludCB0ZXN0TWVtY3B5KHVuc2lnbmVkIGxvbmcgbnVtLCBzaXplX3QgbXNn
c2l6ZSkKewoJcHJpbnRmKCJUZXN0ICglbGQpIG1lbWNweSBvZiBzaXplcyAoJWxkKSAuLi4uXG4i
LAogICAgICAgICAgICBudW0sIG1zZ3NpemUpOwogICAgdW5zaWduZWQgbG9uZyBpOwogICAgdW5z
aWduZWQgbG9uZyBsb25nIG5zdGltZTsKICAgIHN0cnVjdCB0aW1lc3BlYyB0MSwgdDIsIHQzOwoK
ICAgIGNoYXIgKmJ1ZjE9bWFsbG9jIChtc2dzaXplKTsKICAgIGNoYXIgKmJ1ZjI9bWFsbG9jICht
c2dzaXplKTsKCiAgICAvLyBtZWFzdXJlCglvc2Ffbm93X3RpbWVzcGVjKCZ0MSk7CiAgICBmb3Ig
KGk9MDsgaTxudW07IGkrKykKICAgICAgICB7CiAgICAgICAgbWVtY3B5IChidWYxLCBidWYyLCBt
c2dzaXplKTsKICAgICAgICB9CiAgICAvLyBtZWFzdXJlCglvc2Ffbm93X3RpbWVzcGVjKCZ0Mik7
Cglvc2FfdGltZWRpZmYoJnQxLCAmdDIsICZ0Myk7CiAgICAKICAgIGZyZWUgKGJ1ZjIpOwogICAg
ZnJlZSAoYnVmMSk7CiAgICAKICAgIG5zdGltZSA9IG9zYV90b19ucygmdDMpLyh1bnNpZ25lZCBs
b25nIGxvbmcpIGk7CglwcmludGYoIiVsZCBtZW1jcHkuIFRpbWUgcGVyIG1lbWNweTogJWxsdSBb
bnNlY10gKCVsbHUgTUIvc2VjKVxuIiwKICAgICAgICAgICAgaSwgbnN0aW1lLAogICAgICAgICAg
ICAoMTAwMFVMTCAqICh1bnNpZ25lZCBsb25nIGxvbmcpIG1zZ3NpemUpLyhuc3RpbWUpKSA7CiAg
ICBmZmx1c2ggKHN0ZG91dCk7CgoKCXByaW50ZigiIGZpbmlzaGVkLlxuIik7CiAgICBmZmx1c2gg
KHN0ZG91dCk7Cn0KCgppbnQgbWFpbigpCnsKICAgIHRlc3RNZW1jcHkoMTAwMDAsICAgICAgMSox
MDI0KTsKICAgIHRlc3RNZW1jcHkoMTAwMDAsICAgICAgMioxMDI0KTsKICAgIHRlc3RNZW1jcHko
MTAwMDAsICAgICAgNCoxMDI0KTsKICAgIHRlc3RNZW1jcHkoMTAwMDAsICAgICAgOCoxMDI0KTsK
ICAgIHRlc3RNZW1jcHkoMTAwMDAsICAgICAxNioxMDI0KTsKICAgIHRlc3RNZW1jcHkoMTAwMCAs
ICAgICAzMioxMDI0KTsKICAgIHRlc3RNZW1jcHkoMTAwMCAsICAgICA1MCoxMDI0KTsKICAgIHRl
c3RNZW1jcHkoMTAwMCAsICAgIDEwMCoxMDI0KTsKICAgIHRlc3RNZW1jcHkoIDEwMCAsICAgMTAy
NCoxMDI0KTsKICAgIHRlc3RNZW1jcHkoICAxMCAsMTAqMTAyNCoxMDI0KTsKICAgIHRlc3RNZW1j
cHkoICAgNSAsNTAqMTAyNCoxMDI0KTsKCiAgICByZXR1cm4gMDsKfQo=

------_=_NextPart_001_01C796E5.92898183--

