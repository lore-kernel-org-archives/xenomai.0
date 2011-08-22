MIME-Version: 1.0
In-Reply-To: <4E523330.6070205@domain.hid>
References: <CAHoMn5rnGNWdfOCkdSX_E=v=3gxxZ+Mm8AM69J5Togg6-aSpXQ@mail.gmail.com>
	<4E4E29DB.3070904@domain.hid>
	<CAHoMn5pdOi_CZUXj_57b2X3HGZKTux5b-_NMxJQ2b9pVbfwNYg@domain.hid>
	<CAHoMn5pW7OL3J7Oa55+=vpgV67Yjut+iq2=p9hP9L2EDo983HA@mail.gmail.com>
	<4E4FFD02.2060002@domain.hid>
	<CAHoMn5qut=4yTNxnEYXK4MR3R=dArayBP3QXVOsMkDVPX83vpQ@mail.gmail.com>
	<4E523330.6070205@domain.hid>
Date: Mon, 22 Aug 2011 20:09:10 +0800
Message-ID: <CAHoMn5q4gk+FMjWDx75c8rsRa7dxUvLM5OxqkBJVgSFr3pQRHA@mail.gmail.com>
From: yi zheng <yizheng23@domain.hid>
Content-Type: multipart/alternative; boundary=001636c928e457e15a04ab16f2aa
Subject: Re: [Xenomai-help] Fwd: building xenomai for AT91SAM9263
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

--001636c928e457e15a04ab16f2aa
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: quoted-printable

>
>
> >>>
> >>>
> >>>>>>>> Hi,all
> >>>>>>>>       i am a newer to xenomai.Now i want to build xenomai for my
> >>> target
> >>>>>>>> platform with AT91SAM9263 ARM and linux kernel vision 2.6.25.I u=
se
> >>>>>>>> arm-linux-gcc 3.4.1 for compiler,
> >>>>>>>> is it suitable for build
> >>>>>>>> xenomai=A3=BFwhich xenomai vision is better for me?
> >>>>>>>
> >>>>>>>> Xenomai 2.5.6 is the latest stable release, it should work. But
> I-pipe
> >>>>>>>> patches for later linux kernel releases have support for FCSE,
> which
> >>>>>>>> greatly improves latencies. As for the version of gcc, I have on=
ly
> >>> been
> >>>>>>> using gcc 4 for a long time.
> >>>>>>
> >>>>>> --
> >>>>>>
> >>>>>
> >>>>>
> >>>>>
> >>>>>>                                             Gilles.
> >>>>>>
> >>>>>      Hi Gilles
> >>>>>            thank you for your kindly replying.I have used
> linux-2.6.25
> >>>>> and Xenomai 2.4.4 today.I compiled both linux kernel and Xenomai
> >>>
> >>>> If you have no special reason for using such old versions, you shoul=
d
> >>>> probably use the latest releases.
> >>
> >>      Actually,I want to use RTnet-0.9.12 for my target platform.The
> network
> >> card driver contained in RTnet-0.9.12 comes from linux kernel
> vision2.6.25.I
> >> prepare to use the same kernel vision as the author who ported standar=
d
> >> linux network card driver to RTnet.
>
> >As I already told you, you can use Xenomai 2.5.6 with linux 2.6.25, so,
> >that is not a good reason.
>
   I have used  Xenomai 2.5.6 with linux 2.6.25,but i got errors when
compiled linux kernel. compilation process is described  as follows.
   1)patch linux kernel with 2.6.25-at91.patch.
   2)[root@domain.hid xenomai-2.5.6]# pwd
/usr/src/xenomai/xenomai-2.5.6
[root@domain.hid xenomai-2.5.6]# scripts/prepare-kernel.sh --arch=3Darm
--adeos=3Dksrc/arch/arm/patches/adeos-ipipe-2.6.25-arm-1.9-02.patch
--linux=3D/usr/src/xenomai/linux-2.6.25
   3)configure linux kernel.
   4)[root@domain.hid linux-2.6.25]# make uImage
 and  I got=A3=BA
 In file included from include/asm/xenomai/system.h:29,
                 from include/xenomai/nucleus/types.h:41,
                 from include/xenomai/nucleus/queue.h:24,
                 from include/xenomai/nucleus/heap.h:25,
                 from kernel/xenomai/nucleus/bufd.c:144:
