MIME-Version: 1.0
Sender: alexis.berlemont@domain.hid
In-Reply-To: <72cf3fb0910160345i494f81dr2c2d7ca4a1f5e66@domain.hid>
References: <96eea0c80910151813v635d518dr6abd72986e2f07bd@domain.hid>
	<72cf3fb0910160345i494f81dr2c2d7ca4a1f5e66@domain.hid>
Date: Fri, 16 Oct 2009 12:46:37 +0200
Message-ID: <72cf3fb0910160346r4e35aa9et42ebd3532875e868@domain.hid>
From: Alexis Berlemont <berlemont.hauw@domain.hid>
Content-Type: text/plain; charset=windows-1252
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
To: xenomai@xenomai.org

Hi,

On Fri, Oct 16, 2009 at 3:13 AM, Peter Pastor <peter.pastor@domain.hid> wrot=
e:
> Hey,
>
> I am trying to get a national instrument data acquisition pci card workin=
g
> under linux 2.6.30.5 xenomai 2.5-rc3 using comedi. I successfully install=
ed
> the regular comedi drivers and I got data from the card, however, I also =
got
> mode switches. Therefore, I moved to the latest xenomai release which
> includes the comedi interface. The installation worked out and I got a
> xeno_comedi.ko module that I can load and a /usr/xenomai/lib/libcomedi.so=
.0.
> However, my program returns with...
>
> xenomai:~/xenomai_test> ./rt_comedi_test
> ./rt_comedi_test: /usr/xenomai/lib/libcomedi.so.0: no version information
> available (required by ./rt_comedi_test)
> Xenomai: incompatible ABI revision level
> (needed=3D1, current=3D2).

Is rt_comedi_test an application you developed ?

> I figured, that I need a national instrument driver (ni_pcimio) to get th=
e
> /dev/comedi0 up and running since there is no kernel module associated wi=
th
> the NI card...

I think you should follow the common comedi way:
1) Check you have the suitable driver loaded:
# cat /proc/comedi/drivers
-- =A0Comedi drivers --

| idx | driver name
| =A000 | comedi_pcimio
| =A001 | 8255
| =A002 | comedi_loop
| =A003 | comedi_fake

2) Check the comedi RTDM devices available:
# cat /proc/xenomai/rtdm/named_devices
Hash =A0 =A0Name =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Dri=
ver =A0 =A0 =A0 =A0 =A0/proc
A1 =A0 =A0 =A0comedi0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rtdm_=
comedi =A0 =A0 comedi0
A2 =A0 =A0 =A0comedi1 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rtdm_=
comedi =A0 =A0 comedi1
A3 =A0 =A0 =A0comedi2 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rtdm_=
comedi =A0 =A0 comedi2
A4 =A0 =A0 =A0comedi3 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rtdm_=
comedi =A0 =A0 comedi3
A5 =A0 =A0 =A0comedi4 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rtdm_=
comedi =A0 =A0 comedi4
A6 =A0 =A0 =A0comedi5 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rtdm_=
comedi =A0 =A0 comedi5
A7 =A0 =A0 =A0comedi6 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rtdm_=
comedi =A0 =A0 comedi6
A8 =A0 =A0 =A0comedi7 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rtdm_=
comedi =A0 =A0 comedi7
A9 =A0 =A0 =A0comedi8 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rtdm_=
comedi =A0 =A0 comedi8
AA =A0 =A0 =A0comedi9 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rtdm_=
comedi =A0 =A0 comedi9
D6 =A0 =A0 =A0rttest0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xeno_=
timerbench rttest0
D7 =A0 =A0 =A0rttest1 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xeno_=
switchtest rttest1


3) =A0You have to attach the driver to the rtdm device you want to use
with comedi_config (a tool available in Xenomai).
#comedi_config comedi0 comedi_pcimio
=A0 =A0 That command will assign comedi_pcimio driver to comedi0

