MIME-Version: 1.0
Date: Wed, 26 May 2010 16:23:09 +0100
Message-ID: <AANLkTilzHg1IAyyLDpri8k8jI1hRooOwdehF8259xoAL@mail.gmail.com>
From: Stephen Bryant <sbxenomai@domain.hid>
Content-Type: multipart/mixed; boundary=0016364d25b3f9d050048780d96e
Subject: [Xenomai-help] pthread_setschedparam() segfault using Xenomai 2.5.2
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

--0016364d25b3f9d050048780d96e
Content-Type: multipart/alternative; boundary=0016364d25b3f9d045048780d96c

--0016364d25b3f9d045048780d96c
Content-Type: text/plain; charset=ISO-8859-1

Hi,

I am receiving a segfault when calling pthread_setschedparam().  Both the
thread and the scheduling parameters are initialised to appropraite values,
and I am using SCHED_FIFO.  Attached is example code, similar to my
application (rather than minimalist), that reproduces the error when
compiled for Xenomai (with '--skin=posix --ldflags' and '--cflags'), while
running cleanly when compiled for standard linux.

Is this a problem with pthread_setschedparam(), or am I doing something
wrong?  If you need any more information then let me know.

I am running:
Linux kernel 2.6.32.8
Adeos patch adeos-ipipe-2.6.32.7-x86-2.6-01.patch (it patched cleanly onto
2.6.32.8)
Xenomai 2.5.2
Processor: Core 2 Duo (kernel is compiled to use only 1 core)

Steve

