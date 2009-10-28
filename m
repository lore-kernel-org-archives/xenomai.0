MIME-Version: 1.0
In-Reply-To: <ddc6e05e0910272308g3fb50cfdueae2bbdd0da49a77@domain.hid>
References: <96eea0c80910151813v635d518dr6abd72986e2f07bd@domain.hid>
	<96eea0c80910161648l1991b124w20ea9949e70f5ae0@domain.hid>
	<200910171600.16265.berlemont.hauw@domain.hid>
	<200910192324.09986.berlemont.hauw@domain.hid>
	<96eea0c80910212230l745bbf85s4493e8958dad356b@domain.hid>
	<72cf3fb0910222349x771f0158ie9a9d97911c8d2fe@domain.hid>
	<96eea0c80910271908l4681fdb2r92f08efd5dd463c9@domain.hid>
	<ddc6e05e0910272308g3fb50cfdueae2bbdd0da49a77@domain.hid>
Date: Wed, 28 Oct 2009 00:27:15 -0700
Message-ID: <96eea0c80910280027g78b9b7eam666b015e17db5fae@domain.hid>
From: Peter Pastor <peter.pastor@domain.hid>
Content-Type: multipart/alternative; boundary=00151774098c5787ad0476f9b912
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
To: Remco den Breeje <remco@domain.hid>
Cc: xenomai@xenomai.org

--00151774098c5787ad0476f9b912
Content-Type: text/plain; charset=ISO-8859-1

Hey Remco den Breeje,

Thanks !!

I updated to the most recent version and after re-compiling the kernel
things seem to work :)

...snip...
[  494.628413] a4l: a4l_pcimio: pcimio_attach: found pcie-6259 board
[  494.628427] mite 0000:06:00.0: PCI INT A -> GSI 56 (level, low) -> IRQ 56
[  494.628515] a4l: MITE: 0xf7dfe000 mapped to f8136000 <6>a4l: DAQ:
0xf7dff000 mapped to f8154000
[  494.628524] a4l: MITE: version = 1, type = 4, mite mode = 1, interface
mode = 3
[  494.628525] a4l: MITE: num channels = 8, write post fifo depth = 1, wins
= 0, iowins = 2
[  494.650096] a4l: a4l_pcimio: pcimio_attach: found irq 56
[  749.173779] a4l: a4l_ioctl_cancel: subdevice currently idle
[  749.375358] a4l: a4l_pcimio: ni_mio_common: interrupt: b_status=a1e0
m1_status=00200000
[  749.375361] a4l: a4l_pcimio: ni_mio_common: interrupt: AO BC_TC
status=0xa1e0 status2=0x0000
[ 1737.638382] a4l: a4l_ioctl_cancel: subdevice currently idle
[ 1737.638390] a4l: a4l_pcimio: ni_ai_cmd: start
[ 1737.638405] a4l: a4l_pcimio: ni_ai_cmd: Interrupt_A_Enable_Register =
0x0021
[ 1737.638411] a4l: a4l_pcimio: ni_ai_cmd: exit
[ 1737.840059] a4l: a4l_pcimio: ni_mio_common: interrupt: a_status=80f2
ai_mite_status=00a00040
[ 1737.840061] a4l: a4l_pcimio: ni_mio_common: SC_TC interrupt
[ 1740.759023] a4l: a4l_pcimio: ni_ai_cmd: start
[ 1740.759045] a4l: a4l_pcimio: ni_ai_cmd: Interrupt_A_Enable_Register =
0x0021
[ 1740.759057] a4l: a4l_pcimio: ni_ai_cmd: exit
[ 1740.960698] a4l: a4l_pcimio: ni_mio_common: interrupt: a_status=80f2
ai_mite_status=00a00000
[ 1740.960701] a4l: a4l_pcimio: ni_mio_common: SC_TC interrupt
...snip...

I figured that I need to
root@domain.hid# ./analogy_config analogy0 a4l_pcimio

the cmd_read and cmd_write programs are working properly.

however, I cannot remove the driver...

root@domain.hid# ./analogy_config -r a4l_pcimio
analogy_config: a4l_open failed ret=-19

root@domain.hid# lsmod
...snip...
analogy_ni_pcimio      16292  1
analogy_ni_mio         48900  1 analogy_ni_pcimio
analogy_ni_tio         26852  1 analogy_ni_mio
analogy_8255            4452  1 analogy_ni_mio
analogy_ni_mite        12644  3
analogy_ni_pcimio,analogy_ni_mio,analogy_ni_tio
xeno_analogy           44772  5
analogy_ni_pcimio,analogy_ni_mio,analogy_ni_tio,analogy_8255,analogy_ni_mite
...snip...


One more question is: which xenomai version should I use if I need to have
the analogy driver and at the same time aim for the most stable release ??

thanks,
 peter



On Tue, Oct 27, 2009 at 11:08 PM, Remco den Breeje <remco@domain.hid> wrote:

> Hi Peter,
>
> On Wed, Oct 28, 2009 at 3:08 AM, Peter Pastor <peter.pastor@domain.hid>
> wrote:
> [...]
> > [   11.460737] analogy_ni_mio: Unknown symbol ni_tio_cmd
> > ...snip...
>
> I think Alexis solved that one with last nights commit
> 8063e1b21350bc6822565f29ad8d53c2a6491238
>
> If not, you may be able to work around that problem by removing the
> '_GPL' string in all EXPORT_SYMBOL_GPL statements in tio_common.c
>
> Cheers,
> Remco den Breeje
>
> >
> > root@domain.hid:~# lspci -v
> > ...snip...
> > 06:00.0 Class ff00: National Instruments Device 717f
> >     Flags: bus master, medium devsel, latency 64, IRQ 11
> >     Memory at f7dfe000 (32-bit, non-prefetchable) [size=4K]
> >     Memory at f7dff000 (32-bit, non-prefetchable) [size=4K]
> >     Kernel driver in use: mite
> >     Kernel modules: analogy_ni_pcimio
> > ...snip...
> >
> > root@domain.hid:~# lsmod | grep analogy
> > analogy_ni_tio         26852  0
> > analogy_8255            4388  0
> > analogy_ni_mite        12644  1 analogy_ni_tio
> > xeno_analogy           39108  3 analogy_ni_tio,analogy_8255,
> > analogy_ni_mite
> >
> > I don't really know how to use analogy_config... since
> >
> > root@domain.hid# ./analogy_config analogy0
> analogy_ni_mite
> > comedi_config: comedi_snd_attach failed ret=-22
> > when I run
> >
> > root@domain.hid# ./cmd_read
> > cmd_read: a4l_fill_desc failed (ret=-22)
> > *** glibc detected *** ./cmd_read: free(): invalid next size (fast):
> 0x08052008 ***
> > ======= Backtrace: =========
> > /lib/tls/i686/cmov/libc.so.6[0xb7f5f604]
> > /lib/tls/i686/cmov/libc.so.6(cfree+0x96)[0xb7f615b6]
> > ./cmd_read[0x80496ae]
> > /lib/tls/i686/cmov/libc.so.6(__libc_start_main+0xe5)[0xb7f06775]
> > ./cmd_read[0x8048f41]
> > ======= Memory map: ========
> > 08048000-0804e000 r-xp 00000000 08:01 13109565
> /usr/xenomai/bin/cmd_read
> > 0804e000-0804f000 r--p 00005000 08:01 13109565
> /usr/xenomai/bin/cmd_read
> > 0804f000-08050000 rw-p 00006000 08:01 13109565
> /usr/xenomai/bin/cmd_read
> > 08050000-08073000 rw-p 00000000 00:00 0          [heap]
> > b7d00000-b7d21000 rw-p 00000000 00:00 0
> > b7d21000-b7e00000 ---p 00000000 00:00 0
> > b7ecf000-b7edc000 r-xp 00000000 08:01 11894849   /lib/libgcc_s.so.1
> > b7edc000-b7edd000 r--p 0000c000 08:01 11894849   /lib/libgcc_s.so.1
> > ...
> >
> > which is I guess due to the unsuccessful analogy_config. My question is,
> which driver do I have to use ?
> >
> > Thanks,
> >  peter
> >
> > On Thu, Oct 22, 2009 at 11:49 PM, Alexis Berlemont <
> berlemont.hauw@domain.hid> wrote:
> >>
> >> Hi,
> >>
> >> On Thu, Oct 22, 2009 at 7:30 AM, Peter Pastor <peter.pastor@domain.hid>
> wrote:
> >> > Hi Alexis,
> >> >
> >> > Sorry for the delay, I was out of town.
> >> >
> >> > I have tried the statical configuration and it seemed to work, i.e. I
> could
> >> > execute the example program /usr/xenomai/bin/cmd_read. However, I
> wanted to
> >> > run the task in real-time and added the -r option which results in
> >> > root@domain.hid# ./cmd_read -vr
> >> > cmd_read: switching to real-time mode
> >> > cmd_read: device comedi0 opened (fd=0)
> >> > cmd_read: basic descriptor retrieved
> >> >      subdevices count = 14
> >> >      read subdevice index = 0
> >> >      write subdevice index = 1
> >> > cmd_read: complex descriptor retrieved
> >> > cmd_read: channel 0
> >> >      ranges count = 7
> >> >      range's size = 16 (bits)
> >> > cmd_read: channel 1
> >> >      ranges count = 7
> >> >      range's size = 16 (bits)
> >> > cmd_read: channel 2
> >> >      ranges count = 7
> >> >      range's size = 16 (bits)
> >> > cmd_read: channel 3
> >> >      ranges count = 7
> >> >      range's size = 16 (bits)
> >> > cmd_read: scan size = 8
> >> > cmd_read: size to read = 800
> >> > cmd_read: command successfully sent
> >> > 0xff 0xff 0xff 0xff 0xff 0xff 0x81 0xf9
> >> > 0xff 0xff 0xff 0xff 0xff 0xff 0xca 0xfb
> >> > ...snip...
> >> > 0xff 0xff 0xff 0xff 0xff 0xff 0xff 0xff
> >> > cmd_read: comedi_read failed (ret=-2)
> >>
> >> -2 is -ENOENT, which means there is nothing more to acquire. The
> >> return code should have been 0 but I 'd rather send -2, which is not
> >> very compliant. It is something I need to work on.
> >>
> >> > The cmd_write however, seems to work
> >> >
> >> > root@domain.hid# ./cmd_write -rv
> >> > cmd_write: switching to real-time mode
> >> > cmd_write: device comedi0 opened (fd=0)
> >> > cmd_write: basic descriptor retrieved
> >> >      subdevices count = 14
> >> >      read subdevice index = 0
> >> >      write subdevice index = 1
> >> > cmd_write: complex descriptor retrieved
> >> > cmd_write: channel 0
> >> >      ranges count = 3
> >> >      range's size = 16 (bits)
> >> > cmd_write: channel 1
> >> >      ranges count = 3
> >> >      range's size = 16 (bits)
> >> > cmd_write: scan size = 4
> >> > cmd_write: size to write  = 400
> >> > cmd_write: command successfully sent
> >> > cmd_write: 400 bytes successfully written
> >> >
> >> > also...
> >> > root@domain.hid# ./insn_read -rv
> >> > insn_read: switching to real-time mode
> >> > insn_read: device (null) opened (fd=0)
> >> > insn_read: basic descriptor retrieved
> >> >      subdevices count = 14
> >> >      read subdevice index = 0
> >> >      write subdevice index = 1
> >> > insn_read: complex descriptor retrieved
> >> > insn_read: channel width is 16 bits
> >> > insn_read: global scan size is 20
> >> > 0xff 0xff
> >> > 0x0 0x0
> >> > 0xff 0xff
> >> > 0x0 0x0
> >> > 0xff 0xff
> >> > 0x0 0x0
> >> > 0xff 0xff
> >> > 0x0 0x0
> >> > 0xff 0xff
> >> > 0x0 0x0
> >> > insn_read: 20 bytes successfully received
> >> >
> >> > What I would like to make sure is that I can write to comedi0 without
> having
> >> > mode switches. Therefore I copied cmd_write and added a rt_task_spawn
> to
> >> > make sure that the task_body runs in real-time (even though the -r
> option
> >> > results in the same behavior.) This way, I could add/change code to
> check
> >> > for mode switches... However, since unfortunately I am debugging
> things
> >> > remotely I cannot "see" the output (the display) of our oscilloscope
> that is
> >> > connected to the pci express card. I'll send an email as soon as I
> know
> >> > more.
> >>
> >> Be careful with the printf() I inserted in the test programs cmd_read,
> >> cmd_write; they will make you switch in the secondary domain.
> >>
> >> > Besides that, I updated to your latest xenomai and re-compiled having
> the
> >> > comedi drivers compiled as loadable modules. After booting the new
> kernel I
> >> > can see the following:
> >> >
> >> > xenomai:~> uname -a
> >> > Linux xenomai 2.6.30.5-xenomai-ipipe-comedi #6 SMP Wed Oct 21 20:05:37
> PDT
> >> > 2009 i686 GNU/Linux
> >> > xenomai:~> lspci -v
> >> > ...snip...
> >> > 06:00.0 Class ff00: National Instruments Device 717f
> >> >     Flags: bus master, medium devsel, latency 64, IRQ 11
> >> >     Memory at f7dfe000 (32-bit, non-prefetchable) [size=4K]
> >> >     Memory at f7dff000 (32-bit, non-prefetchable) [size=4K]
> >> >     Kernel driver in use: mite
> >> >     Kernel modules: comedi_ni_pcimio
> >> > ...snip...
> >> > xenomai:~> lsmod | grep come
> >> > comedi_ni_tio          26884  0
> >> > comedi_8255             4420  0
> >> > comedi_ni_mite         12708  1 comedi_ni_tio
> >> > xeno_comedi            39908  3
> comedi_ni_tio,comedi_8255,comedi_ni_mite
> >> >
> >> >
> >> > However, the problem is that there is:
> >> >
> >> > root@domain.hid# ./comedi_config comedi0 comedi_pcimio
> >> > comedi_config: comedi_snd_attach failed ret=-22
> >> >
> >> > also...
> >> >
> >> > root@domain.hid# ./comedi_config comedi0
> comedi_ni_mite
> >> > comedi_config: comedi_snd_attach failed ret=-22
> >> >
> >> > root@domain.hid# dmesg
> >> > ...snip...
> >> > [   11.298460] Comedi: MITE: Available NI device IDs: 0x717f(used)
> >> > [   11.305333] comedi_8255: module license 'unspecified' taints
> kernel.
> >> > [   11.305337] Disabling lock debugging due to kernel taint
> >> > [   11.331840] comedi_ni_mio: Unknown symbol ni_tio_handle_interrupt
> >> > [   11.331936] comedi_ni_mio: Unknown symbol ni_tio_set_mite_channel
> >> > [   11.331986] comedi_ni_mio: Unknown symbol ni_tio_cmd_mask
> >> > [   11.332171] comedi_ni_mio: Unknown symbol ni_tio_init_counter
> >> > [   11.332317] comedi_ni_mio: Unknown symbol ni_tio_winsn
> >> > [   11.332416] comedi_ni_mio: Unknown symbol ni_gpct_device_destroy
> >> > [   11.332466] comedi_ni_mio: Unknown symbol ni_tio_insn_config
> >> > [   11.332696] comedi_ni_mio: Unknown symbol
> ni_tio_acknowledge_and_confirm
> >> > [   11.332786] comedi_ni_mio: Unknown symbol ni_tio_cmdtest
> >> > [   11.332921] comedi_ni_mio: Unknown symbol ni_tio_cancel
> >> > [   11.332976] comedi_ni_mio: Unknown symbol ni_gpct_device_construct
> >> > [   11.333139] comedi_ni_mio: Unknown symbol ni_tio_rinsn
> >> > [   11.333189] comedi_ni_mio: Unknown symbol ni_tio_cmd
> >> > ...snip...
> >> >
> >> > How can I fix this ? Or should I simply work with the statical linked
> comedi
> >> > drivers ??
> >>
> >> I will update my git repository soon with these fixes. However, could
> >> you switch to the analogy branch ? As you may know, comedi/RTDM has
> >> been renamed as analogy:
> >> https://mail.gna.org/public/xenomai-core/2009-09/msg00016.html
> >>
> >> Alexis.
> >
> >
> > _______________________________________________
> > Xenomai-help mailing list
> > Xenomai-help@domain.hid
> > https://mail.gna.org/listinfo/xenomai-help
> >
>

