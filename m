MIME-Version: 1.0
In-Reply-To: <72cf3fb0910222349x771f0158ie9a9d97911c8d2fe@domain.hid>
References: <96eea0c80910151813v635d518dr6abd72986e2f07bd@domain.hid>
	<96eea0c80910161648l1991b124w20ea9949e70f5ae0@domain.hid>
	<200910171600.16265.berlemont.hauw@domain.hid>
	<200910192324.09986.berlemont.hauw@domain.hid>
	<96eea0c80910212230l745bbf85s4493e8958dad356b@domain.hid>
	<72cf3fb0910222349x771f0158ie9a9d97911c8d2fe@domain.hid>
Date: Tue, 27 Oct 2009 19:08:53 -0700
Message-ID: <96eea0c80910271908l4681fdb2r92f08efd5dd463c9@domain.hid>
From: Peter Pastor <peter.pastor@domain.hid>
Content-Type: multipart/alternative; boundary=0016e644c18ec587040476f5464e
Subject: Re: [Xenomai-help] national instruments card and comedi-rtdm-dev
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Alexis Berlemont <berlemont.hauw@domain.hid>
Cc: xenomai@xenomai.org

--0016e644c18ec587040476f5464e
Content-Type: text/plain; charset=ISO-8859-1

Hi Alexis,

Thanks a lot !!

I switched to the analogy branch, configured the kernel to build the analogy
kernel moduels and compiled it. However, here is what I get:

root@domain.hid:~# dmesg
...snip...
[   11.413779] Comedi: MITE: Available NI device IDs: 0x717f(used)
[   11.430558] analogy_8255: module license 'unspecified' taints kernel.
[   11.430561] Disabling lock debugging due to kernel taint
[   11.459390] analogy_ni_mio: Unknown symbol ni_tio_handle_interrupt
[   11.459441] analogy_ni_mio: Unknown symbol ni_tio_set_mite_channel
[   11.459577] analogy_ni_mio: Unknown symbol ni_tio_cmd_mask
[   11.459805] analogy_ni_mio: Unknown symbol ni_tio_init_counter
[   11.459856] analogy_ni_mio: Unknown symbol ni_tio_winsn
[   11.459997] analogy_ni_mio: Unknown symbol ni_gpct_device_destroy
[   11.460047] analogy_ni_mio: Unknown symbol ni_tio_insn_config
[   11.460328] analogy_ni_mio: Unknown symbol ni_tio_acknowledge_and_confirm
[   11.460419] analogy_ni_mio: Unknown symbol ni_tio_cmdtest
[   11.460511] analogy_ni_mio: Unknown symbol ni_tio_cancel
[   11.460567] analogy_ni_mio: Unknown symbol ni_gpct_device_construct
[   11.460688] analogy_ni_mio: Unknown symbol ni_tio_rinsn
[   11.460737] analogy_ni_mio: Unknown symbol ni_tio_cmd
...snip...

root@domain.hid:~# lspci -v

...snip...
06:00.0 Class ff00: National Instruments Device 717f
    Flags: bus master, medium devsel, latency 64, IRQ 11
    Memory at f7dfe000 (32-bit, non-prefetchable) [size=4K]
    Memory at f7dff000 (32-bit, non-prefetchable) [size=4K]
    Kernel driver in use: mite
    Kernel modules: analogy_ni_pcimio
...snip...

root@domain.hid:~# lsmod | grep analogy
analogy_ni_tio         26852  0
analogy_8255            4388  0
analogy_ni_mite        12644  1 analogy_ni_tio
xeno_analogy           39108  3 analogy_ni_tio,analogy_8255,
analogy_ni_mite

I don't really know how to use analogy_config... since

root@domain.hid# ./analogy_config analogy0 analogy_ni_mite
comedi_config: comedi_snd_attach failed ret=-22

when I run

