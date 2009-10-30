MIME-Version: 1.0
In-Reply-To: <1256812559.2065.197.camel@domain.hid>
References: <1f3e02580910290229t5ad46268r5e7799a46950db5e@domain.hid>
	<1256812559.2065.197.camel@domain.hid>
Date: Fri, 30 Oct 2009 10:31:22 +0900
Message-ID: <1f3e02580910291831t3db9f713sef6b162bb51ad6ee@domain.hid>
From: Didenko Sergey <didenkos@domain.hid>
Content-Type: multipart/alternative; boundary=001636e0b6014b986104771cfcba
Subject: Re: [Xenomai-help] [VxWorks API] Compile and Link
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

--001636e0b6014b986104771cfcba
Content-Type: text/plain; charset=UTF-8

Dear Philippe

Thank you very much for the detailed explanation.
That was exactly what I need to understand once again and again.
Yes, I have read the "Porting_From_RTOS", but my next small step is just to
reuse APIs provided by Xenomai.

*may I test my understanding in one thing "where Xenomai should be
installed?"*

I have my Linux based PC with:
$linux_tree = /home/d.sergey/kernel/linux-2.6.29-v02.00.29 (patched with
xenomai + added support for MV 88F6290 Platfrom)
$xenomai_root = /home/d.sergey/xemomai/xenomai-2.4.9.1
$build_root = /home/d.sergey/build_root
$staging_dir = /nfs/rootfs

after patching linux_tree with Xenomai and Adeos...
I have done:
======================
cd $linux_tree
make ARCH=arm CROSS_COMPILE=arm-none-linux-gnueabi- O=$build_root
project_defconfig -j5
make ARCH=arm CROSS_COMPILE=arm-none-linux-gnueabi- O=$build_root bzImage
modules -j5
======================
then
======================
cd  $build_root
/home/d.sergey/xemomai/xenomai-2.4.9.1/configure --build=i686-pc-linux-gnu
--host=arm-none-linux-gnueabi --enable-arm-mach=generic --enable-arm-tsc
make DESTDIR=/nfs/rootfs install
======================

*Gilles, is that what you said ?*

> You need to install Xenomai, running 'make install' in the build tree.
>

