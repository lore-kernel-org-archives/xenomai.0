MIME-Version: 1.0
In-Reply-To: <4E4FFD02.2060002@domain.hid>
References: <CAHoMn5rnGNWdfOCkdSX_E=v=3gxxZ+Mm8AM69J5Togg6-aSpXQ@mail.gmail.com>
	<4E4E29DB.3070904@domain.hid>
	<CAHoMn5pdOi_CZUXj_57b2X3HGZKTux5b-_NMxJQ2b9pVbfwNYg@domain.hid>
	<CAHoMn5pW7OL3J7Oa55+=vpgV67Yjut+iq2=p9hP9L2EDo983HA@mail.gmail.com>
	<4E4FFD02.2060002@domain.hid>
Date: Mon, 22 Aug 2011 16:55:11 +0800
Message-ID: <CAHoMn5qut=4yTNxnEYXK4MR3R=dArayBP3QXVOsMkDVPX83vpQ@mail.gmail.com>
From: yi zheng <yizheng23@domain.hid>
Content-Type: multipart/alternative; boundary=001636c928e49860ef04ab143c05
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

--001636c928e49860ef04ab143c05
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: quoted-printable

>
>
> >>>>> Hi,all
> >>>>>       i am a newer to xenomai.Now i want to build xenomai for my
> target
> >>>>> platform with AT91SAM9263 ARM and linux kernel vision 2.6.25.I use
> >>>>> arm-linux-gcc 3.4.1 for compiler,
> >>>>> is it suitable for build
> >>>>> xenomai=A3=BFwhich xenomai vision is better for me?
> >>>
> >>>> Xenomai 2.5.6 is the latest stable release, it should work. But I-pi=
pe
> >>>> patches for later linux kernel releases have support for FCSE, which
> >>>> greatly improves latencies. As for the version of gcc, I have only
> been
> >>>>using gcc 4 for a long time.
> >>>
> >>> --
> >>>
> >>
> >>
> >>
> >>>                                             Gilles.
> >>>
> >>      Hi Gilles
> >>            thank you for your kindly replying.I have used linux-2.6.25
> >> and Xenomai 2.4.4 today.I compiled both linux kernel and Xenomai
>
> >If you have no special reason for using such old versions, you should
> >probably use the latest releases.

     Actually,I want to use RTnet-0.9.12 for my target platform.The network
card driver contained in RTnet-0.9.12 comes from linux kernel vision2.6.25.=
I
prepare to use the same kernel vision as the author who ported standard
linux network card driver to RTnet.

> >Really. Even if you are stuck  with linux 2.6.25 (which probably means
> that the I-pipe patch you use does not have the FCSE

   FCSE is a completely new concept for me=A3=ACI will get more information=
 about
it.

> >option), you can use Xenomai 2.5.6

  I have already compiled  Xenomai 2.4.4 and linux kernel 2.6.25
> successfully on my target platform.
> >>how can i check out that Xenomai can run smoothly with my
> target  platform.look forward to your reply.
>
> >Just run the latency test. But without FCSE, you will not get
> good latencies.
>

      I run latency test,and I got the following result:
[@NewMsg9263: bin]# pwd
/usr/xenomai/bin
[@NewMsg9263: bin]# ./latency -t0 -T60 -p200 -h
=3D=3D Sampling period: 200 us
=3D=3D Test mode: periodic user-mode task
=3D=3D All results in microseconds
warming up...
RTT|  00:00:01  (periodic user-mode task, 200 us period, priority 99)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat
worst
RTD|      33.730|      50.453|      84.750|       0|      33.730|
 84.750
RTD|      23.242|      50.736|      85.034|       0|      23.242|
 85.034
RTD|      20.975|      50.453|      85.034|       0|      20.975|
 85.034
RTD|      24.659|      50.453|      85.884|       0|      20.975|
 85.884
RTD|      24.376|      50.453|      85.600|       0|      20.975|
 85.884
RTD|      24.092|      50.453|      84.750|       0|      20.975|
 85.884
RTD|      23.242|      50.453|      85.034|       0|      20.975|
 85.884
RTD|      24.376|      50.453|      86.167|       0|      20.975|
 86.167
RTD|      22.675|      50.453|      85.600|       0|      20.975|
 86.167
