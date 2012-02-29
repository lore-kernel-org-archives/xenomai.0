MIME-Version: 1.0
Date: Wed, 29 Feb 2012 18:29:13 +0100
Message-ID: <CAEc6OSwfGvfwXM3vqtAXd7o_XeMhSmuvj8mkd8ziLXQSMyK0aA@mail.gmail.com>
From: Charles Lesire-Cabaniols <charles.lesire@domain.hid>
Content-Type: multipart/mixed; boundary=bcaec554d9e2a09cee04ba1dae8b
Subject: [Xenomai-help] Execution time profiling
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

--bcaec554d9e2a09cee04ba1dae8b
Content-Type: multipart/alternative; boundary=bcaec554d9e2a09cd804ba1dae89

--bcaec554d9e2a09cd804ba1dae89
Content-Type: text/plain; charset=UTF-8

Hi guys,

I have installed a Debian+Xenomai (2.6.0) OS on my Gumstix Overo.

I want to evaluate the execution time of a simple program, executed as a
real-time thread.

I definitely wonder about which functions to use, as I have completely
inconsistent measures.
I have tried using rt_timer_read, rt_timer_tsc, clock_gettime.
I also directly read the CNNT register with ARM instructions (which is the
only one I think correct) in order to have a (good?) reference.

I join the simple program I use.

The output is :
----- ASM instruction -----
start: 62483 ; end: 172961 ; (s-e): 110478 ; overhead: 102 ;
(s-e-overhead): 110376 ; CET: 110478
----- Xenomai rt_timer_read -----
start: 1016 ; end: 3435090911 ; (s-e): 1016 ; CET: 3435246834
----- Xenomai rt_timer_tsc -----
start: 13 ; end: 938009132 ; (s-e): 13 ; CET: 938011124
----- Xenomai clock_gettime -----
[ s] start: 946689173 ; end: 946689173 ; (s-e): 0 ; CET: 0
[ns] start: 231412764 ; end: 231569761 ; (s-e): 156997 ; CET: 156997

So that I can support that the correct execution time is around 110 000
(ticks?)

Only the nsecs of clock_gettime seem to be consistent ; other functions
return erratic values!

What am I doing wrong?

Should I initialize something in my program (I tried
rt_timer_set_mode(TM_ONESHOT) without any change)?

Should I check or change my kernel or xenomai configuration options?

Any (urgent) help would be appreciated!

Thanks,

Charles.

--bcaec554d9e2a09cd804ba1dae89
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi guys,<br><br>I have installed a Debian+Xenomai (2.6.0) OS on my Gumstix =
Overo.<br><br>I want to evaluate the execution time of a simple program, ex=
ecuted as a real-time thread.<br><br>I definitely wonder about which functi=
ons to use, as I have completely inconsistent measures.<br>
I have tried using rt_timer_read, rt_timer_tsc, clock_gettime.<br>I also di=
rectly read the CNNT register with ARM instructions (which is the only one =
I think correct) in order to have a (good?) reference.<br><br>I join the si=
mple program I use.<br>
<br>The output is :<br>----- ASM instruction -----<br>start: 62483 ; end: 1=
72961 ; (s-e): 110478 ; overhead: 102 ; (s-e-overhead): 110376 ; CET: 11047=
8 <br>----- Xenomai rt_timer_read -----<br>start: 1016 ; end: 3435090911 ; =
(s-e): 1016 ; CET: 3435246834 <br>
----- Xenomai rt_timer_tsc -----<br>start: 13 ; end: 938009132 ; (s-e): 13 =
; CET: 938011124 <br>----- Xenomai clock_gettime -----<br>[ s] start: 94668=
9173 ; end: 946689173 ; (s-e): 0 ; CET: 0 <br>[ns] start: 231412764 ; end: =
231569761 ; (s-e): 156997 ; CET: 156997 <br>
<br>So that I can support that the correct execution time is around 110 000=
 (ticks?)<br><br>Only the nsecs of clock_gettime seem to be consistent ; ot=
