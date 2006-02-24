Message-ID: <b647ffbd0602240329x21f8946br@domain.hid>
Date: Fri, 24 Feb 2006 13:29:46 +0200
From: "Dmitry Adamushko" <dmitry.adamushko@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_20673_30585533.1140780586063"
Subject: [Xenomai-core] [arm/hal.c] possible problem (and a PIC-related
	observation in vanilla Linux)
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

------=_Part_20673_30585533.1140780586063
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hello everybody,

1) arm/hal.c : rthal_irq_enable/disable/end()

the only arch that calls Linux'es enable_irq() and disable_irq() directly.

The later ones use spinlock with the interrupts off only for the Linux
domain,
so that under some circumstances - Linux domain gets preempted being in
enable/disable/setup/free_irq (THIS_IRQ) by the rt-ISR (of THIS_IRQ) -
the deadlock may happen.

rthal_irq_end() -> enable_irq() -> spin_lock_irqsave(lock,flags) ->
deadlock    (*)

wait.. does that only may happen for inter-domain shared interrupts
(THIS_IRQ must be used
in both domains)? No indeed :)

# cat /proc/interrupts   may lead to the same deadlock!

this routine is called for i =3D 0..NR_IRQS and used in fs/proc.c (arch
dependent part, e.g. i386/kernel/irq.c)

int show_interrupts(struct seq_file *p, void *v)
{
    int i =3D *(loff_t *) v, j;
    struct irqaction * action;
    unsigned long flags;

    if (i =3D=3D 0) {
        seq_printf(p, "           ");
        for_each_cpu(j)
            seq_printf(p, "CPU%d       ",j);
        seq_putc(p, '\n');
    }

    if (i < NR_IRQS) {
        spin_lock_irqsave(&irq_desc[i].lock, flags);    <--- LOCK

    [Oops!!!] We are preempted here by the rt-ISR that's registered for
"irq" only in the primary domain

        action =3D irq_desc[i].action;
        if (!action)        <--- i.e. there is no ISR in the linux domain,
thus - nothing to be printed out
            goto skip;

        ...

skip:
        spin_unlock_irqrestore(&irq_desc[i].lock, flags);

(*) takes place and BUM! :o)

So, I guess, it's better to implement rthal_irq_enable/disable/end() the
same way as other archs do.


2) This one concern Linux and not Xeno.

[so one may skip-skip-skip it :]

we know that any ISR is always called with a given local IRQ line disabled.

e.g.

__do_IRQ()
{

    .ack -> disables the IRQ line

    // all the ISRs for this IRQ line are called

    .end -> enables it.
}

If an ISR wants to defer IRQ line enabling until later (e.g. bottom half),
it may
call disable_irq_nosync() or even disable_irq() (with care as specified in
comments).

void disable_irq_nosync(unsigned int irq)
{
    irq_desc_t *desc =3D irq_desc + irq;
    unsigned long flags;

    spin_lock_irqsave(&desc->lock, flags);
        if (!desc->depth++) {                <--- inc (depth)
        desc->status |=3D IRQ_DISABLED;        <--- DISABLED is set!
        desc->handler->disable(irq);
    }
    spin_unlock_irqrestore(&desc->lock, flags);
}

In this case, .end must _not_ re-enable the IRQ line! In order to do so, it
checks for IRQ_DISABLED flag.

e.g.

here is a correct implementation: i386/kernel/i8259.c

static void end_8259A_irq (unsigned int irq)
{
    if (!(irq_desc[irq].status & (IRQ_DISABLED|IRQ_INPROGRESS)) &&
<--- i.e. was disabled in ISR
                            irq_desc[irq].action)
        enable_8259A_irq(irq);
}

end_8259A_irq() is almost the same as enable_8259A_irq() with the only
difference that
the later one always re-enables the IRQ line unconditionaly. That's why
any implementation of .end() (which re-enables the IRQ line) must always
check for IRQ_DISABLED
and never be the same routine as .enable!
Otherwise, disable_irq_nosync() being called in ISR works not as expected
(IRQ line enabling is not defered).

e.g.

arch/ppc/syslib/gt64260_pic.c