root@domain.hid# ./cmd_read
cmd_read: a4l_fill_desc failed (ret=-22)
*** glibc detected *** ./cmd_read: free(): invalid next size (fast):
0x08052008 ***
======= Backtrace: =========
/lib/tls/i686/cmov/libc.so.6[0xb7f5f604]
/lib/tls/i686/cmov/libc.so.6(cfree+0x96)[0xb7f615b6]
./cmd_read[0x80496ae]
/lib/tls/i686/cmov/libc.so.6(__libc_start_main+0xe5)[0xb7f06775]
./cmd_read[0x8048f41]
======= Memory map: ========
08048000-0804e000 r-xp 00000000 08:01 13109565   /usr/xenomai/bin/cmd_read
0804e000-0804f000 r--p 00005000 08:01 13109565   /usr/xenomai/bin/cmd_read
0804f000-08050000 rw-p 00006000 08:01 13109565   /usr/xenomai/bin/cmd_read
08050000-08073000 rw-p 00000000 00:00 0          [heap]
b7d00000-b7d21000 rw-p 00000000 00:00 0
b7d21000-b7e00000 ---p 00000000 00:00 0
b7ecf000-b7edc000 r-xp 00000000 08:01 11894849   /lib/libgcc_s.so.1
b7edc000-b7edd000 r--p 0000c000 08:01 11894849   /lib/libgcc_s.so.1
...

which is I guess due to the unsuccessful analogy_config. My question is,
which driver do I have to use ?

Thanks,
 peter


On Thu, Oct 22, 2009 at 11:49 PM, Alexis Berlemont
<berlemont.hauw@domain.hid>wrote:

