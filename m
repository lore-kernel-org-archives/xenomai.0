MIME-Version: 1.0
In-Reply-To: <4E085FFF.9020300@domain.hid>
References: <BANLkTi=tRb1bZ=ZSkzhvps62xt8PMzNb3A@mail.gmail.com>
	<4E085FFF.9020300@domain.hid>
From: Ashish Budhiraja <ashishmach@domain.hid>
Date: Tue, 28 Jun 2011 15:07:19 +0200
Message-ID: <BANLkTinNM-i9HfF44_fgKcaD2dxESMiy5Q@mail.gmail.com>
Content-Type: multipart/alternative; boundary=000e0cd1852c679bcc04a6c55bd8
Subject: Re: [Xenomai-help] Xenomai Unknown
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

--000e0cd1852c679bcc04a6c55bd8
Content-Type: text/plain; charset=ISO-8859-1

Hello,

I performed Xenotest I am appending the log file, after a certain command it
tried to start workload and gave me this error

dd workload started, pids 3599 stored in /var/lock/xeno-test.3463.pids
 3599 pts/1    00:00:00 dd
something died a 3599 or

HEre is the log file could someone please check this file I would be really
glad as I am totally new to xenomai
just want to use the features as I really need RT capabilities. Please have
a look.

  GNU nano 2.0.9           File:
/tmp/test-2.6.32.11-110628.144057                   Modified

eval: 1: -p: not found

Tue Jun 28 14:40:57 CEST 2011
running: ./bin/xeno-config --verbose
xeno-config --verbose
        --version="2.5.2"
        --cc="gcc"
        --arch="x86"
        --prefix="/usr/xenomai"
        --xeno-cflags="-I/usr/xenomai/include -D_GNU_SOURCE -D_REENTRANT
-Wall -pipe -D__XENO_$
        --xeno-ldflags="-L/usr/xenomai/lib -lxenomai -lpthread "
        --posix-cflags=""
        --posix-ldflags="-Wl,@/usr/xenomai/lib/posix.wrappers
-L/usr/xenomai/lib -lpthread_rt $
        --library-dir="/usr/xenomai/lib"

Tue Jun 28 14:40:57 CEST 2011
running: ./bin/xeno-info
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux ugvuavrt3-desktop 2.6.32.11 #1 Fri Jun 24 09:01:30 CEST 2011 i586
GNU/Linux

  GNU nano 2.0.9           File:
/tmp/test-2.6.32.11-110628.144057


Gnu C                  4.4.1-4ubuntu8)
Gnu make               3.81
util-linux             ng 2.16)
mount                  ng 2.16 (with libblkid and selinux support)
module-init-tools      3.10
e2fsprogs              1.41.9
PPP                    2.4.5
Linux C Library        2.10.1
Dynamic linker (ldd)   2.10.1
Procps                 3.2.8
Net-tools              1.60
Kbd                    1.15
Sh-utils               7.4
Modules Loaded

Tue Jun 28 14:40:58 CEST 2011
running: cat /proc/cpuinfo
processor       : 0
vendor_id       : Vortex86 SoC
cpu family      : 5
model           : 2
model name      : 05/02
model           : 2
model name      : 05/02
stepping        : 2
cpu MHz         : 1000.061
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu tsc cx8
bogomips        : 2000.12
clflush size    : 32
cache_alignment : 32
address sizes   : 32 bits physical, 32 bits virtual
power management:


Tue Jun 28 14:40:59 CEST 2011
running: md5sum /proc/cpuinfo # cpuinfo fingerprint
7e64ba423a68109e5e37d4774a2bf30c  /proc/cpuinfo

Tue Jun 28 14:40:59 CEST 2011
running: cat /proc/ipipe/Linux
       +----- Handling ([A]ccepted, [G]rabbed, [W]ired, [D]iscarded)
       |+---- Sticky
       ||+--- Locked
       |||+-- Exclusive
       ||||+- Virtual
[IRQ]  |||||
   0:  A....
   1:  A....
   2:  A....
   3:  A.L..
   4:  A.L..
   5:  A....
   6:  A....
   7:  A....
   8:  A....
   9:  A....
  10:  A....
  11:  A....
  12:  A.L..
  13:  A....
  14:  A....
  15:  A....
  32:  G...V
  33:  G...V
[Domain info]
id=0x00000000
priority=100

Tue Jun 28 14:40:59 CEST 2011
running: cat /proc/ipipe/Xenomai
       +----- Handling ([A]ccepted, [G]rabbed, [W]ired, [D]iscarded)
       |+---- Sticky
       ||+--- Locked
       |||+-- Exclusive
       ||||+- Virtual
