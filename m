Message-ID: <b647ffbd0611111559y8e66c37m12deb64828a85d08@domain.hid>
Date: Sun, 12 Nov 2006 00:59:24 +0100
From: "Dmitry Adamushko" <dmitry.adamushko@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_56798_15056849.1163289564134"
Subject: [Xenomai-core] [patch] memory barriers in intr.c ::
	xnintr_lock/unlock()
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org, Jan Kiszka <jan.kiszka@domain.hid>

------=_Part_56798_15056849.1163289564134
Content-Type: multipart/alternative; 
	boundary="----=_Part_56799_26495851.1163289564134"

------=_Part_56799_26495851.1163289564134
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello,

following the recent discussion with Jan, here is a patch that aims at
allowing xnintr_lock/unlock actually do what they were supposed to do in the
first instance.

in the shirq case and smp,

1) xnintr_lock/unlock()

we have to guarantee that any possible access to the shirq handlers' list is
taken inside the lock / unlock() section. To this goal, the shirq->counter's
modification have to be separated with a memory barrier from the mentioned
above access.

so the patch takes care of it.

2) now, (1) works as long as the 2nd part (xnintr_detach() ->
xnintr_irq_detach() -> deletion of the element from the list of shirq
handlers)
also respects the rules. Here, a modification of the list (element deletion)
has to be completed before the shirq->active counter being accessed. But the
deletion takes place inside the xnlock_get/put_irq* section
(xnintr_detach()) which always implies a memory barrier in place.

In case of linux, smp_mb__after_atomic_inc() and smp_mb__before_atomic_dec()
would do the job. But so far, I decided not to add something like
xnarch_memory_barrier__after_atomic_inc() :) , provided that both seem to
end up being either mb() or barrier() at the same time (have to check more
thoroughly) anyway.

Any suggestions?

-- 
Best regards,
Dmitry Adamushko

------=_Part_56799_26495851.1163289564134
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<br>
Hello,<br>
<br>
following the recent discussion with Jan, here is a patch that aims at
allowing xnintr_lock/unlock actually do what they were supposed to do
in the first instance.<br>
<br>
in the shirq case and smp,<br>
<br>
1) xnintr_lock/unlock()<br>
<br>
we have to guarantee that any possible access to the shirq handlers'
list is taken inside the lock / unlock() section. To this goal, the
shirq-&gt;counter's modification have to be separated with a memory
barrier from the mentioned above access.<br>
<br>
so the patch takes care of it.<br>
<br>
2) now, (1) works as long as the 2nd part (xnintr_detach() -&gt;
xnintr_irq_detach() -&gt; deletion of the element from the list of
shirq handlers) <br>
also respects the rules. Here, a modification of the list (element
deletion) has to be completed before the shirq-&gt;active counter being
accessed. But the deletion takes place inside the xnlock_get/put_irq*
section (xnintr_detach()) which always implies a memory barrier in
place.<br>
<br>
In case of linux, smp_mb__after_atomic_inc() and
smp_mb__before_atomic_dec() would do the job. But so far, I decided not
to add something like xnarch_memory_barrier__after_atomic_inc() :) ,
provided that both seem to end up being either mb() or barrier() at the
same time (have to check more thoroughly) anyway.<br>
<br>
Any suggestions?<br>
<br>-- <br>Best regards,<br>Dmitry Adamushko<br>
<br>
<br>


------=_Part_56799_26495851.1163289564134--

------=_Part_56798_15056849.1163289564134
Content-Type: text/x-patch; name=intr.c-mb.patch; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_eueogsvl
Content-Disposition: attachment; filename="intr.c-mb.patch"

LS0tIHhlbm9tYWkva3NyYy9udWNsZXVzL2ludHItb2xkLmMJMjAwNi0xMS0xMiAwMDoxNzo1Ni4w
MDAwMDAwMDAgKzAxMDAKKysrIHhlbm9tYWkva3NyYy9udWNsZXVzL2ludHIuYwkyMDA2LTExLTEy
IDAwOjIyOjE1LjAwMDAwMDAwMCArMDEwMApAQCAtMTM1LDEyICsxMzUsMTQgQEAgc3RhdGljIGlu
bGluZSB2b2lkIHhuaW50cl9zaGlycV9sb2NrKHhuaQogewogI2lmZGVmIENPTkZJR19TTVAKIAl4
bmFyY2hfYXRvbWljX2luYygmc2hpcnEtPmFjdGl2ZSk7CisJeG5hcmNoX21lbW9yeV9iYXJyaWVy
KCk7CiAjZW5kaWYKIH0KIAogc3RhdGljIGlubGluZSB2b2lkIHhuaW50cl9zaGlycV91bmxvY2so
eG5pbnRyX3NoaXJxX3QgKnNoaXJxKQogewogI2lmZGVmIENPTkZJR19TTVAKKwl4bmFyY2hfbWVt
b3J5X2JhcnJpZXIoKTsKIAl4bmFyY2hfYXRvbWljX2RlYygmc2hpcnEtPmFjdGl2ZSk7CiAjZW5k
aWYKIH0K
------=_Part_56798_15056849.1163289564134--

