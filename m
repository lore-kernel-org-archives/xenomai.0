MIME-Version: 1.0
Sender: alexis.berlemont@domain.hid
In-Reply-To: <96eea0c80910212230l745bbf85s4493e8958dad356b@domain.hid>
References: <96eea0c80910151813v635d518dr6abd72986e2f07bd@domain.hid>
	<96eea0c80910161648l1991b124w20ea9949e70f5ae0@domain.hid>
	<200910171600.16265.berlemont.hauw@domain.hid>
	<200910192324.09986.berlemont.hauw@domain.hid>
	<96eea0c80910212230l745bbf85s4493e8958dad356b@domain.hid>
Date: Fri, 23 Oct 2009 08:49:00 +0200
Message-ID: <72cf3fb0910222349x771f0158ie9a9d97911c8d2fe@domain.hid>
From: Alexis Berlemont <berlemont.hauw@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
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
To: Peter Pastor <peter.pastor@domain.hid>
Cc: xenomai@xenomai.org

Hi,

On Thu, Oct 22, 2009 at 7:30 AM, Peter Pastor <peter.pastor@domain.hid> wrot=
e:
> Hi Alexis,
>
> Sorry for the delay, I was out of town.
>
> I have tried the statical configuration and it seemed to work, i.e. I cou=
ld
> execute the example program /usr/xenomai/bin/cmd_read. However, I wanted =
to
> run the task in real-time and added the -r option which results in
> root@domain.hid# ./cmd_read -vr
> cmd_read: switching to real-time mode
> cmd_read: device comedi0 opened (fd=3D0)
> cmd_read: basic descriptor retrieved
> =A0=A0=A0 =A0subdevices count =3D 14
> =A0=A0=A0 =A0read subdevice index =3D 0
> =A0=A0=A0 =A0write subdevice index =3D 1
> cmd_read: complex descriptor retrieved
> cmd_read: channel 0
> =A0=A0=A0 =A0ranges count =3D 7
> =A0=A0=A0 =A0range's size =3D 16 (bits)
> cmd_read: channel 1
> =A0=A0=A0 =A0ranges count =3D 7
> =A0=A0=A0 =A0range's size =3D 16 (bits)
> cmd_read: channel 2
> =A0=A0=A0 =A0ranges count =3D 7
> =A0=A0=A0 =A0range's size =3D 16 (bits)
> cmd_read: channel 3
> =A0=A0=A0 =A0ranges count =3D 7
> =A0=A0=A0 =A0range's size =3D 16 (bits)
> cmd_read: scan size =3D 8
> cmd_read: size to read =3D 800
> cmd_read: command successfully sent
> 0xff 0xff 0xff 0xff 0xff 0xff 0x81 0xf9
> 0xff 0xff 0xff 0xff 0xff 0xff 0xca 0xfb
> ...snip...
> 0xff 0xff 0xff 0xff 0xff 0xff 0xff 0xff
> cmd_read: comedi_read failed (ret=3D-2)

-2 is -ENOENT, which means there is nothing more to acquire. The
return code should have been 0 but I 'd rather send -2, which is not
very compliant. It is something I need to work on.

> The cmd_write however, seems to work
>
> root@domain.hid# ./cmd_write -rv
> cmd_write: switching to real-time mode
> cmd_write: device comedi0 opened (fd=3D0)
> cmd_write: basic descriptor retrieved
> =A0=A0=A0 =A0subdevices count =3D 14
> =A0=A0=A0 =A0read subdevice index =3D 0
> =A0=A0=A0 =A0write subdevice index =3D 1
> cmd_write: complex descriptor retrieved
> cmd_write: channel 0
> =A0=A0=A0 =A0ranges count =3D 3
> =A0=A0=A0 =A0range's size =3D 16 (bits)
> cmd_write: channel 1
> =A0=A0=A0 =A0ranges count =3D 3
> =A0=A0=A0 =A0range's size =3D 16 (bits)
> cmd_write: scan size =3D 4
> cmd_write: size to write=A0 =3D 400
> cmd_write: command successfully sent
> cmd_write: 400 bytes successfully written
>
> also...
> root@domain.hid# ./insn_read -rv
> insn_read: switching to real-time mode
> insn_read: device (null) opened (fd=3D0)
> insn_read: basic descriptor retrieved
> =A0=A0=A0 =A0subdevices count =3D 14
> =A0=A0=A0 =A0read subdevice index =3D 0
> =A0=A0=A0 =A0write subdevice index =3D 1
> insn_read: complex descriptor retrieved
> insn_read: channel width is 16 bits
> insn_read: global scan size is 20
> 0xff 0xff
> 0x0 0x0
> 0xff 0xff
> 0x0 0x0
> 0xff 0xff
> 0x0 0x0
> 0xff 0xff
> 0x0 0x0
> 0xff 0xff
> 0x0 0x0
> insn_read: 20 bytes successfully received
>
> What I would like to make sure is that I can write to comedi0 without hav=
ing
> mode switches. Therefore I copied cmd_write and added a rt_task_spawn to
> make sure that the task_body runs in real-time (even though the -r option
> results in the same behavior.) This way, I could add/change code to check
> for mode switches... However, since unfortunately I am debugging things
> remotely I cannot "see" the output (the display) of our oscilloscope that=
 is
