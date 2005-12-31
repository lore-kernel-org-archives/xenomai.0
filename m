Message-ID: <b647ffbd0512310437x6e92487es@domain.hid>
Date: Sat, 31 Dec 2005 14:37:06 +0200
From: Dmitry Adamushko <dmitry.adamushko@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_6046_1169171.1136032626884"
Subject: [Xenomai-core] [PATCH,
	RFC] nucleus:shared irq and possible ipipe problem
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org, Philippe Gerum <rpm@xenomai.org>

------=_Part_6046_1169171.1136032626884
Content-Type: multipart/alternative; 
	boundary="----=_Part_6047_20914548.1136032626884"

------=_Part_6047_20914548.1136032626884
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi everybody,

I have got a few synch-related problems while adding the code for supportin=
g
the rt shared irqs to
the nucleus layer. But at first let's take a look at some adeos code that,
well, possibly has the
same problem.

let's say the primary domain is interested in irq =3D TEST_IRQ.

CPU 0:

-  TEST_IRQ occurs.

-  ipipe_handle_irq()    The local interrupts are off on entry.

    testbit(IPIPE_HANDLE_FLAG, ipd->irqs[irq].control) shows whether a give=
n
domain is interested in handling the irq.

    Then cpu-local data is mainly used, e.g. cpudata->irq_hits[irq]++ and
proper changes of pending_lo/hi

    ...

CPU 1:

-  ... -> rthal_irq_release() ->  ipipe_virtualize_irq(TEST_IRQ, ... handle=
r
=3D NULL, ...)

-  Here, __ipipe_pipe_lock + interrupts off.

    o  ipipe_virtualize_irq() drops the IPIPE_HANDLE_FLAG and sets up
ipd->irqs[irq].handler to NULL.

    First observations, at the same time the TEST_IRQ still can be marked a=
s
pending
    (i.e. some_cpudata->irq_pending_lo/hi and irq_hits)!

CPU 0:

-  actually, ipipe_handle_irq() now (if not yet done before) may be calling
__ipipe_set_irq_bit(ipd,cpuid,irq)
    but noone is interested in this irq =3D=3D TEST_IRQ already. But no mat=
ter,
    the fact is that cpudata->irq_* of a given cpu denotes a pending irq,
let's go further.

-  later on, ipipe_sync_stage() is called for a given domain and cpu.

    It handles all irqs which are marked for the domain and cpu. So it's
based only on the check of
    cpudata->irq_(pending_(hi,lo), hits) fields.
    Let's recall that TEST_IRQ is marked here as well...

    In some way (ipipe_call_root_*irq_handler() or directly
ipd->irqs[irq].handler()) the isr handler is called
    and boom! it's NULL.


Have I missed something that prevents this?

-----

In a sense, the synch. problem I have mentioned at the beginning of this
mail reminds this scenario.

The draft patch is enclosed just to elustrate an idea.

There are 2 problems:

1) we probably don't want to hold any lock while processing the handlers
list (xnintr_intr_handler(): for all shirq->handlers).

Here we may use the approach used by linux in manage.c::free_irq() vs.
handle.c::__do_IRQ() that calls handle_IRQ_event() without the desc->lock
being locked.
The magic is in free_irq() : it removes the "action" item from the list but
then falls into busy waiting until the IRQ_INPROGRESS flag is removed. And
only then it deletes the "action" item.
At that time, the "action" item is already not on the list but still points
to the valid tail of the list so the iteration may be proceeded even if the
current item =3D=3D "deleted" one.
Blah, just I guess the presupposition here is that the operation of deletio=
n
(free_irq():: *pp =3D action->next) is atomic.

2) xnintr_irq_handler() gets a cookie which is =3D=3D xnshared_irq_t* (see
xnintr_attach) that may already be invalid at that time or, and that's a
problem, become invalid during the execution of xnintr_irq_handler().
To prevent that, we could add a flag like IRQ_INPROGRESS but

either we have to set/remove it on the adeos layer before the control is
passed to the xnintr_irq_handler() (to be sure that cookie is not
xnfree()'d. xnintr_detach() will do busy waiting)

or we may set/remove the flag in the xnintr_irq_handler() but have to ignor=
e
the passed "cookie" and
get it as cookie =3D  rthal_irq_cookie(ipd,irq). Mmm, not very gracefully I=
'd
say.

Ok, it's enough for the New Year's Eve.

Happy New Year to everybody! I wish you all the best for the New Year :o)


--
Best regards,
Dmitry Adamushko

