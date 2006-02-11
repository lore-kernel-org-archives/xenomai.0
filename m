Message-ID: <b647ffbd0602110331i400d7ff5k@domain.hid>
Date: Sat, 11 Feb 2006 13:31:16 +0200
From: Dmitry Adamushko <dmitry.adamushko@domain.hid>
In-Reply-To: <43ECD570.5000704@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_5334_4269781.1139657476486"
References: <43ECD570.5000704@domain.hid>
Subject: [Xenomai-core] Re: [shirq] first test results
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

------=_Part_5334_4269781.1139657476486
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Jan,

> some news from the testing front: It works fairly well - and it doesn't
> crash =3D:).

Good news indeed :)

> We set up a quite demanding test scenario which consists of
> two Sick Laser scanners feeding two UART ports at 500 Kbit/s. The UARTs
> are on a special PC104 card, sharing the same edge-triggered IRQ line.
> We were able to get data from both devices running at the same time. But
> we noticed some overruns of MAX_EDGEIRQ_COUNTER (a few per second). The
> next step on Monday will be to generate a back-trace with the
> ipipe-tracer to see if the system is "just" overloaded or if we are
> still facing problems with the driver and/or IRQ layer. Will be very
> interesting to see on that radar what's happing.

Yes.

And as an additional option,
it could be interesting to print out to the log if not all "counter" values
then min,max,average (the same like for the latency :) per second or per
1000 interrupts; so to see whether tweaking the MAX_EDGEIRQ_COUNTER may mak=
e
the things better.


> I attached two patches. One enables xeno_16550A to use the new features,
> and the other improves the /proc output of your patch slightly.
>
> Furthermore, we noticed that virtual IRQs (namely the printk forwarder)
> get displayed under /proc/xenomai/irq too. Is this useful? We wondered
> what IRQ 34 might be until code analysis of Xenomai and Ipipe revealed
> it (__ipipe_printk_virq). If it is considered useful, we should at least
> mark those irqs virtual in the output or even give them names as well.

It's a virq but it can not be __ipipe_printk_virq :)
The latter one is registered in the linux domain while we are
printing out the irqs of the primary one in /proc/xenomai/irq.

It should be xnarch_escalation_virq.

Probably, BASE_VIRQ =3D=3D 32 (if NR_IRQS =3D=3D 16).

So,

32 -    __ipipe_printk_virq (Linux domain)
33 -    rthal_apc_virq (Linux domain)
34 -    xnarch_escalation_virq (Xeno domain)

They are ordered (that's why they have such irq numbers) as
ipipe_alloc_virq()
is called for them.

That can be confirmed by :

# cat /proc/ipipe/Xenomai

...
irq 32-33: passed, virtual
irq 34: grabbed, virtual    <--- 1 virq is in the primary domain
...

# cat /proc/ipipe/Linux

irq 32-33: grabbed, virtual    <--- 2 virqs are in the linux domain
irq 34: passed, virtual


Yep, the output is confusing. At least, we may :

1) add "virq" or "virtual" quilification, smth like 34 (virtual);

2) not print them out at all.

Maybe we'd better go for 1, just in case somebody would like to know
the actual number of virq occuried. Although, I can imagine that only
for debugging reasons and of no avail for the normal users, so maybe 2 :)


> Then I stumbled over the xnintr structure. Why do you keep a copy of the
> device name?
> A "const char *" should be enough, we just have to demand
> that it will remain valid as long as the xnintr structure itself (i.e.
> during the IRQ being attached). Saves a few bytes. :)

Could be if all the users of it are initially kernel-mode entities.

But e.g. there is a version of rt_intr_create() that may be called by
user-space
apps and I extended it to support the "name" parameter too :

int rt_intr_create(RT_INTR *intr, const char *name, unsigned irq, int mode)=
;

In such a case, the kernel-side rt_intr_create() is called with the "name"
allocated on the stack in skins/native/syscall.c : __rt_intr_create())
so the initial copy of the name can not remain valid.


Thanks for the patches.


> Jan

--
Best regards,
Dmitry Adamushko

------=_Part_5334_4269781.1139657476486
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<br>
Hi Jan,<br>
<br>
&gt; some news from the testing front: It works fairly well - and it doesn'=
t<br>
&gt; crash =3D:). <br>
<br>
Good news indeed :)<br>
<br>
&gt; We set up a quite demanding test scenario which consists of<br>
&gt; two Sick Laser scanners feeding two UART ports at 500 Kbit/s. The UART=
s<br>
&gt; are on a special PC104 card, sharing the same edge-triggered IRQ line.=
<br>
&gt; We were able to get data from both devices running at the same time. B=
ut<br>
&gt; we noticed some overruns of MAX_EDGEIRQ_COUNTER (a few per second). Th=
e<br>
&gt; next step on Monday will be to generate a back-trace with the<br>
&gt; ipipe-tracer to see if the system is &quot;just&quot; overloaded or if=
 we are<br>
