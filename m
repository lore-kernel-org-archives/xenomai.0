Message-ID: <SNT136-w1186529A4B49E82E01FEDCC6880@domain.hid>
From: Thomas Schaefer <thomas_schaefer_canada@domain.hid>
Date: Fri, 13 May 2011 15:39:47 -0700
In-Reply-To: <1305282386.2147.10.camel@domain.hid>
References: <505044.35954.qm@domain.hid>,,
	<4DC2908C.2020501@domain.hid> <4DC29BB9.1090709@domain.hid>,,
	<4DC2B804.9070604@domain.hid>,,
	<4549EF6022ACA546AAA8FC8544AC20100D9D2C5D@XCHG2.ms.msli.com>,
	<SNT136-w203D311728EC78CF0DCAB1C6860@domain.hid>,
	<1305282386.2147.10.camel@domain.hid>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Problems with rt pipes after upgrade
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai@xenomai.org


Hello=2C

----------------------------------------
> Subject: Re: [Xenomai-help] Problems with rt pipes after upgrade
> From: rpm@xenomai.org
> To: thomas_schaefer_canada@domain.hid
> CC: xenomai@xenomai.org
> Date: Fri=2C 13 May 2011 12:26:26 +0200
>
> On Wed=2C 2011-05-11 at 07:46 -0700=2C Thomas Schaefer wrote:
> >
> > Hi=2C
> >
> > we are currently running an earlier version of Xenomai (2.5.3) on a Qua=
d core Xeon with kernel 2.6.31.8(X86_64).
> > I was looking into upgrading to the latest Xenomai version from the git=
 head and kernel 2.6.37.6.
> > Everything seems to work well except creating rt_pipes in the kernel dr=
iver.
> > First I thought this is a problem with our PCIe driver but I see the sa=
me problem when loading xeno_klat.
> >
> > # modprobe xeno_klat
> > [ 70.511784] ------------[ cut here ]------------
> > [ 70.516422] WARNING: at fs/proc/generic.c:860 remove_proc_entry+0x25b/=
0x260()
> > [ 70.523556] Hardware name: D-Mitri
> > [ 70.526960] remove_proc_entry: removing non-empty directory 'native/pi=
pes'=2C leaking at least 'klat_pipe'
> > [ 70.536433] Modules linked in: xeno_klat bonding [last unloaded: scsi_=
wait_scan]
> > [ 70.545910] Pid: 296=2C comm: kworker/1:1 Not tainted 2.6.37.6 #4
> > [ 70.551834] Call Trace:
> > [ 70.554291] [] ? warn_slowpath_common+0x7b/0xc0
> > [ 70.560484] [] ? warn_slowpath_fmt+0x45/0x50
> > [ 70.566402] [] ? __xlate_proc_name+0x35/0xd0
> > [ 70.572330] [] ? remove_proc_entry+0x25b/0x260
> > [ 70.578434] [] ? registry_proc_callback+0x4b5/0x5c0
> > [ 70.584963] [] ? registry_proc_callback+0x0/0x5c0
> > [ 70.591330] [] ? process_one_work+0x107/0x3c0
> > [ 70.597351] [] ? worker_thread+0x14c/0x410
> > [ 70.603106] [] ? worker_thread+0x0/0x410
> > [ 70.608678] [] ? kthread+0x95/0xa0
> > [ 70.613758] [] ? kernel_thread_helper+0x4/0x10
> > [ 70.619857] [] ? kthread+0x0/0xa0
> > [ 70.624840] [] ? kernel_thread_helper+0x0/0x10
> > [ 70.630941] ---[ end trace 793ec26c5b485748 ]---
> >
> >
> > I would appreciate if someone could point me in the right direction of =
the possible cause.
>
> This very much looks like a race in the registry support. We have to
> resync registry object deletion done from primary mode with the linux
> kernel actually doing the work for us (via /procfs)=2C and somehow=2C we
> don't do this right. This is not a critical issue and will likely not
> break your platform=2C but this is still quite ugly=2C and requires a fix=
.
>
> Could you give us some hints about how to reproduce this easily? TIA=2C
>
=20
I used VBox and installed a very basic Debian squeeze with the netinst.iso.
Installed our kernel into it from the debian package I created and copied x=
eno_klat.ko to it.
Running insmod xeno_klat.ko shows the same symptom.
=20
=20
Thomas
=20
=20

> >
> >
> > Thanks=2C
> > Thomas
> > _______________________________________________ Xenomai-help mailing li=
st Xenomai-help@domain.hid https://mail.gna.org/listinfo/xenomai-help
>
> --
> Philippe.
>
> 		 	   		  =