> Hi,
>
> On Thu, Oct 22, 2009 at 7:30 AM, Peter Pastor <peter.pastor@domain.hid>
> wrote:
> > Hi Alexis,
> >
> > Sorry for the delay, I was out of town.
> >
> > I have tried the statical configuration and it seemed to work, i.e. I
> could
> > execute the example program /usr/xenomai/bin/cmd_read. However, I wanted
> to
> > run the task in real-time and added the -r option which results in
> > root@domain.hid# ./cmd_read -vr
> > cmd_read: switching to real-time mode
> > cmd_read: device comedi0 opened (fd=0)
> > cmd_read: basic descriptor retrieved
> >      subdevices count = 14
> >      read subdevice index = 0
> >      write subdevice index = 1
> > cmd_read: complex descriptor retrieved
> > cmd_read: channel 0
> >      ranges count = 7
> >      range's size = 16 (bits)
> > cmd_read: channel 1
> >      ranges count = 7
> >      range's size = 16 (bits)
> > cmd_read: channel 2
> >      ranges count = 7
> >      range's size = 16 (bits)
> > cmd_read: channel 3
> >      ranges count = 7
> >      range's size = 16 (bits)
> > cmd_read: scan size = 8
> > cmd_read: size to read = 800
> > cmd_read: command successfully sent
> > 0xff 0xff 0xff 0xff 0xff 0xff 0x81 0xf9
> > 0xff 0xff 0xff 0xff 0xff 0xff 0xca 0xfb
> > ...snip...
> > 0xff 0xff 0xff 0xff 0xff 0xff 0xff 0xff
> > cmd_read: comedi_read failed (ret=-2)
>
> -2 is -ENOENT, which means there is nothing more to acquire. The
> return code should have been 0 but I 'd rather send -2, which is not
> very compliant. It is something I need to work on.
>
> > The cmd_write however, seems to work
> >
> > root@domain.hid# ./cmd_write -rv
> > cmd_write: switching to real-time mode
> > cmd_write: device comedi0 opened (fd=0)
> > cmd_write: basic descriptor retrieved
> >      subdevices count = 14
> >      read subdevice index = 0
> >      write subdevice index = 1
> > cmd_write: complex descriptor retrieved
> > cmd_write: channel 0
> >      ranges count = 3
> >      range's size = 16 (bits)
> > cmd_write: channel 1
> >      ranges count = 3
> >      range's size = 16 (bits)
> > cmd_write: scan size = 4
> > cmd_write: size to write  = 400
> > cmd_write: command successfully sent
> > cmd_write: 400 bytes successfully written
> >
> > also...
> > root@domain.hid# ./insn_read -rv
> > insn_read: switching to real-time mode
> > insn_read: device (null) opened (fd=0)
> > insn_read: basic descriptor retrieved
> >      subdevices count = 14
> >      read subdevice index = 0
> >      write subdevice index = 1
> > insn_read: complex descriptor retrieved
> > insn_read: channel width is 16 bits
> > insn_read: global scan size is 20
> > 0xff 0xff
> > 0x0 0x0
> > 0xff 0xff
> > 0x0 0x0
> > 0xff 0xff
> > 0x0 0x0
> > 0xff 0xff
> > 0x0 0x0
> > 0xff 0xff
> > 0x0 0x0
> > insn_read: 20 bytes successfully received
> >
> > What I would like to make sure is that I can write to comedi0 without
> having
> > mode switches. Therefore I copied cmd_write and added a rt_task_spawn to
> > make sure that the task_body runs in real-time (even though the -r option
> > results in the same behavior.) This way, I could add/change code to check
> > for mode switches... However, since unfortunately I am debugging things
> > remotely I cannot "see" the output (the display) of our oscilloscope that
> is
> > connected to the pci express card. I'll send an email as soon as I know
> > more.
>
> Be careful with the printf() I inserted in the test programs cmd_read,
> cmd_write; they will make you switch in the secondary domain.
>
> > Besides that, I updated to your latest xenomai and re-compiled having the
> > comedi drivers compiled as loadable modules. After booting the new kernel
> I
> > can see the following:
> >
> > xenomai:~> uname -a
> > Linux xenomai 2.6.30.5-xenomai-ipipe-comedi #6 SMP Wed Oct 21 20:05:37
> PDT
> > 2009 i686 GNU/Linux
> > xenomai:~> lspci -v
> > ...snip...
> > 06:00.0 Class ff00: National Instruments Device 717f
> >     Flags: bus master, medium devsel, latency 64, IRQ 11
> >     Memory at f7dfe000 (32-bit, non-prefetchable) [size=4K]
> >     Memory at f7dff000 (32-bit, non-prefetchable) [size=4K]
> >     Kernel driver in use: mite
> >     Kernel modules: comedi_ni_pcimio
> > ...snip...
> > xenomai:~> lsmod | grep come
> > comedi_ni_tio          26884  0
> > comedi_8255             4420  0
> > comedi_ni_mite         12708  1 comedi_ni_tio
> > xeno_comedi            39908  3 comedi_ni_tio,comedi_8255,comedi_ni_mite
> >
> >
> > However, the problem is that there is:
> >
> > root@domain.hid# ./comedi_config comedi0 comedi_pcimio
> > comedi_config: comedi_snd_attach failed ret=-22
> >
> > also...
> >
> > root@domain.hid# ./comedi_config comedi0 comedi_ni_mite
> > comedi_config: comedi_snd_attach failed ret=-22
> >
> > root@domain.hid# dmesg
> > ...snip...
> > [   11.298460] Comedi: MITE: Available NI device IDs: 0x717f(used)
> > [   11.305333] comedi_8255: module license 'unspecified' taints kernel.
> > [   11.305337] Disabling lock debugging due to kernel taint
> > [   11.331840] comedi_ni_mio: Unknown symbol ni_tio_handle_interrupt
> > [   11.331936] comedi_ni_mio: Unknown symbol ni_tio_set_mite_channel
> > [   11.331986] comedi_ni_mio: Unknown symbol ni_tio_cmd_mask
> > [   11.332171] comedi_ni_mio: Unknown symbol ni_tio_init_counter
> > [   11.332317] comedi_ni_mio: Unknown symbol ni_tio_winsn
> > [   11.332416] comedi_ni_mio: Unknown symbol ni_gpct_device_destroy
> > [   11.332466] comedi_ni_mio: Unknown symbol ni_tio_insn_config
> > [   11.332696] comedi_ni_mio: Unknown symbol
> ni_tio_acknowledge_and_confirm
> > [   11.332786] comedi_ni_mio: Unknown symbol ni_tio_cmdtest
> > [   11.332921] comedi_ni_mio: Unknown symbol ni_tio_cancel
> > [   11.332976] comedi_ni_mio: Unknown symbol ni_gpct_device_construct
> > [   11.333139] comedi_ni_mio: Unknown symbol ni_tio_rinsn
> > [   11.333189] comedi_ni_mio: Unknown symbol ni_tio_cmd
> > ...snip...
> >
> > How can I fix this ? Or should I simply work with the statical linked
> comedi
> > drivers ??
>
> I will update my git repository soon with these fixes. However, could
> you switch to the analogy branch ? As you may know, comedi/RTDM has
> been renamed as analogy:
> https://mail.gna.org/public/xenomai-core/2009-09/msg00016.html
>
> Alexis.
>