include/asm-generic/xenomai/system.h:452: error: parse error before
"phys_addr_t"
include/asm-generic/xenomai/system.h:455: warning: function declaration
isn't a prototype
include/asm-generic/xenomai/system.h: In function
`xnarch_remap_io_page_range':
include/asm-generic/xenomai/system.h:456: error: `vma' undeclared (first us=
e
in this function)
include/asm-generic/xenomai/system.h:456: error: (Each undeclared identifie=
r
is reported only once
include/asm-generic/xenomai/system.h:456: error: for each function it
appears in.)
include/asm-generic/xenomai/system.h:456: error: `from' undeclared (first
use in this function)
include/asm-generic/xenomai/system.h:456: error: `to' undeclared (first use
in this function)
include/asm-generic/xenomai/system.h:456: error: `size' undeclared (first
use in this function)
include/asm-generic/xenomai/system.h:456: error: `prot' undeclared (first
use in this function)
make[3]: *** [kernel/xenomai/nucleus/bufd.o] error 1
make[2]: *** [kernel/xenomai/nucleus] error 2
make[1]: *** [kernel/xenomai] error 2
make: *** [kernel] error 2
I think it was because linux kernel vision does not match Xenomai vision,so
I give up.

>
> >>
> ---|------------|------------|------------|--------|---------------------=
----
> >> RTS|      20.975|      50.453|      86.167|       0|
>  00:00:11/00:01:00
> >>
> >> I think my Xenomai environment built successfully.And I want to do mor=
e
> >> performance test on Xenomai,is there any other existing test program i
> can
> >> use?
>
> >The usual way to assess the latencies of your system is with the
> >"latency" test, but running it several hours with the machine under
> >load. latency results, when run 11seconds on an idle machine are
> >meaningless.
> This time I only want to make sure Xenomai can run successfully on my
> platform.I will take your advise when testing the performance of Xenomai.
> >>
> >> With above-mentioned linux and Xenomai I compiled RTnet0.9.12.There
> seems
> >> something wrong with RTnet.
> >>  [@NewMsg9263: modules]# insmod rt_macb.ko
> >> RTnet: registered rteth0
> >> MACB_mii_bus: probed
> >> rteth0: Atmel MACB at 0xfffbc000 irq 21 (12:34:56:78:90:12)
> >> rteth0: attached PHY driver [Davicom DM9161A]
> (mii_bus:phy_addr=3Dffffffff:00,
> >> irq=3D-1)
> >> [@NewMsg9263: modules]# lsmod
> >> rt_macb 8164 0 - Live 0xbf014000
> >> rt_loopback 2404 0 - Live 0xbf012000
> >> rtipv4 25484 0 - Live 0xbf00a000
> >> rtnet 33360 3 rt_macb,rt_loopback,rtipv4, Live 0xbf000000
> >> [@NewMsg9263: sbin]# ./rtifconfig rteth0 up
> >> [@NewMsg9263: sbin]# rteth0: link up (100/Full)
> >> RTnet: host 192.168.0.255 unreachable
> >> RTnet: unable to forward packet from 192.168.0.8
> >> RTnet: host 255.255.255.255 unreachable
> >> RTnet: unable to forward packet from 192.168.0.100
> >> RTnet: host 192.168.0.255 unreachable
> >> RTnet: unable to forward packet from 192.168.0.122
> >> RTnet: host 255.255.255.255 unreachable
> >> RTnet: unable to forward packet from 192.168.0.100
> >> I know this is Xenomai maillist=A3=ACbut if you know where is my
> problem.Please
> >> tell me.
>
> >Now, the natural question is: do you get the same problems with xenomai
> >2.5.6? Because if you do not get them with xenomai 2.5.6, it means that
> >you hit a bug that was already solved. As long as you persist in using
> >outdated versions, nobody will lift a finger to try and debug issues
> >that may have already been fixed in later releases.
>
   As previously mentioned I have tried Xenomai 2.5.6 with failure=A3=ACso =
I
thought linux kernel vision and Xenomai vision must match wrong.I
have neither used Xenomai and RTnet before.Now i only want to insure Xenoma=
i
and RTnet can  run smoothly with the minimum effort.

>
> >--
> >                                                             Gilles.
>
   Thank you for your help.
   regards
   yizheng

