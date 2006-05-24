Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C67F33.FB8CA2D9"
Subject: RE: [Xenomai-help] Almost running - kernel BUG in
	add_preempt_countat	kernel/sched.c:2819!
Date: Wed, 24 May 2006 08:11:44 -0500
Message-ID: <EF12971F23B6EE48803C4991CDAF3C8002FD2658@domain.hid>
References: <447231CC.9080708@domain.hid><44732162.8050606@domain.hid><200605232248.k4NMmtqC024042@domain.hid>
	<447404E7.3030804@domain.hid>
From: "Kharche, Harshad" <Harshad.Kharche@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>, wallace@domain.hid
Cc: xenomai@xenomai.org, jan.kiszka@domain.hid, "Rosenow,
	Jim" <Jim.Rosenow@domain.hid>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C67F33.FB8CA2D9
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

I got the same error when i applied the patch and changed =
CONFIG_IPIPE_TRACE_SHIFT to 12 or 10.
=20
    Uncompressing Linux...inflate returned FFFFFFFB
   exit
=20
- Harshad

________________________________

From: xenomai-help-bounces@domain.hid on behalf of Philippe Gerum
Sent: Wed 5/24/2006 2:01 AM
To: wallace@domain.hid
Cc: xenomai@xenomai.org; jan.kiszka@domain.hid; Rosenow, Jim
Subject: Re: [Xenomai-help] Almost running - kernel BUG in =
add_preempt_countat kernel/sched.c:2819!



Gary Wallace wrote:
>   Thanks for the Makefile patch.  The kernel successfully compiles
> with the tracer enabled after applying this.  Unfortunately I am now
> getting a different error at boot time.
>
>   The image file downloads and starts executing but fails with:
>
> Uncompressing Linux...inflate returned FFFFFFFB
> exit

Try lowering CONFIG_IPIPE_TRACE_SHIFT to 12.

>
> Gary
>
> ------------------------------------
>
>
>>Date: Tue, 23 May 2006 16:51:14 +0200
>>From: Philippe Gerum <rpm@xenomai.org>
>>
>>Gary Wallace wrote:
>>
>>>  I've attached first the config file used without the motorola
>>>patches, and then the config file used with a motorola patched
>>>kernel.
>>
>>Try this:
>>
>>--- arch/ppc/boot/Makefile~   2006-01-31 07:52:07.000000000 +0100
>>+++ arch/ppc/boot/Makefile    2006-05-23 16:49:46.000000000 +0200
>>@@ -13,6 +13,14 @@
>> CFLAGS               +=3D -fno-builtin -D__BOOTER__ =
-Iarch/$(ARCH)/boot/include
>> HOSTCFLAGS   +=3D -Iarch/$(ARCH)/boot/include
>>
>>+ifdef CONFIG_IPIPE_TRACE
>>+# do not trace the boot loader
>>+nullstring :=3D
>>+space      :=3D $(nullstring) # end of the line
>>+pg_flag     =3D $(nullstring) -pg # end of the line
>>+CFLAGS     :=3D $(subst ${pg_flag},${space},${CFLAGS})
>>+endif
>>+
>> BOOT_TARGETS =3D zImage zImage.initrd znetboot znetboot.initrd
>>
>> bootdir-y                    :=3D simple
>>
>>--
>>
>>Philippe.
>>
>
>


--

Philippe.

_______________________________________________
Xenomai-help mailing list
Xenomai-help@domain.hid
https://mail.gna.org/listinfo/xenomai-help