--0016e644c18ec587040476f5464e
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Alexis,<br><br>Thanks a lot !!<br><br>I switched to the analogy
branch, configured the kernel to build the analogy kernel moduels and
compiled it. However, here is what I get:<br><br>root@<span class=3D"il">xe=
nomai</span>:~# dmesg <br>...snip...<br>
[=A0=A0 11.413779] Comedi: MITE: Available NI device IDs: 0x717f(used)<br>[=
=A0=A0 11.430558] analogy_8255: module license &#39;unspecified&#39; taints=
 kernel.<br>[=A0=A0 11.430561] Disabling lock debugging due to kernel taint=
<br>[=A0=A0 11.459390] analogy_ni_mio: Unknown symbol ni_tio_handle_interru=
pt<br>

[=A0=A0 11.459441] analogy_ni_mio: Unknown symbol ni_tio_set_mite_channel<b=
r>[=A0=A0 11.459577] analogy_ni_mio: Unknown symbol ni_tio_cmd_mask<br>[=A0=
=A0 11.459805] analogy_ni_mio: Unknown symbol ni_tio_init_counter<br>[=A0=
=A0 11.459856] analogy_ni_mio: Unknown symbol ni_tio_winsn<br>

[=A0=A0 11.459997] analogy_ni_mio: Unknown symbol ni_gpct_device_destroy<br=
>[=A0=A0 11.460047] analogy_ni_mio: Unknown symbol ni_tio_insn_config<br>[=
=A0=A0 11.460328] analogy_ni_mio: Unknown symbol ni_tio_acknowledge_and_con=
firm<br>
[=A0=A0 11.460419] analogy_ni_mio: Unknown symbol ni_tio_cmdtest<br>
[=A0=A0 11.460511] analogy_ni_mio: Unknown symbol ni_tio_cancel<br>[=A0=A0 =
11.460567] analogy_ni_mio: Unknown symbol ni_gpct_device_construct<br>[=A0=
=A0 11.460688] analogy_ni_mio: Unknown symbol ni_tio_rinsn<br>[=A0=A0 11.46=
0737] analogy_ni_mio: Unknown symbol ni_tio_cmd<br>

...snip...<br>
<br>root@<span class=3D"il">xenomai</span>:~# lspci -v<div class=3D"im"><br=
>...snip...<br>
06:00.0 Class ff00: National Instruments Device 717f<br>=A0=A0=A0 Flags: bu=
s master, medium devsel, latency 64, IRQ 11<br>=A0=A0=A0 Memory at f7dfe000=
 (32-bit, non-prefetchable) [size=3D4K]<br>=A0=A0=A0 Memory at f7dff000 (32=
-bit, non-prefetchable) [size=3D4K]<br>

=A0=A0=A0 Kernel driver in use: mite<br></div>=A0=A0=A0 Kernel modules: ana=
logy_ni_pcimio<br>...snip...<br><br>
root@<span class=3D"il">xenomai</span>:~# lsmod | grep analogy<br>analogy_n=
i_tio=A0=A0=A0=A0=A0=A0=A0=A0 26852=A0 0 <br>analogy_8255=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 4388=A0 0 <br>analogy_ni_mite=A0=A0=A0=A0=A0=A0=A0 12644=A0=
 1 analogy_ni_tio<br>xeno_analogy=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 39108=A0 3 =
analogy_ni_tio,analogy_8255,<div id=3D":10y" class=3D"ii gt">
analogy_ni_mite<br>
<br>I don&#39;t really know how to use analogy_config... since<br><br>root@=
<span><span class=3D"il">xenomai</span></span>:/usr/<span><span class=3D"il=
">xenomai</span></span>/sbin# ./analogy_config analogy0 analogy_ni_mite<div=
 class=3D"im">
<div><div>


comedi_config: comedi_snd_attach failed ret=3D-22</div></div><br></div>when=
 I run <br><div class=3D"im"><br>root@<span class=3D"il">xenomai</span>:/us=
r/<span class=3D"il">xenomai</span>/bin# ./cmd_read <br></div>cmd_read: a4l=
_fill_desc failed (ret=3D-22)<br>
*** glibc detected *** ./cmd_read: free(): invalid next size (fast): 0x0805=
2008 ***<br>
=3D=3D=3D=3D=3D=3D=3D Backtrace: =3D=3D=3D=3D=3D=3D=3D=3D=3D<br>/lib/tls/i6=
86/cmov/libc.so.6[0xb7f5f604]<br>/lib/tls/i686/cmov/libc.so.6(cfree+0x96)[0=
xb7f615b6]<br>./cmd_read[0x80496ae]<br>/lib/tls/i686/cmov/libc.so.6(__libc_=
start_main+0xe5)[0xb7f06775]<br>

