MIME-Version: 1.0
In-Reply-To: <200910192324.09986.berlemont.hauw@domain.hid>
References: <96eea0c80910151813v635d518dr6abd72986e2f07bd@domain.hid>
	<96eea0c80910161648l1991b124w20ea9949e70f5ae0@domain.hid>
	<200910171600.16265.berlemont.hauw@domain.hid>
	<200910192324.09986.berlemont.hauw@domain.hid>
Date: Wed, 21 Oct 2009 22:30:55 -0700
Message-ID: <96eea0c80910212230l745bbf85s4493e8958dad356b@domain.hid>
From: Peter Pastor <peter.pastor@domain.hid>
Content-Type: multipart/alternative; boundary=000e0cd28e7245a60204767f662b
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

--000e0cd28e7245a60204767f662b
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Hi Alexis,

Sorry for the delay, I was out of town.

I have tried the statical configuration and it seemed to work, i.e. I could
execute the example program /usr/xenomai/bin/cmd_read. However, I wanted to
run the task in real-time and added the -r option which results in
root@domain.hid# ./cmd_read -vr
cmd_read: switching to real-time mode
cmd_read: device comedi0 opened (fd=3D0)
cmd_read: basic descriptor retrieved
     subdevices count =3D 14
     read subdevice index =3D 0
     write subdevice index =3D 1
cmd_read: complex descriptor retrieved
cmd_read: channel 0
     ranges count =3D 7
     range's size =3D 16 (bits)
cmd_read: channel 1
     ranges count =3D 7
     range's size =3D 16 (bits)
cmd_read: channel 2
     ranges count =3D 7
     range's size =3D 16 (bits)
cmd_read: channel 3
     ranges count =3D 7
     range's size =3D 16 (bits)
cmd_read: scan size =3D 8
cmd_read: size to read =3D 800
cmd_read: command successfully sent
0xff 0xff 0xff 0xff 0xff 0xff 0x81 0xf9
0xff 0xff 0xff 0xff 0xff 0xff 0xca 0xfb
...snip...
0xff 0xff 0xff 0xff 0xff 0xff 0xff 0xff
cmd_read: comedi_read failed (ret=3D-2)

The cmd_write however, seems to work

root@domain.hid# ./cmd_write -rv
cmd_write: switching to real-time mode
cmd_write: device comedi0 opened (fd=3D0)
cmd_write: basic descriptor retrieved
     subdevices count =3D 14
     read subdevice index =3D 0
     write subdevice index =3D 1
cmd_write: complex descriptor retrieved
cmd_write: channel 0
     ranges count =3D 3
     range's size =3D 16 (bits)
cmd_write: channel 1
     ranges count =3D 3
     range's size =3D 16 (bits)
cmd_write: scan size =3D 4
cmd_write: size to write  =3D 400
cmd_write: command successfully sent
cmd_write: 400 bytes successfully written

also...
root@domain.hid# ./insn_read -rv
insn_read: switching to real-time mode
insn_read: device (null) opened (fd=3D0)
insn_read: basic descriptor retrieved
     subdevices count =3D 14
     read subdevice index =3D 0
     write subdevice index =3D 1
insn_read: complex descriptor retrieved
insn_read: channel width is 16 bits
insn_read: global scan size is 20
0xff 0xff
0x0 0x0
0xff 0xff
0x0 0x0
0xff 0xff
0x0 0x0
0xff 0xff
0x0 0x0
0xff 0xff
0x0 0x0
insn_read: 20 bytes successfully received

What I would like to make sure is that I can write to comedi0 without havin=
g
mode switches. Therefore I copied cmd_write and added a rt_task_spawn to
make sure that the task_body runs in real-time (even though the -r option
results in the same behavior.) This way, I could add/change code to check
for mode switches... However, since unfortunately I am debugging things
remotely I cannot "see" the output (the display) of our oscilloscope that i=
s
connected to the pci express card. I'll send an email as soon as I know
more.

Besides that, I updated to your latest xenomai and re-compiled having the
comedi drivers compiled as loadable modules. After booting the new kernel I
can see the following:

