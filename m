Message-ID: <2ff1a98a0804101116j8189495q4505db2cf8d3f435@domain.hid>
Date: Thu, 10 Apr 2008 20:16:34 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <2ff1a98a0804101103i12cdf92ehde6110763656116f@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_6282_9260199.1207851394396"
References: <000701c89a75$d349f630$9601a8c0@domain.hid>
	<18429.6412.785941.128928@domain.hid>
	<000801c89a89$b7b09820$9601a8c0@domain.hid>
	<47FD650C.7030709@domain.hid>
	<2ff1a98a0804100225q6e216a50nb0c7c78c86d8817c@domain.hid>
	<47FE25EF.9070204@domain.hid>
	<2ff1a98a0804100843u4d4c20e5rd33f0b1c94f1e78a@domain.hid>
	<2ff1a98a0804101026g3fdb4795l59895c0a7be0f5a7@domain.hid>
	<47FE53F8.2010605@domain.hid>
	<2ff1a98a0804101103i12cdf92ehde6110763656116f@domain.hid>
Subject: Re: [Xenomai-help] mlockall questions
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: jeff koftinoff <jeffk@domain.hid>
Cc: xenomai@xenomai.org

------=_Part_6282_9260199.1207851394396
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Thu, Apr 10, 2008 at 8:03 PM, Gilles Chanteperdrix
<gilles.chanteperdrix@xenomai.org> wrote:
>
> On Thu, Apr 10, 2008 at 7:52 PM, jeff koftinoff <jeffk@domain.hid> wrote:
>  > Gilles Chanteperdrix wrote:
>  >
>  > >
>  > > It looks we are wrong. The main thread stack remains allocated
>  > > on-demand, even though the process is mlocked. It must be some recent
>  > > kernel evolution
>  > >
>  >
>  >  Hmm.. interesting.  What is the best way to make sure all my stacks are not
>  > allocated on-demand?
>
>  Find attached the example I used to read the stack size of an mlocked process.
>
>  You can run it on your target to see if you get the same result as me.
>
>  Now, I suspect this on-demand allocation only exists for the main
>  thread stack, I will run further tests to confirm this. So, you may:
>  - decide not to use the main thread for real-time duties
>  - memset a large buffer on stack to force the kernel to commit memory.

Forgot the attachment, but here is a better one, which prints the main
thread stack size as well as a newly created thread stack size. It
shows that, at least in my configuration, only the main thread stack
mapping is grown on-demand.

-- 
                                               Gilles

------=_Part_6282_9260199.1207851394396
Content-Type: text/x-csrc; name=stack_size.c
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fevni20r0
Content-Disposition: attachment; filename=stack_size.c

I2luY2x1ZGUgPHVuaXN0ZC5oPgojaW5jbHVkZSA8c3RkbGliLmg+CiNpbmNsdWRlIDxzdGRpby5o
PgojaW5jbHVkZSA8c3lzL21tYW4uaD4KI2luY2x1ZGUgPHN0cmluZy5oPgojaW5jbHVkZSA8cHRo
cmVhZC5oPgoKbG9uZyBnZXRfc3RhY2tfc2l6ZSh1bnNpZ25lZCBsb25nIHN0YWNrcHRyKQp7Cglj
aGFyICpsaW5lID0gTlVMTDsKCXNpemVfdCBsaW5lc3o7CglGSUxFICpmaWxlOwoJaW50IGxlbjsK
CglmaWxlID0gZm9wZW4oIi9wcm9jL3NlbGYvbWFwcyIsICJyIik7CglpZiAoIWZpbGUpIHsKCQlw
ZXJyb3IoImZvcGVuKC9wcm9jL3NlbGYvbWFwcykiKTsKCQlleGl0KEVYSVRfRkFJTFVSRSk7Cgl9
CgoJd2hpbGUgKChsZW4gPSBnZXRsaW5lKCZsaW5lLCAmbGluZXN6LCBmaWxlKSkgIT0gLTEpIHsK
CQl1bnNpZ25lZCBsb25nIG1hcF9zdGFydCwgbWFwX2VuZDsKCgkJLyogUmVtb3ZlIHRyYWlsaW5n
IFxyXG4gKGlmIGFueSkgKi8KCQl3aGlsZSAobGluZVtsZW4gLSAxXSA9PSAnXG4nIHx8IGxpbmVb
bGVuIC0gMV0gPT0gJ1xyJykKCQkJbGluZVstLWxlbl0gPSAnXDAnOwoKCQlpZiAoc3NjYW5mKGxp
bmUsICIlbHgtJWx4IiwgJm1hcF9zdGFydCwgJm1hcF9lbmQpIDwgMikgewoJCQlwZXJyb3IoInNz
Y2FuZiIpOwoJCQlleGl0KEVYSVRfRkFJTFVSRSk7CgkJfQoKCQlpZiAoKHVuc2lnbmVkKSAoc3Rh
Y2twdHIgLSBtYXBfc3RhcnQpID49IChtYXBfZW5kIC0gbWFwX3N0YXJ0KSkKCQkJY29udGludWU7
CgoJCWZyZWUobGluZSk7CgkJZmNsb3NlKGZpbGUpOwoJCXJldHVybiBtYXBfZW5kIC0gbWFwX3N0
YXJ0OwoJfQoJaWYgKGxpbmUpCgkJZnJlZShsaW5lKTsKCWZjbG9zZShmaWxlKTsKCglmcHJpbnRm
KHN0ZGVyciwgIkNvdWxkIG5vdCBmaW5kIHN0YWNrIGluIC9wcm9jL3NlbGYvbWFwc1xuIik7Cgll
eGl0KEVYSVRfRkFJTFVSRSk7Cn0KCnVuc2lnbmVkIGxvbmcgdGhyZWFkc3RhY2s7CnZvaWQgKnRo
cmVhZCh2b2lkICpjb29raWUpCnsKCXVuc2lnbmVkIGR1bW15OwoJdGhyZWFkc3RhY2sgPSAodW5z
aWduZWQgbG9uZykgJmR1bW15OwoKCXBhdXNlKCk7CgoJcmV0dXJuIGNvb2tpZTsKfQoKaW50IG1h
aW4odm9pZCkKewoJcHRocmVhZF90IHRpZDsKCWludCBlcnI7CgoJaWYgKG1sb2NrYWxsKE1DTF9D
VVJSRU5UIHwgTUNMX0ZVVFVSRSkpIHsKCQlwZXJyb3IoIm1sb2NrYWxsIik7CgkJZXhpdChFWElU
X0ZBSUxVUkUpOwoJfQoKCWlmICgoZXJyID0gcHRocmVhZF9jcmVhdGUoJnRpZCwgTlVMTCwgdGhy
ZWFkLCBOVUxMKSkpIHsKCQlmcHJpbnRmKHN0ZGVyciwgInB0aHJlYWRfY3JlYXRlOiAlc1xuIiwg
c3RyZXJyb3IoZXJyKSk7CgkJZXhpdChFWElUX0ZBSUxVUkUpOwoJfQoJc2xlZXAoMSk7CgoJcHJp
bnRmKCJzdGFjazogJWxkS1xuIiwgZ2V0X3N0YWNrX3NpemUoKHVuc2lnbmVkIGxvbmcpICZ0aWQp
IC8gMTAyNCk7CglwcmludGYoInRocmVhZCBzdGFjazogJWxkS1xuIiwgZ2V0X3N0YWNrX3NpemUo
dGhyZWFkc3RhY2spIC8gMTAyNCk7CgoJcmV0dXJuIDA7Cn0K
------=_Part_6282_9260199.1207851394396--

