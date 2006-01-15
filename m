Message-ID: <b647ffbd0601150050k573ef53fu@domain.hid>
Date: Sun, 15 Jan 2006 10:50:58 +0200
From: Dmitry Adamushko <dmitry.adamushko@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_57285_16508617.1137315058510"
Subject: [Xenomai-core] [PATCH] shared irqs v.3
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

------=_Part_57285_16508617.1137315058510
Content-Type: multipart/alternative; 
	boundary="----=_Part_57286_32290413.1137315058510"

------=_Part_57286_32290413.1137315058510
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

here goes another implementation of shared irqs on the nucleus layer.
I have conducted a few tests and it seems to work. The test example is
attached.

There were 2 main issues concerning synchronization:

1)  xnintr_attach() vs. xnintr_detach() (and each of them vs. itself)

    The problem is that we can't use the "nklock" (nor any other lock + irq
off) as Gilles pointed out.

    A possible solution:

    o  something lick xnlock_get/put()

    There is no irqsave/restore -less interface of xnlock_get/put available=
.
For pure locking scheme
    (without touching the irqs) the concept of _preemption_ (to prevent a
thread from being preempted
    while in a locked section) must be introduced and, at the first glance,
that would be quite difficult
    since it must be consistent across all domains (if only for the primary
- that's easy).

    o  rthal_critical_enter/exit()

    This one is used currently.


2)  xnintr_attach/detach() vs. xnintr_irq_handler()

    The problem here is how to be sure that 1) the "xnintr_shirq_t" object
is valid (when dynamically allocated)
    and 2) to be safe while iterating through the handlers list.

    Currently, 1) is allowed by the static xnintr_shirq_t
xnshirqs[IPIPE_NR_IRQS]. Ok, it can be done lighter
    when a one-way-list is used instead of xnqueue_t.

    Beleive it or not, I have considered different ways to guarantee that a
passed "cookie" param is valid
    (xnintr_detach() has not deleted it) and remains to be so while the
xnintr_irq_handler() is running.
    And there are some obstacles there... I'll post them later if someone i=
s
interested since I'm short of time now :)
    ...


There are a few ugly things in code, namely __IPIPE_NR_IRQS and definitions
of rthal_critical_enter/exit().
That code is compiled for the user-mode code also and the originals are not
available. So consider it a temp
solution for test purposes, I guess it's easily fixable.

test/shirq.c - is a test module.

SHIRQ_VECTOR must be the one used by Linux, e.g. I have used 12 that's used
by the trackball device.


--
Best regards,
Dmitry Adamushko

------=_Part_57286_32290413.1137315058510
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<br>
Hi,<br>
<br>
here goes another implementation of shared irqs on the nucleus layer.<br>
I have conducted a few tests and it seems to work. The test example is atta=
ched.<br>
<br>
There were 2 main issues concerning synchronization:<br>
<br>
1)&nbsp; xnintr_attach() vs. xnintr_detach() (and each of them vs. itself)<=
br>
<br>
&nbsp;&nbsp;&nbsp; The problem is that we can't use the &quot;nklock&quot; =
(nor any other lock + irq off) as Gilles pointed out.<br>
<br>
&nbsp;&nbsp;&nbsp; A possible solution:<br>
<br>
&nbsp;&nbsp;&nbsp; o&nbsp; something lick xnlock_get/put()<br>
&nbsp;&nbsp;&nbsp; <br>
&nbsp;&nbsp;&nbsp; There is no irqsave/restore -less interface of xnlock_ge=
t/put available. For pure locking scheme<br>
&nbsp;&nbsp;&nbsp; (without touching the irqs) the concept of _preemption_ =
(to prevent a thread from being preempted<br>
&nbsp;&nbsp;&nbsp; while in a locked section) must be introduced and, at th=
e first glance, that would be quite difficult<br>
&nbsp;&nbsp;&nbsp; since it must be consistent across all domains (if only =
for the primary - that's easy).<br>
&nbsp;&nbsp;&nbsp; <br>
&nbsp;&nbsp;&nbsp; o&nbsp; rthal_critical_enter/exit()<br>
&nbsp;&nbsp;&nbsp; <br>
&nbsp;&nbsp;&nbsp; This one is used currently.<br>
&nbsp;&nbsp;&nbsp; <br>
&nbsp;&nbsp;&nbsp; <br>
2)&nbsp; xnintr_attach/detach() vs. xnintr_irq_handler()<br>
<br>
&nbsp;&nbsp;&nbsp; The problem here is how to be sure that 1) the &quot;xni=
ntr_shirq_t&quot; object is valid (when dynamically allocated)<br>
&nbsp;&nbsp;&nbsp; and 2) to be safe while iterating through the handlers l=
ist.<br>
&nbsp;&nbsp;&nbsp; <br>
&nbsp;&nbsp;&nbsp; Currently, 1) is allowed by the static xnintr_shirq_t xn=
shirqs[IPIPE_NR_IRQS]. Ok, it can be done lighter<br>
&nbsp;&nbsp;&nbsp; when a one-way-list is used instead of xnqueue_t.<br>
&nbsp;&nbsp;&nbsp; <br>
&nbsp;&nbsp;&nbsp; Beleive it or not, I have considered different ways to g=
uarantee that a passed &quot;cookie&quot; param is valid<br>
&nbsp;&nbsp;&nbsp; (xnintr_detach() has not deleted it) and remains to be s=
o while the xnintr_irq_handler() is running.<br>
&nbsp;&nbsp;&nbsp; And there are some obstacles there... I'll post them
later if someone is interested since I'm short of time now :)<br>
&nbsp;&nbsp;&nbsp; ...<br>
&nbsp;&nbsp;&nbsp; <br>
<br>
There are a few ugly things in code, namely __IPIPE_NR_IRQS and definitions=
 of rthal_critical_enter/exit().<br>
