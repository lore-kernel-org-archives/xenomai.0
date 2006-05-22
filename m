content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C67DA2.DDF8CA5E"
Date: Mon, 22 May 2006 15:23:08 +0200
Message-ID: <CC692F5386B0AA47A62B7484A7CA2B6D02B52527@domain.hid>
From: "Behre, Frederik - LT" <Behre.Frederik@domain.hid>
Subject: [Xenomai-help] Xenomai @ ppc with linker Porblem
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

------_=_NextPart_001_01C67DA2.DDF8CA5E
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi

I have following problem when I compiling my Xenomai Program. It is a
example from the Internet.=20
As Attachment I send the programm and the Makefile.

I think the problem is very simple but I have no Idea what it can be.=20

My system is
Linux 2.4.25
Xenomai 2.1.1
Adeos 1.0-04

PPC - MPC 8270 on Mircosys PM287.

This is my output:
bash-2.05b# echo $PATH
/usr/xenomai/bin:/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/us
r/bin:/usr/X11R6/bin
bash-2.05b# make
gcc -I. -I/usr/xenomai/include -O2 -D_GNU_SOURCE -D_REENTRANT -D__XENO__
-Wall -pipe -L/usr/xenomai/lib -lpthread -lnative -o timer timer.c
timer.c: In function `main':
timer.c:44: warning: `rt_timer_start' is deprecated (declared at
/usr/xenomai/include/native/timer.h:62)
/tmp/ccyCczMp.o(.text+0x3c): In function `testtask':
: undefined reference to `rt_task_sleep'
/tmp/ccyCczMp.o(.text+0xac): In function `clean_exit':
: undefined reference to `rt_task_delete'
/tmp/ccyCczMp.o(.text+0x124): In function `main':
: undefined reference to `rt_task_create'
/tmp/ccyCczMp.o(.text+0x144): In function `main':
: undefined reference to `rt_task_start'
collect2: ld returned 1 exit status
make: *** [timer] Error 1
bash-2.05b#  =20


Thanks for helping

Greetz
Freddy

------_=_NextPart_001_01C67DA2.DDF8CA5E
Content-Type: application/octet-stream;
	name="timer.c"
Content-Transfer-Encoding: base64
Content-Description: timer.c
Content-Disposition: attachment;
	filename="timer.c"