------=_Part_6047_20914548.1136032626884
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<br>
Hi everybody,<br>
<br>
I have got a few synch-related problems while adding the code for supportin=
g the rt shared irqs to<br>
the nucleus layer. But at first let's take a look at some adeos code that, =
well, possibly has the<br>
same problem.<br>
<br>
let's say the primary domain is interested in irq =3D TEST_IRQ.<br>
<br>
CPU 0:<br>
<br>
-&nbsp; TEST_IRQ occurs.<br>
<br>
-&nbsp; ipipe_handle_irq()&nbsp;&nbsp;&nbsp; The local interrupts are off o=
n entry.<br>
<br>
&nbsp;&nbsp;&nbsp; testbit(IPIPE_HANDLE_FLAG,
ipd-&gt;irqs[irq].control) shows whether a given domain is interested
in handling the irq.<br>
<br>
&nbsp;&nbsp;&nbsp; Then cpu-local data is mainly used, e.g. cpudata-&gt;irq=
_hits[irq]++ and proper changes of pending_lo/hi<br>
&nbsp;&nbsp;&nbsp; <br>
&nbsp;&nbsp;&nbsp; ...<br>
&nbsp;&nbsp;&nbsp; <br>
CPU 1:<br>
<br>
-&nbsp; ... -&gt; rthal_irq_release() -&gt;&nbsp; ipipe_virtualize_irq(TEST=
_IRQ, ... handler =3D NULL, ...)<br>
<br>
-&nbsp; Here, __ipipe_pipe_lock + interrupts off.<br>
<br>
&nbsp;&nbsp;&nbsp; o&nbsp; ipipe_virtualize_irq() drops the IPIPE_HANDLE_FL=
AG and sets up ipd-&gt;irqs[irq].handler to NULL.<br>
&nbsp;&nbsp;&nbsp; <br>
&nbsp;&nbsp;&nbsp; First observations, at the same time the TEST_IRQ still =
can be marked as pending<br>
&nbsp;&nbsp;&nbsp; (i.e. some_cpudata-&gt;irq_pending_lo/hi and irq_hits)!<=
br>
<br>
CPU 0:<br>
<br>
-&nbsp; actually, ipipe_handle_irq() now (if not yet done before) may be ca=
lling __ipipe_set_irq_bit(ipd,cpuid,irq)<br>
&nbsp;&nbsp;&nbsp; but noone is interested in this irq =3D=3D TEST_IRQ alre=
ady. But no matter, <br>
&nbsp;&nbsp;&nbsp; the fact is that cpudata-&gt;irq_* of a given cpu denote=
s a pending irq, let's go further.<br>
<br>
-&nbsp; later on, ipipe_sync_stage() is called for a given domain and cpu.<=
br>
<br>
&nbsp;&nbsp;&nbsp; It handles all irqs which are marked for the domain and =
cpu. So it's based only on the check of<br>
&nbsp;&nbsp;&nbsp; cpudata-&gt;irq_(pending_(hi,lo), hits) fields.<br>
&nbsp;&nbsp;&nbsp; Let's recall that TEST_IRQ is marked here as well...<br>
&nbsp;&nbsp;&nbsp; <br>
&nbsp;&nbsp;&nbsp; In some way (ipipe_call_root_*irq_handler() or
directly ipd-&gt;irqs[irq].handler()) the isr handler is called<br>
&nbsp;&nbsp;&nbsp; and boom! it's NULL.<br>
&nbsp;&nbsp;&nbsp; <br>
<br>
Have I missed something that prevents this?<br>
<br>
-----<br>
<br>
In a sense, the synch. problem I have mentioned at the beginning of this ma=
il reminds this scenario.<br>
<br>
The draft patch is enclosed just to elustrate an idea.<br>
<br>
There are 2 problems:<br>
<br>
1) we probably don't want to hold any lock while processing the
handlers list (xnintr_intr_handler(): for all shirq-&gt;handlers).<br>
<br>
Here we may use the approach used by linux in manage.c::free_irq() vs.
handle.c::__do_IRQ() that calls handle_IRQ_event() without the
desc-&gt;lock being locked.<br>
The magic is in free_irq() : it removes the &quot;action&quot; item from th=
e list
but then falls into busy waiting until the IRQ_INPROGRESS flag is
removed. And only then it deletes the &quot;action&quot; item.<br>
At that time, the &quot;action&quot; item is already not on the list but st=
ill
points to the valid tail of the list so the iteration may be proceeded
even if the current item =3D=3D &quot;deleted&quot; one.<br>
Blah, just I guess the presupposition here is that the operation of deletio=
n (free_irq():: *pp =3D action-&gt;next) is atomic.<br>
<br>
2) xnintr_irq_handler() gets a cookie which is =3D=3D xnshared_irq_t* (see
xnintr_attach) that may already be invalid at that time or, and that's
a problem, become invalid during the execution of xnintr_irq_handler().<br>
To prevent that, we could add a flag like IRQ_INPROGRESS but <br>
<br>
either we have to set/remove it on the adeos layer before the control
is passed to the xnintr_irq_handler() (to be sure that cookie is not
xnfree()'d. xnintr_detach() will do busy waiting)<br>
<br>
or we may set/remove the flag in the xnintr_irq_handler() but have to ignor=
e the passed &quot;cookie&quot; and <br>
get it as cookie =3D&nbsp; rthal_irq_cookie(ipd,irq). Mmm, not very gracefu=
lly I'd say.<br>
<br>
Ok, it's enough for the New Year's Eve.<br>
<br>
Happy New Year to everybody! I wish you all the best for the New Year :o)<b=
r>
<br>
<br>-- <br>Best regards,<br>Dmitry Adamushko<br>
<br>
<br>