That code is compiled for the user-mode code also and the originals are not=
 available. So consider it a temp<br>
solution for test purposes, I guess it's easily fixable.<br>
<br>
test/shirq.c - is a test module.<br>
<br>
SHIRQ_VECTOR must be the one used by Linux, e.g. I have used 12 that's used=
 by the trackball device.<br>
<br>
<br>-- <br>Best regards,<br>Dmitry Adamushko

------=_Part_57286_32290413.1137315058510--

------=_Part_57285_16508617.1137315058510
Content-Type: application/octet-stream; name="shirq-2_intr.c.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="shirq-2_intr.c.patch"

LS0tIGludHItY3ZzLmMJMjAwNS0xMi0wMiAxOTo1NjoyMC4wMDAwMDAwMDAgKzAxMDAKKysrIGlu
dHIuYwkyMDA2LTAxLTE1IDA5OjM5OjM3LjAwMDAwMDAwMCArMDEwMApAQCAtNDEsNiArNDEsNjIg
QEAgeG5pbnRyX3QgbmtjbG9jazsKIHN0YXRpYyB2b2lkIHhuaW50cl9pcnFfaGFuZGxlcih1bnNp
Z25lZCBpcnEsCiAJCQkgICAgICAgdm9pZCAqY29va2llKTsKIAordHlwZWRlZiBzdHJ1Y3QgeG5p
bnRyX3NoaXJxIHsKKworICAgIHhucXVldWVfdCBoYW5kbGVyczsKKyAgICAKKyNpZmRlZiBDT05G
SUdfU01QCisgICAgYXRvbWljX2NvdW50ZXJfdCBhY3RpdmU7CisjZW5kaWYgLyogQ09ORklHX1NN
UCAqLworCit9IHhuaW50cl9zaGlycV90OworCisjZGVmaW5lIF9fSVBJUEVfTlJfSVJRUwkJMjI0
CisKK3N0YXRpYyB4bmludHJfc2hpcnFfdCB4bnNoaXJxc1tfX0lQSVBFX05SX0lSUVNdOworCitl
eHRlcm4gdW5zaWduZWQgbG9uZyBydGhhbF9jcml0aWNhbF9lbnRlcih2b2lkICgqc3luY2gpKHZv
aWQpKTsKK2V4dGVybiB2b2lkIHJ0aGFsX2NyaXRpY2FsX2V4aXQodW5zaWduZWQgbG9uZyBmbGFn
cyk7CisKKyNpZmRlZiBDT05GSUdfU01QCisKK3N0YXRpYyBpbmxpbmUgdm9pZCB4bmludHJfc2hp
cnFfbG9jayh4bmludHJfc2hpcnFfdCAqc2hpcnEpCit7CisgICAgeG5hcmNoX2F0b21pY19pbmMo
JnNoaXJxLT5hY3RpdmUpOworfQorCitzdGF0aWMgaW5saW5lIHZvaWQgeG5pbnRyX3NoaXJxX3Vu
bG9jayh4bmludHJfc2hpcnFfdCAqc2hpcnEpCit7CisgICAgeG5hcmNoX2F0b21pY19kZWMoJnNo
aXJxLT5hY3RpdmUpOworfQorCitzdGF0aWMgaW5saW5lIHZvaWQgeG5pbnRyX3NoaXJxX3NwaW4o
eG5pbnRyX3NoaXJxX3QgKnNoaXJxKQoreworICAgIHdoaWxlICh4bmFyY2hfYXRvbWljX2dldCgm
c2hpcnEtPmFjdGl2ZSkpCisJY3B1X3JlbGF4KCk7Cit9CisKKyNlbHNlIC8qICFDT05GSUdfU01Q
ICovCisKK3N0YXRpYyBpbmxpbmUgdm9pZCB4bmludHJfc2hpcnFfbG9jayh4bmludHJfc2hpcnFf
dCAqc2hpcnEpIHt9CitzdGF0aWMgaW5saW5lIHZvaWQgeG5pbnRyX3NoaXJxX3VubG9jayh4bmlu
dHJfc2hpcnFfdCAqc2hpcnEpIHt9CitzdGF0aWMgaW5saW5lIHZvaWQgeG5pbnRyX3NoaXJxX3Nw
aW4oeG5pbnRyX3NoaXJxX3QgKnNoaXJxKSB7fQorCisjZW5kaWYgLyogQ09ORklHX1NNUCAqLwor
CitpbnQgeG5pbnRyX21vdW50KHZvaWQpCit7CisgICAgaW50IGk7CisgICAgZm9yIChpID0gMDsg
aSA8IF9fSVBJUEVfTlJfSVJRUzsgKytpKQorCXsKKwlpbml0cSgmeG5zaGlycXNbaV0uaGFuZGxl
cnMpOworI2lmZGVmIENPTkZJR19TTVAKKwlhdG9taWNfc2V0KCZ4bnNoaXJxc1tpXS5hY3RpdmUs
MCk7CisjZW5kaWYgLyogQ09ORklHX1NNUCAqLworCX0KKyAgICByZXR1cm4gMDsKK30KKwogLyoh
IAogICogXGZuIGludCB4bmludHJfaW5pdCAoeG5pbnRyX3QgKmludHIsdW5zaWduZWQgaXJxLHhu
aXNyX3QgaXNyLHhuaWFja190IGlhY2sseG5mbGFnc190IGZsYWdzKQogICogXGJyaWVmIEluaXRp
YWxpemUgYW4gaW50ZXJydXB0IG9iamVjdC4KQEAgLTEzMCw2ICsxODYsOCBAQCBpbnQgeG5pbnRy
X2luaXQgKHhuaW50cl90ICppbnRyLAogICAgIGludHItPmlhY2sgPSBpYWNrOwogICAgIGludHIt
PmNvb2tpZSA9IE5VTEw7CiAgICAgaW50ci0+aGl0cyA9IDA7CisgICAgaW50ci0+ZmxhZ3MgPSBm
bGFnczsKKyAgICBpbml0aCgmaW50ci0+bGluayk7CiAKICAgICByZXR1cm4gMDsKIH0KQEAgLTE4
MSw4ICsyMzksNyBAQCBpbnQgeG5pbnRyX2Rlc3Ryb3kgKHhuaW50cl90ICppbnRyKQogICoKICAq
IEBwYXJhbSBjb29raWUgQSB1c2VyLWRlZmluZWQgb3BhcXVlIHZhbHVlIHdoaWNoIGlzIHN0b3Jl
ZCBpbnRvIHRoZQogICogaW50ZXJydXB0IG9iamVjdCBkZXNjcmlwdG9yIGZvciBmdXJ0aGVyIHJl
dHJpZXZhbCBieSB0aGUgSVNSL0lTUgotICogaGFuZGxlcnMuCi0gKgorICogaGFuZGxlcnMuICoK
ICAqIEByZXR1cm4gMCBpcyByZXR1cm5lZCBvbiBzdWNjZXNzLiBPdGhlcndpc2UsIC1FSU5WQUwg
aXMgcmV0dXJuZWQgaWYKICAqIGEgbG93LWxldmVsIGVycm9yIG9jY3VycmVkIHdoaWxlIGF0dGFj
aGluZyB0aGUgaW50ZXJydXB0LiAtRUJVU1kgaXMKICAqIHNwZWNpZmljYWxseSByZXR1cm5lZCBp
ZiB0aGUgaW50ZXJydXB0IG9iamVjdCB3YXMgYWxyZWFkeSBhdHRhY2hlZC4KQEAgLTIwNCwxMSAr
MjYxLDQ1IEBAIGludCB4bmludHJfZGVzdHJveSAoeG5pbnRyX3QgKmludHIpCiBpbnQgeG5pbnRy
X2F0dGFjaCAoeG5pbnRyX3QgKmludHIsCiAJCSAgIHZvaWQgKmNvb2tpZSkKIHsKKyAgICB4bmlu
dHJfc2hpcnFfdCAqc2hpcnEgPSAmeG5zaGlycXNbaW50ci0+aXJxXTsKKyAgICBpbnQgZXJyID0g
MCwgc2V0dXAgPSAwLCBuOworICAgIHVuc2lnbmVkIGxvbmcgZmxhZ3M7CisKICAgICBpbnRyLT5o
aXRzID0gMDsKICAgICBpbnRyLT5jb29raWUgPSBjb29raWU7Ci0gICAgcmV0dXJuIHhuYXJjaF9o
b29rX2lycShpbnRyLT5pcnEsJnhuaW50cl9pcnFfaGFuZGxlcixpbnRyLT5pYWNrLGludHIpOwor
CisgICAgZmxhZ3MgPSBydGhhbF9jcml0aWNhbF9lbnRlcihOVUxMKTsKKworICAgIGlmIChuID0g
Y291bnRxKCZzaGlycS0+aGFuZGxlcnMpKQorCXsKKwl4bmludHJfdCAqb2xkID0gbGluazJ4bmlu
dHIoZ2V0aGVhZHEoJnNoaXJxLT5oYW5kbGVycykpOworCisJaWYgKCEob2xkLT5mbGFncyAmIGlu
dHItPmZsYWdzICYgWE5fSVNSX1NIQVJFRCkpCisJICAgIHsKKwkgICAgZXJyID0gLUVCVVNZOwor
CSAgICBnb3RvIHVubG9ja19hbmRfZXhpdDsKKwkgICAgfQorCX0KKyAgICBlbHNlCisJc2V0dXAg
PSAxOworCisgICAgYXBwZW5kcSgmc2hpcnEtPmhhbmRsZXJzLCZpbnRyLT5saW5rKTsKKworICAg
IGlmIChzZXR1cCkKKwl7CisJZXJyID0geG5hcmNoX2hvb2tfaXJxKGludHItPmlycSwmeG5pbnRy
X2lycV9oYW5kbGVyLGludHItPmlhY2ssTlVMTCk7CisKKwlpZiAoZXJyKQorCSAgICByZW1vdmVx
KCZzaGlycS0+aGFuZGxlcnMsJmludHItPmxpbmspOworCX0KKwordW5sb2NrX2FuZF9leGl0Ogor
CisgICAgcnRoYWxfY3JpdGljYWxfZXhpdChmbGFncyk7CisgICAgcmV0dXJuIGVycjsKIH0KIAor
CiAvKiEgCiAgKiBcZm4gaW50IHhuaW50cl9kZXRhY2ggKHhuaW50cl90ICppbnRyKQogICogXGJy
aWVmIERldGFjaCBhbiBpbnRlcnJ1cHQgb2JqZWN0LgpAQCAtMjQxLDcgKzMzMiwyNyBAQCBpbnQg
eG5pbnRyX2F0dGFjaCAoeG5pbnRyX3QgKmludHIsCiBpbnQgeG5pbnRyX2RldGFjaCAoeG5pbnRy
X3QgKmludHIpCiAKIHsKLSAgICByZXR1cm4geG5hcmNoX3JlbGVhc2VfaXJxKGludHItPmlycSk7
CisgICAgeG5pbnRyX3NoaXJxX3QgKnNoaXJxID0gJnhuc2hpcnFzW2ludHItPmlycV07CisgICAg
dW5zaWduZWQgbG9uZyBmbGFnczsKKyAgICBpbnQgZXJyID0gMDsKKworICAgIGZsYWdzID0gcnRo
YWxfY3JpdGljYWxfZW50ZXIoTlVMTCk7CisKKyAgICByZW1vdmVxKCZzaGlycS0+aGFuZGxlcnMs
JmludHItPmxpbmspOworCisgICAgaWYgKCFjb3VudHEoJnNoaXJxLT5oYW5kbGVycykpCisJZXJy
ID0geG5hcmNoX3JlbGVhc2VfaXJxKGludHItPmlycSk7CisKKyAgICBydGhhbF9jcml0aWNhbF9l
eGl0KGZsYWdzKTsKKworICAgIC8qIFRoZSBpZGVhIGhlcmUgaXMgdG8ga2VlcCB0aGUgcmVtb3Zl
ZCB4bmludHJfdCBlbGVtZW50IHZhbGlkIGFzIGxvbmcKKyAgICAgICBhcyB0aGUgY29ycmVzcG9u
ZGluZyBpcnEgaGFuZGxlciBpcyBydW5uaW5nLiBUaGlzIGlzIG9uZSBvZiB0aGUgcmVxdWlyZW1l
bnRzCisgICAgICAgdG8gaXRlcmF0ZSBvdmVyIHRoZSB4bmludHJfc2hpcnFfdDo6aGFuZGxlcnMg
bGlzdCBpbiB4bmludHJfaXJxX2hhbmRsZXIoKQorICAgICAgIGluIGEgbG9ja2xlc3Mgd2F5LiAq
LworCisgICAgeG5pbnRyX3NoaXJxX3NwaW4oc2hpcnEpOworCisgICAgcmV0dXJuIGVycjsKIH0K
IAogLyohIApAQCAtMzUwLDE3ICs0NjEsMzIgQEAgc3RhdGljIHZvaWQgeG5pbnRyX2lycV9oYW5k
bGVyICh1bnNpZ25lZAogCiB7CiAgICAgeG5zY2hlZF90ICpzY2hlZCA9IHhucG9kX2N1cnJlbnRf
c2NoZWQoKTsKLSAgICB4bmludHJfdCAqaW50ciA9ICh4bmludHJfdCAqKWNvb2tpZTsKLSAgICBp
bnQgczsKKyAgICB4bmludHJfc2hpcnFfdCAqc2hpcnEgPSAmeG5zaGlycXNbaXJxXTsKKyAgICB4
bmhvbGRlcl90ICpob2xkZXI7CisgICAgaW50IHMgPSAwOwogCiAgICAgeG5hcmNoX21lbW9yeV9i
YXJyaWVyKCk7CiAKICAgICB4bmx0dF9sb2dfZXZlbnQoeGVub19ldl9pZW50ZXIsaXJxKTsKIAog
ICAgICsrc2NoZWQtPmluZXN0aW5nOwotICAgIHMgPSBpbnRyLT5pc3IoaW50cik7CisKKyAgICB4
bmludHJfc2hpcnFfbG9jayhzaGlycSk7CisgICAgCisgICAgaG9sZGVyID0gZ2V0aGVhZHEoJnNo
aXJxLT5oYW5kbGVycyk7CisgICAgCisgICAgd2hpbGUgKGhvbGRlcikKKwl7CisJeG5pbnRyX3Qg
KmludHIgPSBsaW5rMnhuaW50cihob2xkZXIpOworCWhvbGRlciA9IG5leHRxKCZzaGlycS0+aGFu
ZGxlcnMsaG9sZGVyKTsKKworCXMgfD0gaW50ci0+aXNyKGludHIpOworCSsraW50ci0+aGl0czsK
Kwl9CisKKyAgICB4bmludHJfc2hpcnFfdW5sb2NrKHNoaXJxKTsKKwogICAgIC0tc2NoZWQtPmlu
ZXN0aW5nOwotICAgICsraW50ci0+aGl0czsKIAogICAgIGlmIChzICYgWE5fSVNSX0VOQUJMRSkK
IAl4bmFyY2hfZW5hYmxlX2lycShpcnEpOwpAQCAtMzg0LDYgKzUxMCw3IEBAIHN0YXRpYyB2b2lk
IHhuaW50cl9pcnFfaGFuZGxlciAodW5zaWduZWQKICAgICB4bmx0dF9sb2dfZXZlbnQoeGVub19l
dl9pZXhpdCxpcnEpOwogfQogCisKIC8qQH0qLwogCiBFWFBPUlRfU1lNQk9MKHhuaW50cl9hdHRh
Y2gpOwo=
------=_Part_57285_16508617.1137315058510
Content-Type: application/octet-stream; name="shirq-2_intr.h.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="shirq-2_intr.h.patch"