xenomai:~> uname -a
Linux xenomai 2.6.30.5-xenomai-ipipe-comedi #6 SMP Wed Oct 21 20:05:37 PDT
2009 i686 GNU/Linux
xenomai:~> lspci -v
...snip...
06:00.0 Class ff00: National Instruments Device 717f
    Flags: bus master, medium devsel, latency 64, IRQ 11
    Memory at f7dfe000 (32-bit, non-prefetchable) [size=3D4K]
    Memory at f7dff000 (32-bit, non-prefetchable) [size=3D4K]
    Kernel driver in use: mite
    Kernel modules: comedi_ni_pcimio
...snip...
xenomai:~> lsmod | grep come
comedi_ni_tio          26884  0
comedi_8255             4420  0
comedi_ni_mite         12708  1 comedi_ni_tio
xeno_comedi            39908  3 comedi_ni_tio,comedi_8255,comedi_ni_mite


However, the problem is that there is:

root@domain.hid# ./comedi_config comedi0 comedi_pcimio
comedi_config: comedi_snd_attach failed ret=3D-22

also...

root@domain.hid# ./comedi_config comedi0 comedi_ni_mite
comedi_config: comedi_snd_attach failed ret=3D-22

root@domain.hid# dmesg
...snip...
[   11.298460] Comedi: MITE: Available NI device IDs: 0x717f(used)
[   11.305333] comedi_8255: module license 'unspecified' taints kernel.
[   11.305337] Disabling lock debugging due to kernel taint
[   11.331840] comedi_ni_mio: Unknown symbol ni_tio_handle_interrupt
[   11.331936] comedi_ni_mio: Unknown symbol ni_tio_set_mite_channel
[   11.331986] comedi_ni_mio: Unknown symbol ni_tio_cmd_mask
[   11.332171] comedi_ni_mio: Unknown symbol ni_tio_init_counter
[   11.332317] comedi_ni_mio: Unknown symbol ni_tio_winsn
[   11.332416] comedi_ni_mio: Unknown symbol ni_gpct_device_destroy
[   11.332466] comedi_ni_mio: Unknown symbol ni_tio_insn_config
[   11.332696] comedi_ni_mio: Unknown symbol ni_tio_acknowledge_and_confirm
[   11.332786] comedi_ni_mio: Unknown symbol ni_tio_cmdtest
[   11.332921] comedi_ni_mio: Unknown symbol ni_tio_cancel
[   11.332976] comedi_ni_mio: Unknown symbol ni_gpct_device_construct
[   11.333139] comedi_ni_mio: Unknown symbol ni_tio_rinsn
[   11.333189] comedi_ni_mio: Unknown symbol ni_tio_cmd
...snip...

How can I fix this ? Or should I simply work with the statical linked comed=
i
drivers ??

Thanks,
 peter



On Mon, Oct 19, 2009 at 2:24 PM, Alexis Berlemont <berlemont.hauw@domain.hid>w=
rote:

> Hi,
>
> On Saturday 17 October 2009 16:00:15 Alexis Berlemont wrote:
> > Hi,
> >
> > On Saturday 17 October 2009 01:48:47 Peter Pastor wrote:
> > > Hey Alexis,
> > >
> > > >> That's because you did not retrieve the "comedi" branch, you are
> > > >> working
> > >
> > > the
> > >
> > > >> master branch which is left unused.
> > > >> You should create a branch on your local repository with the remot=
e
> > >
> > > comedi
> > >
> > > >> branch as reference.
> > >
> > > Sorry... I managed to do it :) (I am new to git) However, I could not
> > > compile the kernel :(
> > >
> > > drivers/xenomai/comedi/intel/8255.c:50:47: error: macro
> > > "subdev_8255_interrupt" requires 2 arguments, but only 1 given
> > > drivers/xenomai/comedi/intel/8255.c:51: error: expected =91=3D=92, =
=91,=92, =91;=92,
> > >  =91asm=92 or =91__attribute__=92 before =91{=92 token
> > > drivers/xenomai/comedi/intel/8255.c: In function =91do_config=92:
> > > drivers/xenomai/comedi/intel/8255.c:85: error: =91CR_CW=92 undeclared
> (first
> > >  use in this function)
> > > drivers/xenomai/comedi/intel/8255.c:85: error: (Each undeclared
> > > identifier is reported only once
> > > drivers/xenomai/comedi/intel/8255.c:85: error: for each function it
> > > appears in.)
> > > drivers/xenomai/comedi/intel/8255.c:88: error: =91CR_A_IO=92 undeclar=
ed
> > > (first use in this function)
> > > drivers/xenomai/comedi/intel/8255.c:90: error: =91CR_B_IO=92 undeclar=
ed
> > > (first use in this function)
> > > drivers/xenomai/comedi/intel/8255.c:92: error: =91CR_C_LO_IO=92 undec=
lared
> > > (first use in this function)
> > > drivers/xenomai/comedi/intel/8255.c:94: error: =91CR_C_HI_IO=92 undec=
lared
> > > (first use in this function)
> > > drivers/xenomai/comedi/intel/8255.c:95: error: =91_8255_CR=92 undecla=
red
> > > (first use in this function)
> > > drivers/xenomai/comedi/intel/8255.c: In function =91subd_8255_insn_bi=
ts=92:
> > > drivers/xenomai/comedi/intel/8255.c:146: error: =91_8255_DATA=92 unde=
clared
> > > (first use in this function)
> > > drivers/xenomai/comedi/intel/8255.c:204:42: error: macro
> > > "subdev_8255_init" requires 2 arguments, but only 1 given
> > > drivers/xenomai/comedi/intel/8255.c: At top level:
> > > drivers/xenomai/comedi/intel/8255.c:205: error: expected =91=3D=92, =
=91,=92, =91;=92,
> > > =91asm=92 or =91__attribute__=92 before =91{=92 token
> > > drivers/xenomai/comedi/intel/8255.c: In function =91dev_8255_attach=
=92:
> > > drivers/xenomai/comedi/intel/8255.c:274: error: =91_8255_SIZE=92 unde=
clared
> > > (first use in this function)
> > > drivers/xenomai/comedi/intel/8255.c:282:25: error: macro
> > > "subdev_8255_init" requires 2 arguments, but only 1 given
> > > drivers/xenomai/comedi/intel/8255.c:282: error: =91subdev_8255_init=
=92
> > > undeclared (first use in this function)
> > > drivers/xenomai/comedi/intel/8255.c: In function =91dev_8255_detach=
=92:
> > > drivers/xenomai/comedi/intel/8255.c:306: error: =91_8255_SIZE=92 unde=
clared
> > > (first use in this function)
> > > make[4]: *** [drivers/xenomai/comedi/intel/8255.o] Error 1
> > > make[3]: *** [drivers/xenomai/comedi/intel] Error 2
> > > make[2]: *** [drivers/xenomai/comedi] Error 2
> > > make[1]: *** [drivers/xenomai] Error 2
> > > make: *** [drivers] Error 2
> >
> > My fault. I forgot to handle some pre-compilation constants when the
> >  drivers are compiled as modules.
> >
> > I will update my git repository; meanwhile, you can statically link all
> the
> > comedi drivers into the kernel. That is a temporary solution until the
> fix
> >  is available.
>
> I updated the git repository a few hours after my answer to your last mai=
l.
> Did you have any opportunity to test it ? Or did you test a statical
> configuration ?
>
> Many thanks.
>
> > > When I reconfigure the kernel to not compile 8255 and friends it does
> not
> > > compile either...
> > >
> > > ... snip ...
> > >   AS      arch/x86/boot/header.o
> > >   LD      arch/x86/boot/setup.elf
> > >   OBJCOPY arch/x86/boot/setup.bin
> > >   BUILD   arch/x86/boot/bzImage
> > > Root device is (8, 1)
> > > Setup is 11692 bytes (padded to 11776 bytes).
> > > System is 2347 kB
> > > CRC 84c0200
> > > Kernel: arch/x86/boot/bzImage is ready  (#1)
> > > ERROR: "comedi_alloc_subd"
> > > [drivers/xenomai/comedi/testing/comedi_loop.ko] undefined!
> > > ERROR: "comedi_alloc_subd"
> > > [drivers/xenomai/comedi/testing/comedi_fake.ko] undefined!
> > > make[1]: *** [__modpost] Error 1
> > > make: *** [modules] Error 2
> > >
> > > I tried 2.6.31 and 2.6.30.5.
> >
> > Another bug of mine. The EXPORT_SYMBOL was missing.
> >
> > Once more, with a kernel in which the drivers are statically included,
> you
> > won't face this issue anymore.
> >
> > > I really appreciate your help !
> > >
> > > Thanks,
> > >  peter
> >
> Alexis.
>
>

--000e0cd28e7245a60204767f662b
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Hi Alexis,<br><br>Sorry for the delay, I was out of town.<br><br>I have tri=
ed the statical configuration and it seemed to work, i.e. I could execute t=
he example program /usr/xenomai/bin/cmd_read. However, I wanted to run the =
task in real-time and added the -r option which results in <br>
root@domain.hid# ./cmd_read -vr<br>cmd_read: switching to rea=
l-time mode<br>cmd_read: device comedi0 opened (fd=3D0)<br>cmd_read: basic =
descriptor retrieved<br>=A0=A0=A0 =A0subdevices count =3D 14<br>=A0=A0=A0 =
=A0read subdevice index =3D 0<br>
=A0=A0=A0 =A0write subdevice index =3D 1<br>cmd_read: complex descriptor re=
trieved<br>cmd_read: channel 0<br>=A0=A0=A0 =A0ranges count =3D 7<br>=A0=A0=
=A0 =A0range&#39;s size =3D 16 (bits)<br>cmd_read: channel 1<br>=A0=A0=A0 =
=A0ranges count =3D 7<br>=A0=A0=A0 =A0range&#39;s size =3D 16 (bits)<br>
cmd_read: channel 2<br>=A0=A0=A0 =A0ranges count =3D 7<br>=A0=A0=A0 =A0rang=
e&#39;s size =3D 16 (bits)<br>cmd_read: channel 3<br>=A0=A0=A0 =A0ranges co=
unt =3D 7<br>=A0=A0=A0 =A0range&#39;s size =3D 16 (bits)<br>cmd_read: scan =
size =3D 8<br>cmd_read: size to read =3D 800<br>
cmd_read: command successfully sent<br>0xff 0xff 0xff 0xff 0xff 0xff 0x81 0=
xf9 <br>0xff 0xff 0xff 0xff 0xff 0xff 0xca 0xfb <br>...snip...<br>0xff 0xff=
 0xff 0xff 0xff 0xff 0xff 0xff <br>cmd_read: comedi_read failed (ret=3D-2)<=
br>
<br>The cmd_write however, seems to work<br><br>root@domain.hid=
in# ./cmd_write -rv<br>cmd_write: switching to real-time mode<br>cmd_write:=
 device comedi0 opened (fd=3D0)<br>cmd_write: basic descriptor retrieved<br=
>
=A0=A0=A0 =A0subdevices count =3D 14<br>=A0=A0=A0 =A0read subdevice index =
=3D 0<br>=A0=A0=A0 =A0write subdevice index =3D 1<br>cmd_write: complex des=
criptor retrieved<br>cmd_write: channel 0<br>=A0=A0=A0 =A0ranges count =3D =
3<br>=A0=A0=A0 =A0range&#39;s size =3D 16 (bits)<br>
cmd_write: channel 1<br>=A0=A0=A0 =A0ranges count =3D 3<br>=A0=A0=A0 =A0ran=
ge&#39;s size =3D 16 (bits)<br>cmd_write: scan size =3D 4<br>cmd_write: siz=
e to write=A0 =3D 400<br>cmd_write: command successfully sent<br>cmd_write:=
 400 bytes successfully written<br>
<br>also...<br>root@domain.hid# ./insn_read -rv<br>insn_read:=
 switching to real-time mode<br>insn_read: device (null) opened (fd=3D0)<br=
>insn_read: basic descriptor retrieved<br>=A0=A0=A0 =A0subdevices count =3D=
 14<br>=A0=A0=A0 =A0read subdevice index =3D 0<br>
=A0=A0=A0 =A0write subdevice index =3D 1<br>insn_read: complex descriptor r=
etrieved<br>insn_read: channel width is 16 bits<br>insn_read: global scan s=
ize is 20<br>0xff 0xff <br>0x0 0x0 <br>0xff 0xff <br>0x0 0x0 <br>0xff 0xff =
<br>0x0 0x0 <br>
0xff 0xff <br>0x0 0x0 <br>0xff 0xff <br>0x0 0x0 <br>insn_read: 20 bytes suc=
cessfully received<br><br>What I would like to make sure is that I can writ=
e to comedi0 without having mode switches. Therefore I copied cmd_write and=
 added a rt_task_spawn to make sure that the task_body runs in real-time (e=
ven though the -r option results in the same behavior.) This way, I could a=
dd/change code to check for mode switches... However, since unfortunately I=
 am debugging things remotely I cannot &quot;see&quot; the output (the disp=
lay) of our oscilloscope that is connected to the pci express card. I&#39;l=
l send an email as soon as I know more.<br>
<br>Besides that, I updated to your latest xenomai and re-compiled having t=
he comedi drivers compiled as loadable modules. After booting the new kerne=
l I can see the following:<br><br>xenomai:~&gt; uname -a<br>Linux xenomai 2=
.6.30.5-xenomai-ipipe-comedi #6 SMP Wed Oct 21 20:05:37 PDT 2009 i686 GNU/L=
inux<br>
xenomai:~&gt; lspci -v<br>...snip...<br>06:00.0 Class ff00: National Instru=
ments Device 717f<br>=A0=A0=A0 Flags: bus master, medium devsel, latency 64=
, IRQ 11<br>=A0=A0=A0 Memory at f7dfe000 (32-bit, non-prefetchable) [size=
=3D4K]<br>=A0=A0=A0 Memory at f7dff000 (32-bit, non-prefetchable) [size=3D4=
K]<br>
=A0=A0=A0 Kernel driver in use: mite<br>=A0=A0=A0 Kernel modules: comedi_ni=
_pcimio<br>...snip...<br>
xenomai:~&gt; lsmod | grep come<br>comedi_ni_tio=A0=A0=A0=A0=A0=A0=A0=A0=A0=
 26884=A0 0 <br>comedi_8255=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 4420=A0 0 <=
br>comedi_ni_mite=A0=A0=A0=A0=A0=A0=A0=A0 12708=A0 1 comedi_ni_tio<br>xeno_=
comedi=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 39908=A0 3 comedi_ni_tio,comedi_825=
5,comedi_ni_mite<br>
<br><br>However, the problem is that there is:<br><br>root@domain.hid=
omai/sbin# ./comedi_config comedi0 comedi_pcimio<br>comedi_config: comedi_s=
nd_attach failed ret=3D-22<br><br>also...<br><br>root@domain.hid/=
sbin# ./comedi_config comedi0 comedi_ni_mite<br>

comedi_config: comedi_snd_attach failed ret=3D-22<br>
<br>root@domain.hid# dmesg<br>...snip...<br>[=A0=A0 11.29846=
0] Comedi: MITE: Available NI device IDs: 0x717f(used)<br>[=A0=A0 11.305333=
] comedi_8255: module license &#39;unspecified&#39; taints kernel.<br>[=A0=
=A0 11.305337] Disabling lock debugging due to kernel taint<br>
[=A0=A0 11.331840] comedi_ni_mio: Unknown symbol ni_tio_handle_interrupt<br=
>[=A0=A0 11.331936] comedi_ni_mio: Unknown symbol ni_tio_set_mite_channel<b=
r>[=A0=A0 11.331986] comedi_ni_mio: Unknown symbol ni_tio_cmd_mask<br>[=A0=
=A0 11.332171] comedi_ni_mio: Unknown symbol ni_tio_init_counter<br>
[=A0=A0 11.332317] comedi_ni_mio: Unknown symbol ni_tio_winsn<br>[=A0=A0 11=
.332416] comedi_ni_mio: Unknown symbol ni_gpct_device_destroy<br>[=A0=A0 11=
.332466] comedi_ni_mio: Unknown symbol ni_tio_insn_config<br>[=A0=A0 11.332=
696] comedi_ni_mio: Unknown symbol ni_tio_acknowledge_and_confirm<br>
[=A0=A0 11.332786] comedi_ni_mio: Unknown symbol ni_tio_cmdtest<br>[=A0=A0 =
11.332921] comedi_ni_mio: Unknown symbol ni_tio_cancel<br>[=A0=A0 11.332976=
] comedi_ni_mio: Unknown symbol ni_gpct_device_construct<br>[=A0=A0 11.3331=
39] comedi_ni_mio: Unknown symbol ni_tio_rinsn<br>
[=A0=A0 11.333189] comedi_ni_mio: Unknown symbol ni_tio_cmd<br>...snip...<b=
r><br>How can I fix this ? Or should I simply work with the statical linked=
 comedi drivers ??<br><br>Thanks,<br>=A0peter<br><br><br><br><div class=3D"=
gmail_quote">
On Mon, Oct 19, 2009 at 2:24 PM, Alexis Berlemont <span dir=3D"ltr">&lt;<a =
href=3D"mailto:berlemont.hauw@domain.hid">berlemont.hauw@domain.hid</a>&gt;</span=
> wrote:<br><blockquote class=3D"gmail_quote" style=3D"border-left: 1px sol=
id rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Hi,<br>
<div class=3D"im"><br>
On Saturday 17 October 2009 16:00:15 Alexis Berlemont wrote:<br>
</div><div><div></div><div class=3D"h5">&gt; Hi,<br>
&gt;<br>
&gt; On Saturday 17 October 2009 01:48:47 Peter Pastor wrote:<br>
&gt; &gt; Hey Alexis,<br>
&gt; &gt;<br>
&gt; &gt; &gt;&gt; That&#39;s because you did not retrieve the &quot;comedi=
&quot; branch, you are<br>
&gt; &gt; &gt;&gt; working<br>
&gt; &gt;<br>
&gt; &gt; the<br>
&gt; &gt;<br>
&gt; &gt; &gt;&gt; master branch which is left unused.<br>
&gt; &gt; &gt;&gt; You should create a branch on your local repository with=
 the remote<br>
&gt; &gt;<br>
&gt; &gt; comedi<br>
&gt; &gt;<br>
&gt; &gt; &gt;&gt; branch as reference.<br>
&gt; &gt;<br>
&gt; &gt; Sorry... I managed to do it :) (I am new to git) However, I could=
 not<br>
&gt; &gt; compile the kernel :(<br>
&gt; &gt;<br>
&gt; &gt; drivers/xenomai/comedi/intel/8255.c:50:47: error: macro<br>
&gt; &gt; &quot;subdev_8255_interrupt&quot; requires 2 arguments, but only =
1 given<br>
&gt; &gt; drivers/xenomai/comedi/intel/8255.c:51: error: expected =91=3D=92=
, =91,=92, =91;=92,<br>
&gt; &gt; =A0=91asm=92 or =91__attribute__=92 before =91{=92 token<br>
&gt; &gt; drivers/xenomai/comedi/intel/8255.c: In function =91do_config=92:=
<br>
&gt; &gt; drivers/xenomai/comedi/intel/8255.c:85: error: =91CR_CW=92 undecl=
ared (first<br>
&gt; &gt; =A0use in this function)<br>
&gt; &gt; drivers/xenomai/comedi/intel/8255.c:85: error: (Each undeclared<b=
r>
&gt; &gt; identifier is reported only once<br>
&gt; &gt; drivers/xenomai/comedi/intel/8255.c:85: error: for each function =
it<br>
&gt; &gt; appears in.)<br>
&gt; &gt; drivers/xenomai/comedi/intel/8255.c:88: error: =91CR_A_IO=92 unde=
clared<br>
&gt; &gt; (first use in this function)<br>
&gt; &gt; drivers/xenomai/comedi/intel/8255.c:90: error: =91CR_B_IO=92 unde=
clared<br>
&gt; &gt; (first use in this function)<br>
&gt; &gt; drivers/xenomai/comedi/intel/8255.c:92: error: =91CR_C_LO_IO=92 u=
ndeclared<br>
&gt; &gt; (first use in this function)<br>
&gt; &gt; drivers/xenomai/comedi/intel/8255.c:94: error: =91CR_C_HI_IO=92 u=
ndeclared<br>
&gt; &gt; (first use in this function)<br>
&gt; &gt; drivers/xenomai/comedi/intel/8255.c:95: error: =91_8255_CR=92 und=
eclared<br>
&gt; &gt; (first use in this function)<br>
&gt; &gt; drivers/xenomai/comedi/intel/8255.c: In function =91subd_8255_ins=
n_bits=92:<br>
&gt; &gt; drivers/xenomai/comedi/intel/8255.c:146: error: =91_8255_DATA=92 =
undeclared<br>
&gt; &gt; (first use in this function)<br>
&gt; &gt; drivers/xenomai/comedi/intel/8255.c:204:42: error: macro<br>
&gt; &gt; &quot;subdev_8255_init&quot; requires 2 arguments, but only 1 giv=
en<br>
&gt; &gt; drivers/xenomai/comedi/intel/8255.c: At top level:<br>
&gt; &gt; drivers/xenomai/comedi/intel/8255.c:205: error: expected =91=3D=
=92, =91,=92, =91;=92,<br>
&gt; &gt; =91asm=92 or =91__attribute__=92 before =91{=92 token<br>
&gt; &gt; drivers/xenomai/comedi/intel/8255.c: In function =91dev_8255_atta=
ch=92:<br>
&gt; &gt; drivers/xenomai/comedi/intel/8255.c:274: error: =91_8255_SIZE=92 =
undeclared<br>
&gt; &gt; (first use in this function)<br>
&gt; &gt; drivers/xenomai/comedi/intel/8255.c:282:25: error: macro<br>
&gt; &gt; &quot;subdev_8255_init&quot; requires 2 arguments, but only 1 giv=
en<br>
&gt; &gt; drivers/xenomai/comedi/intel/8255.c:282: error: =91subdev_8255_in=
it=92<br>
&gt; &gt; undeclared (first use in this function)<br>
&gt; &gt; drivers/xenomai/comedi/intel/8255.c: In function =91dev_8255_deta=
ch=92:<br>
&gt; &gt; drivers/xenomai/comedi/intel/8255.c:306: error: =91_8255_SIZE=92 =
undeclared<br>
&gt; &gt; (first use in this function)<br>
&gt; &gt; make[4]: *** [drivers/xenomai/comedi/intel/8255.o] Error 1<br>
&gt; &gt; make[3]: *** [drivers/xenomai/comedi/intel] Error 2<br>
&gt; &gt; make[2]: *** [drivers/xenomai/comedi] Error 2<br>
&gt; &gt; make[1]: *** [drivers/xenomai] Error 2<br>
&gt; &gt; make: *** [drivers] Error 2<br>
&gt;<br>
&gt; My fault. I forgot to handle some pre-compilation constants when the<b=
r>
&gt; =A0drivers are compiled as modules.<br>
&gt;<br>
&gt; I will update my git repository; meanwhile, you can statically link al=
l the<br>
&gt; comedi drivers into the kernel. That is a temporary solution until the=
 fix<br>
&gt; =A0is available.<br>
<br>
</div></div><div class=3D"im">I updated the git repository a few hours afte=
r my answer to your last mail.<br>
</div>Did you have any opportunity to test it ? Or did you test a statical<=
br>
configuration ?<br>
<br>
Many thanks.<br>
<div><div></div><div class=3D"h5"><br>
&gt; &gt; When I reconfigure the kernel to not compile 8255 and friends it =
does not<br>
&gt; &gt; compile either...<br>
&gt; &gt;<br>
&gt; &gt; ... snip ...<br>
&gt; &gt; =A0 AS =A0 =A0 =A0arch/x86/boot/header.o<br>
&gt; &gt; =A0 LD =A0 =A0 =A0arch/x86/boot/setup.elf<br>
&gt; &gt; =A0 OBJCOPY arch/x86/boot/setup.bin<br>
&gt; &gt; =A0 BUILD =A0 arch/x86/boot/bzImage<br>
&gt; &gt; Root device is (8, 1)<br>
&gt; &gt; Setup is 11692 bytes (padded to 11776 bytes).<br>
&gt; &gt; System is 2347 kB<br>
&gt; &gt; CRC 84c0200<br>
&gt; &gt; Kernel: arch/x86/boot/bzImage is ready =A0(#1)<br>
&gt; &gt; ERROR: &quot;comedi_alloc_subd&quot;<br>
&gt; &gt; [drivers/xenomai/comedi/testing/comedi_loop.ko] undefined!<br>
&gt; &gt; ERROR: &quot;comedi_alloc_subd&quot;<br>
&gt; &gt; [drivers/xenomai/comedi/testing/comedi_fake.ko] undefined!<br>
&gt; &gt; make[1]: *** [__modpost] Error 1<br>
&gt; &gt; make: *** [modules] Error 2<br>
&gt; &gt;<br>
&gt; &gt; I tried 2.6.31 and 2.6.30.5.<br>
&gt;<br>
&gt; Another bug of mine. The EXPORT_SYMBOL was missing.<br>
&gt;<br>
&gt; Once more, with a kernel in which the drivers are statically included,=
 you<br>
&gt; won&#39;t face this issue anymore.<br>
&gt;<br>
&gt; &gt; I really appreciate your help !<br>
&gt; &gt;<br>
&gt; &gt; Thanks,<br>
&gt; &gt; =A0peter<br>
&gt;<br>
Alexis.<br>
<br>
</div></div></blockquote></div><br>

--000e0cd28e7245a60204767f662b--