RTD|      23.809|      50.453|      85.317|       0|      20.975|
 86.167
^C---|--param|----range-|--samples
HSD|    min|  20 - 21 |        1
HSD|    min|  22 - 23 |        1
HSD|    min|  23 - 24 |        3
HSD|    min|  24 - 25 |        4
HSD|    min|  33 - 34 |        1
---|--param|----range-|--samples
HSD|    avg|  20 - 21 |        1
HSD|    avg|  22 - 23 |        1
HSD|    avg|  23 - 24 |        7
HSD|    avg|  24 - 25 |       16
HSD|    avg|  25 - 26 |       18
HSD|    avg|  26 - 27 |       18
HSD|    avg|  27 - 28 |        6
HSD|    avg|  28 - 29 |       11
HSD|    avg|  29 - 30 |        4
HSD|    avg|  30 - 31 |        2
HSD|    avg|  32 - 33 |        6
HSD|    avg|  33 - 34 |       13
HSD|    avg|  34 - 35 |       13
HSD|    avg|  35 - 36 |        3
HSD|    avg|  36 - 37 |        1
HSD|    avg|  37 - 38 |       11
HSD|    avg|  38 - 39 |       15
HSD|    avg|  41 - 42 |       29
HSD|    avg|  42 - 43 |      109
HSD|    avg|  43 - 44 |      104
HSD|    avg|  44 - 45 |        6
HSD|    avg|  45 - 46 |       14
HSD|    avg|  46 - 47 |       17
HSD|    avg|  47 - 48 |       15
HSD|    avg|  48 - 49 |       38
HSD|    avg|  49 - 50 |     2084
HSD|    avg|  50 - 51 |    38208
HSD|    avg|  51 - 52 |    11706
HSD|    avg|  52 - 53 |      283
HSD|    avg|  53 - 54 |       96
HSD|    avg|  54 - 55 |       18
latency: failed to pend on semaphore, code -3
HSD|    avg|  55 - 56 |       12
HSD|    avg|  56 - 57 |       31
HSD|    avg|  57 - 58 |       13
HSD|    avg|  58 - 59 |        4
HSD|    avg|  59 - 60 |        7
HSD|    avg|  60 - 61 |       75
HSD|    avg|  61 - 62 |      103
HSD|    avg|  62 - 63 |       38
HSD|    avg|  63 - 64 |       11
HSD|    avg|  64 - 65 |       11
HSD|    avg|  65 - 66 |        2
HSD|    avg|  66 - 67 |        4
HSD|    avg|  67 - 68 |        3
HSD|    avg|  73 - 74 |       19
HSD|    avg|  74 - 75 |        4
HSD|    avg|  82 - 83 |        1
HSD|    avg|  83 - 84 |       32
HSD|    avg|  84 - 85 |       36
HSD|    avg|  85 - 86 |       19
HSD|    avg|  86 - 87 |        2
---|--param|----range-|--samples
HSD|    max|  84 - 85 |        2
HSD|    max|  85 - 86 |        7
HSD|    max|  86 - 87 |        1
HSH|--param|--samples-|--average--|---stddev--
HSS|    min|        10|     24.000|      3.399
HSS|    avg|     53300|     50.229|      2.137
HSS|    max|        10|     84.900|      0.568
---|------------|------------|------------|--------|-----------------------=
--
RTS|      20.975|      50.453|      86.167|       0|    00:00:11/00:01:00

I think my Xenomai environment built successfully.And I want to do more
performance test on Xenomai,is there any other existing test program i can
use?

With above-mentioned linux and Xenomai I compiled RTnet0.9.12.There seems
something wrong with RTnet.
 [@NewMsg9263: modules]# insmod rt_macb.ko