LS0tIGludHItY3ZzLmgJMjAwNS0xMS0wMSAyMzozNzo0NS4wMDAwMDAwMDAgKzAxMDAKKysrIGlu
dHIuaAkyMDA2LTAxLTE0IDIwOjEzOjE5LjAwMDAwMDAwMCArMDEwMApAQCAtMjYsMjEgKzI2LDMx
IEBACiAjZGVmaW5lIFhOX0lTUl9DSEFJTkVEICAgMHgxCiAjZGVmaW5lIFhOX0lTUl9FTkFCTEUg
ICAgMHgyCiAKKy8qIENyZWF0aW9uIGZsYWdzLiAqLworI2RlZmluZSBYTl9JU1JfU0hBUkVECSAw
eDEKKwogI2lmIGRlZmluZWQoX19LRVJORUxfXykgfHwgZGVmaW5lZChfX1hFTk9fVVZNX18pIHx8
IGRlZmluZWQoX19YRU5PX1NJTV9fKQogCiBzdHJ1Y3QgeG5pbnRyOwogCiB0eXBlZGVmIHN0cnVj
dCB4bmludHIgewogCi0gICAgdW5zaWduZWQgaXJxOwkvKiAhPCBJUlEgbnVtYmVyLiAqLworICAg
IHhuaG9sZGVyX3QgbGluazsKIAorI2RlZmluZSBsaW5rMnhuaW50cihsYWRkcikgXAorKCh4bmlu
dHJfdCAqKSgoKGNoYXIgKilsYWRkcikgLSAoaW50KSgmKCh4bmludHJfdCAqKTApLT5saW5rKSkp
CisgICAgCiAgICAgeG5pc3JfdCBpc3I7CS8qICE8IEludGVycnVwdCBzZXJ2aWNlIHJvdXRpbmUu
ICovCiAKLSAgICB4bmlhY2tfdCBpYWNrOwkvKiAhPCBJbnRlcnJ1cHQgYWNrbm93bGVkZ2Ugcm91
dGluZS4gKi8KKyAgICB2b2lkICpjb29raWU7CS8qICE8IFVzZXItZGVmaW5lZCBjb29raWUgdmFs
dWUuICovCiAKICAgICB1bnNpZ25lZCBsb25nIGhpdHM7CS8qICE8IE51bWJlciBvZiByZWNlaXB0
cyAoc2luY2UgYXR0YWNobWVudCkuICovCiAKLSAgICB2b2lkICpjb29raWU7CS8qICE8IFVzZXIt
ZGVmaW5lZCBjb29raWUgdmFsdWUuICovCisgICAgeG5mbGFnc190IGZsYWdzOyAJLyogITwgQ3Jl
YXRpb24gZmxhZ3MuICovCisKKyAgICB1bnNpZ25lZCBpcnE7CS8qICE8IElSUSBudW1iZXIuICov
CisKKyAgICB4bmlhY2tfdCBpYWNrOwkvKiAhPCBJbnRlcnJ1cHQgYWNrbm93bGVkZ2Ugcm91dGlu
ZS4gKi8KIAogfSB4bmludHJfdDsKIApAQCAtNTAsNiArNjAsOCBAQCBleHRlcm4geG5pbnRyX3Qg
bmtjbG9jazsKIGV4dGVybiAiQyIgewogI2VuZGlmCiAKK2ludCB4bmludHJfbW91bnQodm9pZCk7
CisKIHZvaWQgeG5pbnRyX2Nsb2NrX2hhbmRsZXIodm9pZCk7CiAKICAgICAvKiBQdWJsaWMgaW50
ZXJmYWNlLiAqLwo=
------=_Part_57285_16508617.1137315058510
Content-Type: application/octet-stream; name="shirq-2_module.c.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="shirq-2_module.c.patch"

