MIME-Version: 1.0
In-Reply-To: <8b216e9e1002131225v16024e66p521d7eaad376441d@domain.hid>
References: <8b216e9e1002100327h3aa332ddl13ec590fcb81f0b7@domain.hid> 
	<4B746FFE.20204@domain.hid>
	<8b216e9e1002111430h5687cb9udfad3e08da08d83a@domain.hid> 
	<4B750157.6080000@domain.hid>
	<8b216e9e1002121023qa0f4d6n33c773110cfc78fd@domain.hid> 
	<4B759DF9.9040800@domain.hid> <4B759F35.3050704@domain.hid> 
	<8b216e9e1002131157k6f1a7ccbiba5e67b8855c77b2@domain.hid> 
	<4B770554.3080809@domain.hid>
	<8b216e9e1002131225v16024e66p521d7eaad376441d@domain.hid>
From: =?ISO-8859-1?Q?Felipe_Brand=E3o_Cavalcanti?= <cavalkaf@domain.hid>
Date: Mon, 15 Feb 2010 15:19:49 -0200
Message-ID: <8b216e9e1002150919p250b5270tab0bf5f242e87a25@domain.hid>
Content-Type: multipart/alternative; boundary=00504502ab61462739047fa6d4da
Subject: Re: [Xenomai-help] Problems when cross-compiling Xenomai
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
Cc: xenomai@xenomai.org

--00504502ab61462739047fa6d4da
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

2010/2/13 Felipe Brand=E3o Cavalcanti <cavalkaf@domain.hid>

>
>
> 2010/2/13 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
>
> Felipe Brand=E3o Cavalcanti wrote:
>> > OK - I did apply the patch to 2.6.30.10, with some very minor
>> modifications
>> > in the sound system and in the headers (MACH_TYPE_IGEP0020 wasn't
>> defined).
>> > I also applied the latest Adeos Ipipe patch.
>> >
>> > However, the compiled kernel doesn't boot - it actually just sits ther=
e,
>> > doing nothing:
>> >
>> > Bytes transferred =3D 2555616 (26fee0 hex)
>> > ## Booting kernel from Legacy Image at 80000000 ...
>> >    Image Name:   Linux-2.6.30.10
>> >    Image Type:   ARM Linux Kernel Image (uncompressed)
>> >    Data Size:    2555552 Bytes =3D  2.4 MB
>> >    Load Address: 80008000
>> >    Entry Point:  80008000
>> >    Verifying Checksum ... OK
>> >    Loading Kernel Image ... OK
>> > OK
>> >
>> > Starting kernel ...
>> >
>> > Uncompressing
>> >
>> Linux...................................................................=
...........................................................................=
....................
>> > done, booting the kernel.
>> >
>> > My guess is that Linux is simply not sending anything through my seria=
l
>> > (i.e., debug) port. Should I attempt to port over the serial driver, o=
r
>> is
>> > this something else?
>> > I am also downloading kernel 2.6.32 to see if I can make it boot on my
>> IGEP.
>>
>> Do you pass the proper "console=3D" argument to the kernel? Is the suppo=
rt
>> for serial driver enabled in the kernel?
>>
>> If yes, then apply trick #1 from the "Tips and tricks" section in the
>> "porting I-pipe to a new board" HOWTO on Xenomai website.
>>
>>
> Yeah, I called it with the console=3D argument, and support is enabled. J=
ust
> tested 2.6.32 - working fine in my board!
>
> I will try 2.6.30 again, but this time with no I-pipe patch, as well as
> enabling the low-level debug options.
>
>

OK - so I compiled the kernel with a series of kernel debug options, to fin=
d
out what was going on. However, the kernel is stuck in a very strange
position - just after starting the network!

So, any ideas on where I should take a look? I will attempt disabling
network support, but this would a temporary solution, as I actually need
network on my embedded system.

Thanks for the help,
  -Felipe Brand=E3o Cavalcanti

Here is my console output:

Starting kernel ...

