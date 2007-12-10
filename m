Message-ID: <c12ec2810712100218s7c93af6drc2ada3ee7644c152@domain.hid>
Date: Mon, 10 Dec 2007 11:18:30 +0100
From: "Ulf Karlsson" <karlsson.ulf@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_11296_6219074.1197281910254"
Subject: [Xenomai-help] rtpipe consistency problems
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

------=_Part_11296_6219074.1197281910254
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

I encounter a problem with rtpipes where the packets are being being
"locked up" inside the pipe, that is the read(2) call waiting for the
data does not return, Furthermore, it appears like I lose packets in
the pipe.

I have attached a two simple C-programs that demonstrate this behavior.

The program linux-pipe.c writes increasing integer values to the pipe
and expects to be able to read the same value back from the pipe,
while the program xeno-pipe.c reads an integer from the pipe and
instantly writes the very same value back.

I am using a 2.6.20.21 kernel together with xenomai 2.4.0.

Here is an example run after having started xeno-pipe in another shell:

$ ./linux-pipe 0
0
1
2
...
3499
3500
<process hangs in read(2)>

$ ./linux-pipe 10
mismatch: in: 10 out: 3501 <now when read(2) is restarted, the old
value is delivered>

$ ./linux-pipe 20
mismatch: in: 20 out: 10 <the pipe is still out of sync however>

$ ./linux-pipe 30
30
31
32
<the value 20 that was previously written has somehow been lost in the
pipe and it is back in sync!>

The behavior is somewhat different between individual runs, but
roughly the same.

I'd be grateful for any help or suggestions.

Regards,
Ulf

------=_Part_11296_6219074.1197281910254
Content-Type: text/x-csrc; name=xeno-pipe.c
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fa0tm22b0
Content-Disposition: attachment; filename=xeno-pipe.c

LyogZ2NjICQoeGVuby1jb25maWcgLS14ZW5vLWNmbGFncyAtLXhlbm8tbGRmbGFncykgLVdhbGwg
LWxuYXRpdmUgXAogKiAgICAgeGVuby1waXBlLmMgLW8geGVuby1waXBlCiAqLwojaW5jbHVkZSA8
bmF0aXZlL3Rhc2suaD4KI2luY2x1ZGUgPG5hdGl2ZS9waXBlLmg+CiNpbmNsdWRlIDxzdGRpby5o
PgojaW5jbHVkZSA8ZXJyb3IuaD4KI2luY2x1ZGUgPHN5cy9tbWFuLmg+CgojZGVmaW5lIFBJUEVf
TkFNRSAiZXh0Y21kMSIKClJUX1RBU0sgbWFpbl90YXNrOwpSVF9QSVBFIGV4dGNtZF9waXBlOwoK
aW50IG1haW4oKQp7CglpbnQgcmV0OwoJdW5zaWduZWQgbG9uZyB2YWw7CgltbG9ja2FsbChNQ0xf
Q1VSUkVOVHxNQ0xfRlVUVVJFKTsKCXJ0X3Rhc2tfc2hhZG93KCZtYWluX3Rhc2ssICJtYWluIHRh
c2siLCA1LCBUX0NQVSgwKSk7CgoJcmV0ID0gcnRfcGlwZV9jcmVhdGUoJmV4dGNtZF9waXBlLCBQ
SVBFX05BTUUsIFBfTUlOT1JfQVVUTywwKTsKCWlmIChyZXQgPCAwKSB7CgkJZXJyb3IoMCwtcmV0
LCJydF9waXBlX2NyZWF0ZSIpOwoJCXJldHVybjsKCX0KCWZvciAoOzspIHsKCQlyZXQgPSBydF9w
aXBlX3JlYWQoJmV4dGNtZF9waXBlLCAmdmFsLCBzaXplb2YgKHZhbCksIFRNX0lORklOSVRFKTsK
CQlpZiAocmV0IDwgMCkKCQkJZXJyb3IoMSwtcmV0LCJydF9waXBlX3JlYWQiKTsKCQlyZXQgPSBy
dF9waXBlX3dyaXRlKCZleHRjbWRfcGlwZSwgJnZhbCwgc2l6ZW9mICh2YWwpLCBQX05PUk1BTCk7
CgkJaWYgKHJldCA8IDApCgkJCWVycm9yKDEsLXJldCwicnRfcGlwZV93cml0ZSIpOwoJfQp9Cg==

------=_Part_11296_6219074.1197281910254
Content-Type: text/x-csrc; name=linux-pipe.c
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fa0u2yia2
Content-Disposition: attachment; filename=linux-pipe.c

LyogZ2NjIC1XYWxsIGxpbnV4LXBpcGUuYyAtbyBsaW51eC1waXBlCiAqLwojaW5jbHVkZSA8ZmNu
dGwuaD4KI2luY2x1ZGUgPHN0ZGlvLmg+CiNpbmNsdWRlIDx1bmlzdGQuaD4KI2luY2x1ZGUgPGVy
cm9yLmg+CiNpbmNsdWRlIDxzdGRsaWIuaD4KaW50IG1haW4oaW50IGFyZ2MsIGNoYXIgKmFyZ3Zb
XSkKewoJdW5zaWduZWQgbG9uZyBpbiA9IDAsIG91dDsKCWludCBmZDsKCWludCByZXQ7CgoJaWYg
KGFyZ2MgPiAxKQoJCWluID0gYXRvaShhcmd2WzFdKTsKCQoJZmQgPSBvcGVuKCIvcHJvYy94ZW5v
bWFpL3JlZ2lzdHJ5L25hdGl2ZS9waXBlcy9leHRjbWQxIiwgT19SRFdSKTsKCWlmIChmZCA8IDAp
CgkJZXJyb3IoMCwgLWZkLCAib3BlbiIpOwoKCWZvciAoOzspIHsKCQlyZXQgPSB3cml0ZShmZCwg
JmluLCBzaXplb2YgKGluKSk7CgkJaWYgKHJldCA8IDApCgkJCWVycm9yKDEsIC1yZXQsICJ3cml0
ZSIpOwoJCXJldCA9IHJlYWQoZmQsICZvdXQsIHNpemVvZiAob3V0KSk7CgkJaWYgKHJldCA8IDAp
CgkJCWVycm9yKDEsIC1yZXQsICJyZWFkIik7CgkJaWYgKGluICE9IG91dCkgewoJCQlwcmludGYo
Im1pc21hdGNoOiBpbjogJWx1IG91dDogJWx1XG4iLCBpbiwgb3V0KTsKCQkJcmV0dXJuIDE7CgkJ
fQoJCXByaW50ZigiJWx1XG4iLCBvdXQpOwoJCWluKys7Cgl9CgoJcmV0dXJuIDA7Cn0K
------=_Part_11296_6219074.1197281910254--

