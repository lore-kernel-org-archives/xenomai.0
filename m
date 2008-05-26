Message-ID: <8c12bab70805261341y76ab4af5lb67267017a9fa0a1@domain.hid>
Date: Mon, 26 May 2008 22:41:21 +0200
From: "Asif Iqbal" <a.iqbal@domain.hid>
Sender: aiqbalrana@domain.hid
In-Reply-To: <2ff1a98a0805260456i44e3805eu5348067aff755c3f@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_7767_31492905.1211834481347"
References: <8c12bab70805260214q785116eai976fe67d399b7040@domain.hid>
	<2ff1a98a0805260456i44e3805eu5348067aff755c3f@domain.hid>
Subject: Re: [Xenomai-help] Running xeno-test leaves behind "dd if /dev/zero
	of /dev/null"
Reply-To: a.iqbal@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

------=_Part_7767_31492905.1211834481347
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Mon, May 26, 2008 at 1:56 PM, Gilles Chanteperdrix <
gilles.chanteperdrix@xenomai.org> wrote:

> On Mon, May 26, 2008 at 11:14 AM, Asif Iqbal <a.iqbal@domain.hid> wrote:
> > Hello there
> >
> > Four days before, I checked out the svn head and compiled with 2.6.25.4
> > kernel. VxWorks skin failed to compile (Really sorry but it didn't come
> to
> > my mind to record the error). Removed VxWorks and everything worked fine.
> >
> > Now whenever I run xeno-test and exit using Ctrl-C, it leaves "dd if
> > /dev/zero of /dev/null" task consuming 100% of the cpu until you manually
> > kill the task. Is it a bug?
>
> You have to tell us a bit more about your setup. What shell do you
> use,

I am using bash.

> do you have all the applications needed by xeno-test installed ?


My system is Core 2 Duo.
Here is the output of ./xeno-info

Linux xyz-ub 2.6.25.4 #1 SMP PREEMPT Sat May 24 13:34:30 CEST 2008 i686
GNU/Linux

Gnu C                  4.2.3
Gnu make               3.81
util-linux             ng 2.13.1)
mount                  ng 2.13.1)
module-init-tools      3.3-pre11
e2fsprogs              1.40.8
PPP                    2.4.4
Linux C Library        > libc.2.7
Dynamic linker (ldd)   2.7
Procps                 3.2.7
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               6.10
Modules Loaded         rfcomm l2cap bluetooth ppdev video output container
ipv6 iptable_filter ip_tables x_tables ac sbp2 lp tda1004x saa7134_dvb
videobuf_dvb dvb_core af_packet tuner tea5767 tda8290 tda18271 tda827x
tuner_xc2028 xc5000 tda9887 tuner_simple mt20xx tea5761 snd_hda_intel
saa7134 snd_pcm_oss snd_mixer_oss snd_pcm videodev v4l1_compat
compat_ioctl32 v4l2_common videobuf_dma_sg videobuf_core ir_kbd_i2c
ir_common psmouse snd_page_alloc snd_hwdep parport_pc parport serio_raw
sr_mod cdrom usblp iTCO_wdt pcspkr snd_seq_dummy tveeprom
iTCO_vendor_support snd_seq_oss snd_seq_midi snd_rawmidi snd_seq_midi_event
i2c_core snd_seq sky2 snd_timer snd_seq_device snd soundcore intel_agp
joydev agpgart button shpchp pci_hotplug evdev ata_piix ext3 jbd mbcache sg
sd_mod pata_jmicron pata_acpi usbhid hid ohci1394 ieee1394 ata_generic ahci
libata scsi_mod dock ehci_hcd uhci_hcd usbcore fan fuse fbcon tileblit font
bitblit softcursor

This is what appears when I run xeno-test (after some console output):
.
.
dd workload started, pids 6649 stored in /var/lock/xeno-test.6509.pids
 6649 pts/0    00:00:00 dd
something died a 6649 or
something died a 6649 or
something died a 6649 or
something died a 6649 or
something died a 6649 or
something died a 6649 or


dmesg | grep Xenomai
[    2.769999] I-pipe: Domain Xenomai registered.
[    2.770119] Xenomai: hal/i386 started.
[    2.771092] Xenomai: real-time nucleus v2.5-devel (Flying In A Blue
Dream) loaded.
[    2.771841] Xenomai: starting native API services.
[    2.771925] Xenomai: starting POSIX services.
[    2.771955] Xenomai: starting RTDM services.

Thanks for any help.



>
>
> --
>  Gilles
>

------=_Part_7767_31492905.1211834481347
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<br><div class=3D"gmail_quote">On Mon, May 26, 2008 at 1:56 PM, Gilles Chan=
teperdrix &lt;<a href=3D"mailto:gilles.chanteperdrix@xenomai.org">gilles.chan=
teperdrix@domain.hid</a>&gt; wrote:<br><blockquote class=3D"gmail_quote" sty=
le=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex;=
 padding-left: 1ex;">