------=_Part_6047_20914548.1136032626884--

------=_Part_6046_1169171.1136032626884
Content-Type: application/octet-stream; name="nucleus_intr.c.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="nucleus_intr.c.patch"

LS0tIGludHIuYy1vbGQJMjAwNS0xMS0yMSAyMTo1MzoxMS4wMDAwMDAwMDAgKzAxMDAKKysrIGlu
dHIuYwkyMDA1LTEyLTMxIDExOjMxOjI3LjAwMDAwMDAwMCArMDEwMApAQCAtNDEsNiArNDEsMTMg
QEAgeG5pbnRyX3QgbmtjbG9jazsKIHN0YXRpYyB2b2lkIHhuaW50cl9pcnFfaGFuZGxlcih1bnNp
Z25lZCBpcnEsCiAJCQkgICAgICAgdm9pZCAqY29va2llKTsKIAordHlwZWRlZiBzdHJ1Y3QgeG5z
aGFyZWRfaXJxIHsKKworICAgIHhucXVldWVfdCBoYW5kbGVyczsKKworfSB4bnNoYXJlZF9pcnFf
dDsKKworCiAvKiEgCiAgKiBcZm4gaW50IHhuaW50cl9pbml0ICh4bmludHJfdCAqaW50cix1bnNp
Z25lZCBpcnEseG5pc3JfdCBpc3IseG5pYWNrX3QgaWFjayx4bmZsYWdzX3QgZmxhZ3MpCiAgKiBc
YnJpZWYgSW5pdGlhbGl6ZSBhbiBpbnRlcnJ1cHQgb2JqZWN0LgpAQCAtMTMwLDYgKzEzNyw3IEBA
IGludCB4bmludHJfaW5pdCAoeG5pbnRyX3QgKmludHIsCiAgICAgaW50ci0+aWFjayA9IGlhY2s7
CiAgICAgaW50ci0+Y29va2llID0gTlVMTDsKICAgICBpbnRyLT5oaXRzID0gMDsKKyAgICBpbml0
aCgmaW50ci0+bGluayk7CiAKICAgICByZXR1cm4gMDsKIH0KQEAgLTIwNCwxMSArMjEyLDY2IEBA
IGludCB4bmludHJfZGVzdHJveSAoeG5pbnRyX3QgKmludHIpCiBpbnQgeG5pbnRyX2F0dGFjaCAo
eG5pbnRyX3QgKmludHIsCiAJCSAgIHZvaWQgKmNvb2tpZSkKIHsKKyAgICBydGhhbF9pcnFfaGFu
ZGxlcl90IGlycV9oYW5kbGVyOworICAgIHVuc2lnbmVkIGlycSA9IGludHItPmlycTsKKyAgICB4
bnNoYXJlZF9pcnFfdCAqc2hpcnE7CisgICAgaW50IGVyciA9IDA7CisgICAgc3BsX3QgczsKKwog
ICAgIGludHItPmhpdHMgPSAwOwogICAgIGludHItPmNvb2tpZSA9IGNvb2tpZTsKLSAgICByZXR1
cm4geG5hcmNoX2hvb2tfaXJxKGludHItPmlycSwmeG5pbnRyX2lycV9oYW5kbGVyLGludHItPmlh
Y2ssaW50cik7CisKKyAgICB4bmxvY2tfZ2V0X2lycXNhdmUoJm5rbG9jayxzKTsKKworICAgIGly
cV9oYW5kbGVyID0gcnRoYWxfaXJxX2hhbmRsZXIoJnJ0aGFsX2RvbWFpbixpcnEpOworICAgIAor
ICAgIGlmIChpcnFfaGFuZGxlcikKKwl7CisJeG5pbnRyX3QgKm9sZDsKKwlzaGlycSA9IHJ0aGFs
X2lycV9jb29raWUoJnJ0aGFsX2RvbWFpbixpcnEpOworCQorCWlmIChpcnFfaGFuZGxlciAhPSAm
eG5pbnRyX2lycV9oYW5kbGVyKQorCSAgICB7CisJICAgIGVyciA9IC1FQlVTWTsKKwkgICAgZ290
byB1bmxvY2tfYW5kX2V4aXQ7CisJICAgIH0KKwkKKwlvbGQgPSBsaW5rMmludHIoZ2V0aGVhZHEo
JnNoaXJxLT5oYW5kbGVycykpOworCisJaWYgKCEob2xkLT5mbGFncyAmIGludHItPmZsYWdzICYg
WE5JU1JfU0hBUkVEX01BU0spKQorCSAgICB7CisJICAgIGVyciA9IC1FQlVTWTsKKwkgICAgZ290
byB1bmxvY2tfYW5kX2V4aXQ7CisJICAgIH0KKwkKKwlhcHBlbmRxKCZzaGlycS0+aGFuZGxlcnMs
JmludHItPmxpbmspOworCX0KKyAgICBlbHNlCisJeworCXNoaXJxID0geG5tYWxsb2Moc2l6ZW9m
KCpzaGlycSkpOworCQorCWlmICghc2hpcnEpCisJICAgIHsKKwkgICAgZXJyID0gLUVOT01FTTsK
KwkgICAgZ290byB1bmxvY2tfYW5kX2V4aXQ7CisJICAgIH0KKworCWluaXRxKCZzaGlycS0+aGFu
ZGxlcnMpOworCWFwcGVuZHEoJnNoaXJxLT5oYW5kbGVycywmaW50ci0+bGluayk7CisKKyAgICAg
ICAgZXJyID0geG5hcmNoX2hvb2tfaXJxKGlycSwmeG5pbnRyX2lycV9oYW5kbGVyLGludHItPmlh
Y2ssc2hpcnEpOworCQorCWlmIChlcnIpCisJICAgIHhuZnJlZShzaGlycSk7CisJfQorCit1bmxv
Y2tfYW5kX2V4aXQ6CisgICAgCisgICAgeG5sb2NrX3B1dF9pcnFyZXN0b3JlKCZua2xvY2sscyk7
CisgICAgcmV0dXJuIGVycjsKIH0KIAorCiAvKiEgCiAgKiBcZm4gaW50IHhuaW50cl9kZXRhY2gg
KHhuaW50cl90ICppbnRyKQogICogXGJyaWVmIERldGFjaCBhbiBpbnRlcnJ1cHQgb2JqZWN0LgpA
QCAtMjQxLDcgKzMwNCwyNiBAQCBpbnQgeG5pbnRyX2F0dGFjaCAoeG5pbnRyX3QgKmludHIsCiBp
bnQgeG5pbnRyX2RldGFjaCAoeG5pbnRyX3QgKmludHIpCiAKIHsKLSAgICByZXR1cm4geG5hcmNo
X3JlbGVhc2VfaXJxKGludHItPmlycSk7CisgICAgdW5zaWduZWQgaXJxID0gaW50ci0+aXJxOwor
ICAgIHhuc2hhcmVkX2lycV90ICpzaGlycTsKKyAgICBpbnQgZXJyID0gMDsKKyAgICBzcGxfdCBz
OworCisgICAgeG5sb2NrX2dldF9pcnFzYXZlKCZua2xvY2sscyk7CisKKyAgICBzaGlycSA9IHJ0
aGFsX2lycV9jb29raWUoJnJ0aGFsX2RvbWFpbixpcnEpOworCisgICAgcmVtb3ZlcSgmc2hpcnEt
PmhhbmRsZXJzLCZpbnRyLT5saW5rKTsKKyAgICAKKyAgICBpZiAoIWNvdW50cSgmc2hpcnEtPmhh
bmRsZXJzKSkKKwl7CisJZXJyID0geG5hcmNoX3JlbGVhc2VfaXJxKGlycSk7CisJeG5mcmVlKHNo
aXJxKTsKKwl9CisKKyAgICB4bmxvY2tfcHV0X2lycXJlc3RvcmUoJm5rbG9jayxzKTsKKworICAg
IHJldHVybiBlcnI7CiB9CiAKIC8qISAKQEAgLTM1MywxNyArNDM1LDI4IEBAIHN0YXRpYyB2b2lk
IHhuaW50cl9pcnFfaGFuZGxlciAodW5zaWduZWQKIAogewogICAgIHhuc2NoZWRfdCAqc2NoZWQg
PSB4bnBvZF9jdXJyZW50X3NjaGVkKCk7Ci0gICAgeG5pbnRyX3QgKmludHIgPSAoeG5pbnRyX3Qg
Kiljb29raWU7Ci0gICAgaW50IHM7CisgICAgeG5zaGFyZWRfaXJxX3QgKnNoaXJxID0gKHhuc2hh
cmVkX2lycV90ICopY29va2llOworICAgIHhuaG9sZGVyX3QgaG9sZGVyOworICAgIGludCBzID0g
MDsKIAogICAgIHhuYXJjaF9tZW1vcnlfYmFycmllcigpOwogCiAgICAgeG5sdHRfbG9nX2V2ZW50
KHhlbm9fZXZfaWVudGVyLGlycSk7CiAKICAgICArK3NjaGVkLT5pbmVzdGluZzsKLSAgICBzID0g
aW50ci0+aXNyKGludHIpOworICAgIAorICAgIGhvbGRlciA9IGdldGhlYWRxKCZzaGlycS0+aGFu
ZGxlcnMpOworICAgIAorICAgIHdoaWxlIChob2xkZXIpCisJeworCXhuaW50cl90ICppbnRyID0g
bGluazJpbnRyKGhvbGRlcik7CisJaG9sZGVyID0gbmV4dHEoJnNoaXJxLT5oYW5kbGVycyxob2xk
ZXIpOworCisJcyB8PSBpbnRyLT5pc3IoaW50cik7CisJKytpbnRyLT5oaXRzOworCX0KKyAgICAK
ICAgICAtLXNjaGVkLT5pbmVzdGluZzsKLSAgICArK2ludHItPmhpdHM7CiAKICAgICBpZiAocyAm
IFhOX0lTUl9FTkFCTEUpCiAJeG5hcmNoX2VuYWJsZV9pcnEoaXJxKTsK
------=_Part_6046_1169171.1136032626884
Content-Type: application/octet-stream; name="nucleus_intr.h.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="nucleus_intr.h.patch"

