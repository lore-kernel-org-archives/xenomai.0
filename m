MIME-Version: 1.0
In-Reply-To: <4C6CF5BF.3060405@domain.hid>
References: <AANLkTi=dpYJNx+UzbjLy6Jpky2sscccUoVS5VZCAKMUv@domain.hid>
	<4C6CF5BF.3060405@domain.hid>
Date: Thu, 19 Aug 2010 11:27:00 +0200
Message-ID: <AANLkTi=MKjwGhRXVGQtPQML5dyO6wUB0edWngncZVqjP@mail.gmail.com>
From: ramon costa <ramoncostacastello@domain.hid>
Content-Type: multipart/alternative; boundary=0016e64ec154d3aec0048e29c890
Subject: Re: [Xenomai-help] using floating point in rtdm
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai help <xenomai@xenomai.org>

--0016e64ec154d3aec0048e29c890
Content-Type: text/plain; charset=ISO-8859-1

Hi,

I'm trying to port some old stuff from RTLinuxfree.  As a first step I would
like to recompile
and check everything. Latter I will try to modify the code structure to  fit
xenomai structure.


- let the kernel compile your module as is, this will generated
> "soft-float" code, which means that the operations will be done in
> software. Your module will contain undefined references to functions
> actually implemented in libgcc. So, you will have to extract the needed
> .o from libgcc.a and put them in your module.
>

As this is only "temporary" this is the best option. I think my old
RTLinuxfree
code does something similar.

How can I do this in the Xenomai framework ?

Does RTDM task store the floating point context during task switching ?

Best wishes
Ramon





> - try and use "hardware" floating points. This means that you will have
> to change the kernel build system to allow compiling hardware floating
> points in kernel space. Here again, your module will contain undefined
> references, but that will be undefined references to the libm functions
> (such as sin, cos). So, you will have to compile the libm as a kernel
> module. You will also have to patch RTDM to allow setting the XNFPU bit
> to RTDM threads, and also note that you will be only able to use FPU
> from such threads (and particularily, not from module initialization and
> cleanup code).
>
> If you decide to go either way, no code helping doing this will ever be
> merged into Xenomai, so you will have to maintain your own version of
> Xenomai.
>
> >
> > Can anyone provide and example (Makefile+code) or point me to one ?
>
> I am afraid nobody every did something like this because this is not
> worth it.
>
> --
>                                             Gilles.
>

--0016e64ec154d3aec0048e29c890
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,<br><br>I&#39;m trying to port some old stuff from RTLinuxfree.=A0 As a =
first step I would like to recompile<br>and check everything. Latter I will=
 try to modify the code structure to=A0 fit xenomai structure.<br><br><br><=
div class=3D"gmail_quote">
<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">- let the kernel =
compile your module as is, this will generated<br>
&quot;soft-float&quot; code, which means that the operations will be done i=
n<br>
software. Your module will contain undefined references to functions<br>
actually implemented in libgcc. So, you will have to extract the needed<br>
.o from libgcc.a and put them in your module.<br></blockquote><div><br>As t=
his is only &quot;temporary&quot; this is the best option. I think my old R=
TLinuxfree <br>code does something similar.<br><br>How can I do this in the=
 Xenomai framework ?<br>
<br>Does RTDM task store the floating point context during task switching ?=
<br><br>Best wishes<br>Ramon<br><br><br><br>=A0</div><blockquote class=3D"g=
mail_quote" style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt=
 0pt 0pt 0.8ex; padding-left: 1ex;">

- try and use &quot;hardware&quot; floating points. This means that you wil=
l have<br>
to change the kernel build system to allow compiling hardware floating<br>
points in kernel space. Here again, your module will contain undefined<br>
references, but that will be undefined references to the libm functions<br>
(such as sin, cos). So, you will have to compile the libm as a kernel<br>
module. You will also have to patch RTDM to allow setting the XNFPU bit<br>
to RTDM threads, and also note that you will be only able to use FPU<br>
from such threads (and particularily, not from module initialization and<br=
>
cleanup code).<br>
<br>
If you decide to go either way, no code helping doing this will ever be<br>
merged into Xenomai, so you will have to maintain your own version of<br>
Xenomai.<br>
<div class=3D"im"><br>
&gt;<br>
&gt; Can anyone provide and example (Makefile+code) or point me to one ?<br=
>
<br>
</div>I am afraid nobody every did something like this because this is not<=
br>
worth it.<br>
<br>
--<br>
<font color=3D"#888888"> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Gilles.<br>
</font></blockquote></div><br>

--0016e64ec154d3aec0048e29c890--