./cmd_read[0x8048f41]<br>=3D=3D=3D=3D=3D=3D=3D Memory map: =3D=3D=3D=3D=3D=
=3D=3D=3D<br>08048000-0804e000 r-xp 00000000 08:01 13109565=A0=A0 /usr/<spa=
n class=3D"il">xenomai</span>/bin/cmd_read<br>0804e000-0804f000 r--p 000050=
00 08:01 13109565=A0=A0 /usr/<span class=3D"il">xenomai</span>/bin/cmd_read=
<br>
0804f000-08050000 rw-p 00006000 08:01 13109565=A0=A0 /usr/<span class=3D"il=
">xenomai</span>/bin/cmd_read<br>
08050000-08073000 rw-p 00000000 00:00 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 [heap]<b=
r>b7d00000-b7d21000 rw-p 00000000 00:00 0 <br>b7d21000-b7e00000 ---p 000000=
00 00:00 0 <br>b7ecf000-b7edc000 r-xp 00000000 08:01 11894849=A0=A0 /lib/li=
bgcc_s.so.1<br>b7edc000-b7edd000 r--p 0000c000 08:01 11894849=A0=A0 /lib/li=
bgcc_s.so.1<br>

...<br><br>which is I guess due to the unsuccessful analogy_config. My ques=
tion is, which driver do I have to use ?<br><br>Thanks,<br><font color=3D"#=
888888">=A0peter</font></div><br><br><div class=3D"gmail_quote">On Thu, Oct=
 22, 2009 at 11:49 PM, Alexis Berlemont <span dir=3D"ltr">&lt;<a href=3D"ma=