Uncompressing
Linux......................................................................=
...........................................................................=
...........................................
<5>Linux version 2.6.30.10 (jdoe@domain.hid) (gcc version 4.3.2 (GCC) ) #1 Mon
Feb 15 18:06:42 CET 2010
CPU: ARMv7 Processor [411fc083] revision 3 (ARMv7), cr=3D10c5387f
CPU: VIPT nonaliasing data cache, VIPT nonaliasing instruction cache
Machine: IGEP v2.x board
Memory policy: ECC disabled, Data cache writeback
<5>Truncating RAM at 80000000-9fffffff to -87ffffff (vmalloc region
overlap).
<7>On node 0 totalpages: 32768
<7>free_area_init_node: node 0, pgdat c06f9208, node_mem_map c0d29000
<7>  Normal zone: 256 pages used for memmap
<7>  Normal zone: 0 pages reserved
<7>  Normal zone: 32512 pages, LIFO batch:7
<6>OMAP3430 ES3.1
<6>SRAM: Mapped pa 0x40200000 to va 0xd7000000 size: 0x100000
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 32512
<5>Kernel command line: mem=3D512M console=3DttyS2,115200n8 console=3Dtty0
omapfb.mode=3Ddvi:1024x768MR-16@domain.hid root=3D/dev/mtdblock4 rootfstype=3Djffs2
<3>Unknown boot option `omapfb.mode=3Ddvi:1024x768MR-16@domain.hid': ignoring
<6>NR_IRQS:402
<6>Clocking rate (Crystal/DPLL/ARM core): 26.0/332/720 MHz
<6>GPMC revision 5.0
<6>IRQ: Found an INTC at 0xd8200000 (revision 4.0) with 96 interrupts
<6>Total of 96 interrupts on 1 active controller
<6>OMAP34xx GPIO hardware version 2.5
PID hash table entries: 512 (order: 9, 2048 bytes)
<6>OMAP clockevent source: GPTIMER1 at 32768 Hz
Console: colour dummy device 80x30
<6>console [tty0] enabled
Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
... MAX_LOCKDEP_SUBCLASSES:  8
... MAX_LOCK_DEPTH:          48
... MAX_LOCKDEP_KEYS:        8191
... CLASSHASH_SIZE:          4096
... MAX_LOCKDEP_ENTRIES:     16384
... MAX_LOCKDEP_CHAINS:      32768
... CHAINHASH_SIZE:          16384
 memory used by lock dependency info: 3871 kB
 per task-struct memory footprint: 2304 bytes
<6>Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
<6>Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
<6>Memory: 128MB =3D 128MB total
<5>Memory: 116308KB available (4880K code, 8068K data, 180K init, 0K
highmem)
<7>ODEBUG: 0 of 0 active objects replaced
<6>Calibrating delay loop... 715.27 BogoMIPS (lpj=3D2793472)
Mount-cache hash table entries: 512
<6>CPU: Testing write buffer coherency: ok
<6>net_namespace: 988 bytes
<6>regulator: core version 0.5
<6>NET: Registered protocol family 16



>
>> --
>>                                             Gilles.
>>
>>
>
>
> --
>       -Felipe Brand=E3o Cavalcanti
>       LARA - Robotics and Automation Laboratory
>       Department of Electrical Engineering
>       UnB - University of Bras=EDlia, Brazil
>       http://www.lara.unb.br/~fbcavalcanti/<http://www.lara.unb.br/%7Efbc=
avalcanti/>
>



--=20
      -Felipe Brand=E3o Cavalcanti
      LARA - Robotics and Automation Laboratory
      Department of Electrical Engineering
      UnB - University of Bras=EDlia, Brazil
      http://www.lara.unb.br/~fbcavalcanti/

--00504502ab61462739047fa6d4da
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">2010/2/13 Felipe Brand=E3o Cavalcanti <s=
pan dir=3D"ltr">&lt;<a href=3D"mailto:cavalkaf@domain.hid">cavalkaf@domain.hid=
m</a>&gt;</span><br><blockquote class=3D"gmail_quote" style=3D"border-left:=
 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex=
;">

<br><br><div class=3D"gmail_quote">2010/2/13 Gilles Chanteperdrix <span dir=
=3D"ltr">&lt;<a href=3D"mailto:gilles.chanteperdrix@xenomai.org" target=3D"=
_blank">gilles.chanteperdrix@xenomai.org</a>&gt;</span><div><div></div><div=
 class=3D"h5">

<br><blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(2=
04, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<div>Felipe Brand=E3o Cavalcanti wrote:<br>
&gt; OK - I did apply the patch to 2.6.30.10, with some very minor modifica=
tions<br>
&gt; in the sound system and in the headers (MACH_TYPE_IGEP0020 wasn&#39;t =
defined).<br>
&gt; I also applied the latest Adeos Ipipe patch.<br>
&gt;<br>
&gt; However, the compiled kernel doesn&#39;t boot - it actually just sits =
there,<br>
&gt; doing nothing:<br>
&gt;<br>
&gt; Bytes transferred =3D 2555616 (26fee0 hex)<br>
&gt; ## Booting kernel from Legacy Image at 80000000 ...<br>
&gt; =A0 =A0Image Name: =A0 Linux-2.6.30.10<br>
&gt; =A0 =A0Image Type: =A0 ARM Linux Kernel Image (uncompressed)<br>
&gt; =A0 =A0Data Size: =A0 =A02555552 Bytes =3D =A02.4 MB<br>
&gt; =A0 =A0Load Address: 80008000<br>
&gt; =A0 =A0Entry Point: =A080008000<br>
&gt; =A0 =A0Verifying Checksum ... OK<br>
&gt; =A0 =A0Loading Kernel Image ... OK<br>
&gt; OK<br>
&gt;<br>
&gt; Starting kernel ...<br>
&gt;<br>
&gt; Uncompressing<br>
&gt; Linux.................................................................=
...........................................................................=
......................<br>
&gt; done, booting the kernel.<br>
&gt;<br>
&gt; My guess is that Linux is simply not sending anything through my seria=
l<br>
&gt; (i.e., debug) port. Should I attempt to port over the serial driver, o=
r is<br>
&gt; this something else?<br>
&gt; I am also downloading kernel 2.6.32 to see if I can make it boot on my=
 IGEP.<br>
<br>
</div>Do you pass the proper &quot;console=3D&quot; argument to the kernel?=
 Is the support<br>
for serial driver enabled in the kernel?<br>
<br>
If yes, then apply trick #1 from the &quot;Tips and tricks&quot; section in=
 the<br>
&quot;porting I-pipe to a new board&quot; HOWTO on Xenomai website.<br>
<br></blockquote></div></div><div><br>Yeah, I called it with the console=3D=
 argument, and support is enabled. Just tested 2.6.32 - working fine in my =
board!<br><br>I will try 2.6.30 again, but this time with no I-pipe patch, =
as well as enabling the low-level debug options.<br>


=A0</div></div></blockquote><div><br>OK - so I compiled the kernel with a s=
eries of kernel debug options, to find out what was going on. However, the =
kernel is stuck in a very strange position - just after starting the networ=
k!<br>

<br>So, any ideas on where I should take a look? I will attempt disabling n=
etwork support, but this would a temporary solution, as I actually need net=
work on my embedded system.<br><br>Thanks for the help,<br>=A0 -Felipe Bran=
d=E3o Cavalcanti<br>

<br>Here is my console output:<br><br>Starting kernel ...<br><br>Uncompress=
ing Linux..................................................................=
...........................................................................=
...............................................<br>

&lt;5&gt;Linux version 2.6.30.10 (jdoe@domain.hid) (gcc version 4.3.2 (GCC) ) #=
1 Mon Feb 15 18:06:42 CET 2010<br>CPU: ARMv7 Processor [411fc083] revision =
3 (ARMv7), cr=3D10c5387f<br>CPU: VIPT nonaliasing data cache, VIPT nonalias=
ing instruction cache<br>

Machine: IGEP v2.x board<br>Memory policy: ECC disabled, Data cache writeba=
ck<br>&lt;5&gt;Truncating RAM at 80000000-9fffffff to -87ffffff (vmalloc re=
gion overlap).<br>&lt;7&gt;On node 0 totalpages: 32768<br>&lt;7&gt;free_are=
a_init_node: node 0, pgdat c06f9208, node_mem_map c0d29000<br>

&lt;7&gt;=A0 Normal zone: 256 pages used for memmap<br>&lt;7&gt;=A0 Normal =
zone: 0 pages reserved<br>&lt;7&gt;=A0 Normal zone: 32512 pages, LIFO batch=
:7<br>&lt;6&gt;OMAP3430 ES3.1<br>&lt;6&gt;SRAM: Mapped pa 0x40200000 to va =
0xd7000000 size: 0x100000<br>

Built 1 zonelists in Zone order, mobility grouping on.=A0 Total pages: 3251=
2<br>&lt;5&gt;Kernel command line: mem=3D512M console=3DttyS2,115200n8 cons=
ole=3Dtty0 omapfb.mode=3Ddvi:1024x768MR-16@domain.hid root=3D/dev/mtdblock4 rootfst=
ype=3Djffs2<br>

&lt;3&gt;Unknown boot option `omapfb.mode=3Ddvi:1024x768MR-16@domain.hid&#39;: igno=
ring<br>&lt;6&gt;NR_IRQS:402<br>&lt;6&gt;Clocking rate (Crystal/DPLL/ARM co=
re): 26.0/332/720 MHz<br>&lt;6&gt;GPMC revision 5.0<br>&lt;6&gt;IRQ: Found =
an INTC at 0xd8200000 (revision 4.0) with 96 interrupts<br>