I2luY2x1ZGUgPHN0ZGlvLmg+CiNpbmNsdWRlIDx1bmlzdGQuaD4KI2luY2x1ZGUgPHN0ZGxpYi5o
PgojaW5jbHVkZSA8c3RyaW5nLmg+CiNpbmNsdWRlIDxzaWduYWwuaD4KI2luY2x1ZGUgPHN5cy90
aW1lLmg+Ci8vI2luY2x1ZGUgPHN5cy9pby5oPgovL2lzIG5vdCBpbiBteSBpbmNsdWRlIGRpcmVj
dG9yeSA/Pz8gd2h5IEkgbmVlZCBpdCA/PyB0YWtlIGFub3RoZXIgPz8/CiNpbmNsdWRlIDxzeXMv
bW1hbi5oPgojaW5jbHVkZSA8bmF0aXZlL3Rhc2suaD4KI2luY2x1ZGUgPG5hdGl2ZS9xdWV1ZS5o
PgojaW5jbHVkZSA8bmF0aXZlL2ludHIuaD4KCiNkZWZpbmUgU1RBQ0tfU0laRSA4MTkyCiNkZWZp
bmUgU1REX1BSSU8gMQoKUlRfVEFTSyB0ZXN0X3Rhc2tfcHRyOwppbnQgaW50X2NvdW50ID0gMDsK
aW50IGVuZCA9IDA7Cgp2b2lkIHRlc3R0YXNrKHZvaWQgKmNvb2tpZSl7CglpbnQgY291bnQgPSAw
OwoJd2hpbGUoIWVuZCl7CiAJCXJ0X3Rhc2tfc2xlZXAoMTAwMCk7CS8vIHNsZWVwIDEgc2VjICgx
MDAwIHRpY2tzLCAxbXMgZWFjaCkKCQljb3VudCsrOwoJCXByaW50ZigibWVzc2FnZSBmcm9tIHRl
c3R0YXNrOiBjb3VudD0lZFxuIiwgY291bnQpOwoJCWZmbHVzaChOVUxMKTsKCX0KfQovLyBzaWdu
YWwtaGFuZGxlciwgdG8gZW5zdXJlIGNsZWFuIGV4aXQgb24gQ3RybC1DIHZvaWQgY2xlYW5fZXhp
dChpbnQgZHVtbXkpIHsKCXByaW50ZigiY2xlYW51cFxuIik7CgllbmQgPSAxOwoJcnRfdGFza19k
ZWxldGUoJnRlc3RfdGFza19wdHIpOwoJcHJpbnRmKCJlbmRcbiIpOwp9CgppbnQgbWFpbihpbnQg
YXJnYywgY2hhciAqYXJndltdKSB7CglpbnQgZXJyOwoJcHJpbnRmKCJzdGFydFxuIik7CgkvLyBp
bnN0YWxsIHNpZ25hbCBoYW5kbGVyCglzaWduYWwoU0lHVEVSTSwgY2xlYW5fZXhpdCk7CglzaWdu
YWwoU0lHSU5ULCBjbGVhbl9leGl0KTsKCS8vIHN0YXJ0IHRpbWVyCgllcnIgPSBydF90aW1lcl9z
dGFydCgxMDAwMDAwKTsgLy8gMW1zIHRpY2tzCglpZiAoZXJyKSB7CgkJcHJpbnRmKCJlcnJvciBy
dF90aW1lcl9zdGFydCAtIGRpZCB5b3UgJ0VuYWJsZSBwZXJpb2RpYyB0aW1lciBzdXBwb3J0JyA/
XG4iKTsKCQlyZXR1cm4gMDsKCX0KCWVyciA9IHJ0X3Rhc2tfc3Bhd24oJnRlc3RfdGFza19wdHIs
ICJUaW1lciIsIFNUQUNLX1NJWkUsIFNURF9QUklPLCAwLCAmdGVzdHRhc2ssIE5VTEwpOwoJaWYg
KGVycikgewoJCXByaW50ZigiZXJyb3IgcnRfdGFza19zcGF3blxuIik7CgkJcmV0dXJuIDA7Cgl9
CgkvLyB3YWl0IGZvciBzaWduYWwgJiByZXR1cm4gb2Ygc2lnbmFsIGhhbmRsZXIKCXBhdXNlKCk7
CglmZmx1c2goTlVMTCk7CglyZXR1cm4gMDsKfQo=

------_=_NextPart_001_01C67DA2.DDF8CA5E
Content-Type: application/octet-stream;
	name="Makefile"
Content-Transfer-Encoding: base64
Content-Description: Makefile
Content-Disposition: attachment;
	filename="Makefile"

cHJlZml4IDo9ICQoc2hlbGwgeGVuby1jb25maWcgLS1wcmVmaXgpCgppZmVxICgkKHByZWZpeCks
KQokKGVycm9yIFBsZWFzZSBhZGQgPHhlbm8taW5zdGFsbD4vYmluIHRvIHlvdXIgUEFUSCB2YXJp
YWJsZSkgZW5kaWYKCkNDID0gZ2NjCiMgY2hhbmNlZCBiZWNhdXNlIEkgY29tcGlsZWluZyBvbiBt
eSBwb3dlcnBjICQoc2hlbGwgeGVuby1jb25maWcgLS1jYykKTFhSVF9DRkxBR1MgPSAkKHNoZWxs
IHhlbm8tY29uZmlnIC0teGVuby1jZmxhZ3MpIExYUlRfTERGTEFHUyA9ICQoc2hlbGwgeGVuby1j
b25maWcgLS14ZW5vLWxkZmxhZ3MpCgphbGw6IHRpbWVyCgp0aW1lcjogdGltZXIuYwoJJChDQykg
JChMWFJUX0NGTEFHUykgJChMWFJUX0xERkxBR1MpIC1sbmF0aXZlIC1vICRAICQ8CgpjbGVhbjoK
CXJtIC1mICoubyB0aW1lcgoKLlBIT05ZOiBjbGVhbgo=

------_=_NextPart_001_01C67DA2.DDF8CA5E--