RTnet: registered rteth0
MACB_mii_bus: probed
rteth0: Atmel MACB at 0xfffbc000 irq 21 (12:34:56:78:90:12)
rteth0: attached PHY driver [Davicom DM9161A] (mii_bus:phy_addr=3Dffffffff:=
00,
irq=3D-1)
[@NewMsg9263: modules]# lsmod
rt_macb 8164 0 - Live 0xbf014000
rt_loopback 2404 0 - Live 0xbf012000
rtipv4 25484 0 - Live 0xbf00a000
rtnet 33360 3 rt_macb,rt_loopback,rtipv4, Live 0xbf000000
[@NewMsg9263: sbin]# ./rtifconfig rteth0 up
[@NewMsg9263: sbin]# rteth0: link up (100/Full)
RTnet: host 192.168.0.255 unreachable
RTnet: unable to forward packet from 192.168.0.8
RTnet: host 255.255.255.255 unreachable
RTnet: unable to forward packet from 192.168.0.100
RTnet: host 192.168.0.255 unreachable
RTnet: unable to forward packet from 192.168.0.122
RTnet: host 255.255.255.255 unreachable
RTnet: unable to forward packet from 192.168.0.100
I know this is Xenomai maillist=A3=ACbut if you know where is my problem.Pl=
ease
tell me.

> >--
> >                                                               Gilles.
>
thank you for your kindly help.
regards
yizheng

--001636c928e49860ef04ab143c05
Content-Type: text/html; charset=GB2312
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margi=
n:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div><br>
&gt;&gt;&gt;&gt;&gt; Hi,all<br>
&gt;&gt;&gt;&gt;&gt; &nbsp; &nbsp; &nbsp; i am a newer to xenomai.Now i wan=
t to build xenomai for my target<br>
&gt;&gt;&gt;&gt;&gt; platform with AT91SAM9263 ARM and linux kernel vision =
2.6.25.I use<br>
&gt;&gt;&gt;&gt;&gt; arm-linux-gcc 3.4.1 for compiler,<br>
&gt;&gt;&gt;&gt;&gt; is it suitable for build<br>
&gt;&gt;&gt;&gt;&gt; xenomai=A3=BFwhich xenomai vision is better for me?<br=
>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; Xenomai 2.5.6 is the latest stable release, it should work=
. But I-pipe<br>
&gt;&gt;&gt;&gt; patches for later linux kernel releases have support for F=
CSE, which<br>
&gt;&gt;&gt;&gt; greatly improves latencies. As for the version of gcc, I h=
ave only been<br>
&gt;&gt;&gt;&gt;using gcc 4 for a long time.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; --<br>
&gt;&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; Gilles.<br>
&gt;&gt;&gt;<br>
&gt;&gt; &nbsp; &nbsp; &nbsp;Hi Gilles<br>
&gt;&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;thank you for your kindly=
 replying.I have used linux-2.6.25<br>
&gt;&gt; and Xenomai 2.4.4 today.I compiled both linux kernel and Xenomai<b=
r>
<br>
</div>&gt;If you have no special reason for using such old versions, you sh=
ould<br>&gt;probably use the latest releases. </blockquote><div>&nbsp; &nbs=
p; &nbsp;Actually,I want to use RTnet-0.9.12 for my target platform.The net=
work card driver contained in RTnet-0.9.12 comes from linux kernel vision2.=
6.25.I prepare to use the same kernel vision as the author who ported stand=
ard linux network card driver to RTnet. &nbsp;</div>

<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">&gt;Really. Even if you are stuck &nbsp;with=
&nbsp;linux 2.6.25 (which probably means that the I-pipe patch you use does=
&nbsp;not have the FCSE </blockquote>
<div>&nbsp; &nbsp;FCSE is a completely new concept for me=A3=ACI will get m=
ore information about it.&nbsp;</div><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">&gt;opt=
ion), you can use Xenomai 2.5.6&nbsp;</blockquote>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">

<div>&nbsp; I have already compiled &nbsp;Xenomai 2.4.4 and linux kernel 2.=
6.25 successfully on my target platform.<br>&gt;&gt;how can i check out tha=
t Xenomai can run smoothly with my target&nbsp;&nbsp;platform.look forward =
to your reply.<br>


<br>
</div>&gt;Just run the latency test. But without FCSE, you will not get goo=
d&nbsp;latencies.<br></blockquote><div>&nbsp; &nbsp; &nbsp; &nbsp;</div><di=
v>&nbsp; &nbsp; &nbsp; I run latency test,and I got the following result:</=
div><div>[@NewMsg9263: bin]# pwd</div>