[IRQ]  |||||
   0:  W..X.
  34:  W...V
[Domain info]
id=0x58454e4f
priority=topmost

Tue Jun 28 14:40:59 CEST 2011
running: cat /proc/ipipe/version
2.6-02

Tue Jun 28 14:40:59 CEST 2011
running: generate_loads 1
dd workload started, pids 3428 stored in /var/lock/xeno-test.3292.pids
 3428 pts/0    00:00:00 dd
something died a 3428 or
something died a 3428 or
something died a 3428 or
something died a 3428 or
something died a 3428 or
something died a 3428 or
something died a 3428 or
something died a 3428 or
something died a 3428 or
something died a 3428 or
something died a 3428 or
something died a 3428 or
something died a 3428 or
something died a 3428 or
something died a 3428 or
something died a 3428 or

Thanks

Ashish

On Mon, Jun 27, 2011 at 12:48 PM, Gilles Chanteperdrix <
gilles.chanteperdrix@xenomai.org> wrote:

> On 06/27/2011 10:41 AM, Ashish Budhiraja wrote:
> > Hello Everyone,
> >
> > I am Ashish, very new to this group, I don't know anything about Xenomai
> but
> > I want to have increased Real Time
> > support for my Roboard-100. So as per the tutorial on this
> >
> http://geonobot-wiki.toile-libre.org/doku.php?id=robotics:computing:xenomai_install_on_roboard
> > link I did everything right now when I boot I get this message saying
> udevd:
> > unknown 'Xenomai'  or something similar, and I can only boot to
> > text console i.e. if I try to go for my gui my keyboard gets jammed.
> >
> > I just want to know is there a possible way to check if Xenomai is
> perfectly
> > installed or not though I looked carefully I didn't find any errors
> during
> > the installation
> > process but now it is showing 'Xenomai' unknown.
> >
> > Please guide me how to proceed or tell me something to read.
>
> In order to know whether Xenomai is working, try and run one of the
> tests which come with Xenomai, "latency", for instance.
>
> The issue with udev is probably that you miss a Xenomai group, and the
> udev rules need one, if you want to run applications as an unprivileged
> user as described here:
>
> http://www.xenomai.org/index.php/Non-root_RT
>
>
> --
>                                                                 Gilles.
>

--000e0cd1852c679bcc04a6c55bd8
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hello,<br><br>I performed Xenotest I am appending the log file, after a cer=
tain command it tried to start workload and gave me this error <br><br>dd w=
orkload started, pids 3599 stored in /var/lock/xeno-test.3463.pids<br>=A035=
99 pts/1=A0=A0=A0 00:00:00 dd<br>

something died a 3599 or<br><br>HEre is the log file could someone please c=
heck this file I would be really glad as I am totally new to xenomai <br>ju=
st want to use the features as I really need RT capabilities. Please have a=
 look.<br>

<br>=A0 GNU nano 2.0.9=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 File: /tmp/test-2.6.32=
.11-110628.144057=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Mod=
ified=A0 <br><br>eval: 1: -p: not found<br><br>Tue Jun 28 14:40:57 CEST 201=
1<br>running: ./bin/xeno-config --verbose<br>xeno-config --verbose<br>

=A0=A0=A0=A0=A0=A0=A0 --version=3D&quot;2.5.2&quot;<br>=A0=A0=A0=A0=A0=A0=
=A0 --cc=3D&quot;gcc&quot;<br>=A0=A0=A0=A0=A0=A0=A0 --arch=3D&quot;x86&quot=
;<br>=A0=A0=A0=A0=A0=A0=A0 --prefix=3D&quot;/usr/xenomai&quot;<br>=A0=A0=A0=
=A0=A0=A0=A0 --xeno-cflags=3D&quot;-I/usr/xenomai/include -D_GNU_SOURCE -D_=
REENTRANT -Wall -pipe -D__XENO_$<br>

=A0=A0=A0=A0=A0=A0=A0 --xeno-ldflags=3D&quot;-L/usr/xenomai/lib -lxenomai -=
lpthread &quot;<br>=A0=A0=A0=A0=A0=A0=A0 --posix-cflags=3D&quot;&quot;<br>=
=A0=A0=A0=A0=A0=A0=A0 --posix-ldflags=3D&quot;-Wl,@/usr/xenomai/lib/posix.w=
rappers -L/usr/xenomai/lib -lpthread_rt $<br>