--00151774098c5787ad0476f9b912
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hey Remco den Breeje,<br><br>Thanks !!<br><br>I updated to the most recent =
version and after re-compiling the kernel things seem to work :)<br><br>...=
snip...<br>[=A0 494.628413] a4l: a4l_pcimio: pcimio_attach: found pcie-6259=
 board<br>
[=A0 494.628427] mite 0000:06:00.0: PCI INT A -&gt; GSI 56 (level, low) -&g=
t; IRQ 56<br>[=A0 494.628515] a4l: MITE: 0xf7dfe000 mapped to f8136000 &lt;=
6&gt;a4l: DAQ: 0xf7dff000 mapped to f8154000<br>[=A0 494.628524] a4l: MITE:=
 version =3D 1, type =3D 4, mite mode =3D 1, interface mode =3D 3<br>
[=A0 494.628525] a4l: MITE: num channels =3D 8, write post fifo depth =3D 1=
, wins =3D 0, iowins =3D 2<br>[=A0 494.650096] a4l: a4l_pcimio: pcimio_atta=
ch: found irq 56<br>[=A0 749.173779] a4l: a4l_ioctl_cancel: subdevice curre=
ntly idle<br>
[=A0 749.375358] a4l: a4l_pcimio: ni_mio_common: interrupt: b_status=3Da1e0=
 m1_status=3D00200000<br>[=A0 749.375361] a4l: a4l_pcimio: ni_mio_common: i=