<div>/usr/xenomai/bin</div><div>[@NewMsg9263: bin]# ./latency -t0 -T60 -p20=
0 -h</div><div>=3D=3D Sampling period: 200 us</div><div>=3D=3D Test mode: p=
eriodic user-mode task</div><div>=3D=3D All results in microseconds</div><d=
iv>warming up...</div>

<div>RTT| &nbsp;00:00:01 &nbsp;(periodic user-mode task, 200 us period, pri=
ority 99)</div><div>RTH|-----lat min|-----lat avg|-----lat max|-overrun|---=
-lat best|---lat worst</div><div>RTD| &nbsp; &nbsp; &nbsp;33.730| &nbsp; &n=
bsp; &nbsp;50.453| &nbsp; &nbsp; &nbsp;84.750| &nbsp; &nbsp; &nbsp; 0| &nbs=
p; &nbsp; &nbsp;33.730| &nbsp; &nbsp; &nbsp;84.750</div>

<div>RTD| &nbsp; &nbsp; &nbsp;23.242| &nbsp; &nbsp; &nbsp;50.736| &nbsp; &n=
bsp; &nbsp;85.034| &nbsp; &nbsp; &nbsp; 0| &nbsp; &nbsp; &nbsp;23.242| &nbs=
p; &nbsp; &nbsp;85.034</div><div>RTD| &nbsp; &nbsp; &nbsp;20.975| &nbsp; &n=
bsp; &nbsp;50.453| &nbsp; &nbsp; &nbsp;85.034| &nbsp; &nbsp; &nbsp; 0| &nbs=
p; &nbsp; &nbsp;20.975| &nbsp; &nbsp; &nbsp;85.034</div><div>RTD| &nbsp; &n=
bsp; &nbsp;24.659| &nbsp; &nbsp; &nbsp;50.453| &nbsp; &nbsp; &nbsp;85.884| =
&nbsp; &nbsp; &nbsp; 0| &nbsp; &nbsp; &nbsp;20.975| &nbsp; &nbsp; &nbsp;85.=
884</div>

<div>RTD| &nbsp; &nbsp; &nbsp;24.376| &nbsp; &nbsp; &nbsp;50.453| &nbsp; &n=
bsp; &nbsp;85.600| &nbsp; &nbsp; &nbsp; 0| &nbsp; &nbsp; &nbsp;20.975| &nbs=
p; &nbsp; &nbsp;85.884</div><div>RTD| &nbsp; &nbsp; &nbsp;24.092| &nbsp; &n=
bsp; &nbsp;50.453| &nbsp; &nbsp; &nbsp;84.750| &nbsp; &nbsp; &nbsp; 0| &nbs=
p; &nbsp; &nbsp;20.975| &nbsp; &nbsp; &nbsp;85.884</div><div>RTD| &nbsp; &n=
bsp; &nbsp;23.242| &nbsp; &nbsp; &nbsp;50.453| &nbsp; &nbsp; &nbsp;85.034| =
&nbsp; &nbsp; &nbsp; 0| &nbsp; &nbsp; &nbsp;20.975| &nbsp; &nbsp; &nbsp;85.=
884</div>

<div>RTD| &nbsp; &nbsp; &nbsp;24.376| &nbsp; &nbsp; &nbsp;50.453| &nbsp; &n=
bsp; &nbsp;86.167| &nbsp; &nbsp; &nbsp; 0| &nbsp; &nbsp; &nbsp;20.975| &nbs=
p; &nbsp; &nbsp;86.167</div><div>RTD| &nbsp; &nbsp; &nbsp;22.675| &nbsp; &n=
bsp; &nbsp;50.453| &nbsp; &nbsp; &nbsp;85.600| &nbsp; &nbsp; &nbsp; 0| &nbs=
p; &nbsp; &nbsp;20.975| &nbsp; &nbsp; &nbsp;86.167</div><div>RTD| &nbsp; &n=
bsp; &nbsp;23.809| &nbsp; &nbsp; &nbsp;50.453| &nbsp; &nbsp; &nbsp;85.317| =
&nbsp; &nbsp; &nbsp; 0| &nbsp; &nbsp; &nbsp;20.975| &nbsp; &nbsp; &nbsp;86.=
167</div>