------_=_NextPart_001_01C67F33.FB8CA2D9
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1">=0A=
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">=0A=
<HTML>=0A=
<HEAD>=0A=
=0A=
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7638.1">=0A=
<TITLE>Re: [Xenomai-help] Almost running - kernel BUG in =
add_preempt_countat	kernel/sched.c:2819!</TITLE>=0A=
</HEAD>=0A=
<BODY>=0A=
<DIV dir=3Dltr><FONT face=3D"Trebuchet MS" color=3D#000000 size=3D2>I =
got the same error =0A=
when i applied the patch and changed <FONT =
size=3D2>CONFIG_IPIPE_TRACE_SHIFT to =0A=
12&nbsp;or 10.</FONT></FONT></DIV>=0A=
<DIV dir=3Dltr><FONT face=3D"Trebuchet MS" size=3D2></FONT>&nbsp;</DIV>=0A=
<DIV dir=3Dltr><FONT size=3D2>&nbsp;&nbsp;&nbsp; Uncompressing =
Linux...inflate =0A=
returned FFFFFFFB</FONT><BR>&nbsp;&nbsp; exit</DIV>=0A=
<DIV dir=3Dltr>&nbsp;</DIV>=0A=
<DIV dir=3Dltr>- Harshad</DIV>=0A=
<DIV dir=3Dltr><BR></DIV>=0A=
<DIV dir=3Dltr>=0A=
<HR tabIndex=3D-1>=0A=
</DIV>=0A=
<DIV dir=3Dltr><FONT face=3DTahoma size=3D2><B>From:</B> =
xenomai-help-bounces@domain.hid =0A=
on behalf of Philippe Gerum<BR><B>Sent:</B> Wed 5/24/2006 2:01 =
AM<BR><B>To:</B> =0A=
wallace@domain.hid<BR><B>Cc:</B> xenomai@xenomai.org; =
jan.kiszka@domain.hid; =0A=
Rosenow, Jim<BR><B>Subject:</B> Re: [Xenomai-help] Almost running - =
kernel BUG =0A=
in add_preempt_countat kernel/sched.c:2819!<BR></FONT><BR></DIV>=0A=
<DIV>=0A=
<P><FONT size=3D2>Gary Wallace wrote:<BR>&gt;&nbsp;&nbsp; Thanks for the =
Makefile =0A=
patch.&nbsp; The kernel successfully compiles<BR>&gt; with the tracer =
enabled =0A=
after applying this.&nbsp; Unfortunately I am now<BR>&gt; getting a =
different =0A=
error at boot time.<BR>&gt;<BR>&gt;&nbsp;&nbsp; The image file downloads =
and =0A=
starts executing but fails with:<BR>&gt;<BR>&gt; Uncompressing =
Linux...inflate =0A=
returned FFFFFFFB<BR>&gt; exit<BR><BR>Try lowering =
CONFIG_IPIPE_TRACE_SHIFT to =0A=
12.<BR><BR>&gt;<BR>&gt; Gary<BR>&gt;<BR>&gt; =0A=
------------------------------------<BR>&gt;<BR>&gt;<BR>&gt;&gt;Date: =
Tue, 23 =0A=
May 2006 16:51:14 +0200<BR>&gt;&gt;From: Philippe Gerum =0A=
&lt;rpm@xenomai.org&gt;<BR>&gt;&gt;<BR>&gt;&gt;Gary Wallace =0A=
wrote:<BR>&gt;&gt;<BR>&gt;&gt;&gt;&nbsp; I've attached first the config =
file =0A=
used without the motorola<BR>&gt;&gt;&gt;patches, and then the config =
file used =0A=
with a motorola =
patched<BR>&gt;&gt;&gt;kernel.<BR>&gt;&gt;<BR>&gt;&gt;Try =0A=
this:<BR>&gt;&gt;<BR>&gt;&gt;--- arch/ppc/boot/Makefile~&nbsp;&nbsp; =
2006-01-31 =0A=
07:52:07.000000000 +0100<BR>&gt;&gt;+++ =
arch/ppc/boot/Makefile&nbsp;&nbsp;&nbsp; =0A=
2006-05-23 16:49:46.000000000 +0200<BR>&gt;&gt;@@ -13,6 +13,14 =
@@<BR>&gt;&gt; =0A=
CFLAGS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =0A=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +=3D -fno-builtin -D__BOOTER__ =0A=
-Iarch/$(ARCH)/boot/include<BR>&gt;&gt; HOSTCFLAGS&nbsp;&nbsp; +=3D =0A=
-Iarch/$(ARCH)/boot/include<BR>&gt;&gt;<BR>&gt;&gt;+ifdef =0A=
CONFIG_IPIPE_TRACE<BR>&gt;&gt;+# do not trace the boot =0A=
loader<BR>&gt;&gt;+nullstring =
:=3D<BR>&gt;&gt;+space&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =0A=
:=3D $(nullstring) # end of the =
line<BR>&gt;&gt;+pg_flag&nbsp;&nbsp;&nbsp;&nbsp; =3D =0A=
$(nullstring) -pg # end of the =
line<BR>&gt;&gt;+CFLAGS&nbsp;&nbsp;&nbsp;&nbsp; =0A=
:=3D $(subst =0A=
${pg_flag},${space},${CFLAGS})<BR>&gt;&gt;+endif<BR>&gt;&gt;+<BR>&gt;&gt;=
 =0A=
BOOT_TARGETS =3D zImage zImage.initrd znetboot =0A=
znetboot.initrd<BR>&gt;&gt;<BR>&gt;&gt; bootdir-y&nbsp;&nbsp;&nbsp; =0A=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =0A=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; :=3D =0A=
simple<BR>&gt;&gt;<BR>&gt;&gt;--<BR>&gt;&gt;<BR>&gt;&gt;Philippe.<BR>&gt;=
&gt;<BR>&gt;<BR>&gt;<BR><BR><BR>--<BR><BR>Philippe.<BR><BR>______________=
_________________________________<BR>Xenomai-help =0A=
mailing list<BR>Xenomai-help@domain.hid<BR><A =0A=
href=3D"https://mail.gna.org/listinfo/xenomai-help">https://mail.gna.org/=
listinfo/xenomai-help</A><BR><BR></FONT></P></DIV>=0A=
=0A=
</BODY>=0A=
</HTML>
------_=_NextPart_001_01C67F33.FB8CA2D9--