nterrupt: AO BC_TC status=3D0xa1e0 status2=3D0x0000<br>[ 1737.638382] a4l: =
a4l_ioctl_cancel: subdevice currently idle<br>
[ 1737.638390] a4l: a4l_pcimio: ni_ai_cmd: start<br>[ 1737.638405] a4l: a4l=
_pcimio: ni_ai_cmd: Interrupt_A_Enable_Register =3D 0x0021<br>[ 1737.638411=
] a4l: a4l_pcimio: ni_ai_cmd: exit<br>[ 1737.840059] a4l: a4l_pcimio: ni_mi=
o_common: interrupt: a_status=3D80f2 ai_mite_status=3D00a00040<br>
[ 1737.840061] a4l: a4l_pcimio: ni_mio_common: SC_TC interrupt<br>[ 1740.75=
9023] a4l: a4l_pcimio: ni_ai_cmd: start<br>[ 1740.759045] a4l: a4l_pcimio: =
ni_ai_cmd: Interrupt_A_Enable_Register =3D 0x0021<br>[ 1740.759057] a4l: a4=
l_pcimio: ni_ai_cmd: exit<br>
[ 1740.960698] a4l: a4l_pcimio: ni_mio_common: interrupt: a_status=3D80f2 a=
i_mite_status=3D00a00000<br>[ 1740.960701] a4l: a4l_pcimio: ni_mio_common: =
SC_TC interrupt<br>...snip...<br><br>I figured that I need to <br>root@domain.hid=
mai:/usr/xenomai/sbin# ./analogy_config analogy0 a4l_pcimio<br>
<br>the cmd_read and cmd_write programs are working properly.<br><br>howeve=
r, I cannot remove the driver...<br><br>root@domain.hid# ./a=
nalogy_config -r a4l_pcimio<br>analogy_config: a4l_open failed ret=3D-19<br=
>
<br>root@domain.hid# lsmod <br>...snip...<br>analogy_ni_pcim=
io=A0=A0=A0=A0=A0 16292=A0 1 <br>analogy_ni_mio=A0=A0=A0=A0=A0=A0=A0=A0 489=
00=A0 1 analogy_ni_pcimio<br>analogy_ni_tio=A0=A0=A0=A0=A0=A0=A0=A0 26852=
=A0 1 analogy_ni_mio<br>analogy_8255=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 4452=
=A0 1 analogy_ni_mio<br>
analogy_ni_mite=A0=A0=A0=A0=A0=A0=A0 12644=A0 3 analogy_ni_pcimio,analogy_n=
i_mio,analogy_ni_tio<br>xeno_analogy=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 44772=A0=
 5 analogy_ni_pcimio,analogy_ni_mio,analogy_ni_tio,analogy_8255,analogy_ni_=