=A0=A0=A0=A0=A0=A0=A0 --library-dir=3D&quot;/usr/xenomai/lib&quot;<br><br>T=
ue Jun 28 14:40:57 CEST 2011<br>running: ./bin/xeno-info<br>If some fields =
are empty or look unusual you may have an old version.<br>Compare to the cu=
rrent minimal requirements in Documentation/Changes.<br>

<br>Linux ugvuavrt3-desktop 2.6.32.11 #1 Fri Jun 24 09:01:30 CEST 2011 i586=
 GNU/Linux<br><br>=A0 GNU nano 2.0.9=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 File: /t=
mp/test-2.6.32.11-110628.144057=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 <br><br><br>Gnu C=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 4.4.1-4ubuntu8)<br>

Gnu make=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 3.81<br>util-linux=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ng 2.16)<br>mount=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 ng 2.16 (with libblkid and selinux support)<br>mod=
ule-init-tools=A0=A0=A0=A0=A0 3.10<br>e2fsprogs=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 1.41.9<br>PPP=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 2.4.5<br>

Linux C Library=A0=A0=A0=A0=A0=A0=A0 2.10.1<br>Dynamic linker (ldd)=A0=A0 2=
.10.1<br>Procps=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 3.2.8<br>Ne=
t-tools=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 1.60<br>Kbd=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 1.15<br>Sh-utils=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 7.4<br>Modules Loaded<br><br>Tue Jun 28 14:40:5=
8 CEST 2011<br>

running: cat /proc/cpuinfo<br>processor=A0=A0=A0=A0=A0=A0 : 0<br>vendor_id=
=A0=A0=A0=A0=A0=A0 : Vortex86 SoC<br>cpu family=A0=A0=A0=A0=A0 : 5<br>model=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 : 2<br>model name=A0=A0=A0=A0=A0 : 05/02<br>=
model=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 : 2<br>model name=A0=A0=A0=A0=A0 : 05/0=
2<br>stepping=A0=A0=A0=A0=A0=A0=A0 : 2<br>

cpu MHz=A0=A0=A0=A0=A0=A0=A0=A0 : 1000.061<br>fdiv_bug=A0=A0=A0=A0=A0=A0=A0=
 : no<br>hlt_bug=A0=A0=A0=A0=A0=A0=A0=A0 : no<br>f00f_bug=A0=A0=A0=A0=A0=A0=
=A0 : no<br>coma_bug=A0=A0=A0=A0=A0=A0=A0 : no<br>fpu=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 : yes<br>fpu_exception=A0=A0 : yes<br>cpuid level=A0=A0=A0=
=A0 : 1<br>wp=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 : yes<br>

flags=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 : fpu tsc cx8<br>bogomips=A0=A0=A0=A0=
=A0=A0=A0 : 2000.12<br>clflush size=A0=A0=A0 : 32<br>cache_alignment : 32<b=
r>address sizes=A0=A0 : 32 bits physical, 32 bits virtual<br>power manageme=
nt:<br><br><br>Tue Jun 28 14:40:59 CEST 2011<br>

running: md5sum /proc/cpuinfo # cpuinfo fingerprint<br>7e64ba423a68109e5e37=
d4774a2bf30c=A0 /proc/cpuinfo<br><br>Tue Jun 28 14:40:59 CEST 2011<br>runni=
ng: cat /proc/ipipe/Linux<br>=A0=A0=A0=A0=A0=A0 +----- Handling ([A]ccepted=
, [G]rabbed, [W]ired, [D]iscarded)<br>

=A0=A0=A0=A0=A0=A0 |+---- Sticky<br>=A0=A0=A0=A0=A0=A0 ||+--- Locked<br>=A0=
=A0=A0=A0=A0=A0 |||+-- Exclusive<br>=A0=A0=A0=A0=A0=A0 ||||+- Virtual<br>[I=
RQ]=A0 |||||<br>=A0=A0 0:=A0 A....<br>=A0=A0 1:=A0 A....<br>=A0=A0 2:=A0 A.=
...<br>=A0=A0 3:=A0 A.L..<br>=A0=A0 4:=A0 A.L..<br>=A0=A0 5:=A0 A....<br>=
=A0=A0 6:=A0 A....<br>

=A0=A0 7:=A0 A....<br>=A0=A0 8:=A0 A....<br>=A0=A0 9:=A0 A....<br>=A0 10:=
=A0 A....<br>=A0 11:=A0 A....<br>=A0 12:=A0 A.L..<br>=A0 13:=A0 A....<br>=
=A0 14:=A0 A....<br>=A0 15:=A0 A....<br>=A0 32:=A0 G...V<br>=A0 33:=A0 G...=
V<br>[Domain info]<br>id=3D0x00000000<br>priority=3D100<br>