> connected to the pci express card. I'll send an email as soon as I know
> more.

Be careful with the printf() I inserted in the test programs cmd_read,
cmd_write; they will make you switch in the secondary domain.

> Besides that, I updated to your latest xenomai and re-compiled having the
> comedi drivers compiled as loadable modules. After booting the new kernel=
 I
> can see the following:
>
> xenomai:~> uname -a
> Linux xenomai 2.6.30.5-xenomai-ipipe-comedi #6 SMP Wed Oct 21 20:05:37 PD=
T
> 2009 i686 GNU/Linux
> xenomai:~> lspci -v
> ...snip...
> 06:00.0 Class ff00: National Instruments Device 717f
> =A0=A0=A0 Flags: bus master, medium devsel, latency 64, IRQ 11
> =A0=A0=A0 Memory at f7dfe000 (32-bit, non-prefetchable) [size=3D4K]
> =A0=A0=A0 Memory at f7dff000 (32-bit, non-prefetchable) [size=3D4K]
> =A0=A0=A0 Kernel driver in use: mite
> =A0=A0=A0 Kernel modules: comedi_ni_pcimio
> ...snip...
> xenomai:~> lsmod | grep come
> comedi_ni_tio=A0=A0=A0=A0=A0=A0=A0=A0=A0 26884=A0 0
> comedi_8255=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 4420=A0 0
> comedi_ni_mite=A0=A0=A0=A0=A0=A0=A0=A0 12708=A0 1 comedi_ni_tio
> xeno_comedi=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 39908=A0 3 comedi_ni_tio,com=
edi_8255,comedi_ni_mite
>
>
> However, the problem is that there is:
>
> root@domain.hid# ./comedi_config comedi0 comedi_pcimio
> comedi_config: comedi_snd_attach failed ret=3D-22
>
> also...
>
> root@domain.hid# ./comedi_config comedi0 comedi_ni_mite
> comedi_config: comedi_snd_attach failed ret=3D-22
>
> root@domain.hid# dmesg
> ...snip...
> [=A0=A0 11.298460] Comedi: MITE: Available NI device IDs: 0x717f(used)
> [=A0=A0 11.305333] comedi_8255: module license 'unspecified' taints kerne=
l.
> [=A0=A0 11.305337] Disabling lock debugging due to kernel taint
> [=A0=A0 11.331840] comedi_ni_mio: Unknown symbol ni_tio_handle_interrupt
> [=A0=A0 11.331936] comedi_ni_mio: Unknown symbol ni_tio_set_mite_channel
> [=A0=A0 11.331986] comedi_ni_mio: Unknown symbol ni_tio_cmd_mask
> [=A0=A0 11.332171] comedi_ni_mio: Unknown symbol ni_tio_init_counter
> [=A0=A0 11.332317] comedi_ni_mio: Unknown symbol ni_tio_winsn
> [=A0=A0 11.332416] comedi_ni_mio: Unknown symbol ni_gpct_device_destroy
> [=A0=A0 11.332466] comedi_ni_mio: Unknown symbol ni_tio_insn_config
> [=A0=A0 11.332696] comedi_ni_mio: Unknown symbol ni_tio_acknowledge_and_c=
onfirm
> [=A0=A0 11.332786] comedi_ni_mio: Unknown symbol ni_tio_cmdtest
> [=A0=A0 11.332921] comedi_ni_mio: Unknown symbol ni_tio_cancel
> [=A0=A0 11.332976] comedi_ni_mio: Unknown symbol ni_gpct_device_construct
> [=A0=A0 11.333139] comedi_ni_mio: Unknown symbol ni_tio_rinsn
> [=A0=A0 11.333189] comedi_ni_mio: Unknown symbol ni_tio_cmd
> ...snip...
>
> How can I fix this ? Or should I simply work with the statical linked com=
edi
> drivers ??

I will update my git repository soon with these fixes. However, could
you switch to the analogy branch ? As you may know, comedi/RTDM has
been renamed as analogy:
https://mail.gna.org/public/xenomai-core/2009-09/msg00016.html

Alexis.