struct hw_interrupt_type gt64260_pic =3D {
    .typename =3D " gt64260_pic ",
    .enable   =3D gt64260_unmask_irq,
    .disable  =3D gt64260_mask_irq,
    .ack      =3D gt64260_mask_irq,
    .end      =3D gt64260_unmask_irq,        <--- the same as .enable (i.e.
doesn't check for IRQ_DISABLED)
};

There are a few other sub-archs that do the same.

Error?

yet another example :

static struct hw_interrupt_type xilinx_intc =3D {
    .typename =3D "Xilinx Interrupt Controller",
    .enable =3D xilinx_intc_enable,
    .disable =3D xilinx_intc_disable,
    .ack =3D xilinx_intc_disable_and_ack,
    .end =3D xilinx_intc_end,                <--- OK! This is correct.
};

but let's look at the implementation :

static void
xilinx_intc_end(unsigned int irq)
{
    unsigned long mask =3D (0x00000001 << (irq & 31));

    pr_debug("end: %d\n", irq);
    if (!(irq_desc[irq].status & (IRQ_DISABLED | IRQ_INPROGRESS))) {
        intc_out_be32(intc + SIE, mask);
        /* ack level sensitive intr */            <--- never gets executed
if ISR has called disable_irq()!
        if (irq_desc[irq].status & IRQ_LEVEL)
            intc_out_be32(intc + IAR, mask);
    }
}

so

ISR have not called disable_irq() : enable + ack.
-//- did call disable_irq()       : only enable (e.g. enable_irq() ->
handler->enable() in bottom half)

Could it be such an arch feature? It looks to me that it's logically wrong
anyway.

Heh... if one is still reading these lines, thanks for your time indeed! :o=
)


--
Best regards,
Dmitry Adamushko

------=_Part_20673_30585533.1140780586063
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<br>

Hello everybody,<br>

<br>

1) arm/hal.c : rthal_irq_enable/disable/end()<br>

<br>

the only arch that calls Linux'es enable_irq() and disable_irq() directly.<=
br>

<br>

The later ones use spinlock with the interrupts off only for the Linux doma=
in,<br>

so that under some circumstances - Linux domain gets preempted being in <br=
>