<div>^C---|--param|----range-|--samples</div><div>HSD| &nbsp; &nbsp;min| &n=
bsp;20 - 21 | &nbsp; &nbsp; &nbsp; &nbsp;1</div><div>HSD| &nbsp; &nbsp;min|=
 &nbsp;22 - 23 | &nbsp; &nbsp; &nbsp; &nbsp;1</div><div>HSD| &nbsp; &nbsp;m=
in| &nbsp;23 - 24 | &nbsp; &nbsp; &nbsp; &nbsp;3</div><div>HSD| &nbsp; &nbs=
p;min| &nbsp;24 - 25 | &nbsp; &nbsp; &nbsp; &nbsp;4</div><div>

HSD| &nbsp; &nbsp;min| &nbsp;33 - 34 | &nbsp; &nbsp; &nbsp; &nbsp;1</div><d=
iv>---|--param|----range-|--samples</div><div>HSD| &nbsp; &nbsp;avg| &nbsp;=
20 - 21 | &nbsp; &nbsp; &nbsp; &nbsp;1</div><div>HSD| &nbsp; &nbsp;avg| &nb=
sp;22 - 23 | &nbsp; &nbsp; &nbsp; &nbsp;1</div><div>HSD| &nbsp; &nbsp;avg| =
&nbsp;23 - 24 | &nbsp; &nbsp; &nbsp; &nbsp;7</div><div>HSD| &nbsp; &nbsp;av=
g| &nbsp;24 - 25 | &nbsp; &nbsp; &nbsp; 16</div>

<div>HSD| &nbsp; &nbsp;avg| &nbsp;25 - 26 | &nbsp; &nbsp; &nbsp; 18</div><d=
iv>HSD| &nbsp; &nbsp;avg| &nbsp;26 - 27 | &nbsp; &nbsp; &nbsp; 18</div><div=
>HSD| &nbsp; &nbsp;avg| &nbsp;27 - 28 | &nbsp; &nbsp; &nbsp; &nbsp;6</div><=
div>HSD| &nbsp; &nbsp;avg| &nbsp;28 - 29 | &nbsp; &nbsp; &nbsp; 11</div><di=
v>HSD| &nbsp; &nbsp;avg| &nbsp;29 - 30 | &nbsp; &nbsp; &nbsp; &nbsp;4</div>=
<div>
HSD| &nbsp; &nbsp;avg| &nbsp;30 - 31 | &nbsp; &nbsp; &nbsp; &nbsp;2</div>
<div>HSD| &nbsp; &nbsp;avg| &nbsp;32 - 33 | &nbsp; &nbsp; &nbsp; &nbsp;6</d=
iv><div>HSD| &nbsp; &nbsp;avg| &nbsp;33 - 34 | &nbsp; &nbsp; &nbsp; 13</div=
><div>HSD| &nbsp; &nbsp;avg| &nbsp;34 - 35 | &nbsp; &nbsp; &nbsp; 13</div><=
div>HSD| &nbsp; &nbsp;avg| &nbsp;35 - 36 | &nbsp; &nbsp; &nbsp; &nbsp;3</di=
v><div>HSD| &nbsp; &nbsp;avg| &nbsp;36 - 37 | &nbsp; &nbsp; &nbsp; &nbsp;1<=
/div><div>
HSD| &nbsp; &nbsp;avg| &nbsp;37 - 38 | &nbsp; &nbsp; &nbsp; 11</div>
<div>HSD| &nbsp; &nbsp;avg| &nbsp;38 - 39 | &nbsp; &nbsp; &nbsp; 15</div><d=
iv>HSD| &nbsp; &nbsp;avg| &nbsp;41 - 42 | &nbsp; &nbsp; &nbsp; 29</div><div=
>HSD| &nbsp; &nbsp;avg| &nbsp;42 - 43 | &nbsp; &nbsp; &nbsp;109</div><div>H=
SD| &nbsp; &nbsp;avg| &nbsp;43 - 44 | &nbsp; &nbsp; &nbsp;104</div><div>HSD=
| &nbsp; &nbsp;avg| &nbsp;44 - 45 | &nbsp; &nbsp; &nbsp; &nbsp;6</div><div>
HSD| &nbsp; &nbsp;avg| &nbsp;45 - 46 | &nbsp; &nbsp; &nbsp; 14</div>
<div>HSD| &nbsp; &nbsp;avg| &nbsp;46 - 47 | &nbsp; &nbsp; &nbsp; 17</div><d=
iv>HSD| &nbsp; &nbsp;avg| &nbsp;47 - 48 | &nbsp; &nbsp; &nbsp; 15</div><div=
>HSD| &nbsp; &nbsp;avg| &nbsp;48 - 49 | &nbsp; &nbsp; &nbsp; 38</div><div>H=
SD| &nbsp; &nbsp;avg| &nbsp;49 - 50 | &nbsp; &nbsp; 2084</div><div>HSD| &nb=
sp; &nbsp;avg| &nbsp;50 - 51 | &nbsp; &nbsp;38208</div><div>
HSD| &nbsp; &nbsp;avg| &nbsp;51 - 52 | &nbsp; &nbsp;11706</div>
<div>HSD| &nbsp; &nbsp;avg| &nbsp;52 - 53 | &nbsp; &nbsp; &nbsp;283</div><d=
iv>HSD| &nbsp; &nbsp;avg| &nbsp;53 - 54 | &nbsp; &nbsp; &nbsp; 96</div><div=
>HSD| &nbsp; &nbsp;avg| &nbsp;54 - 55 | &nbsp; &nbsp; &nbsp; 18</div><div>l=
atency: failed to pend on semaphore, code -3</div><div>HSD| &nbsp; &nbsp;av=
g| &nbsp;55 - 56 | &nbsp; &nbsp; &nbsp; 12</div>