&lt;6&gt;Total of 96 interrupts on 1 active controller<br>&lt;6&gt;OMAP34xx=
 GPIO hardware version 2.5<br>PID hash table entries: 512 (order: 9, 2048 b=
ytes)<br>&lt;6&gt;OMAP clockevent source: GPTIMER1 at 32768 Hz<br>Console: =
colour dummy device 80x30<br>

&lt;6&gt;console [tty0] enabled<br>Lock dependency validator: Copyright (c)=
 2006 Red Hat, Inc., Ingo Molnar<br>... MAX_LOCKDEP_SUBCLASSES:=A0 8<br>...=
 MAX_LOCK_DEPTH:=A0=A0=A0=A0=A0=A0=A0=A0=A0 48<br>... MAX_LOCKDEP_KEYS:=A0=
=A0=A0=A0=A0=A0=A0 8191<br>... CLASSHASH_SIZE:=A0=A0=A0=A0=A0=A0=A0=A0=A0 4=
096<br>

... MAX_LOCKDEP_ENTRIES:=A0=A0=A0=A0 16384<br>... MAX_LOCKDEP_CHAINS:=A0=A0=
=A0=A0=A0 32768<br>... CHAINHASH_SIZE:=A0=A0=A0=A0=A0=A0=A0=A0=A0 16384<br>=
=A0memory used by lock dependency info: 3871 kB<br>=A0per task-struct memor=
y footprint: 2304 bytes<br>&lt;6&gt;Dentry cache hash table entries: 16384 =
(order: 4, 65536 bytes)<br>