enable/disable/setup/free_irq
<div id=3D"mb_0">(THIS_IRQ) by the rt-ISR (of THIS_IRQ) -<br>
the deadlock may happen.<br>
<br>
rthal_irq_end() -&gt; enable_irq() -&gt; spin_lock_irqsave(lock,flags) -&gt=
; deadlock&nbsp;&nbsp;&nbsp; (*)<br>
<br>
wait.. does that only may happen for inter-domain shared interrupts (THIS_I=
RQ must be used<br>
in both domains)? No indeed :)<br>
<br>
# cat /proc/interrupts&nbsp;&nbsp; may lead to the same deadlock!<br>
<br>
this routine is called for i =3D 0..NR_IRQS and used in fs/proc.c (arch dep=
endent part, e.g. i386/kernel/irq.c)<br>
<br>
int show_interrupts(struct seq_file *p, void *v)<br>
{<br>
&nbsp;&nbsp;&nbsp; int i =3D *(loff_t *) v, j;<br>
&nbsp;&nbsp;&nbsp; struct irqaction * action;<br>
&nbsp;&nbsp;&nbsp; unsigned long flags;<br>
<br>
&nbsp;&nbsp;&nbsp; if (i =3D=3D 0) {<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; seq_printf(p, &quot;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;);<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; for_each_cpu(j)<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; seq_printf(p, &quo=
t;CPU%d&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;,j);<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; seq_putc(p, '\n');<br>
&nbsp;&nbsp;&nbsp; }<br>
<br>
&nbsp;&nbsp;&nbsp; if (i &lt; NR_IRQS) {<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; spin_lock_irqsave(&amp;irq_desc[i].lo=
ck, flags);&nbsp;&nbsp;&nbsp; &lt;--- LOCK<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; <br>
&nbsp;&nbsp;&nbsp; [Oops!!!] We are preempted here by the rt-ISR that's reg=
istered for &quot;irq&quot; only in the primary domain<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; <br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; action =3D irq_desc[i].action;<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; if (!action)&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp; &lt;--- i.e. there is no ISR in the linux domain,
thus - nothing to be printed out <br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; goto skip;<br>
<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; ...<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; <br>
skip:<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; spin_unlock_irqrestore(&amp;irq_desc[=
i].lock, flags);<br>
<br>
(*) takes place and BUM! :o)<br>
<br>
So, I guess, it's better to implement rthal_irq_enable/disable/end() the sa=
me way as other archs do.<br>
<br>
<br>
2) This one concern Linux and not Xeno.<br>
<br>
[so one may skip-skip-skip it :]<br>
<br>
we know that any ISR is always called with a given local IRQ line disabled.=
<br>
<br>
e.g.<br>
<br>
__do_IRQ()<br>
{<br>
<br>
&nbsp;&nbsp;&nbsp; .ack -&gt; disables the IRQ line<br>
<br>
&nbsp;&nbsp;&nbsp; // all the ISRs for this IRQ line are called<br>
<br>
&nbsp;&nbsp;&nbsp; .end -&gt; enables it.<br>
}<br>
<br>
If an ISR wants to defer IRQ line enabling until later (e.g. bottom half), =
it may<br>
call disable_irq_nosync() or even disable_irq() (with care as specified in =
comments). <br>
<br>
void disable_irq_nosync(unsigned int irq)<br>
{<br>
&nbsp;&nbsp;&nbsp; irq_desc_t *desc =3D irq_desc + irq;<br>
&nbsp;&nbsp;&nbsp; unsigned long flags;<br>
<br>
&nbsp;&nbsp;&nbsp; spin_lock_irqsave(&amp;desc-&gt;lock, flags);<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; if (!desc-&gt;depth++)
{&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp; &lt;--- inc (depth)<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; desc-&gt;status |=3D
IRQ_DISABLED;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &lt;--- DISABLED is
set!<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; desc-&gt;handler-&gt;disable(irq);<br=
>
&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp; spin_unlock_irqrestore(&amp;desc-&gt;lock, flags);<br>
}<br>
<br>
In this case, .end must _not_ re-enable the IRQ line! In order to do so, it=
 checks for IRQ_DISABLED flag.<br>
<br>
e.g.<br>
<br>
here is a correct implementation: i386/kernel/i8259.c<br>
<br>
static void end_8259A_irq (unsigned int irq)<br>
{<br>
&nbsp;&nbsp;&nbsp; if (!(irq_desc[irq].status &amp;
(IRQ_DISABLED|IRQ_INPROGRESS)) &amp;&amp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp; &lt;--- i.e. was disabled in ISR<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp; irq_desc[irq].action)<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; enable_8259A_irq(irq);<br>
}<br>
<br>
end_8259A_irq() is almost the same as enable_8259A_irq() with the only diff=
erence that<br>
the later one always re-enables the IRQ line unconditionaly. That's why <br=
>
any implementation of .end() (which re-enables the IRQ line) must always ch=
eck for IRQ_DISABLED<br>
and never be the same routine as .enable!<br>
Otherwise, disable_irq_nosync() being called in ISR works not as expected (=
IRQ line enabling is not defered). <br>
<br>
e.g.<br>
<br>
arch/ppc/syslib/gt64260_pic.c<br>
<br>
struct hw_interrupt_type gt64260_pic =3D {<br>
&nbsp;&nbsp;&nbsp; .typename =3D &quot; gt64260_pic &quot;,<br>
&nbsp;&nbsp;&nbsp; .enable&nbsp;&nbsp; =3D gt64260_unmask_irq,<br>
&nbsp;&nbsp;&nbsp; .disable&nbsp; =3D gt64260_mask_irq,<br>
&nbsp;&nbsp;&nbsp; .ack&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D gt64260_mask_irq,=
<br>
&nbsp;&nbsp;&nbsp; .end&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D
gt64260_unmask_irq,&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &lt;--- the
same as .enable (i.e. doesn't check for IRQ_DISABLED)<br>
};<br>
<br>
There are a few other sub-archs that do the same.<br>
<br>
Error?<br>
<br>
yet another example :<br>
<br>
static struct hw_interrupt_type xilinx_intc =3D {<br>
&nbsp;&nbsp;&nbsp; .typename =3D &quot;Xilinx Interrupt Controller&quot;,<b=
r>
&nbsp;&nbsp;&nbsp; .enable =3D xilinx_intc_enable,<br>
&nbsp;&nbsp;&nbsp; .disable =3D xilinx_intc_disable,<br>
&nbsp;&nbsp;&nbsp; .ack =3D xilinx_intc_disable_and_ack,<br>
&nbsp;&nbsp;&nbsp; .end =3D xilinx_intc_end,&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &lt;--- OK!
This is correct.<br>
};<br>
<br>
but let's look at the implementation :<br>
<br>
static void<br>
xilinx_intc_end(unsigned int irq)<br>
{<br>
&nbsp;&nbsp;&nbsp; unsigned long mask =3D (0x00000001 &lt;&lt; (irq &amp; 3=
1));<br>
<br>
&nbsp;&nbsp;&nbsp; pr_debug(&quot;end: %d\n&quot;, irq);<br>
&nbsp;&nbsp;&nbsp; if (!(irq_desc[irq].status &amp; (IRQ_DISABLED | IRQ_INP=
ROGRESS))) {<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; intc_out_be32(intc + SIE, mask);<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; /* ack level sensitive intr
*/&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &lt;---
never gets executed if ISR has called disable_irq()!<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; if (irq_desc[irq].status &amp; IRQ_LE=
VEL)<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; intc_out_be32(intc=
 + IAR, mask);<br>
&nbsp;&nbsp;&nbsp; }<br>
}<br>
<br>
so<br>
<br>
ISR have not called disable_irq() : enable + ack.<br>
-//- did call disable_irq()&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : only
enable (e.g. enable_irq() -&gt; handler-&gt;enable() in bottom half)<br>
<br>
Could it be such an arch feature? It looks to me that it's logically wrong =
anyway.<br>
<br>
Heh... if one is still reading these lines, thanks for your time indeed! :o=
)<br>
<br clear=3D"all"><br>-- <br>Best regards,<br><span class=3D"sg">Dmitry Ada=
mushko</span></div>


------=_Part_20673_30585533.1140780586063--

