Message-ID: <b647ffbd0608212353u13a450f4w16069329cea3966a@domain.hid>
Date: Tue, 22 Aug 2006 08:53:48 +0200
From: "Dmitry Adamushko" <dmitry.adamushko@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_44183_2257694.1156229628184"
Subject: [Xenomai-core] [patch, minor] irq proc output in intr.c
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

------=_Part_44183_2257694.1156229628184
Content-Type: multipart/alternative; 
	boundary="----=_Part_44184_28570147.1156229628184"

------=_Part_44184_28570147.1156229628184
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On 19/08/06, Jan Kiszka <jan.kiszka@domain.hid> wrote:
>
> just realised that the output of /proc/xenomai/irq is suboptimal (no
> names) under !CONFIG_XENO_OPT_SHIRQ_LEVEL &&
> !CONFIG_XENO_OPT_SHIRQ_EDGE...



It should be ok but just in case, Jan, pls give it a try first. I was not
able to test a branch with rthal_irq_cookie() (but as I recall it worked
when it was implemented) as I don't have any driver at hand to be loaded.

TIA,


Thanks,
> Jan
>
>

-- 
Best regards,
Dmitry Adamushko

------=_Part_44184_28570147.1156229628184
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<br><br><div><span class="gmail_quote">On 19/08/06, <b class="gmail_sendername">Jan Kiszka</b> &lt;<a href="mailto:jan.kiszka@domain.hid" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">jan.kiszka@domain.hid
</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
just realised that the output of /proc/xenomai/irq is suboptimal (no<br>names) under !CONFIG_XENO_OPT_SHIRQ_LEVEL &amp;&amp;<br>!CONFIG_XENO_OPT_SHIRQ_EDGE...</blockquote><div><br>
<br>
It should be ok but just in case, Jan, pls give it a try first. I was
not able to test a branch with rthal_irq_cookie() (but as I recall it worked when it was implemented) as I don't have any
driver at hand to be loaded.<br>
<br>
TIA,<br>
<br>
</div><br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Thanks,<br>Jan<br><br></blockquote></div><br><br>-- <br>Best regards,<br>Dmitry Adamushko
<br>
<br>


------=_Part_44184_28570147.1156229628184--

------=_Part_44183_2257694.1156229628184
Content-Type: text/x-patch; name=ext-proc.patch; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_er5yyefy
Content-Disposition: attachment; filename="ext-proc.patch"

