MIME-Version: 1.0
In-Reply-To: <1265388236.2348.246.camel@domain.hid>
References: <1aa9845a1002040751o549d86efh19c7c0c033dae2c1@domain.hid>
	<1265300097.2348.158.camel@domain.hid>
	<1aa9845a1002050816s714ae6afq2373dcb243462186@domain.hid>
	<1265388236.2348.246.camel@domain.hid>
Date: Sun, 7 Feb 2010 20:56:13 +0530
Message-ID: <1aa9845a1002070726i2a920207jc72b37c0a948cd75@domain.hid>
From: Saravanan S <sarans1987@domain.hid>
Content-Type: multipart/alternative; boundary=0016e648a7701ac8d5047f044ee7
Subject: Re: [Xenomai-help] User interrupt handling in Xenomai running into
	probs
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

--0016e648a7701ac8d5047f044ee7
Content-Type: text/plain; charset=ISO-8859-1

On Fri, Feb 5, 2010 at 10:13 PM, Philippe Gerum <rpm@xenomai.org> wrote:

> On Fri, 2010-02-05 at 21:46 +0530, Saravanan S wrote:
> >
> >
> > On Thu, Feb 4, 2010 at 9:44 PM, Philippe Gerum <rpm@xenomai.org>
> > wrote:
> >         On Thu, 2010-02-04 at 21:21 +0530, Saravanan S wrote:
> >         > Hi,
> >         >
> >         >     I tried to implement the hardware interrupt handling
> >         feature of
> >         > xenomai in user space.I read the native-api document and ran
> >         the
> >         > user_irq.c program with one change ,i tried to intercept the
> >         eth0
> >         > interrupt on my system(using interrupt number from
> >         > cat /proc/interrupts).When i ran the program the system
> >         froze!!!!!
> >         >
> >         > What am i doing wrong??
> >
> >
> >         The thing is that your tiny little change has some impact. You
> >         just
> >         can't intercept a random interrupt without knowing how it
> >         interacts with
> >         the Linux kernel, and expect this to work.
> >
> >         The Linux NIC driver won't get interrupts because of this,
> >         since
> >         usr_irq.c does not care of propagating them to the standard
> >         kernel, so
> >         your device is likely going to bury your box under an
> >         interrupt storm.
> >
> > To prevent that i used (as given in  native-api document) the option
> > I_PROPAGATE while creating the interrupt  object which is supposed to
> > forward the interrupt to the kernel after ADEOS services it but still
> > the system froze....
>
> This won't be enough. I'm telling you that you should first understand
> how intercepting an interrupt in a high priority domain like Xenomai
> could (badly) interact with the kernel.
>
> What if your IRQ is level-triggered?
> - Xenomai grabs the incoming IRQ, pends it for later processing by Linux
> - Your ethernet device keeps chiming in, leaving the interrupt signaled,
> because your sample task did not care of clearing the cause of that IRQ.
>
> What do you think will happen next, when interrupts are enabled for
> Linux later, or even by Xenomai upon return from its own handler? The
> NIC driver won't have the opportunity to run its ISR, because it's
> already too late: you have been stormed by interrupts from your ethernet
> device.
>
> That could even happen with edge-triggered IRQs, depending on the
> device.
>
> I should have added the following in my previous reply: sharing IRQs
> between the Linux and Xenomai domains is wrong. All wrong. This is a
> limitation induced by the co-kernel design. That is the reason why
> usr_irq.c, which is x86-biased, hooks IRQ #7. This one is not associated
> with an I/O device. This also explains why changing this to any random
> I/O device IRQ number is triggering the issue.
>

> >
> >         What is in snippets/ is not meant to be run blindly. Those are
> >         pieces of
> >         code to illustrate the use of services in a general way, not
> >         examples
> >         tailored to run on any platform, not even yours.
> >
> >         Read the "Life with Adeos" doc to understand why it can't work
> >         the way
> >         you did it.
> >
> >         >
> >         > What  is the purpose of this feature of allowing user space
> >         handling
> >         > of interrupts.Can a user space driver be written using
> >         this???
> >         >
> >
> >
> >         Sure. When done properly.
> >
> > I want to experiment with this feature and need your help on how to do
> > it properly.I have read the "Life with Adeos" document.
> >
>
> Ok, the best help I can give is: forget about doing this. Write a RTDM
> device driver in kernel space, to serve a RT app in userland.
>
> Indeed this set of API services to process IRQs in userland is there,
> but kept mostly for legacy reasons. But I would not recommend to use
> them these days. At all. RTDM is your friend. Really.
>

