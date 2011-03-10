MIME-Version: 1.0
Sender: madjsw@domain.hid
In-Reply-To: <4D791819.8090106@domain.hid>
References: <AANLkTim6O4XMWav05C5LRKN3snqeicZbCzqB-czkx2sW@mail.gmail.com>
	<4D787DB7.2020503@domain.hid> <4D78CC23.5030302@domain.hid>
	<AANLkTik_2=H8f3CjEzPVsrVOzMtCkFWt+YAmZMbTR1q2@domain.hid>
	<4D791819.8090106@domain.hid>
Date: Thu, 10 Mar 2011 12:37:08 -0600
Message-ID: <AANLkTikPUuyf-kp0bfLLec4LVAcUUdNRH2EsjcAAAYdB@mail.gmail.com>
From: Jeff Weber <jwamsc@domain.hid>
Content-Type: multipart/alternative; boundary=0016363ba5ab0983a6049e2522e3
Subject: Re: [Xenomai-help] rtdm_printk
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

--0016363ba5ab0983a6049e2522e3
Content-Type: text/plain; charset=ISO-8859-1

On Thu, Mar 10, 2011 at 12:27 PM, Gilles Chanteperdrix <
gilles.chanteperdrix@xenomai.org> wrote:

> Jeff Weber wrote:
> > On Thu, Mar 10, 2011 at 7:03 AM, Gilles Chanteperdrix <
> > gilles.chanteperdrix@xenomai.org> wrote:
> >
> >> Gilles Chanteperdrix wrote:
> >>> Jeff Weber wrote:
> >>>> When writing a RTDM kernel module driver, when must rtdm_printk() be
> >> used
> >>>> instead of printk() ?
> >>> If RTDM was, one day, ported over something else than a Linux
> >>> kernel-space based solution (for instance, over a port of Xenomai
> >>> without Linux, or in Linux user-space), then you would not have to
> >>> change your driver codeto have it compile over that new port.
> >>>
> >>> Until then, printk and rtdm_printk are identical.
> >>>
> >>> Note that the first paragraph is something very hypothetical, because
> in
> >>> an RTDM driver, you generally have some other Linux kernel-space
> >>> specific code, such as for instance the registration as a PCI driver,
> >>> though the necessary parts of the Linux API could be implemented for
> >>> that hypothetical port. But in that case, so could printk.
> >>>
> >>> So...
> >> I guess the real reason for rtdm_printk is that at some point in the
> >> past (probably before the Adeos era), printk was not safe to be called
> >> from the real-time domain. In that case, rtdm_printk would be safe to be
> >> called from the real-time domain. So, the answer is that you should use
> >> rtdm_printk if you are calling from a Xenomai domain interrupt handler,
> >> or from the context of a thread running in primary mode.
> >>
> >>
> > What happens when a driver executes a non-realtime kernel function, from
> a
> > Xenomai domain interrupt handler, or from the context of a thread running
> in
> > primary mode?  Say the driver executes kmalloc() instead of
> rtdm_malloc(),
> > or copy_to_user() instead of rtdm_copy_to_user().  Hopefully these are
> > better examples than [rtdm_]printk() .
> >
> > Does the offending user space thread transition to secondary mode?
> >
> > What happens to the offending interrupt handler?
> >
> > Do the notions of primary, secondary mode apply to the kernel as well?
>
> The notion of primary, secondary mode applies to user-space Xenomai
> threads. However, the mechanism used to automatically switch between
> primary and secondary mode is the system calls handling. So, in short,
> if you already are in kernel-space and call a non-realtime compatible
> linux kernel function, you risk anything from fault to lockup, or debug
> message if you have I-pipe debugging enabled. Daemons are flying around
> your nose.
>
> >
> >
> > Perhaps it's easier not analyze, separate all the non/realtime driver
> > contexts, and always use the rtdm_ functions; say rtdm_malloc()
> everywhere
> > in the driver (never use kmalloc).  Would this practice work?
>
> It is not really hard, in a driver, to know whether you are in the
> Xenomai or Linux domain. Everything executed by Linux is executing in
> Linux domain (so init_module, exit_module, any callback you register to
> a Linux subsystem, such as pci), as well as the _nrt callbaccks of an
> RTDM driver. Irq handlers registered with rtdm_irq_request aand the _rt
> callbacks registered in RTDM drivers/protocol are executed in primary
> domain.
>
> Say I have a driver utility function that can be called indirectly from
either RT or NRT contexts, and say this function in turn needs to allocate
kernel memory.  Can the function safely call rtdm_malloc regardless of the
context?  Or, must the code test for the NRT/RT context and call kmalloc()
or rtdm_malloc() appropriately?

Jeff