&lt;6&gt;Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)<br>&l=
t;6&gt;Memory: 128MB =3D 128MB total<br>&lt;5&gt;Memory: 116308KB available=
 (4880K code, 8068K data, 180K init, 0K highmem)<br>&lt;7&gt;ODEBUG: 0 of 0=
 active objects replaced<br>

&lt;6&gt;Calibrating delay loop... 715.27 BogoMIPS (lpj=3D2793472)<br>Mount=
-cache hash table entries: 512<br>&lt;6&gt;CPU: Testing write buffer cohere=
ncy: ok<br>&lt;6&gt;net_namespace: 988 bytes<br>&lt;6&gt;regulator: core ve=
rsion 0.5<br>

&lt;6&gt;NET: Registered protocol family 16<br><br>=A0</div><blockquote cla=
ss=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, 204, 204); marg=
in: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><div class=3D"gmail_quote"><bloc=
kquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, 204, =
204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">


<br>
--<br>
<font color=3D"#888888"> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Gilles.<br>
<br>
</font></blockquote></div><div><div></div><div class=3D"h5"><br><br clear=
=3D"all"><br>-- <br> =A0 =A0 =A0 -Felipe Brand=E3o Cavalcanti<br> =A0 =A0 =
=A0 LARA - Robotics and Automation Laboratory<br> =A0 =A0 =A0 Department of=
 Electrical Engineering<br>

 =A0 =A0 =A0 UnB - University of Bras=EDlia, Brazil<br>
 =A0 =A0 =A0 <a href=3D"http://www.lara.unb.br/%7Efbcavalcanti/" target=3D"=
_blank">http://www.lara.unb.br/~fbcavalcanti/</a><br>
</div></div></blockquote></div><br><br clear=3D"all"><br>-- <br> =A0 =A0 =
=A0 -Felipe Brand=E3o Cavalcanti<br> =A0 =A0 =A0 LARA - Robotics and Automa=
tion Laboratory<br> =A0 =A0 =A0 Department of Electrical Engineering<br> =
=A0 =A0 =A0 UnB - University of Bras=EDlia, Brazil<br>

 =A0 =A0 =A0 <a href=3D"http://www.lara.unb.br/~fbcavalcanti/">http://www.l=
ara.unb.br/~fbcavalcanti/</a><br>

--00504502ab61462739047fa6d4da--