RTDM is the right approach i agree.I currently want real time driver for a
Qlogic fibre channel Host Bus Adapter PCI express card.With no experience in
writing drivers i will have a tough time.Anyway i will try to start on this
path.Thanks.


>
> >
> >
> >         > Thanks in advance.
> >         >
> >         > With regards,
> >         >
> >         > S Saravanan
> >
> >         > _______________________________________________
> >         > Xenomai-help mailing list
> >         > Xenomai-help@domain.hid
> >         > https://mail.gna.org/listinfo/xenomai-help
> >
> >
> >         --
> >         Philippe.
> >
> >
> >
>
>
> --
> Philippe.
>
>
>

--0016e648a7701ac8d5047f044ee7
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">On Fri, Feb 5, 2010 at 10:13 PM, Philipp=
e Gerum <span dir=3D"ltr">&lt;<a href=3D"mailto:rpm@xenomai.org">rpm@xenomai.org=
i.org</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"b=
order-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; paddin=
g-left: 1ex;">
<div><div></div><div class=3D"h5">On Fri, 2010-02-05 at 21:46 +0530, Sarava=
nan S wrote:<br>
&gt;<br>
&gt;<br>
&gt; On Thu, Feb 4, 2010 at 9:44 PM, Philippe Gerum &lt;<a href=3D"mailto:r=
pm@domain.hid">rpm@xenomai.org</a>&gt;<br>
&gt; wrote:<br>
&gt; =A0 =A0 =A0 =A0 On Thu, 2010-02-04 at 21:21 +0530, Saravanan S wrote:<=
br>
&gt; =A0 =A0 =A0 =A0 &gt; Hi,<br>
&gt; =A0 =A0 =A0 =A0 &gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 I tried to implement the hardware interru=
pt handling<br>
&gt; =A0 =A0 =A0 =A0 feature of<br>
&gt; =A0 =A0 =A0 =A0 &gt; xenomai in user space.I read the native-api docum=
ent and ran<br>
&gt; =A0 =A0 =A0 =A0 the<br>
&gt; =A0 =A0 =A0 =A0 &gt; user_irq.c program with one change ,i tried to in=
tercept the<br>
&gt; =A0 =A0 =A0 =A0 eth0<br>
&gt; =A0 =A0 =A0 =A0 &gt; interrupt on my system(using interrupt number fro=
m<br>
&gt; =A0 =A0 =A0 =A0 &gt; cat /proc/interrupts).When i ran the program the =
system<br>
&gt; =A0 =A0 =A0 =A0 froze!!!!!<br>
&gt; =A0 =A0 =A0 =A0 &gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt; What am i doing wrong??<br>
&gt;<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 The thing is that your tiny little change has some imp=
act. You<br>
&gt; =A0 =A0 =A0 =A0 just<br>
&gt; =A0 =A0 =A0 =A0 can&#39;t intercept a random interrupt without knowing=
 how it<br>