<div>HSD| &nbsp; &nbsp;avg| &nbsp;56 - 57 | &nbsp; &nbsp; &nbsp; 31</div><d=
iv>HSD| &nbsp; &nbsp;avg| &nbsp;57 - 58 | &nbsp; &nbsp; &nbsp; 13</div><div=
>HSD| &nbsp; &nbsp;avg| &nbsp;58 - 59 | &nbsp; &nbsp; &nbsp; &nbsp;4</div><=
div>HSD| &nbsp; &nbsp;avg| &nbsp;59 - 60 | &nbsp; &nbsp; &nbsp; &nbsp;7</di=
v><div>HSD| &nbsp; &nbsp;avg| &nbsp;60 - 61 | &nbsp; &nbsp; &nbsp; 75</div>=
<div>
HSD| &nbsp; &nbsp;avg| &nbsp;61 - 62 | &nbsp; &nbsp; &nbsp;103</div>
<div>HSD| &nbsp; &nbsp;avg| &nbsp;62 - 63 | &nbsp; &nbsp; &nbsp; 38</div><d=
iv>HSD| &nbsp; &nbsp;avg| &nbsp;63 - 64 | &nbsp; &nbsp; &nbsp; 11</div><div=
>HSD| &nbsp; &nbsp;avg| &nbsp;64 - 65 | &nbsp; &nbsp; &nbsp; 11</div><div>H=
SD| &nbsp; &nbsp;avg| &nbsp;65 - 66 | &nbsp; &nbsp; &nbsp; &nbsp;2</div><di=
v>HSD| &nbsp; &nbsp;avg| &nbsp;66 - 67 | &nbsp; &nbsp; &nbsp; &nbsp;4</div>=
<div>
HSD| &nbsp; &nbsp;avg| &nbsp;67 - 68 | &nbsp; &nbsp; &nbsp; &nbsp;3</div>
<div>HSD| &nbsp; &nbsp;avg| &nbsp;73 - 74 | &nbsp; &nbsp; &nbsp; 19</div><d=
iv>HSD| &nbsp; &nbsp;avg| &nbsp;74 - 75 | &nbsp; &nbsp; &nbsp; &nbsp;4</div=
><div>HSD| &nbsp; &nbsp;avg| &nbsp;82 - 83 | &nbsp; &nbsp; &nbsp; &nbsp;1</=
div><div>HSD| &nbsp; &nbsp;avg| &nbsp;83 - 84 | &nbsp; &nbsp; &nbsp; 32</di=
v><div>HSD| &nbsp; &nbsp;avg| &nbsp;84 - 85 | &nbsp; &nbsp; &nbsp; 36</div>=
<div>
HSD| &nbsp; &nbsp;avg| &nbsp;85 - 86 | &nbsp; &nbsp; &nbsp; 19</div>
<div>HSD| &nbsp; &nbsp;avg| &nbsp;86 - 87 | &nbsp; &nbsp; &nbsp; &nbsp;2</d=
iv><div>---|--param|----range-|--samples</div><div>HSD| &nbsp; &nbsp;max| &=
nbsp;84 - 85 | &nbsp; &nbsp; &nbsp; &nbsp;2</div><div>HSD| &nbsp; &nbsp;max=
| &nbsp;85 - 86 | &nbsp; &nbsp; &nbsp; &nbsp;7</div><div>HSD| &nbsp; &nbsp;=
max| &nbsp;86 - 87 | &nbsp; &nbsp; &nbsp; &nbsp;1</div><div>
HSH|--param|--samples-|--average--|---stddev--</div>
<div>HSS| &nbsp; &nbsp;min| &nbsp; &nbsp; &nbsp; &nbsp;10| &nbsp; &nbsp; 24=
.000| &nbsp; &nbsp; &nbsp;3.399</div><div>HSS| &nbsp; &nbsp;avg| &nbsp; &nb=
sp; 53300| &nbsp; &nbsp; 50.229| &nbsp; &nbsp; &nbsp;2.137</div><div>HSS| &=
nbsp; &nbsp;max| &nbsp; &nbsp; &nbsp; &nbsp;10| &nbsp; &nbsp; 84.900| &nbsp=
; &nbsp; &nbsp;0.568</div><div>---|------------|------------|------------|-=
-------|-------------------------</div>