--001636c928e457e15a04ab16f2aa
Content-Type: text/html; charset=GB2312
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margi=
n:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex;"><div class=3D"im=
"><br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Hi,all<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &nbsp; &nbsp; &nbsp; i am a newer to xenom=
ai.Now i want to build xenomai for my<br>
&gt;&gt;&gt; target<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; platform with AT91SAM9263 ARM and linux ke=
rnel vision 2.6.25.I use<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; arm-linux-gcc 3.4.1 for compiler,<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; is it suitable for build<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; xenomai=A3=BFwhich xenomai vision is bette=
r for me?<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Xenomai 2.5.6 is the latest stable release=
, it should work. But I-pipe<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; patches for later linux kernel releases ha=
ve support for FCSE, which<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; greatly improves latencies. As for the ver=
sion of gcc, I have only<br>
&gt;&gt;&gt; been<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; using gcc 4 for a long time.<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; --<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp; Gilles.<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; &nbsp; &nbsp; &nbsp;Hi Gilles<br>
&gt;&gt;&gt;&gt;&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;thank you for=
 your kindly replying.I have used linux-2.6.25<br>
&gt;&gt;&gt;&gt;&gt; and Xenomai 2.4.4 today.I compiled both linux kernel a=
nd Xenomai<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; If you have no special reason for using such old versions,=
 you should<br>
&gt;&gt;&gt;&gt; probably use the latest releases.<br>
&gt;&gt;<br>
&gt;&gt; &nbsp; &nbsp; &nbsp;Actually,I want to use RTnet-0.9.12 for my tar=
get platform.The network<br>
&gt;&gt; card driver contained in RTnet-0.9.12 comes from linux kernel visi=
on2.6.25.I<br>
&gt;&gt; prepare to use the same kernel vision as the author who ported sta=
ndard<br>
&gt;&gt; linux network card driver to RTnet.<br>
<br>
</div>&gt;As I already told you, you can use Xenomai 2.5.6 with linux 2.6.2=
5, so,<br>&gt;that is not a good reason.<br></blockquote><div>&nbsp; &nbsp;=
I have used &nbsp;Xenomai 2.5.6 with linux 2.6.25,but i got errors when com=
piled linux kernel.&nbsp;compilation process&nbsp;is described &nbsp;as fol=
lows.</div>
<div>&nbsp; &nbsp;1)patch linux kernel with&nbsp;2.6.25-at91.patch.</div><d=
iv>&nbsp; &nbsp;2)[root@domain.hid xenomai-2.5.6]# pwd</div><div>/usr/src/x=
enomai/xenomai-2.5.6</div><div>[root@domain.hid xenomai-2.5.6]# scripts/pre=
pare-kernel.sh --arch=3Darm --adeos=3Dksrc/arch/arm/patches/adeos-ipipe-2.6=
.25-arm-1.9-02.patch --linux=3D/usr/src/xenomai/linux-2.6.25</div>
<div>&nbsp; &nbsp;3)configure linux kernel.</div><div>&nbsp; &nbsp;4)[root@=
ServerMing linux-2.6.25]# make uImage</div><div>&nbsp;and &nbsp;I got=A3=BA=
&nbsp;</div><div>&nbsp;In file included from include/asm/xenomai/system.h:2=
9,</div><div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
from include/xenomai/nucleus/types.h:41,</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;from inc=
lude/xenomai/nucleus/queue.h:24,</div><div>&nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp;from include/xenomai/nucleus/heap.h:25,</div>=
<div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;from ker=
nel/xenomai/nucleus/bufd.c:144:</div><div>include/asm-generic/xenomai/syste=
m.h:452: error: parse error before &quot;phys_addr_t&quot;</div>
<div>include/asm-generic/xenomai/system.h:455: warning: function declaratio=
n isn&#39;t a prototype</div><div>include/asm-generic/xenomai/system.h: In =
function `xnarch_remap_io_page_range&#39;:</div><div>include/asm-generic/xe=
nomai/system.h:456: error: `vma&#39; undeclared (first use in this function=
)</div>
<div>include/asm-generic/xenomai/system.h:456: error: (Each undeclared iden=
tifier is reported only once</div><div>include/asm-generic/xenomai/system.h=
:456: error: for each function it appears in.)</div><div>include/asm-generi=
c/xenomai/system.h:456: error: `from&#39; undeclared (first use in this fun=
ction)</div>
<div>include/asm-generic/xenomai/system.h:456: error: `to&#39; undeclared (=
first use in this function)</div><div>include/asm-generic/xenomai/system.h:=
456: error: `size&#39; undeclared (first use in this function)</div><div>
include/asm-generic/xenomai/system.h:456: error: `prot&#39; undeclared (fir=
st use in this function)</div><div>make[3]: *** [kernel/xenomai/nucleus/buf=
d.o] error 1</div><div>make[2]: *** [kernel/xenomai/nucleus] error 2</div>
<div>make[1]: *** [kernel/xenomai] error 2</div><div>make: *** [kernel] err=
or 2</div><div>I think it was because linux kernel vision does not match Xe=
nomai vision,so I give up.</div><blockquote class=3D"gmail_quote" style=3D"=
margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex;">