LS0tIG1vZHVsZS1jdnMuYwkyMDA2LTAxLTE1IDA5OjMzOjEwLjAwMDAwMDAwMCArMDEwMAorKysg
bW9kdWxlLmMJMjAwNi0wMS0xNCAyMDowMjo1MS4wMDAwMDAwMDAgKzAxMDAKQEAgLTcxNCw2ICs3
MTQsOCBAQCBpbnQgX19pbml0IF9feGVub19zeXNfaW5pdCAodm9pZCkKICAgICB4bnBvZF9pbml0
X3Byb2MoKTsKICNlbmRpZiAvKiBDT05GSUdfUFJPQ19GUyAqLwogCisgICAgeG5pbnRyX21vdW50
KCk7CisKICNpZmRlZiBDT05GSUdfTFRUCiAgICAgeG5sdHRfbW91bnQoKTsKICNlbmRpZiAvKiBD
T05GSUdfTFRUICovCg==
------=_Part_57285_16508617.1137315058510
Content-Type: application/x-gzip; name="test-shirq.tgz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="test-shirq.tgz"

H4sIAOAVykMAA+1WW1PiSBTmlf4Vpxx3FlhCIIpU6bpVDESlRHBBdnyYqkyTNNJjLmyn42pNzX/f
00lQYRlXp9aZh+3vgZjuc/nONUoWS7PwuqgjWs2mejZazXr63tjdTZ85Co36zp61W99t1luFeqPe
qu8UoPnKvFIksaQCoODxIHhajon4exD6vpCq/mf0ms24z17JhyrwXlbvjfVvYc3T+lvNRsvaw/pb
O02rAPVX4rOC/3n9yak9Gth95w97NO4NB3AIH5OQBgwM8ZEcTdSZ0+2N8NxMYmHesjAKKDfJ8q5z
1G8fj/Ha6Jk+n5pB5CU+i83t0qrhsjlNuO+ZPHT9xGPwgRSN3nbpwUP5/sroOiPbHlyM2oOLVK7r
HA8mzng4GXVsMBZ8gTKzMDJiKbgrDepzGvPwihD7EpWWlH5BTu+p78O9l+yiTEg0/WQEsH8I8ZyL
P2sRiQM+p+61gRfx43OyTMv+Sl6Ix2Y08eU+KW6XztqndhmMDqzFvxo4jCfvMMrx4Xbp/H23DLkc
Ia7PaIiGRIBBQaUWQa1ScwMPlr8oWXNzRtdRJihmUJPBwrnBnuRRGJNvrn86/5lx9z9sqxX8y/zv
7OC3YXX/W5ba/3r+Xx9mhUAFLuY8BvUFAHwuqJAQzUDOGVzag+FZuwcLEX1irqyh8L08nl0JGiiV
mWAM4mgm/6KCHcBdlIBLQxDM42pIp4lEyxJo6JmRUAawqfnsTp0locdE6ksyEcRLxzjxcMxCJqgP
58nU5y70ucvCmAGNlYWFOoznzIPpXapxpDiMcw5wFKFhKnE4DoBxvBeQDwtYuQ9lJbdZhUhAiUrF
XEC0UHplpHsHPpUPqsvwuyx2BU+l9uECJwi3z32qsE9u0Gq8ryTHcyTjQW/0O77h1nyzXHK/hglO
fhIvN2pt/tuGSx5KoW7IG9w4PMT4TtAU7tTOxXBUbFiE3IZKxpGgHtX01zogBJ/ZynDmmHSfidK9
YMWNomvOyuQzAcRtSIU7d/zoiglR2jIMY00Rd5thfAi3ymhWKQgmExHC5cDpjUdO56TdG9jdA/Jl
g1PrBV7X/VqZ42e6Tn07jkqmE1/z0OEh9lbpJuIe7vvMpxJBb2jLrKSJUhXJyKQklUrpbZbHx3mu
wtsVZlUYTPr96pLG+KQ9srtIUZlC+/gtzA1SKak7X5pUSrkUn0EJJcuk+JkU11KxqluGGcWx9Kq5
5Z84piN9QVPFPB8N/PML2ZTXNEqcz+FpnsU8cuuroVtPx259U/DWj4veWgn/URPV075RDbLSN+z2
a32D/utZAJt8+Uz+HIPH8MnSFD/yuJIXjz3k5R8J2ZyNXCXVeCojz+JlPYeY9XJm1ouppY1lZP8I
YVWC6IZ5GTksTHacNeb6XKNEfq2qVVovH16fDbuTvu30ex17MLZLW8fnfWX3R39sNTQ0NDQ0NDQ0
NDQ0NDQ0NDQ0NDQ0NDQ0vgP+BpRY17AAKAAA
------=_Part_57285_16508617.1137315058510--