mite<br>...snip...<br><br><br>One more question is: which xenomai version s=
hould I use if I need to have the analogy driver and at the same time aim f=
or the most stable release ??<br>
<br>thanks,<br>=A0peter<br><br><br><br><div class=3D"gmail_quote">On Tue, O=
ct 27, 2009 at 11:08 PM, Remco den Breeje <span dir=3D"ltr">&lt;<a href=3D"=
mailto:remco@domain.hid">remco@domain.hid</a>&gt;</span> wrote:<br><blockquote =
class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, 204, 204); m=
argin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Hi Peter,<br>
<br>
On Wed, Oct 28, 2009 at 3:08 AM, Peter Pastor &lt;<a href=3D"mailto:peter.p=
astor@domain.hid">peter.pastor@domain.hid</a>&gt; wrote:<br>
[...]<br>
<div class=3D"im">&gt; [=A0=A0 11.460737] analogy_ni_mio: Unknown symbol ni=
_tio_cmd<br>
&gt; ...snip...<br>
<br>
</div>I think Alexis solved that one with last nights commit<br>
8063e1b21350bc6822565f29ad8d53c2a6491238<br>
<br>
If not, you may be able to work around that problem by removing the<br>
&#39;_GPL&#39; string in all EXPORT_SYMBOL_GPL statements in tio_common.c<b=
r>
<br>
Cheers,<br>
Remco den Breeje<br>
<div><div></div><div class=3D"h5"><br>
&gt;<br>
&gt; root@domain.hid:~# lspci -v<br>
&gt; ...snip...<br>
&gt; 06:00.0 Class ff00: National Instruments Device 717f<br>
&gt; =A0=A0=A0 Flags: bus master, medium devsel, latency 64, IRQ 11<br>
&gt; =A0=A0=A0 Memory at f7dfe000 (32-bit, non-prefetchable) [size=3D4K]<br=
>
&gt; =A0=A0=A0 Memory at f7dff000 (32-bit, non-prefetchable) [size=3D4K]<br=
>
&gt; =A0=A0=A0 Kernel driver in use: mite<br>
&gt; =A0=A0=A0 Kernel modules: analogy_ni_pcimio<br>
&gt; ...snip...<br>
&gt;<br>
&gt; root@domain.hid:~# lsmod | grep analogy<br>
&gt; analogy_ni_tio=A0=A0=A0=A0=A0=A0=A0=A0 26852=A0 0<br>
&gt; analogy_8255=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 4388=A0 0<br>
&gt; analogy_ni_mite=A0=A0=A0=A0=A0=A0=A0 12644=A0 1 analogy_ni_tio<br>
&gt; xeno_analogy=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 39108=A0 3 analogy_ni_tio,a=
nalogy_8255,<br>
&gt; analogy_ni_mite<br>
&gt;<br>
&gt; I don&#39;t really know how to use analogy_config... since<br>
&gt;<br>
&gt; root@domain.hid# ./analogy_config analogy0 analogy_ni_m=
ite<br>
&gt; comedi_config: comedi_snd_attach failed ret=3D-22<br>
&gt; when I run<br>
&gt;<br>
&gt; root@domain.hid# ./cmd_read<br>
&gt; cmd_read: a4l_fill_desc failed (ret=3D-22)<br>
&gt; *** glibc detected *** ./cmd_read: free(): invalid next size (fast): 0=
x08052008 ***<br>
&gt; =3D=3D=3D=3D=3D=3D=3D Backtrace: =3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
&gt; /lib/tls/i686/cmov/libc.so.6[0xb7f5f604]<br>
&gt; /lib/tls/i686/cmov/libc.so.6(cfree+0x96)[0xb7f615b6]<br>
&gt; ./cmd_read[0x80496ae]<br>
&gt; /lib/tls/i686/cmov/libc.so.6(__libc_start_main+0xe5)[0xb7f06775]<br>
&gt; ./cmd_read[0x8048f41]<br>
&gt; =3D=3D=3D=3D=3D=3D=3D Memory map: =3D=3D=3D=3D=3D=3D=3D=3D<br>
&gt; 08048000-0804e000 r-xp 00000000 08:01 13109565=A0=A0 /usr/xenomai/bin/=
cmd_read<br>
&gt; 0804e000-0804f000 r--p 00005000 08:01 13109565=A0=A0 /usr/xenomai/bin/=
cmd_read<br>
&gt; 0804f000-08050000 rw-p 00006000 08:01 13109565=A0=A0 /usr/xenomai/bin/=
cmd_read<br>
&gt; 08050000-08073000 rw-p 00000000 00:00 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 [he=
ap]<br>
&gt; b7d00000-b7d21000 rw-p 00000000 00:00 0<br>
&gt; b7d21000-b7e00000 ---p 00000000 00:00 0<br>
&gt; b7ecf000-b7edc000 r-xp 00000000 08:01 11894849=A0=A0 /lib/libgcc_s.so.=
1<br>
&gt; b7edc000-b7edd000 r--p 0000c000 08:01 11894849=A0=A0 /lib/libgcc_s.so.=
1<br>
&gt; ...<br>
&gt;<br>
&gt; which is I guess due to the unsuccessful analogy_config. My question i=
s, which driver do I have to use ?<br>
&gt;<br>
&gt; Thanks,<br>
&gt; =A0peter<br>
&gt;<br>
&gt; On Thu, Oct 22, 2009 at 11:49 PM, Alexis Berlemont &lt;<a href=3D"mail=
to:berlemont.hauw@domain.hid">berlemont.hauw@domain.hid</a>&gt; wrote:<br>
&gt;&gt;<br>
&gt;&gt; Hi,<br>
&gt;&gt;<br>
&gt;&gt; On Thu, Oct 22, 2009 at 7:30 AM, Peter Pastor &lt;<a href=3D"mailt=
o:peter.pastor@domain.hid">peter.pastor@domain.hid</a>&gt; wrote:<br>
&gt;&gt; &gt; Hi Alexis,<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Sorry for the delay, I was out of town.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; I have tried the statical configuration and it seemed to work=
, i.e. I could<br>
&gt;&gt; &gt; execute the example program /usr/xenomai/bin/cmd_read. Howeve=
r, I wanted to<br>
&gt;&gt; &gt; run the task in real-time and added the -r option which resul=
ts in<br>
&gt;&gt; &gt; root@domain.hid# ./cmd_read -vr<br>
&gt;&gt; &gt; cmd_read: switching to real-time mode<br>
&gt;&gt; &gt; cmd_read: device comedi0 opened (fd=3D0)<br>
&gt;&gt; &gt; cmd_read: basic descriptor retrieved<br>
&gt;&gt; &gt; =A0=A0=A0 =A0subdevices count =3D 14<br>
&gt;&gt; &gt; =A0=A0=A0 =A0read subdevice index =3D 0<br>
&gt;&gt; &gt; =A0=A0=A0 =A0write subdevice index =3D 1<br>
&gt;&gt; &gt; cmd_read: complex descriptor retrieved<br>
&gt;&gt; &gt; cmd_read: channel 0<br>
&gt;&gt; &gt; =A0=A0=A0 =A0ranges count =3D 7<br>
&gt;&gt; &gt; =A0=A0=A0 =A0range&#39;s size =3D 16 (bits)<br>
&gt;&gt; &gt; cmd_read: channel 1<br>
&gt;&gt; &gt; =A0=A0=A0 =A0ranges count =3D 7<br>
&gt;&gt; &gt; =A0=A0=A0 =A0range&#39;s size =3D 16 (bits)<br>
&gt;&gt; &gt; cmd_read: channel 2<br>
&gt;&gt; &gt; =A0=A0=A0 =A0ranges count =3D 7<br>
&gt;&gt; &gt; =A0=A0=A0 =A0range&#39;s size =3D 16 (bits)<br>
&gt;&gt; &gt; cmd_read: channel 3<br>
&gt;&gt; &gt; =A0=A0=A0 =A0ranges count =3D 7<br>
&gt;&gt; &gt; =A0=A0=A0 =A0range&#39;s size =3D 16 (bits)<br>
&gt;&gt; &gt; cmd_read: scan size =3D 8<br>
&gt;&gt; &gt; cmd_read: size to read =3D 800<br>
&gt;&gt; &gt; cmd_read: command successfully sent<br>
&gt;&gt; &gt; 0xff 0xff 0xff 0xff 0xff 0xff 0x81 0xf9<br>
&gt;&gt; &gt; 0xff 0xff 0xff 0xff 0xff 0xff 0xca 0xfb<br>
&gt;&gt; &gt; ...snip...<br>
&gt;&gt; &gt; 0xff 0xff 0xff 0xff 0xff 0xff 0xff 0xff<br>
&gt;&gt; &gt; cmd_read: comedi_read failed (ret=3D-2)<br>
&gt;&gt;<br>
&gt;&gt; -2 is -ENOENT, which means there is nothing more to acquire. The<b=
r>
&gt;&gt; return code should have been 0 but I &#39;d rather send -2, which =
is not<br>
&gt;&gt; very compliant. It is something I need to work on.<br>
&gt;&gt;<br>
&gt;&gt; &gt; The cmd_write however, seems to work<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; root@domain.hid# ./cmd_write -rv<br>
&gt;&gt; &gt; cmd_write: switching to real-time mode<br>
&gt;&gt; &gt; cmd_write: device comedi0 opened (fd=3D0)<br>
&gt;&gt; &gt; cmd_write: basic descriptor retrieved<br>
&gt;&gt; &gt; =A0=A0=A0 =A0subdevices count =3D 14<br>
&gt;&gt; &gt; =A0=A0=A0 =A0read subdevice index =3D 0<br>
&gt;&gt; &gt; =A0=A0=A0 =A0write subdevice index =3D 1<br>
&gt;&gt; &gt; cmd_write: complex descriptor retrieved<br>
&gt;&gt; &gt; cmd_write: channel 0<br>
&gt;&gt; &gt; =A0=A0=A0 =A0ranges count =3D 3<br>
&gt;&gt; &gt; =A0=A0=A0 =A0range&#39;s size =3D 16 (bits)<br>
&gt;&gt; &gt; cmd_write: channel 1<br>
&gt;&gt; &gt; =A0=A0=A0 =A0ranges count =3D 3<br>
&gt;&gt; &gt; =A0=A0=A0 =A0range&#39;s size =3D 16 (bits)<br>
&gt;&gt; &gt; cmd_write: scan size =3D 4<br>
&gt;&gt; &gt; cmd_write: size to write=A0 =3D 400<br>
&gt;&gt; &gt; cmd_write: command successfully sent<br>
&gt;&gt; &gt; cmd_write: 400 bytes successfully written<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; also...<br>
&gt;&gt; &gt; root@domain.hid# ./insn_read -rv<br>
&gt;&gt; &gt; insn_read: switching to real-time mode<br>
&gt;&gt; &gt; insn_read: device (null) opened (fd=3D0)<br>
&gt;&gt; &gt; insn_read: basic descriptor retrieved<br>
&gt;&gt; &gt; =A0=A0=A0 =A0subdevices count =3D 14<br>
&gt;&gt; &gt; =A0=A0=A0 =A0read subdevice index =3D 0<br>
&gt;&gt; &gt; =A0=A0=A0 =A0write subdevice index =3D 1<br>
&gt;&gt; &gt; insn_read: complex descriptor retrieved<br>
&gt;&gt; &gt; insn_read: channel width is 16 bits<br>
&gt;&gt; &gt; insn_read: global scan size is 20<br>
&gt;&gt; &gt; 0xff 0xff<br>
&gt;&gt; &gt; 0x0 0x0<br>
&gt;&gt; &gt; 0xff 0xff<br>
&gt;&gt; &gt; 0x0 0x0<br>
&gt;&gt; &gt; 0xff 0xff<br>
&gt;&gt; &gt; 0x0 0x0<br>
&gt;&gt; &gt; 0xff 0xff<br>
&gt;&gt; &gt; 0x0 0x0<br>
&gt;&gt; &gt; 0xff 0xff<br>
&gt;&gt; &gt; 0x0 0x0<br>
&gt;&gt; &gt; insn_read: 20 bytes successfully received<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; What I would like to make sure is that I can write to comedi0=
 without having<br>