<div class=3D"im"><br>
&gt;&gt; ---|------------|------------|------------|--------|--------------=
-----------<br>
&gt;&gt; RTS| &nbsp; &nbsp; &nbsp;20.975| &nbsp; &nbsp; &nbsp;50.453| &nbsp=
; &nbsp; &nbsp;86.167| &nbsp; &nbsp; &nbsp; 0| &nbsp; &nbsp;00:00:11/00:01:=
00<br>
&gt;&gt;<br>
&gt;&gt; I think my Xenomai environment built successfully.And I want to do=
 more<br>
&gt;&gt; performance test on Xenomai,is there any other existing test progr=
am i can<br>
&gt;&gt; use?<br>
<br>
</div>&gt;The usual way to assess the latencies of your system is with the<=
br>&gt;&quot;latency&quot; test, but running it several hours with the mach=
ine under<br>&gt;load. latency results, when run 11seconds on an idle machi=
ne are<br>
&gt;meaningless.<br>
<div><div></div><div class=3D"h5">This time I only want to make sure Xenoma=
i can run successfully on my platform.I will take your advise when testing =
the performance of Xenomai.<br>
&gt;&gt;<br>
&gt;&gt; With above-mentioned linux and Xenomai I compiled RTnet0.9.12.Ther=
e seems<br>
&gt;&gt; something wrong with RTnet.<br>
&gt;&gt; &nbsp;[@NewMsg9263: modules]# insmod rt_macb.ko<br>
&gt;&gt; RTnet: registered rteth0<br>
&gt;&gt; MACB_mii_bus: probed<br>
&gt;&gt; rteth0: Atmel MACB at 0xfffbc000 irq 21 (12:34:56:78:90:12)<br>
&gt;&gt; rteth0: attached PHY driver [Davicom DM9161A] (mii_bus:phy_addr=3D=
ffffffff:00,<br>
&gt;&gt; irq=3D-1)<br>
&gt;&gt; [@NewMsg9263: modules]# lsmod<br>
&gt;&gt; rt_macb 8164 0 - Live 0xbf014000<br>
&gt;&gt; rt_loopback 2404 0 - Live 0xbf012000<br>
&gt;&gt; rtipv4 25484 0 - Live 0xbf00a000<br>
&gt;&gt; rtnet 33360 3 rt_macb,rt_loopback,rtipv4, Live 0xbf000000<br>
&gt;&gt; [@NewMsg9263: sbin]# ./rtifconfig rteth0 up<br>
&gt;&gt; [@NewMsg9263: sbin]# rteth0: link up (100/Full)<br>
&gt;&gt; RTnet: host 192.168.0.255 unreachable<br>
&gt;&gt; RTnet: unable to forward packet from 192.168.0.8<br>
&gt;&gt; RTnet: host 255.255.255.255 unreachable<br>
&gt;&gt; RTnet: unable to forward packet from 192.168.0.100<br>
&gt;&gt; RTnet: host 192.168.0.255 unreachable<br>
&gt;&gt; RTnet: unable to forward packet from 192.168.0.122<br>
&gt;&gt; RTnet: host 255.255.255.255 unreachable<br>
&gt;&gt; RTnet: unable to forward packet from 192.168.0.100<br>
&gt;&gt; I know this is Xenomai maillist=A3=ACbut if you know where is my p=
roblem.Please<br>
&gt;&gt; tell me.<br>
<br>
</div></div>&gt;Now, the natural question is: do you get the same problems =
with xenomai<br>&gt;2.5.6? Because if you do not get them with xenomai 2.5.=
6, it means that<br>&gt;you hit a bug that was already solved. As long as y=
ou persist in using<br>
&gt;outdated versions, nobody will lift a finger to try and debug issues<br=
>&gt;that may have already been fixed in later releases.<br></blockquote><d=
iv>&nbsp; &nbsp;As previously mentioned I have tried Xenomai 2.5.6 with fai=
lure=A3=ACso I thought linux kernel vision and Xenomai vision must match wr=
ong.I have&nbsp;neither used Xenomai and RTnet before.Now i only want to&nb=
sp;insure Xenomai and RTnet can &nbsp;run smoothly with the minimum effort.=
</div>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex;">
<br>&gt;--<br><font color=3D"#888888">&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; Gilles.<br></font></blockquote><div>&nbsp; &nbs=
p;Thank you for your help.</div><div>&nbsp; &nbsp;regards</div><div>&nbsp; =
&nbsp;yizheng</div></div><br>

--001636c928e457e15a04ab16f2aa--