--0016364d25b3f9d045048780d96c
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,<br><br>I am receiving a segfault when calling pthread_setschedparam().=
=A0 Both the thread and the scheduling parameters are initialised to approp=
raite values, and I am using SCHED_FIFO.=A0 Attached is example code, simil=
ar to my application (rather than minimalist), that reproduces the error wh=
en compiled for Xenomai (with &#39;--skin=3Dposix --ldflags&#39; and &#39;-=
-cflags&#39;), while running cleanly when compiled for standard linux.<br>
<br>Is this a problem with pthread_setschedparam(), or am I doing something=
 wrong?=A0 If you need any more information then let me know.<br><br>I am r=
unning:<br>Linux kernel 2.6.32.8<br>Adeos patch adeos-ipipe-2.6.32.7-x86-2.=
6-01.patch (it patched cleanly onto 2.6.32.8)<br>
Xenomai 2.5.2<br>Processor: Core 2 Duo (kernel is compiled to use only 1 co=
re)<br><br>Steve<br>

--0016364d25b3f9d045048780d96c--

--0016364d25b3f9d050048780d96e
Content-Type: text/x-c++src; charset=US-ASCII; name="SchedParam.cpp"
Content-Disposition: attachment; filename="SchedParam.cpp"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g9ob63s50

I2lmZGVmIF9fWEVOT19fCiNpbmNsdWRlIDxwb3NpeC9wb3NpeC5oPgojaW5jbHVkZSA8c3lzL21t
YW4uaD4KI2Vsc2UKI2luY2x1ZGUgPHB0aHJlYWQuaD4KI2VuZGlmIC8vIF9fWEVOT19fCgojaW5j
bHVkZSA8c3RkaW8uaD4KI2luY2x1ZGUgPHVuaXN0ZC5oPgoKdHlwZWRlZiB2b2lkKiAoKkVOVFJZ
UE9JTlQpKHZvaWQqKTsKCnN0cnVjdCBUaHJlYWRBcmdzCnsKICAgcHVibGljOgogICAgICBFTlRS
WVBPSU5UIHBGY247CiAgICAgIHZvaWQqIHBGY25BcmdzOwogICAgICBpbnQgUHJpb3JpdHk7Cn07
Cgp2b2lkICpUaHJlYWRXcmFwcGVyKHZvaWQgKnBBcmdzKTsKdm9pZCBUZXN0RmNuKCk7CgppbnQg
bWFpbigpCnsKICAgI2lmZGVmIF9fWEVOT19fCiAgIG1sb2NrYWxsKE1DTF9DVVJSRU5UIHwgTUNM
X0ZVVFVSRSk7CiAgICNlbmRpZiAvL19fWEVOT19fCgogICBwdGhyZWFkX3QqIHBUaHJlYWQgPSBu
ZXcgcHRocmVhZF90KCk7OwogICBzdHJ1Y3QgVGhyZWFkQXJncyAqcFRBcmdzID0gbmV3IHN0cnVj
dCBUaHJlYWRBcmdzOwoJcHRocmVhZF9hdHRyX3QgVGhyZWFkQ3VzdG9tQXR0cjsKCglwdGhyZWFk
X2F0dHJfaW5pdCgmVGhyZWFkQ3VzdG9tQXR0cik7CgkjaWZkZWYgX19YRU5PX18KICAgcHRocmVh
ZF9hdHRyX3NldHN0YWNrc2l6ZSgmVGhyZWFkQ3VzdG9tQXR0ciwgUFRIUkVBRF9TVEFDS19NSU4g
KyAxMDAwMCk7CiAgICNlbHNlCiAgIHB0aHJlYWRfYXR0cl9zZXRzdGFja3NpemUoJlRocmVhZEN1
c3RvbUF0dHIsIDIwMDAwKTsKICAgI2VuZGlmIC8vIF9fWEVOT19fCiAgIHB0aHJlYWRfYXR0cl9z
ZXRkZXRhY2hzdGF0ZSgmVGhyZWFkQ3VzdG9tQXR0ciwgUFRIUkVBRF9DUkVBVEVfREVUQUNIRUQp
OwogICBwdGhyZWFkX2F0dHJfc2V0aW5oZXJpdHNjaGVkKCZUaHJlYWRDdXN0b21BdHRyLCBQVEhS
RUFEX0VYUExJQ0lUX1NDSEVEKTsKICAgcHRocmVhZF9hdHRyX3NldHNjb3BlKCZUaHJlYWRDdXN0
b21BdHRyLCBQVEhSRUFEX1NDT1BFX1BST0NFU1MpOwoKICAgcFRBcmdzLT5wRmNuID0gKEVOVFJZ
UE9JTlQpIFRlc3RGY247CiAgIHBUQXJncy0+cEZjbkFyZ3MgPSBOVUxMOwogICBwVEFyZ3MtPlBy
aW9yaXR5ID0gNjA7CgogICBwdGhyZWFkX2NyZWF0ZShwVGhyZWFkLCAmVGhyZWFkQ3VzdG9tQXR0
ciwgVGhyZWFkV3JhcHBlciwgKHZvaWQgKikgcFRBcmdzKTsKCiAgIGlmKHBUaHJlYWQgIT0gTlVM
TCkgeyBkZWxldGUgcFRocmVhZDsgfQoKICAgc2xlZXAoMyk7CgogICByZXR1cm4gMDsKfQoKdm9p
ZCAqVGhyZWFkV3JhcHBlcih2b2lkICpwQXJncykKewogICB2b2lkICpwUmVzdWx0OwogICBzdHJ1
Y3QgVGhyZWFkQXJncyAqcFRBcmdzID0gKHN0cnVjdCBUaHJlYWRBcmdzICopIHBBcmdzOwoKCXN0
cnVjdCBzY2hlZF9wYXJhbSBTY2hlZFBhcmFtOwoJU2NoZWRQYXJhbS5zY2hlZF9wcmlvcml0eSA9
IHBUQXJncy0+UHJpb3JpdHk7CglwdGhyZWFkX3NldHNjaGVkcGFyYW0ocHRocmVhZF9zZWxmKCks
IFNDSEVEX0ZJRk8sICZTY2hlZFBhcmFtKTsKCiAgIHBSZXN1bHQgPSAodm9pZCAqKSBwVEFyZ3Mt
PnBGY24ocFRBcmdzLT5wRmNuQXJncyk7CgogICBkZWxldGUgcFRBcmdzOwoKICAgcmV0dXJuIHBS
ZXN1bHQ7Cn0KCnZvaWQgVGVzdEZjbigpCnsKICAgcHJpbnRmKCJNYWRlIGl0XG4iKTsKfQo=
--0016364d25b3f9d050048780d96e--