ZGlmZiAtdXJwIHhlbm9tYWktU1ZOL2luY2x1ZGUvbnVjbGV1cy9pbnRyLmggeGVub21haS1hL2lu
Y2x1ZGUvbnVjbGV1cy9pbnRyLmgKLS0tIHhlbm9tYWktU1ZOL2luY2x1ZGUvbnVjbGV1cy9pbnRy
LmgJMjAwNi0wNy0yMCAxMTowOTowMS4wMDAwMDAwMDAgKzAyMDAKKysrIHhlbm9tYWktYS9pbmNs
dWRlL251Y2xldXMvaW50ci5oCTIwMDYtMDgtMjIgMDk6MzI6MjQuMDAwMDAwMDAwICswMjAwCkBA
IC03MSw3ICs3MSw5IEBAIGludCB4bmludHJfbW91bnQodm9pZCk7CiAKIHZvaWQgeG5pbnRyX2Ns
b2NrX2hhbmRsZXIodm9pZCk7CiAKKyNpZiBkZWZpbmVkKENPTkZJR19QUk9DX0ZTKSAmJiBkZWZp
bmVkKF9fS0VSTkVMX18pCiBpbnQgeG5pbnRyX2lycV9wcm9jKHVuc2lnbmVkIGludCBpcnEsIGNo
YXIgKnN0cik7CisjZW5kaWYgLyogQ09ORklHX1BST0NfRlMgJiYgX19LRVJORUxfXyAqLwogCiAg
ICAgLyogUHVibGljIGludGVyZmFjZS4gKi8KIApkaWZmIC11cnAgeGVub21haS1TVk4va3NyYy9u
dWNsZXVzL2ludHIuYyB4ZW5vbWFpLWEva3NyYy9udWNsZXVzL2ludHIuYwotLS0geGVub21haS1T
Vk4va3NyYy9udWNsZXVzL2ludHIuYwkyMDA2LTA3LTIwIDEyOjM1OjQwLjAwMDAwMDAwMCArMDIw
MAorKysgeGVub21haS1hL2tzcmMvbnVjbGV1cy9pbnRyLmMJMjAwNi0wOC0yMiAwOTozNDoyOC4w
MDAwMDAwMDAgKzAyMDAKQEAgLTY5MSw2ICs2OTEsNyBAQCBpbnQgeG5pbnRyX21vdW50KHZvaWQp
CiAJcmV0dXJuIDA7CiB9CiAKKyNpZiBkZWZpbmVkKENPTkZJR19QUk9DX0ZTKSAmJiBkZWZpbmVk
KF9fS0VSTkVMX18pCiBpbnQgeG5pbnRyX2lycV9wcm9jKHVuc2lnbmVkIGludCBpcnEsIGNoYXIg
KnN0cikKIHsKIAl4bmludHJfc2hpcnFfdCAqc2hpcnE7CkBAIC03MjcsNiArNzI4LDcgQEAgaW50
IHhuaW50cl9pcnFfcHJvYyh1bnNpZ25lZCBpbnQgaXJxLCBjaAogCiAJcmV0dXJuIHAgLSBzdHI7
CiB9CisjZW5kaWYgLyogQ09ORklHX1BST0NfRlMgJiYgX19LRVJORUxfXyAqLwogCiAjZWxzZSAv
KiAhQ09ORklHX1hFTk9fT1BUX1NISVJRX0xFVkVMICYmICFDT05GSUdfWEVOT19PUFRfU0hJUlFf
RURHRSAqLwogCkBAIC03MzUsMTAgKzczNywzMSBAQCBpbnQgeG5pbnRyX21vdW50KHZvaWQpCiAJ
cmV0dXJuIDA7CiB9CiAKKyNpZiBkZWZpbmVkKENPTkZJR19QUk9DX0ZTKSAmJiBkZWZpbmVkKF9f
S0VSTkVMX18pCiBpbnQgeG5pbnRyX2lycV9wcm9jKHVuc2lnbmVkIGludCBpcnEsIGNoYXIgKnN0
cikKIHsKLQlyZXR1cm4gMDsKKwl4bmludHJfdCAqaW50cjsKKwljaGFyICpwID0gc3RyOworCisJ
aWYgKHJ0aGFsX3ZpcnR1YWxfaXJxX3AoaXJxKSkgeworCQlwICs9IHNwcmludGYocCwgIiAgICAg
ICAgIFt2aXJ0dWFsXSIpOworCQlyZXR1cm4gcCAtIHN0cjsKKwl9IGVsc2UgaWYgKGlycSA9PSBY
TkFSQ0hfVElNRVJfSVJRKSB7CisJCXAgKz0gc3ByaW50ZihwLCAiICAgICAgICAgJXMiLCBua2Ns
b2NrLm5hbWUpOworCQlyZXR1cm4gcCAtIHN0cjsKKwl9CisKKwl4bmxvY2tfZ2V0X2lycXNhdmUo
Jm5rbG9jaywgcyk7CisKKwlpbnRyID0gcnRoYWxfaXJxX2Nvb2tpZSgmcnRoYWxfZG9tYWluLCBp
cnEpOworCWlmIChpbnRyICYmICooaW50ci0+bmFtZSkpCisJCXAgKz0gc3ByaW50ZihwLCAiICAg
ICAgICAlcyIsIGludHItPm5hbWUpOworCisJeG5sb2NrX3B1dF9pcnFyZXN0b3JlKCZua2xvY2ss
IHMpOworCisJcmV0dXJuIHAgLSBzdHI7CiB9CisjZW5kaWYgLyogQ09ORklHX1BST0NfRlMgJiYg
X19LRVJORUxfXyAqLwogCiAjZW5kaWYgLyogQ09ORklHX1hFTk9fT1BUX1NISVJRX0xFVkVMIHx8
IENPTkZJR19YRU5PX09QVF9TSElSUV9FREdFICovCiAK
------=_Part_44183_2257694.1156229628184
Content-Type: text/x-patch; name=ChangeLog.patch; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_er5yzacf
Content-Disposition: attachment; filename="ChangeLog.patch"

LS0tIENoYW5nZUxvZy1TVk4JMjAwNi0wOC0yMiAwMjoxNDo0My4wMDAwMDAwMDAgKzAyMDAKKysr
IENoYW5nZUxvZwkyMDA2LTA4LTIyIDAyOjE5OjIxLjAwMDAwMDAwMCArMDIwMApAQCAtMTAsNiAr
MTAsOSBAQAogCiAJKiBrc3JjL251Y2xldXMvcGlwZS5jICh4bnBpcGVfcmVjdik6IFJlLWV2YWx1
YXRlIHRoZSB0aW1lb3V0IHZhbHVlCiAJYXMgd2UgaXRlcmF0ZSBvdmVyIHRoZSBtZXNzYWdlIGFj
cXVpc2l0aW9uLgorCQorCSoga3NyYy9udWNsZXVzL2ludHIuYyAoeG5pbnRyX2lycV9wcm9jKTog
UHJpbnQgdGhlIG5hbWVzIG9mIHJlZ2lzdGVyZWQKKwloYW5kbGVycyBhbHNvIGluIGNhc2Ugb2Yg
bm9uLXNoYXJlZCBpbnRlcnJ1cHRzLgogCiAyMDA2LTA4LTIwICBHaWxsZXMgQ2hhbnRlcGVyZHJp
eCAgPGdpbGxlcy5jaGFudGVwZXJkcml4QGxhcG9zdGUubmV0PgogCg==
------=_Part_44183_2257694.1156229628184--

