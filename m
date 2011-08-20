MIME-Version: 1.0
In-Reply-To: <CAHoMn5pdOi_CZUXj_57b2X3HGZKTux5b-_NMxJQ2b9pVbfwNYg@domain.hid>
References: <CAHoMn5rnGNWdfOCkdSX_E=v=3gxxZ+Mm8AM69J5Togg6-aSpXQ@mail.gmail.com>
	<4E4E29DB.3070904@domain.hid>
	<CAHoMn5pdOi_CZUXj_57b2X3HGZKTux5b-_NMxJQ2b9pVbfwNYg@domain.hid>
Date: Sat, 20 Aug 2011 10:20:46 +0800
Message-ID: <CAHoMn5pW7OL3J7Oa55+=vpgV67Yjut+iq2=p9hP9L2EDo983HA@mail.gmail.com>
From: yi zheng <yizheng23@domain.hid>
Content-Type: multipart/alternative; boundary=001636b2b8266ba3fb04aae67e5f
Subject: [Xenomai-help] Fwd:  building xenomai for AT91SAM9263
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

--001636b2b8266ba3fb04aae67e5f
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: quoted-printable

>
> >> Hi,all
> >>       i am a newer to xenomai.Now i want to build xenomai for my targe=
t
> >> platform with AT91SAM9263 ARM and linux kernel vision 2.6.25.I use
> >> arm-linux-gcc 3.4.1 for compiler,
> >> is it suitable for build
> >> xenomai=A3=BFwhich xenomai vision is better for me?
>
> >Xenomai 2.5.6 is the latest stable release, it should work. But I-pipe
> >patches for later linux kernel releases have support for FCSE, which
> >greatly improves latencies. As for the version of gcc, I have only been
> >using gcc 4 for a long time.
>
> --
>



>                                             Gilles.
>
     Hi Gilles
           thank you for your kindly replying.I have used linux-2.6.25
and Xenomai 2.4.4 today.I compiled both linux kernel and Xenomai
successfully following "2.6 Building for ARM" in Xenomai 2.4.4's document
named "readme.install" .But i didn't know how to run test program,that is t=
o
say i didn't know whether Xenomai could run smoothly on my target
platform.As mentioned earlier my embedded platform is AT91SAM9263 ARM.And
arm-linux-gcc I used is 3.4.1.
           I used 2.6.25-at91.patch patching the kernel.And then compiling
linux kernel and Xenomai 2.4.4 as followed=A3=BA
         compiling linux kernel
         1=A3=A9  scripts/prepare-kernel.sh
             --arch=3Darm
 --adeos=3Dksrc/arch/arm/patches/adeos-ipipe-2.6.25-arm-1.9-02.patch
            --linux=3D/usr/src/xenomai/linux-2.6.25
         2=A3=A9make ARCH=3Darm CROSS_COMPILE=3Darm-linux-  at91sam9263ek_d=
efconfig
         3=A3=A9 make ARCH=3Darm CROSS_COMPILE=3Darm-linux-  uImage modules
         compiling  Xenomai
         4=A3=A9ARCH=3Darm  CROSS_COMPILE=3Darm-linux-
             ./configure --host=3Darm-linux
              --enable-arm-mach=3Dat91sam926x  --enable-arm-tsc
          5=A3=A9make install
         Xenomai installation directory is  /usr/xenomai.executing "ls",i
got
          [root@domain.hid xenomai]# ls
         bin  include  lib  sbin  share

         I downloaded kernel and /usr/xenomai to my target platform in
a suitable way.Linux kernel can run successfully.
 [@NewMsg9263: bin]# pwd
 /usr/xenomai/bin
[@NewMsg9263: bin]# ./xeno-info
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

BusyBox v1.15.3 (2010-03-30 15:34:10 CST) multi-call binary
Linux NewMsg9263 2.6.25 #3 Sat Aug 20 09:40:50 CST 2011 armv5tejl GNU/Linux

module-init-tools      V
Modules Loaded

when i tried to run xeno-info directory=A3=ACi got information above.

if there is something wrong with compiling kernel and Xenomai=A3=ACplease c=
orrect
me.and how can i check out that Xenomai can run smoothly with my target
platform.look forward to your reply.
yizhneg

--001636b2b8266ba3fb04aae67e5f
Content-Type: text/html; charset=GB2312
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote"><div class=3D"gmail_quote"><div><div class=3D"h5=
"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:=
1px #ccc solid;padding-left:1ex"><div><div>&gt;&gt; Hi,all<br>&gt;&gt; &nbs=
p; &nbsp; &nbsp; i am a newer to xenomai.Now i want to build xenomai for my=
 target<br>
&gt;&gt; platform with AT91SAM9263 ARM and linux kernel vision 2.6.25.I use=
<br>