<div><div></div><div class=3D"Wj3C7c">On Mon, May 26, 2008 at 11:14 AM, Asi=
f Iqbal &lt;<a href=3D"mailto:a.iqbal@domain.hid">a.iqbal@domain.hid</a>&gt; wr=
ote:<br>
&gt; Hello there<br>
&gt;<br>
&gt; Four days before, I checked out the svn head and compiled with <a href=
=3D"http://2.6.25.4" target=3D"_blank">2.6.25.4</a><br>
&gt; kernel. VxWorks skin failed to compile (Really sorry but it didn&#39;t=
 come to<br>
&gt; my mind to record the error). Removed VxWorks and everything worked fi=
ne.<br>
&gt;<br>
&gt; Now whenever I run xeno-test and exit using Ctrl-C, it leaves &quot;dd=
 if<br>
&gt; /dev/zero of /dev/null&quot; task consuming 100% of the cpu until you =
manually<br>
&gt; kill the task. Is it a bug?<br>
<br>
</div></div>You have to tell us a bit more about your setup. What shell do =
you<br>
use,</blockquote><div>I am using bash. <br></div><blockquote class=3D"gmail=
_quote" style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt=
 0pt 0.8ex; padding-left: 1ex;"> do you have all the applications needed by=
 xeno-test installed ?</blockquote>
<div><br>My system is Core 2 Duo.<br>Here is the output of ./xeno-info<br><=
br>Linux xyz-ub <a href=3D"http://2.6.25.4">2.6.25.4</a> #1 SMP PREEMPT Sat=
 May 24 13:34:30 CEST 2008 i686 GNU/Linux<br>&nbsp;<br>Gnu C&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; 4.2.3<br>
Gnu make&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; 3.81<br>util-linux&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ng 2.13.1)<br>mount&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; ng 2.13.1)<br>module-init-tools&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3.3-pre=
11<br>e2fsprogs&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; 1.40.8<br>PPP&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2.4=
.4<br>Linux C Library&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; libc.2=
.7<br>
Dynamic linker (ldd)&nbsp;&nbsp; 2.7<br>Procps&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3.2.7<b=
r>Net-tools&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; 1.60<br>Console-tools&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; 0.2.3<br>Sh-utils&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 6.10<br>Modules Loaded&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rfcomm l2cap bluetooth ppdev video o=
utput container ipv6 iptable_filter ip_tables x_tables ac sbp2 lp tda1004x =
saa7134_dvb videobuf_dvb dvb_core af_packet tuner tea5767 tda8290 tda18271 =
tda827x tuner_xc2028 xc5000 tda9887 tuner_simple mt20xx tea5761 snd_hda_int=
el saa7134 snd_pcm_oss snd_mixer_oss snd_pcm videodev v4l1_compat compat_io=
ctl32 v4l2_common videobuf_dma_sg videobuf_core ir_kbd_i2c ir_common psmous=
e snd_page_alloc snd_hwdep parport_pc parport serio_raw sr_mod cdrom usblp =
iTCO_wdt pcspkr snd_seq_dummy tveeprom iTCO_vendor_support snd_seq_oss snd_=
seq_midi snd_rawmidi snd_seq_midi_event i2c_core snd_seq sky2 snd_timer snd=
_seq_device snd soundcore intel_agp joydev agpgart button shpchp pci_hotplu=
g evdev ata_piix ext3 jbd mbcache sg sd_mod pata_jmicron pata_acpi usbhid h=
id ohci1394 ieee1394 ata_generic ahci libata scsi_mod dock ehci_hcd uhci_hc=
d usbcore fan fuse fbcon tileblit font bitblit softcursor<br>
<br>This is what appears when I run xeno-test (after some console output):<=
br>.<br>.<br>dd workload started, pids 6649 stored in /var/lock/xeno-test.6=
509.pids<br>&nbsp;6649 pts/0&nbsp;&nbsp;&nbsp; 00:00:00 dd<br>something die=
d a 6649 or<br>something died a 6649 or<br>
something died a 6649 or<br>something died a 6649 or<br>something died a 66=
49 or<br>something died a 6649 or<br><br><br>dmesg | grep Xenomai<br>[&nbsp=
;&nbsp;&nbsp; 2.769999] I-pipe: Domain Xenomai registered.<br>[&nbsp;&nbsp;=
&nbsp; 2.770119] Xenomai: hal/i386 started.<br>
[&nbsp;&nbsp;&nbsp; 2.771092] Xenomai: real-time nucleus v2.5-devel (Flying=
 In A Blue Dream) loaded.<br>[&nbsp;&nbsp;&nbsp; 2.771841] Xenomai: startin=
g native API services.<br>[&nbsp;&nbsp;&nbsp; 2.771925] Xenomai: starting P=
OSIX services.<br>[&nbsp;&nbsp;&nbsp; 2.771955] Xenomai: starting RTDM serv=
ices.<br>
<br>Thanks for any help.<br><br>&nbsp;<br></div><blockquote class=3D"gmail_=
quote" style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt =
0pt 0.8ex; padding-left: 1ex;"><br>
<br>
--<br>
<font color=3D"#888888">&nbsp;Gilles<br>
</font></blockquote></div><br>

------=_Part_7767_31492905.1211834481347--