&gt;&gt; &gt; mode switches. Therefore I copied cmd_write and added a rt_ta=
sk_spawn to<br>
&gt;&gt; &gt; make sure that the task_body runs in real-time (even though t=
he -r option<br>
&gt;&gt; &gt; results in the same behavior.) This way, I could add/change c=
ode to check<br>
&gt;&gt; &gt; for mode switches... However, since unfortunately I am debugg=
ing things<br>
&gt;&gt; &gt; remotely I cannot &quot;see&quot; the output (the display) of=
 our oscilloscope that is<br>
&gt;&gt; &gt; connected to the pci express card. I&#39;ll send an email as =
soon as I know<br>
&gt;&gt; &gt; more.<br>
&gt;&gt;<br>
&gt;&gt; Be careful with the printf() I inserted in the test programs cmd_r=
ead,<br>
&gt;&gt; cmd_write; they will make you switch in the secondary domain.<br>
&gt;&gt;<br>
&gt;&gt; &gt; Besides that, I updated to your latest xenomai and re-compile=
d having the<br>
&gt;&gt; &gt; comedi drivers compiled as loadable modules. After booting th=
e new kernel I<br>
&gt;&gt; &gt; can see the following:<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; xenomai:~&gt; uname -a<br>
&gt;&gt; &gt; Linux xenomai 2.6.30.5-xenomai-ipipe-comedi #6 SMP Wed Oct 21=
 20:05:37 PDT<br>