LS0tIGludHIuaC1vbGQJMjAwNS0xMS0yMSAyMTo1Mjo0MC4wMDAwMDAwMDAgKzAxMDAKKysrIGlu
dHIuaAkyMDA1LTEyLTMxIDEzOjUzOjM4LjAwMDAwMDAwMCArMDEwMApAQCAtMzIsMTggKzMyLDI2
IEBAIHN0cnVjdCB4bmludHI7CiAKIHR5cGVkZWYgc3RydWN0IHhuaW50ciB7CiAKLSAgICB1bnNp
Z25lZCBpcnE7CS8qICE8IElSUSBudW1iZXIuICovCisgICAgeG5ob2xkZXJfdCBsaW5rOwogCisj
ZGVmaW5lIGxpbmsyaW50cihsYWRkcikgXAorKCh4bmludHJfdCAqKSgoKGNoYXIgKilsYWRkcikg
LSAoaW50KSgmKCh4bmludHJfdCAqKTApLT5saW5rKSkpCisgICAgCiAgICAgeG5pc3JfdCBpc3I7
CS8qICE8IEludGVycnVwdCBzZXJ2aWNlIHJvdXRpbmUuICovCiAKLSAgICB4bmlhY2tfdCBpYWNr
OwkvKiAhPCBJbnRlcnJ1cHQgYWNrbm93bGVkZ2Ugcm91dGluZS4gKi8KLQogICAgIHVuc2lnbmVk
IGxvbmcgaGl0czsJLyogITwgTnVtYmVyIG9mIHJlY2VpcHRzIChzaW5jZSBhdHRhY2htZW50KS4g
Ki8KIAorICAgIHVuc2lnbmVkIGxvbmcgZmxhZ3M7CisKKyAgICB1bnNpZ25lZCBpcnE7CS8qICE8
IElSUSBudW1iZXIuICovCisgICAgCiAgICAgdm9pZCAqY29va2llOwkvKiAhPCBVc2VyLWRlZmlu
ZWQgY29va2llIHZhbHVlLiAqLwogCisgICAgeG5pYWNrX3QgaWFjazsJLyogITwgSW50ZXJydXB0
IGFja25vd2xlZGdlIHJvdXRpbmUuICovCisKIH0geG5pbnRyX3Q7CiAKKwogZXh0ZXJuIHhuaW50
cl90IG5rY2xvY2s7CiAKICNpZmRlZiBfX2NwbHVzcGx1cwo=
------=_Part_6046_1169171.1136032626884--