her functions return erratic values!<br><br>What am I doing wrong?<br><br>
Should I initialize something in my program (I tried rt_timer_set_mode(TM_O=
NESHOT) without any change)?<br><br>Should I check or change my kernel or x=
enomai configuration options?<br><br>Any (urgent) help would be appreciated=
!<br>
<br>Thanks,<br><br>Charles.<br>

--bcaec554d9e2a09cd804ba1dae89--

--bcaec554d9e2a09cee04ba1dae8b
Content-Type: text/x-csrc; charset=US-ASCII; name="wcet_test.c"
Content-Disposition: attachment; filename="wcet_test.c"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gz8n3m1i0

I2luY2x1ZGUgPHN0ZGlvLmg+CiNpbmNsdWRlIDxzaWduYWwuaD4KI2luY2x1ZGUgPHVuaXN0ZC5o
PgojaW5jbHVkZSA8c3lzL21tYW4uaD4KCiNpbmNsdWRlIDxuYXRpdmUvdGFzay5oPgojaW5jbHVk
ZSA8bmF0aXZlL3RpbWVyLmg+CiNpbmNsdWRlIDxydGRrLmg+CiNpbmNsdWRlIDxwb3NpeC90aW1l
Lmg+CgpSVF9UQVNLIHRhc2s7CgppbnQgc3VtKCkgewoJaW50IGkgPSAwOwoJaW50IHMgPSAwOwoJ
Zm9yKGkgPSAwOyBpIDwgMTAwMDA7IGkrKykKICAgIAlzICs9IGk7CglyZXR1cm4gczsKfQoKc3Rh
dGljIGlubGluZSB1bnNpZ25lZCBsb25nIGludCBnZXRfY3ljbGVjb3VudCAodm9pZCkKewogIHVu
c2lnbmVkIGxvbmcgaW50IHZhbHVlOwogIC8vTVJDIHAxNSwgMCwgPFJkPiwgYzksIGMxMywgMCA7
IFJlYWQgQ0NOVCBSZWdpc3RlcgogIGFzbSB2b2xhdGlsZSAoIk1SQyBwMTUsIDAsICVbUmRdLCBj
OSwgYzEzLCAwXHRcbiI6IFtSZF0gIj1yIih2YWx1ZSkpOwogIHJldHVybiB2YWx1ZTsKfQoKc3Rh
dGljIGlubGluZSB2b2lkIGluaXRfcGVyZmNvdW50ZXJzIChpbnQzMl90IGRvX3Jlc2V0LCBpbnQz
Ml90IGVuYWJsZV9kaXZpZGVyKQp7CiAgLy8gaW4gZ2VuZXJhbCBlbmFibGUgYWxsIGNvdW50ZXJz
IChpbmNsdWRpbmcgY3ljbGUgY291bnRlcikKICBpbnQzMl90IHZhbHVlID0gMTsKICAvLyBwZWZv
cm0gcmVzZXQ6CiAgaWYgKGRvX3Jlc2V0KQogIHsKICAgIHZhbHVlIHw9IDI7ICAgICAvLyByZXNl
dCBhbGwgY291bnRlcnMgdG8gemVyby4KICAgIHZhbHVlIHw9IDQ7ICAgICAvLyByZXNldCBjeWNs
ZSBjb3VudGVyIHRvIHplcm8uCiAgfQogIGlmIChlbmFibGVfZGl2aWRlcikKICAgIHZhbHVlIHw9
IDg7ICAgICAvLyBlbmFibGUgImJ5IDY0IiBkaXZpZGVyIGZvciBDQ05ULgogIHZhbHVlIHw9IDE2
OwogIC8vIHByb2dyYW0gdGhlIHBlcmZvcm1hbmNlLWNvdW50ZXIgY29udHJvbC1yZWdpc3RlcjoK
ICBhc20gdm9sYXRpbGUgKCJNQ1IgcDE1LCAwLCAlMCwgYzksIGMxMiwgMFx0XG4iIDo6ICJyIih2
YWx1ZSkpOwogICAgLy8gZW5hYmxlIGFsbCBjb3VudGVyczoKICBhc20gdm9sYXRpbGUgKCJNQ1Ig
cDE1LCAwLCAlMCwgYzksIGMxMiwgMVx0XG4iIDo6ICJyIigweDgwMDAwMDBmKSk7CiAgLy8gY2xl
YXIgb3ZlcmZsb3dzOgogIGFzbSB2b2xhdGlsZSAoIk1DUiBwMTUsIDAsICUwLCBjOSwgYzEyLCAz
XHRcbiIgOjogInIiKDB4ODAwMDAwMGYpKTsKfQoKdm9pZCBzdW1fdGFzayh2b2lkICphcmcpIHsK
CS8vIEluaXQgQVNNIHJlZ2lzdGVycwoJaW5pdF9wZXJmY291bnRlcnMoMSwgMCk7CgkvLyBJbml0
IFRpbWVyCiAgICBydF90aW1lcl9zZXRfbW9kZShUTV9PTkVTSE9UKTsKCglydF9wcmludGYoIi0t
LS0tIEFTTSBpbnN0cnVjdGlvbiAtLS0tLVxuIik7Cgl1bnNpZ25lZCBsb25nIGludCBhc21fcywg
YXNtX2UsIGFzbV9jLCBhc21fbzsKCWFzbV9vID0gZ2V0X2N5Y2xlY291bnQoKTsgYXNtX28gPSBn
ZXRfY3ljbGVjb3VudCgpIC0gYXNtX287Cglhc21fcyA9IGdldF9jeWNsZWNvdW50KCk7CglzdW0o
KTsKCWFzbV9lID0gZ2V0X2N5Y2xlY291bnQoKTsKCWFzbV9jID0gYXNtX2UgLSBhc21fczsKCXJ0
X3ByaW50Zigic3RhcnQ6ICVsdSA7IGVuZDogJWx1IDsgKHMtZSk6ICVsdSA7IG92ZXJoZWFkOiAl
bHUgOyAocy1lLW92ZXJoZWFkKTogJWx1IDsgQ0VUOiAlbHUgXG4iLAoJCWFzbV9zLCBhc21fZSwg
KGFzbV9lIC0gYXNtX3MpLCBhc21fbywgKChhc21fZS1hc21fcyktYXNtX28pLCBhc21fYyk7CgoJ
cnRfcHJpbnRmKCItLS0tLSBYZW5vbWFpIHJ0X3RpbWVyX3JlYWQgLS0tLS1cbiIpOwoJUlRJTUUg
cmVhZF9zLCByZWFkX2UsIHJlYWRfYzsKCXJlYWRfcyA9IHJ0X3RpbWVyX3JlYWQoKTsKCXN1bSgp
OwoJcmVhZF9lID0gcnRfdGltZXJfcmVhZCgpOwoJcmVhZF9jID0gcmVhZF9lIC0gcmVhZF9zOwoJ
cnRfcHJpbnRmKCJzdGFydDogJWx1IDsgZW5kOiAlbHUgOyAocy1lKTogJWx1IDsgQ0VUOiAlbHUg
XG4iLCByZWFkX3MsIHJlYWRfZSwgKHJlYWRfZSAtIHJlYWRfcyksIHJlYWRfYyk7CgoJcnRfcHJp
bnRmKCItLS0tLSBYZW5vbWFpIHJ0X3RpbWVyX3RzYyAtLS0tLVxuIik7CglSVElNRSB0c2Nfcywg
dHNjX2UsIHRzY19jOwoJdHNjX3MgPSBydF90aW1lcl90c2MoKTsKCXN1bSgpOwoJdHNjX2UgPSBy
dF90aW1lcl90c2MoKTsKCXRzY19jID0gdHNjX2UgLSB0c2NfczsKCXJ0X3ByaW50Zigic3RhcnQ6
ICVsdSA7IGVuZDogJWx1IDsgKHMtZSk6ICVsdSA7IENFVDogJWx1IFxuIiwgdHNjX3MsIHRzY19l
LCAodHNjX2UgLSB0c2NfcyksIHRzY19jKTsKCglydF9wcmludGYoIi0tLS0tIFhlbm9tYWkgY2xv
Y2tfZ2V0dGltZSAtLS0tLVxuIik7CglzdHJ1Y3QgdGltZXNwZWMgY2xvY2tfcywgY2xvY2tfZSwg
Y2xvY2tfYzsKCWNsb2NrX2dldHRpbWUoQ0xPQ0tfUkVBTFRJTUUsICZjbG9ja19zKTsKCXN1bSgp
OwoJY2xvY2tfZ2V0dGltZShDTE9DS19SRUFMVElNRSwgJmNsb2NrX2UpOwoJY2xvY2tfYy50dl9z
ZWMgPSBjbG9ja19lLnR2X3NlYyAtIGNsb2NrX3MudHZfc2VjOwoJY2xvY2tfYy50dl9uc2VjID0g
Y2xvY2tfZS50dl9uc2VjIC0gY2xvY2tfcy50dl9uc2VjOwoJcnRfcHJpbnRmKCJbIHNdIHN0YXJ0
OiAlZCA7IGVuZDogJWQgOyAocy1lKTogJWQgOyBDRVQ6ICVkIFxuIiwKCQkJY2xvY2tfcy50dl9z
ZWMsIGNsb2NrX2UudHZfc2VjLCAoY2xvY2tfZS50dl9zZWMgLSBjbG9ja19zLnR2X3NlYyksIGNs
b2NrX2MudHZfc2VjKTsKCXJ0X3ByaW50ZigiW25zXSBzdGFydDogJWQgOyBlbmQ6ICVkIDsgKHMt
ZSk6ICVkIDsgQ0VUOiAlZCBcbiIsCgkJCWNsb2NrX3MudHZfbnNlYywgY2xvY2tfZS50dl9uc2Vj
LCAoY2xvY2tfZS50dl9uc2VjIC0gY2xvY2tfcy50dl9uc2VjKSwgY2xvY2tfYy50dl9uc2VjKTsK
fQoKCmludCBtYWluKGludCBhcmdjLCBjaGFyKiBhcmd2W10pIHsKCWNoYXIgc3RyWzEwXSA7Cgkv
LyBQZXJmb3JtIGF1dG8taW5pdCBvZiBydF9wcmludCBidWZmZXJzIGlmIHRoZSB0YXNrIGRvZXNu
J3QgZG8gc28KCXJ0X3ByaW50X2F1dG9faW5pdCgxKTsKCS8vIExvY2sgbWVtb3J5IDogYXZvaWQg
bWVtb3J5IHN3YXBwaW5nIGZvciB0aGlzIHByb2dyYW0KCW1sb2NrYWxsKE1DTF9DVVJSRU5UIHwg
TUNMX0ZVVFVSRSk7CglzcHJpbnRmKHN0ciwgInN1bV90ZXN0Iik7CgkvLyBydF90YXNrX2NyZWF0
ZSh0YXNrLCB0YXNrIG5hbWUsIHN0YWNrIHNpemUsIHByaW9yaXR5LCBtb2RlCglydF90YXNrX2Ny
ZWF0ZSgmdGFzaywgc3RyLCAwLCA1MCwgMCk7CgkvLyBydF90YXNrX3N0YXJ0KHRhc2ssIHRhc2sg
ZnVuY3Rpb24sIGZ1bmN0aW9uIGFyZ3VtZW50CglydF90YXNrX3N0YXJ0KCZ0YXNrLCAmc3VtX3Rh
c2ssIDApOwoJcnRfdGFza19qb2luKCZ0YXNrKTsKfQo=
--bcaec554d9e2a09cee04ba1dae8b--