&gt;&gt; &gt; 2009 i686 GNU/Linux<br>
&gt;&gt; &gt; xenomai:~&gt; lspci -v<br>
&gt;&gt; &gt; ...snip...<br>
&gt;&gt; &gt; 06:00.0 Class ff00: National Instruments Device 717f<br>
&gt;&gt; &gt; =A0=A0=A0 Flags: bus master, medium devsel, latency 64, IRQ 1=
1<br>
&gt;&gt; &gt; =A0=A0=A0 Memory at f7dfe000 (32-bit, non-prefetchable) [size=
=3D4K]<br>
&gt;&gt; &gt; =A0=A0=A0 Memory at f7dff000 (32-bit, non-prefetchable) [size=
=3D4K]<br>
&gt;&gt; &gt; =A0=A0=A0 Kernel driver in use: mite<br>
&gt;&gt; &gt; =A0=A0=A0 Kernel modules: comedi_ni_pcimio<br>
&gt;&gt; &gt; ...snip...<br>
&gt;&gt; &gt; xenomai:~&gt; lsmod | grep come<br>
&gt;&gt; &gt; comedi_ni_tio=A0=A0=A0=A0=A0=A0=A0=A0=A0 26884=A0 0<br>
&gt;&gt; &gt; comedi_8255=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 4420=A0 0<br>
&gt;&gt; &gt; comedi_ni_mite=A0=A0=A0=A0=A0=A0=A0=A0 12708=A0 1 comedi_ni_t=
io<br>
&gt;&gt; &gt; xeno_comedi=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 39908=A0 3 comed=
i_ni_tio,comedi_8255,comedi_ni_mite<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; However, the problem is that there is:<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; root@domain.hid# ./comedi_config comedi0 comed=
i_pcimio<br>
&gt;&gt; &gt; comedi_config: comedi_snd_attach failed ret=3D-22<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; also...<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; root@domain.hid# ./comedi_config comedi0 comed=
i_ni_mite<br>
&gt;&gt; &gt; comedi_config: comedi_snd_attach failed ret=3D-22<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; root@domain.hid# dmesg<br>
&gt;&gt; &gt; ...snip...<br>
&gt;&gt; &gt; [=A0=A0 11.298460] Comedi: MITE: Available NI device IDs: 0x7=
17f(used)<br>
&gt;&gt; &gt; [=A0=A0 11.305333] comedi_8255: module license &#39;unspecifi=
ed&#39; taints kernel.<br>
&gt;&gt; &gt; [=A0=A0 11.305337] Disabling lock debugging due to kernel tai=
nt<br>
&gt;&gt; &gt; [=A0=A0 11.331840] comedi_ni_mio: Unknown symbol ni_tio_handl=
e_interrupt<br>
&gt;&gt; &gt; [=A0=A0 11.331936] comedi_ni_mio: Unknown symbol ni_tio_set_m=
ite_channel<br>
&gt;&gt; &gt; [=A0=A0 11.331986] comedi_ni_mio: Unknown symbol ni_tio_cmd_m=
ask<br>
&gt;&gt; &gt; [=A0=A0 11.332171] comedi_ni_mio: Unknown symbol ni_tio_init_=
counter<br>
&gt;&gt; &gt; [=A0=A0 11.332317] comedi_ni_mio: Unknown symbol ni_tio_winsn=
<br>
&gt;&gt; &gt; [=A0=A0 11.332416] comedi_ni_mio: Unknown symbol ni_gpct_devi=
ce_destroy<br>
&gt;&gt; &gt; [=A0=A0 11.332466] comedi_ni_mio: Unknown symbol ni_tio_insn_=
config<br>
&gt;&gt; &gt; [=A0=A0 11.332696] comedi_ni_mio: Unknown symbol ni_tio_ackno=
wledge_and_confirm<br>
&gt;&gt; &gt; [=A0=A0 11.332786] comedi_ni_mio: Unknown symbol ni_tio_cmdte=
st<br>
&gt;&gt; &gt; [=A0=A0 11.332921] comedi_ni_mio: Unknown symbol ni_tio_cance=
l<br>
&gt;&gt; &gt; [=A0=A0 11.332976] comedi_ni_mio: Unknown symbol ni_gpct_devi=
ce_construct<br>
&gt;&gt; &gt; [=A0=A0 11.333139] comedi_ni_mio: Unknown symbol ni_tio_rinsn=
<br>
&gt;&gt; &gt; [=A0=A0 11.333189] comedi_ni_mio: Unknown symbol ni_tio_cmd<b=
r>
&gt;&gt; &gt; ...snip...<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; How can I fix this ? Or should I simply work with the statica=
l linked comedi<br>
&gt;&gt; &gt; drivers ??<br>
&gt;&gt;<br>
&gt;&gt; I will update my git repository soon with these fixes. However, co=
uld<br>
&gt;&gt; you switch to the analogy branch ? As you may know, comedi/RTDM ha=
s<br>
&gt;&gt; been renamed as analogy:<br>
&gt;&gt; <a href=3D"https://mail.gna.org/public/xenomai-core/2009-09/msg000=
16.html" target=3D"_blank">https://mail.gna.org/public/xenomai-core/2009-09=
/msg00016.html</a><br>
&gt;&gt;<br>
&gt;&gt; Alexis.<br>
&gt;<br>
&gt;<br>
</div></div>&gt; _______________________________________________<br>
&gt; Xenomai-help mailing list<br>
&gt; <a href=3D"mailto:Xenomai-help@domain.hid">Xenomai-help@domain.hid</a><br>
&gt; <a href=3D"https://mail.gna.org/listinfo/xenomai-help" target=3D"_blan=
k">https://mail.gna.org/listinfo/xenomai-help</a><br>
&gt;<br>
</blockquote></div><br>

--00151774098c5787ad0476f9b912--