4) Eventually, you can test the acquistion is working with some test
tool of ours :cmd_read
# /usr/local/bin/cmd_read -v
cmd_read: device comedi0 opened (fd=3D0)
cmd_read: basic descriptor retrieved
=A0 =A0 =A0 =A0 subdevices count =3D 14
=A0 =A0 =A0 =A0 read subdevice index =3D 0
=A0 =A0 =A0 =A0 write subdevice index =3D 1
cmd_read: complex descriptor retrieved
cmd_read: channel 0
=A0 =A0 =A0 =A0 ranges count =3D 4
=A0 =A0 =A0 =A0 range's size =3D 16 (bits)
cmd_read: channel 1
=A0 =A0 =A0 =A0 ranges count =3D 4
=A0 =A0 =A0 =A0 range's size =3D 16 (bits)
cmd_read: channel 2
=A0 =A0 =A0 =A0 ranges count =3D 4
=A0 =A0 =A0 =A0 range's size =3D 16 (bits)
cmd_read: channel 3
=A0 =A0 =A0 =A0 ranges count =3D 4
=A0 =A0 =A0 =A0 range's size =3D 16 (bits)
cmd_read: scan size =3D 8
cmd_read: size to read =3D 800
cmd_read: command successfully sent
0x0 0x0 0x69 0x1 0x5f 0x33 0x33 0x58
0xb3 0x3a 0xec 0x28 0x2a 0x2d 0x9e 0x3a
0x73 0x3b 0x2f 0x35 0x78 0x32 0x7d 0x35
0x8b 0x37 0xad 0x36 0x25 0x35 0x8f 0x35
0xe 0x36 0x49 0x36 0xcd 0x35 0xef 0x35
0xc5 0x35 0x1 0x36 0xdb 0x35 0xe 0x36
0xc3 0x35 0xea 0x35 0xd1 0x35 0xe 0x36
0xc6 0x35 0xe4 0x35 0xc7 0x35 0x9 0x36
0xc3 0x35 0xe0 0x35 0xc1 0x35 0x1 0x36
0xc0 0x35 0xd9 0x35 0xbb 0x35 0xfb 0x35
0xb9 0x35 0xd5 0x35 0xb5 0x35 0xf3 0x35
0xb2 0x35 0xce 0x35 0xae 0x35 0xee 0x35

Here is my output with a NI 6221.

> xenomai:~/xenomai_test> lspci -v
>
> ...
>
> 06:00.0 Class ff00: National Instruments Device 717f
> =A0=A0=A0 Flags: bus master, medium devsel, latency 64, IRQ 11
> =A0=A0=A0 Memory at f7dfe000 (32-bit, non-prefetchable) [size=3D4K]
> =A0=A0=A0 Memory at f7dff000 (32-bit, non-prefetchable) [size=3D4K]
>
> ...
>
> I "svn co http://svn.gna.org/svn/xenomai/branches/comedi-rtdm-dev" since =
it
> seems to contain the NI drivers... however, I got a compiler error that I
> think relates to the fact that the system I am using has 4GB of ram
> (highmem). I am using revision: 4727.


SVN is not our version control system anymore. You should use our git
repository.

If you want the last fix I made, take my comedi branch.
Have a look at:
http://git.xenomai.org/?p=3Dxenomai-abe.git;a=3Dshortlog;h=3Drefs/heads/com=
edi


> root@domain.hid# make
> make=A0 all-recursive
> make[1]: Entering directory `/usr/src/comedi-rtdm-dev'
> Making all in comedi_kcore
> make[2]: Entering directory `/usr/src/comedi-rtdm-dev/comedi_kcore'
> make[3]: Entering directory `/usr/src/comedi-rtdm-dev'
> make[3]: Leaving directory `/usr/src/comedi-rtdm-dev'
> make[3]: Entering directory `/usr/src/linux-2.6.30.5'
> =A0 CC [M]=A0 /usr/src/comedi-rtdm-dev/comedi_kcore/comedi_os_facilities.=
o
> =A0 CC [M]=A0 /usr/src/comedi-rtdm-dev/comedi_kcore/comedi_command.o
> =A0 CC [M]=A0 /usr/src/comedi-rtdm-dev/comedi_kcore/comedi_instruction.o
> =A0 CC [M]=A0 /usr/src/comedi-rtdm-dev/comedi_kcore/comedi_driver.o
> =A0 CC [M]=A0 /usr/src/comedi-rtdm-dev/comedi_kcore/comedi_subdevice.o
> =A0 CC [M]=A0 /usr/src/comedi-rtdm-dev/comedi_kcore/comedi_buffer.o
> /usr/src/comedi-rtdm-dev/comedi_kcore/comedi_buffer.c: In function
> =91comedi_free_buffer=92:
> /usr/src/comedi-rtdm-dev/comedi_kcore/comedi_buffer.c:52: error: implicit
> declaration of function =91__va_to_kva=92
> make[4]: *** [/usr/src/comedi-rtdm-dev/comedi_kcore/comedi_buffer.o] Erro=
r 1
> make[3]: *** [_module_/usr/src/comedi-rtdm-dev/comedi_kcore] Error 2
> make[3]: Leaving directory `/usr/src/linux-2.6.30.5'
> make[2]: *** [comedi.ko] Error 2
> make[2]: Leaving directory `/usr/src/comedi-rtdm-dev/comedi_kcore'
> make[1]: *** [all-recursive] Error 1
> make[1]: Leaving directory `/usr/src/comedi-rtdm-dev'
> make: *** [all] Error 2
>
> I would be really happy if someone could give me some hints/advice on how=
 to
> get things working. What do I need to do ??
>
> Thanks a lot,
> =A0peter
>

Alexis.

