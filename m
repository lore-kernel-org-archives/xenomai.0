MIME-Version: 1.0
Sender: madjsw@domain.hid
In-Reply-To: <4D78CC23.5030302@domain.hid>
References: <AANLkTim6O4XMWav05C5LRKN3snqeicZbCzqB-czkx2sW@mail.gmail.com>
	<4D787DB7.2020503@domain.hid> <4D78CC23.5030302@domain.hid>
Date: Thu, 10 Mar 2011 12:15:04 -0600
Message-ID: <AANLkTik_2=H8f3CjEzPVsrVOzMtCkFWt+YAmZMbTR1q2@domain.hid>
From: Jeff Weber <jwamsc@domain.hid>
Content-Type: multipart/alternative; boundary=0016e6d972bf1cd4c0049e24d35f
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

--0016e6d972bf1cd4c0049e24d35f
Content-Type: text/plain; charset=ISO-8859-1

On Thu, Mar 10, 2011 at 7:03 AM, Gilles Chanteperdrix <
gilles.chanteperdrix@xenomai.org> wrote:

> Gilles Chanteperdrix wrote:
> > Jeff Weber wrote:
> >> When writing a RTDM kernel module driver, when must rtdm_printk() be
> used
> >> instead of printk() ?
> >
> > If RTDM was, one day, ported over something else than a Linux
> > kernel-space based solution (for instance, over a port of Xenomai
> > without Linux, or in Linux user-space), then you would not have to
> > change your driver codeto have it compile over that new port.
> >
> > Until then, printk and rtdm_printk are identical.
> >
> > Note that the first paragraph is something very hypothetical, because in
> > an RTDM driver, you generally have some other Linux kernel-space
> > specific code, such as for instance the registration as a PCI driver,
> > though the necessary parts of the Linux API could be implemented for
> > that hypothetical port. But in that case, so could printk.
> >
> > So...
>
> I guess the real reason for rtdm_printk is that at some point in the
> past (probably before the Adeos era), printk was not safe to be called
> from the real-time domain. In that case, rtdm_printk would be safe to be
> called from the real-time domain. So, the answer is that you should use
> rtdm_printk if you are calling from a Xenomai domain interrupt handler,
> or from the context of a thread running in primary mode.
>
>
What happens when a driver executes a non-realtime kernel function, from a
Xenomai domain interrupt handler, or from the context of a thread running in
primary mode?  Say the driver executes kmalloc() instead of rtdm_malloc(),
or copy_to_user() instead of rtdm_copy_to_user().  Hopefully these are
better examples than [rtdm_]printk() .

Does the offending user space thread transition to secondary mode?

What happens to the offending interrupt handler?

Do the notions of primary, secondary mode apply to the kernel as well?


Perhaps it's easier not analyze, separate all the non/realtime driver
contexts, and always use the rtdm_ functions; say rtdm_malloc() everywhere
in the driver (never use kmalloc).  Would this practice work?

thanks,
Jeff

--0016e6d972bf1cd4c0049e24d35f
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><div class=3D"gmail_quote">On Thu, Mar 10, 2011 at 7:03 AM, Gilles Chan=
teperdrix <span dir=3D"ltr">&lt;<a href=3D"mailto:gilles.chanteperdrix@xenomai.org=
mai.org">gilles.chanteperdrix@xenomai.org</a>&gt;</span> wrote:<br><blockqu=
ote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; border-left: =
1px solid rgb(204, 204, 204); padding-left: 1ex;">
<div><div></div><div class=3D"h5">Gilles Chanteperdrix wrote:<br>
&gt; Jeff Weber wrote:<br>
&gt;&gt; When writing a RTDM kernel module driver, when must rtdm_printk() =
be used<br>
&gt;&gt; instead of printk() ?<br>
&gt;<br>
&gt; If RTDM was, one day, ported over something else than a Linux<br>
&gt; kernel-space based solution (for instance, over a port of Xenomai<br>
&gt; without Linux, or in Linux user-space), then you would not have to<br>
&gt; change your driver codeto have it compile over that new port.<br>
&gt;<br>
&gt; Until then, printk and rtdm_printk are identical.<br>
&gt;<br>
&gt; Note that the first paragraph is something very hypothetical, because =
in<br>
&gt; an RTDM driver, you generally have some other Linux kernel-space<br>
&gt; specific code, such as for instance the registration as a PCI driver,<=
br>
&gt; though the necessary parts of the Linux API could be implemented for<b=
r>
&gt; that hypothetical port. But in that case, so could printk.<br>
&gt;<br>
&gt; So...<br>
<br>
</div></div>I guess the real reason for rtdm_printk is that at some point i=
n the<br>
past (probably before the Adeos era), printk was not safe to be called<br>
from the real-time domain. In that case, rtdm_printk would be safe to be<br=
>
called from the real-time domain. So, the answer is that you should use<br>
rtdm_printk if you are calling from a Xenomai domain interrupt handler,<br>
or from the context of a thread running in primary mode.<br><br></blockquot=
e><div><br>What happens when a driver executes a non-realtime kernel functi=
on,=A0from a Xenomai domain interrupt handler, or from the context of a thr=
ead running in primary mode?=A0 Say the driver executes kmalloc() instead o=
f rtdm_malloc(), or copy_to_user() instead of rtdm_copy_to_user().=A0 Hopef=
ully these are better examples than [rtdm_]printk() .<br>
<br>Does the offending user space thread transition to secondary mode?<br><=
br>What happens to the offending interrupt handler?<br><br>Do the notions o=
f primary, secondary mode apply to the kernel as well?<br><br><br>Perhaps i=
t&#39;s easier not analyze, separate all the non/realtime driver contexts, =
and always use the rtdm_ functions; say rtdm_malloc() everywhere in the dri=
ver (never use kmalloc).=A0 Would this practice work?<br>
<br>thanks,<br>Jeff<br></div></div>

--0016e6d972bf1cd4c0049e24d35f--