ilto:berlemont.hauw@domain.hid">berlemont.hauw@domain.hid</a>&gt;</span> wrote:<b=
r>
<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Hi,<br>
<div><div></div><div class=3D"h5"><br>
On Thu, Oct 22, 2009 at 7:30 AM, Peter Pastor &lt;<a href=3D"mailto:peter.p=
astor@domain.hid">peter.pastor@domain.hid</a>&gt; wrote:<br>
&gt; Hi Alexis,<br>
&gt;<br>
&gt; Sorry for the delay, I was out of town.<br>
&gt;<br>
&gt; I have tried the statical configuration and it seemed to work, i.e. I =
could<br>
&gt; execute the example program /usr/xenomai/bin/cmd_read. However, I want=
ed to<br>
&gt; run the task in real-time and added the -r option which results in<br>
&gt; root@domain.hid# ./cmd_read -vr<br>
&gt; cmd_read: switching to real-time mode<br>
&gt; cmd_read: device comedi0 opened (fd=3D0)<br>
&gt; cmd_read: basic descriptor retrieved<br>
&gt; =A0=A0=A0 =A0subdevices count =3D 14<br>
&gt; =A0=A0=A0 =A0read subdevice index =3D 0<br>
&gt; =A0=A0=A0 =A0write subdevice index =3D 1<br>
&gt; cmd_read: complex descriptor retrieved<br>
&gt; cmd_read: channel 0<br>
&gt; =A0=A0=A0 =A0ranges count =3D 7<br>
&gt; =A0=A0=A0 =A0range&#39;s size =3D 16 (bits)<br>
&gt; cmd_read: channel 1<br>
&gt; =A0=A0=A0 =A0ranges count =3D 7<br>
&gt; =A0=A0=A0 =A0range&#39;s size =3D 16 (bits)<br>
&gt; cmd_read: channel 2<br>
&gt; =A0=A0=A0 =A0ranges count =3D 7<br>
&gt; =A0=A0=A0 =A0range&#39;s size =3D 16 (bits)<br>
&gt; cmd_read: channel 3<br>
&gt; =A0=A0=A0 =A0ranges count =3D 7<br>
&gt; =A0=A0=A0 =A0range&#39;s size =3D 16 (bits)<br>
&gt; cmd_read: scan size =3D 8<br>
&gt; cmd_read: size to read =3D 800<br>
&gt; cmd_read: command successfully sent<br>
&gt; 0xff 0xff 0xff 0xff 0xff 0xff 0x81 0xf9<br>
&gt; 0xff 0xff 0xff 0xff 0xff 0xff 0xca 0xfb<br>
&gt; ...snip...<br>
&gt; 0xff 0xff 0xff 0xff 0xff 0xff 0xff 0xff<br>
&gt; cmd_read: comedi_read failed (ret=3D-2)<br>
<br>
</div></div>-2 is -ENOENT, which means there is nothing more to acquire. Th=
e<br>
return code should have been 0 but I &#39;d rather send -2, which is not<br=
>
very compliant. It is something I need to work on.<br>
<div><div></div><div class=3D"h5"><br>
&gt; The cmd_write however, seems to work<br>
&gt;<br>
&gt; root@domain.hid# ./cmd_write -rv<br>
&gt; cmd_write: switching to real-time mode<br>
&gt; cmd_write: device comedi0 opened (fd=3D0)<br>
&gt; cmd_write: basic descriptor retrieved<br>
&gt; =A0=A0=A0 =A0subdevices count =3D 14<br>
&gt; =A0=A0=A0 =A0read subdevice index =3D 0<br>
&gt; =A0=A0=A0 =A0write subdevice index =3D 1<br>
&gt; cmd_write: complex descriptor retrieved<br>
&gt; cmd_write: channel 0<br>
&gt; =A0=A0=A0 =A0ranges count =3D 3<br>
&gt; =A0=A0=A0 =A0range&#39;s size =3D 16 (bits)<br>
&gt; cmd_write: channel 1<br>
&gt; =A0=A0=A0 =A0ranges count =3D 3<br>
&gt; =A0=A0=A0 =A0range&#39;s size =3D 16 (bits)<br>
&gt; cmd_write: scan size =3D 4<br>
&gt; cmd_write: size to write=A0 =3D 400<br>
&gt; cmd_write: command successfully sent<br>
&gt; cmd_write: 400 bytes successfully written<br>
&gt;<br>
&gt; also...<br>
&gt; root@domain.hid# ./insn_read -rv<br>
&gt; insn_read: switching to real-time mode<br>
&gt; insn_read: device (null) opened (fd=3D0)<br>
&gt; insn_read: basic descriptor retrieved<br>
&gt; =A0=A0=A0 =A0subdevices count =3D 14<br>
&gt; =A0=A0=A0 =A0read subdevice index =3D 0<br>
&gt; =A0=A0=A0 =A0write subdevice index =3D 1<br>
&gt; insn_read: complex descriptor retrieved<br>
&gt; insn_read: channel width is 16 bits<br>
&gt; insn_read: global scan size is 20<br>
&gt; 0xff 0xff<br>
&gt; 0x0 0x0<br>
&gt; 0xff 0xff<br>
&gt; 0x0 0x0<br>
&gt; 0xff 0xff<br>
&gt; 0x0 0x0<br>
&gt; 0xff 0xff<br>
&gt; 0x0 0x0<br>
&gt; 0xff 0xff<br>
&gt; 0x0 0x0<br>
&gt; insn_read: 20 bytes successfully received<br>
&gt;<br>
&gt; What I would like to make sure is that I can write to comedi0 without =
having<br>
&gt; mode switches. Therefore I copied cmd_write and added a rt_task_spawn =
to<br>
&gt; make sure that the task_body runs in real-time (even though the -r opt=
ion<br>
&gt; results in the same behavior.) This way, I could add/change code to ch=
eck<br>
&gt; for mode switches... However, since unfortunately I am debugging thing=
s<br>
&gt; remotely I cannot &quot;see&quot; the output (the display) of our osci=
lloscope that is<br>
&gt; connected to the pci express card. I&#39;ll send an email as soon as I=
 know<br>
&gt; more.<br>
<br>
</div></div>Be careful with the printf() I inserted in the test programs cm=
d_read,<br>
cmd_write; they will make you switch in the secondary domain.<br>
<div><div></div><div class=3D"h5"><br>
&gt; Besides that, I updated to your latest xenomai and re-compiled having =
the<br>
&gt; comedi drivers compiled as loadable modules. After booting the new ker=
nel I<br>
&gt; can see the following:<br>
&gt;<br>
&gt; xenomai:~&gt; uname -a<br>
&gt; Linux xenomai 2.6.30.5-xenomai-ipipe-comedi #6 SMP Wed Oct 21 20:05:37=
 PDT<br>