<br>Tue Jun 28 14:40:59 CEST 2011<br>running: cat /proc/ipipe/Xenomai<br>=
=A0=A0=A0=A0=A0=A0 +----- Handling ([A]ccepted, [G]rabbed, [W]ired, [D]isca=
rded)<br>=A0=A0=A0=A0=A0=A0 |+---- Sticky<br>=A0=A0=A0=A0=A0=A0 ||+--- Lock=
ed<br>=A0=A0=A0=A0=A0=A0 |||+-- Exclusive<br>
=A0=A0=A0=A0=A0=A0 ||||+- Virtual<br>
[IRQ]=A0 |||||<br>=A0=A0 0:=A0 W..X.<br>=A0 34:=A0 W...V<br>[Domain info]<b=
r>id=3D0x58454e4f<br>priority=3Dtopmost<br><br>Tue Jun 28 14:40:59 CEST 201=
1<br>running: cat /proc/ipipe/version<br>2.6-02<br><br>Tue Jun 28 14:40:59 =
CEST 2011<br>

running: generate_loads 1<br>dd workload started, pids 3428 stored in /var/=
lock/xeno-test.3292.pids<br>=A03428 pts/0=A0=A0=A0 00:00:00 dd<br>something=
 died a 3428 or<br>something died a 3428 or<br>something died a 3428 or<br>=
something died a 3428 or<br>

something died a 3428 or<br>something died a 3428 or<br>something died a 34=
28 or<br>something died a 3428 or<br>something died a 3428 or<br>something =
died a 3428 or<br>something died a 3428 or<br>something died a 3428 or<br>

something died a 3428 or<br>something died a 3428 or<br>something died a 34=
28 or<br>something died a 3428 or<br><br>Thanks<br><br>Ashish<br><br><div c=
lass=3D"gmail_quote">On Mon, Jun 27, 2011 at 12:48 PM, Gilles Chanteperdrix=
 <span dir=3D"ltr">&lt;<a href=3D"mailto:gilles.chanteperdrix@xenomai.org">=
gilles.chanteperdrix@xenomai.org</a>&gt;</span> wrote:<br>

<blockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; borde=
r-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;"><div><div></div><=
div class=3D"h5">On 06/27/2011 10:41 AM, Ashish Budhiraja wrote:<br>
&gt; Hello Everyone,<br>
&gt;<br>
&gt; I am Ashish, very new to this group, I don&#39;t know anything about X=
enomai but<br>
&gt; I want to have increased Real Time<br>
&gt; support for my Roboard-100. So as per the tutorial on this<br>
&gt; <a href=3D"http://geonobot-wiki.toile-libre.org/doku.php?id=3Drobotics=
:computing:xenomai_install_on_roboard" target=3D"_blank">http://geonobot-wi=
ki.toile-libre.org/doku.php?id=3Drobotics:computing:xenomai_install_on_robo=
ard</a><br>


&gt; link I did everything right now when I boot I get this message saying =
udevd:<br>
&gt; unknown &#39;Xenomai&#39; =A0or something similar, and I can only boot=
 to<br>
&gt; text console i.e. if I try to go for my gui my keyboard gets jammed.<b=
r>
&gt;<br>
&gt; I just want to know is there a possible way to check if Xenomai is per=
fectly<br>
&gt; installed or not though I looked carefully I didn&#39;t find any error=
s during<br>
&gt; the installation<br>
&gt; process but now it is showing &#39;Xenomai&#39; unknown.<br>
&gt;<br>
&gt; Please guide me how to proceed or tell me something to read.<br>
<br>
</div></div>In order to know whether Xenomai is working, try and run one of=
 the<br>
tests which come with Xenomai, &quot;latency&quot;, for instance.<br>
<br>
The issue with udev is probably that you miss a Xenomai group, and the<br>
udev rules need one, if you want to run applications as an unprivileged<br>
user as described here:<br>
<br>
<a href=3D"http://www.xenomai.org/index.php/Non-root_RT" target=3D"_blank">=
http://www.xenomai.org/index.php/Non-root_RT</a><br>
<br>
<br>
--<br>
<font color=3D"#888888"> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0Gilles.<br>
</font></blockquote></div><br>

--000e0cd1852c679bcc04a6c55bd8--