&gt; still facing problems with the driver and/or IRQ layer. Will be very<b=
r>
&gt; interesting to see on that radar what's happing.<br>
<br>
Yes.<br>
<br>
And as an additional option,<br>
it could be interesting to print out to the log if not all &quot;counter&qu=
ot;
values then min,max,average (the same like for the latency :) per
second or per 1000 interrupts; so to see whether tweaking the
MAX_EDGEIRQ_COUNTER may make the things better.<br>
<br>
<br>
&gt; I attached two patches. One enables xeno_16550A to use the new feature=
s,<br>
&gt; and the other improves the /proc output of your patch slightly.<br>
&gt; <br>
&gt; Furthermore, we noticed that virtual IRQs (namely the printk forwarder=
)<br>
&gt; get displayed under /proc/xenomai/irq too. Is this useful? We wondered=
<br>
&gt; what IRQ 34 might be until code analysis of Xenomai and Ipipe revealed=
<br>
&gt; it (__ipipe_printk_virq). If it is considered useful, we should at lea=
st<br>
&gt; mark those irqs virtual in the output or even give them names as well.=
<br>
<br>
It's a virq but it can not be __ipipe_printk_virq :)<br>
The latter one is registered in the linux domain while we are<br>
printing out the irqs of the primary one in /proc/xenomai/irq.<br>
<br>
It should be xnarch_escalation_virq.<br>
<br>
Probably, BASE_VIRQ =3D=3D 32 (if NR_IRQS =3D=3D 16).<br>
<br>
So,<br>
<br>
32 -&nbsp;&nbsp;&nbsp; __ipipe_printk_virq (Linux domain)<br>
33 -&nbsp;&nbsp;&nbsp; rthal_apc_virq (Linux domain)<br>
34 -&nbsp;&nbsp;&nbsp; xnarch_escalation_virq (Xeno domain)<br>
<br>
They are ordered (that's why they have such irq numbers) as ipipe_alloc_vir=
q()<br>
is called for them.<br>
<br>
That can be confirmed by :<br>
<br>
# cat /proc/ipipe/Xenomai<br>
<br>
...<br>
irq 32-33: passed, virtual<br>
irq 34: grabbed, virtual&nbsp;&nbsp;&nbsp; &lt;--- 1 virq is in the primary=
 domain<br>
...<br>
<br>
# cat /proc/ipipe/Linux<br>
<br>
irq 32-33: grabbed, virtual&nbsp;&nbsp;&nbsp; &lt;--- 2 virqs are in the li=
nux domain<br>
irq 34: passed, virtual<br>
<br>
<br>
Yep, the output is confusing. At least, we may :<br>
<br>
1) add &quot;virq&quot; or &quot;virtual&quot; quilification, smth like 34 =
(virtual);<br>
<br>
2) not print them out at all.<br>
<br>
Maybe we'd better go for 1, just in case somebody would like to know<br>
the actual number of virq occuried. Although, I can imagine that only<br>
for debugging reasons and of no avail for the normal users, so maybe 2 :)<b=
r>
<br>
<br>
&gt; Then I stumbled over the xnintr structure. Why do you keep a copy of t=
he<br>
&gt; device name?<br>
&gt; A &quot;const char *&quot; should be enough, we just have to demand<br=
>
&gt; that it will remain valid as long as the xnintr structure itself (i.e.=
<br>
&gt; during the IRQ being attached). Saves a few bytes. :)<br>
<br>
Could be if all the users of it are initially kernel-mode entities.<br>
<br>
But e.g. there is a version of rt_intr_create() that may be called by user-=
space<br>
apps and I extended it to support the &quot;name&quot; parameter too :<br>
<br>
int rt_intr_create(RT_INTR *intr, const char *name, unsigned irq, int mode)=
;<br>
<br>
In such a case, the kernel-side rt_intr_create() is called with the &quot;n=
ame&quot;<br>
allocated on the stack in skins/native/syscall.c : __rt_intr_create())<br>
so the initial copy of the name can not remain valid.<br>
<br>
<br>
Thanks for the patches.<br>
<br>
<br>
&gt; Jan<br>
<br>
-- <br>Best regards,<br>Dmitry Adamushko

------=_Part_5334_4269781.1139657476486--