&gt;&gt; arm-linux-gcc 3.4.1 for compiler,<br>
&gt;&gt; is it suitable for build<br>
&gt;&gt; xenomai=A3=BFwhich xenomai vision is better for me?<br>
<br>
</div></div>&gt;Xenomai 2.5.6 is the latest stable release, it should work.=
 But I-pipe<br>&gt;patches for later linux kernel releases have support for=
 FCSE, which<br>&gt;greatly improves latencies. As for the version of gcc, =
I have only been<br>


&gt;using gcc 4 for a long time.<br>
&nbsp;<br>
--<br></blockquote><div><br></div><div>&nbsp; &nbsp;</div><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex">
<font color=3D"#888888"> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp;Gilles.<br></font></blockquote></div></div><div=
>&nbsp; &nbsp; &nbsp;Hi Gilles</div><div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp;thank you for your kindly replying.I have used linux-2.6.25 and&nbsp=
;Xenomai 2.4.4 today.I compiled both linux kernel and&nbsp;Xenomai successf=
ully following &quot;2.6 Building for ARM&quot; in&nbsp;Xenomai 2.4.4&#39;s=
&nbsp;document named &quot;readme.install&quot; .But i didn&#39;t know how =
to run test program,that is to say i didn&#39;t know whether&nbsp;Xenomai c=
ould run smoothly on my target platform.As mentioned earlier my embedded pl=
atform is AT91SAM9263 ARM.And arm-linux-gcc I used is 3.4.1.</div>


<div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;I used&nbsp;2.6.25-at91.patch=
 patching the kernel.And then compiling linux kernel and&nbsp;Xenomai 2.4.4=
 as followed=A3=BA</div><div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;compiling li=
nux kernel</div><div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;1=A3=A9 &nbsp;script=
s/prepare-kernel.sh&nbsp;</div>

<div>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; --arch=3Darm &nbsp;--adeos=3Dksrc=
/arch/arm/patches/adeos-ipipe-2.6.25-arm-1.9-02.patch&nbsp;</div><div>&nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; --linux=3D/usr/src/xenomai/linux-2.6.2=
5</div><div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;2=A3=A9make ARCH=3Darm CROSS_=
COMPILE=3Darm-linux- &nbsp;at91sam9263ek_defconfig</div>


<div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;3=A3=A9&nbsp;make ARCH=3Darm CROSS_C=
OMPILE=3Darm-linux- &nbsp;uImage modules</div><div>&nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp;compiling&nbsp;&nbsp;Xenomai</div><div>&nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp;4=A3=A9ARCH=3Darm &nbsp;CROSS_COMPILE=3Darm-linux-</div><div>&nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;./configure --host=3Darm-linux&nb=
sp;</div>


<div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; --enable-arm-mach=3Da=
t91sam926x &nbsp;--enable-arm-tsc&nbsp;</div><div>&nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; 5=A3=A9make install</div><div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;X=
enomai installation directory is &nbsp;/usr/xenomai.executing &quot;ls&quot=
;,i got&nbsp;</div><div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;[root@domain.hid=
rMing xenomai]# ls</div>


<div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;bin &nbsp;include &nbsp;lib &nbsp;sb=
in &nbsp;share&nbsp;</div><div>&nbsp;</div><div>&nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp;I downloaded kernel and /usr/xenomai to my target platform in a&nbsp=
;suitable way.Linux kernel can run successfully.</div><div>&nbsp;[@NewMsg92=
63: bin]# pwd</div>

<div>&nbsp;/usr/xenomai/bin</div><div>[@NewMsg9263: bin]# ./xeno-info&nbsp;=
</div><div>If some fields are empty or look unusual you may have an old ver=
sion.</div><div>Compare to the current minimal requirements in Documentatio=
n/Changes.</div>

<div>&nbsp;</div><div>BusyBox v1.15.3 (2010-03-30 15:34:10 CST) multi-call =
binary</div><div>Linux NewMsg9263 2.6.25 #3 Sat Aug 20 09:40:50 CST 2011 ar=
mv5tejl GNU/Linux</div><div>&nbsp;</div><div>module-init-tools &nbsp; &nbsp=
; &nbsp;V</div><div>
Modules Loaded &nbsp;</div>
<div><br></div><div>when i tried to run xeno-info directory=A3=ACi got info=
rmation above.</div><div><br></div><div>if there is something wrong with co=
mpiling kernel and&nbsp;Xenomai=A3=ACplease correct me.and how can i check =
out that&nbsp;Xenomai can run smoothly with my target platform.look forward=
 to your reply.</div>

<div>yizhneg</div><div><br></div><div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nb=
sp;</div></div>
</div><br>

--001636b2b8266ba3fb04aae67e5f--