&gt; =A0 =A0 =A0 =A0 interacts with<br>
&gt; =A0 =A0 =A0 =A0 the Linux kernel, and expect this to work.<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 The Linux NIC driver won&#39;t get interrupts because =
of this,<br>
&gt; =A0 =A0 =A0 =A0 since<br>
&gt; =A0 =A0 =A0 =A0 usr_irq.c does not care of propagating them to the sta=
ndard<br>
&gt; =A0 =A0 =A0 =A0 kernel, so<br>
&gt; =A0 =A0 =A0 =A0 your device is likely going to bury your box under an<=
br>
&gt; =A0 =A0 =A0 =A0 interrupt storm.<br>
&gt;<br>
&gt; To prevent that i used (as given in =A0native-api document) the option=
<br>
&gt; I_PROPAGATE while creating the interrupt =A0object which is supposed t=
o<br>
&gt; forward the interrupt to the kernel after ADEOS services it but still<=
br>
&gt; the system froze....<br>
<br>
</div></div>This won&#39;t be enough. I&#39;m telling you that you should f=
irst understand<br>
how intercepting an interrupt in a high priority domain like Xenomai<br>
could (badly) interact with the kernel.<br>
<br>
What if your IRQ is level-triggered?<br>
- Xenomai grabs the incoming IRQ, pends it for later processing by Linux<br=
>
- Your ethernet device keeps chiming in, leaving the interrupt signaled,<br=
>
because your sample task did not care of clearing the cause of that IRQ.<br=
>
<br>
What do you think will happen next, when interrupts are enabled for<br>
Linux later, or even by Xenomai upon return from its own handler? The<br>
NIC driver won&#39;t have the opportunity to run its ISR, because it&#39;s<=
br>
already too late: you have been stormed by interrupts from your ethernet<br=
>
device.<br>
<br>
That could even happen with edge-triggered IRQs, depending on the<br>
device.<br>
<br>
I should have added the following in my previous reply: sharing IRQs<br>
between the Linux and Xenomai domains is wrong. All wrong. This is a<br>
limitation induced by the co-kernel design. That is the reason why<br>
usr_irq.c, which is x86-biased, hooks IRQ #7. This one is not associated<br=
>
with an I/O device. This also explains why changing this to any random<br>
I/O device IRQ number is triggering the issue.<br></blockquote><blockquote =
class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, 204, 204); m=
argin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<div class=3D"im"><br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 What is in snippets/ is not meant to be run blindly. T=
hose are<br>
&gt; =A0 =A0 =A0 =A0 pieces of<br>
&gt; =A0 =A0 =A0 =A0 code to illustrate the use of services in a general wa=
y, not<br>
&gt; =A0 =A0 =A0 =A0 examples<br>
&gt; =A0 =A0 =A0 =A0 tailored to run on any platform, not even yours.<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 Read the &quot;Life with Adeos&quot; doc to understand=
 why it can&#39;t work<br>
&gt; =A0 =A0 =A0 =A0 the way<br>
&gt; =A0 =A0 =A0 =A0 you did it.<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt; What =A0is the purpose of this feature of allowin=
g user space<br>
&gt; =A0 =A0 =A0 =A0 handling<br>
&gt; =A0 =A0 =A0 =A0 &gt; of interrupts.Can a user space driver be written =
using<br>
&gt; =A0 =A0 =A0 =A0 this???<br>
&gt; =A0 =A0 =A0 =A0 &gt;<br>
&gt;<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 Sure. When done properly.<br>
&gt;<br>
&gt; I want to experiment with this feature and need your help on how to do=
<br>
&gt; it properly.I have read the &quot;Life with Adeos&quot; document.<br>
&gt;<br>
<br>
</div>Ok, the best help I can give is: forget about doing this. Write a RTD=
M<br>
device driver in kernel space, to serve a RT app in userland.<br>
<br>
Indeed this set of API services to process IRQs in userland is there,<br>
but kept mostly for legacy reasons. But I would not recommend to use<br>
them these days. At all. RTDM is your friend. Really.<br></blockquote><div>=
<br>RTDM is the right approach i agree.I currently want real time driver fo=
r a Qlogic fibre channel Host Bus Adapter PCI express card.With no experien=
ce in writing drivers i will have a tough time.Anyway i will try to start o=
n this path.Thanks.<br>
=A0</div><blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid =
rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<div class=3D"im"><br>
&gt;<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt; Thanks in advance.<br>
&gt; =A0 =A0 =A0 =A0 &gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt; With regards,<br>
&gt; =A0 =A0 =A0 =A0 &gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt; S Saravanan<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt; _______________________________________________<b=
r>
&gt; =A0 =A0 =A0 =A0 &gt; Xenomai-help mailing list<br>
&gt; =A0 =A0 =A0 =A0 &gt; <a href=3D"mailto:Xenomai-help@domain.hid">Xenomai-h=
elp@domain.hid</a><br>
&gt; =A0 =A0 =A0 =A0 &gt; <a href=3D"https://mail.gna.org/listinfo/xenomai-=
help" target=3D"_blank">https://mail.gna.org/listinfo/xenomai-help</a><br>
&gt;<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 --<br>
&gt; =A0 =A0 =A0 =A0 Philippe.<br>
&gt;<br>
&gt;<br>
&gt;<br>
<br>
<br>
</div>--<br>
<font color=3D"#888888">Philippe.<br>
<br>
<br>
</font></blockquote></div><br>

--0016e648a7701ac8d5047f044ee7--