*Or should I install Xenomai on my Linux based PC?* (Right now I assume it
is installed on my target's rootfs)



> Then use xeno-config.
>
*Sorry, but I did not get how should I use it?
Please give me more details!*

*I also do not understand for what the $build_root folder is required?
Why  can not **we **compile the Xenomai's code it its tree?*

Philippe, I understand all the things you have mentioned...

> moving a pristine VxWorks application from a traditional RTOS
> environment to Linux *requires some work*, no API emulation layer will
> give you 1:1 mapping between the zillions of WRS APIs and Linux+Xenomai.
>

But, for the next step of my journey*, *I simply need to emulate the API
layer, that is it!*
Please help me to understand how can I emulate the APIs.
Right now I just need to make my code be able to use Xenomai's APIs.

*I'm not saying that right after that I will try to run my project on the
target and will complain why it is not working, no...
Just to do next step, I want to make my code compile and link with new APIs.
Looking forward to hearing from you.
*
*Sergey

2009/10/29 Philippe Gerum <rpm@xenomai.org>

> On Thu, 2009-10-29 at 18:29 +0900, Didenko Sergey wrote:
> > Dear experts
> >
> > assuming I have:
> >
> > xenomai_tree - path to Xenomai source code
> > project_tree - path to my project (originally based on VxWorks)
> >
> > Which directories and files should I include to the project's makefile
> > to be able to compile and link it with Xenimai's VxWorks APIs instead
> > of VxWorks's API's?
> > Do I need only *.h and *.c files or any libraries are required?
> >
>
> XENO_CONFIG := /usr/xenomai/bin/xeno-config
> CFLAGS:= $(shell $(XENO_CONFIG) --xeno-cflags) -g
> LDFLAGS:= $(shell $(XENO_CONFIG) --xeno-ldflags) -lvxworks
>
> This said, moving a pristine VxWorks application from a traditional RTOS
> environment to Linux requires some work, no API emulation layer will
> give you 1:1 mapping between the zillions of WRS APIs and Linux+Xenomai.
>
> Only playing whack-a-mole fixing syntactical/compilation issues until
> your app eventually builds and links is the fastest way to hell for such
> a porting exercise: this will NOT address the design-related issues that
> must exist (e.g. what will you do with your original I/O drivers, how
> and where will you put the kernel/user boundary when porting your code
> etc, etc).
>
> A core issue is that programming models are fundamentally different,
> i.e:
>
> - single-address space + flat/physically addressed memory + permanent
> supervisor privileges + sloppy device driver model
> VS
> - multiple process contexts + MMU protection + separate
> kernel/application address spaces + non-privileged CPU mode for
> applications + strict device driver model.
>
> And, while I'm at it, just in case you might have considered this:
> moving all of your original code to Linux kernel space on top of the
> Xenomai APIs there would be likely terribly wrong. Aside of the license
> issues (GPL vs proprietary), you may also have serious problems down the
> road porting your code.
>
> The Xenomai APIs _in kernel space_ are now deprecated, they were made
> available at a time when Xenomai had no user-space support, back in
> 2001. We have such support since 2004 and the in-kernel APIs were kept
> for backward compatibility purposes only, so moving a complex
> application today, to such an hostile environment for user-level code is
> basically masochistic.
>
> A safer way to this journey is:
>
> - assess which original I/O drivers have to be real-time and move them
> to kernel space on top of RTDM.
> - assess which original I/O drivers have direct Linux counter-parts,
> and/or does not have any RT requirement, and reuse/implement a regular
> Linux driver for those.
> - segregate what parts of your original code has to be RT enabled from
> the other more "relaxed" parts.
> - move the application code bulk to userland, on top of the Xenomai APIs
> there. Adapt the RT portions to the Xenomai APIs, use anything that fits
> for the rest (e.g. plain glibc).
>
> Driver-wise, there is rule #666 to abide by: in a dual kernel
> environment - like Xenomai 2.x - never, ever, plan to share an IRQ line
> between a real-time device and a regular one. As soon as anyone feels
> tempted by implementing such a construct, the design flaw is there, and
> something must have been wrongly assessed during the early porting
> steps.
>
> All in all, and to sum up: unless your application is 50 LOC at most,
> porting it to Linux will require some implementation re-design work, and
> Xenomai is no magic bullet to avoid that. What Xenomai aims at, is
> providing a _correct_ emulation of the core VxWorks services (~100 of
> them), which normally mitigates the impact of such re-design work. In
> other words, do not confuse Xenomai with running the actual, original
> RTOS within some virtual machine on top of a bare metal hypervisor.
>
> The hypervisor approach is not Linux at all, it is just enabling the
> legacy RTOS to run on the same hw than Linux. The former approach is
> about mimicking the original RTOS environment natively in a Linux
> context, which leads to very different trade-offs when porting.
>
> You may at the very least want to read that piece, not much yet, but
> this is still better than nothing:
> http://www.xenomai.org/index.php/Xenomai:Porting_From_RTOS
>
> > Sergey
> >
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

--001636e0b6014b986104771cfcba
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Dear Philippe<br><br>Thank you very much for the detailed explanation.<br>T=
hat was exactly what I need to understand once again and again.<br>Yes, I h=
ave read the &quot;Porting_From_RTOS&quot;, but my next small step is just =
to reuse APIs provided by Xenomai.<br>
<br><b>may I test my understanding in one thing &quot;where Xenomai should =
be installed?&quot;</b><br><br>I have my Linux based PC with:<br>$linux_tre=
e =3D /home/d.sergey/kernel/linux-2.6.29-v02.00.29 (patched with xenomai + =
added support for MV 88F6290 Platfrom)<br>
$xenomai_root =3D /home/d.sergey/xemomai/xenomai-2.4.9.1<br>$build_root =3D=
 /home/d.sergey/build_root<br>$staging_dir =3D /nfs/rootfs<br><br>after pat=
ching linux_tree with Xenomai and Adeos...<br>I have done:<br>=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
cd $linux_tree<br>make ARCH=3Darm CROSS_COMPILE=3Darm-none-linux-gnueabi- O=
=3D$build_root project_defconfig -j5<br>make ARCH=3Darm CROSS_COMPILE=3Darm=
-none-linux-gnueabi- O=3D$build_root  bzImage modules -j5<br>=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
then<br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<=
br>cd=C2=A0 $build_root<br>/home/d.sergey/xemomai/xenomai-2.4.9.1/configure=
 --build=3Di686-pc-linux-gnu --host=3Darm-none-linux-gnueabi --enable-arm-m=
ach=3Dgeneric --enable-arm-tsc<br>make DESTDIR=3D/nfs/rootfs install<br>
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br><br><=
b>Gilles, is that what you said ?</b> <br><blockquote style=3D"border-left:=
 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex=
;" class=3D"gmail_quote">You need to install Xenomai, running &#39;make ins=
tall&#39; in the build tree.<br>
</blockquote><div>=C2=A0</div><div><b>Or should I install Xenomai on my Lin=
ux based PC?</b> (Right now I assume it is installed on my target&#39;s roo=
tfs)<br><br>=C2=A0<br></div><blockquote style=3D"border-left: 1px solid rgb=
(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;" class=3D"gm=
ail_quote">

Then use xeno-config.<br></blockquote><div><b>Sorry, but I did not get how =
should I use it? <br>Please give me more details!</b><br><br><b>I also do n=
ot understand for what the $build_root folder is required? <br>Why=C2=A0 ca=
n not </b><b>we </b><b>compile the Xenomai&#39;s code it its tree?</b><br>
</div><br>Philippe, I understand all the things you have mentioned...<br><b=
lockquote style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0=
pt 0pt 0.8ex; padding-left: 1ex;" class=3D"gmail_quote">moving a pristine V=
xWorks application from a traditional RTOS<br>

environment to Linux <u>requires some work</u>, no API emulation layer will=
<br>
give you 1:1 mapping between the zillions of WRS APIs and Linux+Xenomai.<br=
></blockquote><div>=C2=A0</div>But, for the next step of my journey<b>, </b=
>I simply need to emulate the API layer, that is it!<b><br>Please help me t=
o understand how can I emulate the APIs.<br>
Right now I just need to make my code be able to use Xenomai&#39;s APIs.<br=
><br></b>I&#39;m not saying that right after that I will try to run my proj=
ect on the target and will complain why it is not working, no...<br>Just to=
 do next step, I want to make my code compile and link with new APIs.<br>
Looking forward to hearing from you.<br><b><br></b>Sergey<br><br><div class=
=3D"gmail_quote">2009/10/29 Philippe Gerum <span dir=3D"ltr">&lt;<a href=3D=
"mailto:rpm@xenomai.org">rpm@xenomai.org</a>&gt;</span><br><blockquote clas=
s=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, 204, 204); margi=
n: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<div class=3D"im">On Thu, 2009-10-29 at 18:29 +0900, Didenko Sergey wrote:<=
br>
</div><div><div></div><div class=3D"h5">&gt; Dear experts<br>
&gt;<br>
&gt; assuming I have:<br>
&gt;<br>
&gt; xenomai_tree - path to Xenomai source code<br>
&gt; project_tree - path to my project (originally based on VxWorks)<br>
&gt;<br>
&gt; Which directories and files should I include to the project&#39;s make=
file<br>
&gt; to be able to compile and link it with Xenimai&#39;s VxWorks APIs inst=
ead<br>
&gt; of VxWorks&#39;s API&#39;s?<br>
&gt; Do I need only *.h and *.c files or any libraries are required?<br>
&gt;<br>
<br>
</div></div><div><div></div><div class=3D"h5">XENO_CONFIG :=3D /usr/xenomai=
/bin/xeno-config<br>
CFLAGS:=3D $(shell $(XENO_CONFIG) --xeno-cflags) -g<br>
LDFLAGS:=3D $(shell $(XENO_CONFIG) --xeno-ldflags) -lvxworks<br>
<br>
This said, moving a pristine VxWorks application from a traditional RTOS<br=
>
environment to Linux requires some work, no API emulation layer will<br>
give you 1:1 mapping between the zillions of WRS APIs and Linux+Xenomai.<br=
>
<br>
Only playing whack-a-mole fixing syntactical/compilation issues until<br>
your app eventually builds and links is the fastest way to hell for such<br=
>
a porting exercise: this will NOT address the design-related issues that<br=
>
must exist (e.g. what will you do with your original I/O drivers, how<br>
and where will you put the kernel/user boundary when porting your code<br>
etc, etc).<br>
<br>
A core issue is that programming models are fundamentally different,<br>
i.e:<br>
<br>
- single-address space + flat/physically addressed memory + permanent<br>
supervisor privileges + sloppy device driver model<br>
VS<br>
- multiple process contexts + MMU protection + separate<br>
kernel/application address spaces + non-privileged CPU mode for<br>
applications + strict device driver model.<br>
<br>
And, while I&#39;m at it, just in case you might have considered this:<br>
moving all of your original code to Linux kernel space on top of the<br>
Xenomai APIs there would be likely terribly wrong. Aside of the license<br>
issues (GPL vs proprietary), you may also have serious problems down the<br=
>
road porting your code.<br>
<br>
The Xenomai APIs _in kernel space_ are now deprecated, they were made<br>
available at a time when Xenomai had no user-space support, back in<br>
2001. We have such support since 2004 and the in-kernel APIs were kept<br>
for backward compatibility purposes only, so moving a complex<br>
application today, to such an hostile environment for user-level code is<br=
>
basically masochistic.<br>
<br>
A safer way to this journey is:<br>
<br>
- assess which original I/O drivers have to be real-time and move them<br>
to kernel space on top of RTDM.<br>
- assess which original I/O drivers have direct Linux counter-parts,<br>
and/or does not have any RT requirement, and reuse/implement a regular<br>
Linux driver for those.<br>
- segregate what parts of your original code has to be RT enabled from<br>
the other more &quot;relaxed&quot; parts.<br>
- move the application code bulk to userland, on top of the Xenomai APIs<br=
>
there. Adapt the RT portions to the Xenomai APIs, use anything that fits<br=
>
for the rest (e.g. plain glibc).<br>
<br>
Driver-wise, there is rule #666 to abide by: in a dual kernel<br>
environment - like Xenomai 2.x - never, ever, plan to share an IRQ line<br>
between a real-time device and a regular one. As soon as anyone feels<br>
tempted by implementing such a construct, the design flaw is there, and<br>
something must have been wrongly assessed during the early porting<br>
steps.<br>
<br>
All in all, and to sum up: unless your application is 50 LOC at most,<br>
porting it to Linux will require some implementation re-design work, and<br=
>
Xenomai is no magic bullet to avoid that. What Xenomai aims at, is<br>
providing a _correct_ emulation of the core VxWorks services (~100 of<br>
them), which normally mitigates the impact of such re-design work. In<br>
other words, do not confuse Xenomai with running the actual, original<br>
RTOS within some virtual machine on top of a bare metal hypervisor.<br>
<br>
The hypervisor approach is not Linux at all, it is just enabling the<br>
legacy RTOS to run on the same hw than Linux. The former approach is<br>
about mimicking the original RTOS environment natively in a Linux<br>
context, which leads to very different trade-offs when porting.<br>
<br>
You may at the very least want to read that piece, not much yet, but<br>
this is still better than nothing:<br>
<a href=3D"http://www.xenomai.org/index.php/Xenomai:Porting_From_RTOS" targ=
et=3D"_blank">http://www.xenomai.org/index.php/Xenomai:Porting_From_RTOS</a=
><br>
<br>
&gt; Sergey<br>
&gt;<br>
&gt; _______________________________________________<br>
&gt; Xenomai-help mailing list<br>
&gt; <a href=3D"mailto:Xenomai-help@domain.hid">Xenomai-help@domain.hid</a><br>
&gt; <a href=3D"https://mail.gna.org/listinfo/xenomai-help" target=3D"_blan=
k">https://mail.gna.org/listinfo/xenomai-help</a><br>
<br>
<br>
--<br>
Philippe.<br>
<br>
<br>
</div></div></blockquote></div><br>

--001636e0b6014b986104771cfcba--

