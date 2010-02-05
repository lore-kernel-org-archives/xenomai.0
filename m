MIME-Version: 1.0
In-Reply-To: <1265300097.2348.158.camel@domain.hid>
References: <1aa9845a1002040751o549d86efh19c7c0c033dae2c1@domain.hid>
	<1265300097.2348.158.camel@domain.hid>
Date: Fri, 5 Feb 2010 21:46:35 +0530
Message-ID: <1aa9845a1002050816s714ae6afq2373dcb243462186@domain.hid>
From: Saravanan S <sarans1987@domain.hid>
Content-Type: multipart/alternative; boundary=0016e6407f0e8c3893047edcc692
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

--0016e6407f0e8c3893047edcc692
Content-Type: text/plain; charset=ISO-8859-1

On Thu, Feb 4, 2010 at 9:44 PM, Philippe Gerum <rpm@xenomai.org> wrote:

> On Thu, 2010-02-04 at 21:21 +0530, Saravanan S wrote:
> > Hi,
> >
> >     I tried to implement the hardware interrupt handling feature of
> > xenomai in user space.I read the native-api document and ran the
> > user_irq.c program with one change ,i tried to intercept the eth0
> > interrupt on my system(using interrupt number from
> > cat /proc/interrupts).When i ran the program the system froze!!!!!
> >
> > What am i doing wrong??
>
> The thing is that your tiny little change has some impact. You just
> can't intercept a random interrupt without knowing how it interacts with
> the Linux kernel, and expect this to work.
>
> The Linux NIC driver won't get interrupts because of this, since
> usr_irq.c does not care of propagating them to the standard kernel, so
> your device is likely going to bury your box under an interrupt storm.
>

To prevent that i used (as given in  native-api document) the option
I_PROPAGATE while creating the interrupt  object which is supposed to
forward the interrupt to the kernel after ADEOS services it but still the
system froze....



> What is in snippets/ is not meant to be run blindly. Those are pieces of
> code to illustrate the use of services in a general way, not examples
> tailored to run on any platform, not even yours.
>
> Read the "Life with Adeos" doc to understand why it can't work the way
> you did it.
>
> >
> > What  is the purpose of this feature of allowing user space handling
> > of interrupts.Can a user space driver be written using this???
> >
>
> Sure. When done properly.
>

I want to experiment with this feature and need your help on how to do it
properly.I have read the "Life with Adeos" document.


> > Thanks in advance.
> >
> > With regards,
> >
> > S Saravanan
> > _______________________________________________
> > Xenomai-help mailing list
> > Xenomai-help@domain.hid
> > https://mail.gna.org/listinfo/xenomai-help
>
>
> --
> Philippe.
>
>
>

--0016e6407f0e8c3893047edcc692
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">On Thu, Feb 4, 2010 at 9:44 PM, Philippe=
 Gerum <span dir=3D"ltr">&lt;<a href=3D"mailto:rpm@xenomai.org">rpm@xenomai.org=
.org</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"bo=
rder-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding=
-left: 1ex;">
<div class=3D"im">On Thu, 2010-02-04 at 21:21 +0530, Saravanan S wrote:<br>
&gt; Hi,<br>
&gt;<br>
&gt; =A0 =A0 I tried to implement the hardware interrupt handling feature o=
f<br>
&gt; xenomai in user space.I read the native-api document and ran the<br>
&gt; user_irq.c program with one change ,i tried to intercept the eth0<br>
&gt; interrupt on my system(using interrupt number from<br>
&gt; cat /proc/interrupts).When i ran the program the system froze!!!!!<br>
&gt;<br>
&gt; What am i doing wrong??<br>
<br>
</div>The thing is that your tiny little change has some impact. You just<b=
r>
can&#39;t intercept a random interrupt without knowing how it interacts wit=
h<br>
the Linux kernel, and expect this to work.<br>
<br>
The Linux NIC driver won&#39;t get interrupts because of this, since<br>
usr_irq.c does not care of propagating them to the standard kernel, so<br>
your device is likely going to bury your box under an interrupt storm.<br><=
/blockquote><div><br>To prevent that i used (as given in=A0 native-api docu=
ment) the option I_PROPAGATE while creating the interrupt=A0 object which i=
s supposed to forward the interrupt to the kernel after ADEOS services it b=
ut still the system froze....<br>
<br>=A0</div><blockquote class=3D"gmail_quote" style=3D"border-left: 1px so=
lid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
What is in snippets/ is not meant to be run blindly. Those are pieces of<br=
>
code to illustrate the use of services in a general way, not examples<br>
tailored to run on any platform, not even yours.<br>
<br>
Read the &quot;Life with Adeos&quot; doc to understand why it can&#39;t wor=
k the way<br>
you did it.<br>
<div class=3D"im"><br>
&gt;<br>
&gt; What =A0is the purpose of this feature of allowing user space handling=
<br>
&gt; of interrupts.Can a user space driver be written using this???<br>
&gt;<br>
<br>
</div>Sure. When done properly.<br></blockquote><div><br>I want to experime=
nt with this feature and need your help on how to do it properly.I have rea=
d the &quot;Life with Adeos&quot; document. <br><br></div><blockquote class=
=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, 204, 204); margin=
: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">

<div class=3D"im"><br>
&gt; Thanks in advance.<br>
&gt;<br>
&gt; With regards,<br>
&gt;<br>
&gt; S Saravanan<br>
</div>&gt; _______________________________________________<br>
&gt; Xenomai-help mailing list<br>
&gt; <a href=3D"mailto:Xenomai-help@domain.hid">Xenomai-help@domain.hid</a><br>
&gt; <a href=3D"https://mail.gna.org/listinfo/xenomai-help" target=3D"_blan=
k">https://mail.gna.org/listinfo/xenomai-help</a><br>
<br>
<br>
--<br>
<font color=3D"#888888">Philippe.<br>
<br>
<br>
</font></blockquote></div><br>

--0016e6407f0e8c3893047edcc692--