&gt; 2009 i686 GNU/Linux<br>
&gt; xenomai:~&gt; lspci -v<br>
&gt; ...snip...<br>
&gt; 06:00.0 Class ff00: National Instruments Device 717f<br>
&gt; =A0=A0=A0 Flags: bus master, medium devsel, latency 64, IRQ 11<br>
&gt; =A0=A0=A0 Memory at f7dfe000 (32-bit, non-prefetchable) [size=3D4K]<br=
>
&gt; =A0=A0=A0 Memory at f7dff000 (32-bit, non-prefetchable) [size=3D4K]<br=
>
&gt; =A0=A0=A0 Kernel driver in use: mite<br>
&gt; =A0=A0=A0 Kernel modules: comedi_ni_pcimio<br>
&gt; ...snip...<br>
&gt; xenomai:~&gt; lsmod | grep come<br>
&gt; comedi_ni_tio=A0=A0=A0=A0=A0=A0=A0=A0=A0 26884=A0 0<br>
&gt; comedi_8255=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 4420=A0 0<br>
&gt; comedi_ni_mite=A0=A0=A0=A0=A0=A0=A0=A0 12708=A0 1 comedi_ni_tio<br>
&gt; xeno_comedi=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 39908=A0 3 comedi_ni_tio,=
comedi_8255,comedi_ni_mite<br>
&gt;<br>
&gt;<br>
&gt; However, the problem is that there is:<br>
&gt;<br>
&gt; root@domain.hid# ./comedi_config comedi0 comedi_pcimio<=
br>
&gt; comedi_config: comedi_snd_attach failed ret=3D-22<br>
&gt;<br>
&gt; also...<br>
&gt;<br>
&gt; root@domain.hid# ./comedi_config comedi0 comedi_ni_mite=
<br>
&gt; comedi_config: comedi_snd_attach failed ret=3D-22<br>
&gt;<br>
&gt; root@domain.hid# dmesg<br>
&gt; ...snip...<br>
&gt; [=A0=A0 11.298460] Comedi: MITE: Available NI device IDs: 0x717f(used)=
<br>
&gt; [=A0=A0 11.305333] comedi_8255: module license &#39;unspecified&#39; t=
aints kernel.<br>
&gt; [=A0=A0 11.305337] Disabling lock debugging due to kernel taint<br>
&gt; [=A0=A0 11.331840] comedi_ni_mio: Unknown symbol ni_tio_handle_interru=
pt<br>
&gt; [=A0=A0 11.331936] comedi_ni_mio: Unknown symbol ni_tio_set_mite_chann=
el<br>
&gt; [=A0=A0 11.331986] comedi_ni_mio: Unknown symbol ni_tio_cmd_mask<br>
&gt; [=A0=A0 11.332171] comedi_ni_mio: Unknown symbol ni_tio_init_counter<b=
r>
&gt; [=A0=A0 11.332317] comedi_ni_mio: Unknown symbol ni_tio_winsn<br>
&gt; [=A0=A0 11.332416] comedi_ni_mio: Unknown symbol ni_gpct_device_destro=
y<br>
&gt; [=A0=A0 11.332466] comedi_ni_mio: Unknown symbol ni_tio_insn_config<br=
>
&gt; [=A0=A0 11.332696] comedi_ni_mio: Unknown symbol ni_tio_acknowledge_an=
d_confirm<br>
&gt; [=A0=A0 11.332786] comedi_ni_mio: Unknown symbol ni_tio_cmdtest<br>
&gt; [=A0=A0 11.332921] comedi_ni_mio: Unknown symbol ni_tio_cancel<br>
&gt; [=A0=A0 11.332976] comedi_ni_mio: Unknown symbol ni_gpct_device_constr=
uct<br>
&gt; [=A0=A0 11.333139] comedi_ni_mio: Unknown symbol ni_tio_rinsn<br>
&gt; [=A0=A0 11.333189] comedi_ni_mio: Unknown symbol ni_tio_cmd<br>
&gt; ...snip...<br>
&gt;<br>
&gt; How can I fix this ? Or should I simply work with the statical linked =
comedi<br>
&gt; drivers ??<br>
<br>
</div></div>I will update my git repository soon with these fixes. However,=
 could<br>
you switch to the analogy branch ? As you may know, comedi/RTDM has<br>
been renamed as analogy:<br>
<a href=3D"https://mail.gna.org/public/xenomai-core/2009-09/msg00016.html" =
target=3D"_blank">https://mail.gna.org/public/xenomai-core/2009-09/msg00016=
.html</a><br>
<font color=3D"#888888"><br>
Alexis.<br>
</font></blockquote></div><br>

--0016e644c18ec587040476f5464e--