--0016363ba5ab0983a6049e2522e3
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><div class=3D"gmail_quote">On Thu, Mar 10, 2011 at 12:27 PM, Gilles Cha=
nteperdrix <span dir=3D"ltr">&lt;<a href=3D"mailto:gilles.chanteperdrix@xenomai.org=
omai.org">gilles.chanteperdrix@xenomai.org</a>&gt;</span> wrote:<br><blockq=
uote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; border-left:=
 1px solid rgb(204, 204, 204); padding-left: 1ex;">
<div><div></div><div class=3D"h5">Jeff Weber wrote:<br>
&gt; On Thu, Mar 10, 2011 at 7:03 AM, Gilles Chanteperdrix &lt;<br>
&gt; <a href=3D"mailto:gilles.chanteperdrix@xenomai.org">gilles.chanteperdr=
ix@domain.hid</a>&gt; wrote:<br>
&gt;<br>
&gt;&gt; Gilles Chanteperdrix wrote:<br>
&gt;&gt;&gt; Jeff Weber wrote:<br>
&gt;&gt;&gt;&gt; When writing a RTDM kernel module driver, when must rtdm_p=
rintk() be<br>
&gt;&gt; used<br>
&gt;&gt;&gt;&gt; instead of printk() ?<br>
&gt;&gt;&gt; If RTDM was, one day, ported over something else than a Linux<=
br>
&gt;&gt;&gt; kernel-space based solution (for instance, over a port of Xeno=
mai<br>
&gt;&gt;&gt; without Linux, or in Linux user-space), then you would not hav=
e to<br>
&gt;&gt;&gt; change your driver codeto have it compile over that new port.<=
br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Until then, printk and rtdm_printk are identical.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Note that the first paragraph is something very hypothetical, =
because in<br>
&gt;&gt;&gt; an RTDM driver, you generally have some other Linux kernel-spa=
ce<br>
&gt;&gt;&gt; specific code, such as for instance the registration as a PCI =
driver,<br>
&gt;&gt;&gt; though the necessary parts of the Linux API could be implement=
ed for<br>
&gt;&gt;&gt; that hypothetical port. But in that case, so could printk.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; So...<br>
&gt;&gt; I guess the real reason for rtdm_printk is that at some point in t=
he<br>
&gt;&gt; past (probably before the Adeos era), printk was not safe to be ca=
lled<br>
&gt;&gt; from the real-time domain. In that case, rtdm_printk would be safe=
 to be<br>
&gt;&gt; called from the real-time domain. So, the answer is that you shoul=
d use<br>
&gt;&gt; rtdm_printk if you are calling from a Xenomai domain interrupt han=
dler,<br>
&gt;&gt; or from the context of a thread running in primary mode.<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt; What happens when a driver executes a non-realtime kernel function, fr=
om a<br>
&gt; Xenomai domain interrupt handler, or from the context of a thread runn=
ing in<br>
&gt; primary mode? =A0Say the driver executes kmalloc() instead of rtdm_mal=
loc(),<br>
&gt; or copy_to_user() instead of rtdm_copy_to_user(). =A0Hopefully these a=
re<br>
&gt; better examples than [rtdm_]printk() .<br>
&gt;<br>
&gt; Does the offending user space thread transition to secondary mode?<br>
&gt;<br>
&gt; What happens to the offending interrupt handler?<br>
&gt;<br>
&gt; Do the notions of primary, secondary mode apply to the kernel as well?=
<br>
<br>
</div></div>The notion of primary, secondary mode applies to user-space Xen=
omai<br>
threads. However, the mechanism used to automatically switch between<br>
primary and secondary mode is the system calls handling. So, in short,<br>
if you already are in kernel-space and call a non-realtime compatible<br>
linux kernel function, you risk anything from fault to lockup, or debug<br>
message if you have I-pipe debugging enabled. Daemons are flying around<br>
your nose.<br>
<div class=3D"im"><br>
&gt;<br>
&gt;<br>
&gt; Perhaps it&#39;s easier not analyze, separate all the non/realtime dri=
ver<br>
&gt; contexts, and always use the rtdm_ functions; say rtdm_malloc() everyw=
here<br>
&gt; in the driver (never use kmalloc). =A0Would this practice work?<br>
<br>
</div>It is not really hard, in a driver, to know whether you are in the<br=
>
Xenomai or Linux domain. Everything executed by Linux is executing in<br>
Linux domain (so init_module, exit_module, any callback you register to<br>
a Linux subsystem, such as pci), as well as the _nrt callbaccks of an<br>
RTDM driver. Irq handlers registered with rtdm_irq_request aand the _rt<br>
callbacks registered in RTDM drivers/protocol are executed in primary<br>
domain.<br><br></blockquote><div>Say I have a driver utility function that =
can be called indirectly from either RT or NRT contexts, and say this funct=
ion in turn needs to allocate kernel memory.=A0 Can the function safely cal=
l rtdm_malloc regardless of the context?=A0 Or, must the code test for the =
NRT/RT context and call kmalloc() or rtdm_malloc() appropriately?<br>
<br>Jeff <br></div></div>

--0016363ba5ab0983a6049e2522e3--