<div>RTS| &nbsp; &nbsp; &nbsp;20.975| &nbsp; &nbsp; &nbsp;50.453| &nbsp; &n=
bsp; &nbsp;86.167| &nbsp; &nbsp; &nbsp; 0| &nbsp; &nbsp;00:00:11/00:01:00&n=
bsp;</div><div><br></div><div>I think my Xenomai&nbsp;environment built suc=
cessfully.And I want to do more performance test on Xenomai,is there any ot=
her existing test program i can use?&nbsp;</div>

<div><br></div><div>With above-mentioned linux and Xenomai I compiled RTnet=
0.9.12.There seems something wrong with RTnet.</div><div>&nbsp;[@NewMsg9263=
: modules]# insmod rt_macb.ko&nbsp;</div><div>RTnet: registered rteth0</div=
><div>
MACB_mii_bus: probed</div><div>rteth0: Atmel MACB at 0xfffbc000 irq 21 (12:=
34:56:78:90:12)</div><div>rteth0: attached PHY driver [Davicom DM9161A] (mi=
i_bus:phy_addr=3Dffffffff:00, irq=3D-1)</div><div>[@NewMsg9263: modules]# l=
smod&nbsp;</div>
<div>rt_macb 8164 0 - Live 0xbf014000</div><div>rt_loopback 2404 0 - Live 0=
xbf012000</div><div>rtipv4 25484 0 - Live 0xbf00a000</div><div>rtnet 33360 =
3 rt_macb,rt_loopback,rtipv4, Live 0xbf000000</div><div><div>[@NewMsg9263: =
sbin]# ./rtifconfig rteth0 up</div>
<div>[@NewMsg9263: sbin]# rteth0: link up (100/Full)</div><div>RTnet: host =
192.168.0.255 unreachable</div><div>RTnet: unable to forward packet from 19=
2.168.0.8</div><div>RTnet: host 255.255.255.255 unreachable</div><div>RTnet=
: unable to forward packet from 192.168.0.100</div>
<div>RTnet: host 192.168.0.255 unreachable</div><div>RTnet: unable to forwa=
rd packet from 192.168.0.122</div><div>RTnet: host 255.255.255.255 unreacha=
ble</div><div>RTnet: unable to forward packet from 192.168.0.100</div></div=
>
<div>I know this is Xenomai maillist=A3=ACbut if you know where is my probl=
em.Please tell me.</div><blockquote class=3D"gmail_quote" style=3D"margin:0=
 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">&gt;--<br>
<font color=3D"#888888">&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; Gilles.<br></font></blockquote><div>thank you for your=
 kindly help.</div><div>regards</div><div>yizheng&nbsp;</div></div><br>

--001636c928e49860ef04ab143c05--

