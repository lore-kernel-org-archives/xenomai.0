Date: Thu, 10 May 2012 17:18:18 +0200 (CEST)
From: aubin.rebillat@domain.hid
Message-ID: <1582745274.144720341.1336663098702.JavaMail.root@domain.hid>
In-Reply-To: <4FABC5C8.8090901@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] Xenomai on the TS-7553 ARM SBC
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

> De: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
> =C3=80: "aubin rebillat" <aubin.rebillat@domain.hid>
> Cc: xenomai@xenomai.org
> Envoy=C3=A9: Jeudi 10 Mai 2012 15:42:32
> Objet: Re: [Xenomai-help] Xenomai on the TS-7553 ARM SBC
>=20
> On 05/10/2012 03:26 PM, aubin.rebillat@domain.hid wrote:
> > Hello,
> >=20
> > I am trying to port Xenomai on the TS-7553 SBC from Technologic
> systems, based on the ECONA CNS2132 (STAR8132) from Cavium networks
> (250
> MHz arm922t).
> > A Linux kernel is available for this board, version 2.6.24.4, which
> > is
> running fine.
> > I patched this kernel with adeos-ipipe-2.6.24-arm-1.9-01.patch and
> > I
> implemented all the IPIPE code for the CNS2132 and everything is
> compiling and booting fine.
> >=20
> > Therefore, I applied the procedure to add the Xenomai nucleus
> > (version
> 2.5.6) to my IPIPE patched kernel:
> >=20
> >> prepare_kernel.sh --arch=3Darm --linux=3D../linux-2.6.24.4 make
> >> O=3D../build_root ts7500_defconfig make O=3D../build_root bzImage
> >> modules
> >=20
> > And everything is compiling fine (Just an error due to the
> non-existence of the phy_addr_t type in 2.6.24 kernel which is easy
> to fix).
> >=20
> > Also, This board does not support standard bootloaders (GRUB,
> > U-BOOT,
> =E2=80=A6), it uses a specific one (TS-BOOTROM) developed by the board
> manufacturer.
> > The bootloader is quite simple, it initialises some hardware and
> > loads
> the kernel and initrd into ram before jumping on the kernel code.
> > Then after the kernel boot, an initialisation script in the initrd
> mounts a debian partition, executes pivot_root on it and launches the
> debian init program.
> > Due to this boot process to have a debian environment, I preferred
> > to
> have a fine running kernel with Xenomai before adding any user space
> support.
> >=20
> > My problem is that during the initialisation script in the initrd
> > the
> kernel hangs and only if Xenomai is enabled in the kernel
> configuration.
> Without Xenomai, the kernel is booting to debian correctly.
> >=20
> > Could it be because of the lack of user space support ? It does not
> > seem likely because if Xenomai crashes a log should be
> printed. Am I wrong ?
> >=20
> > Could it be because of the initrd ? Do I need a xenomai specific
> > initrd ? I did not see anything about initrd and xenomai anywhere
> > so
> > I assume
> that the answers are ''no''. Am I wrong ?
> >=20
> > In my tests, I disabled the pivot_root call in the init script but
> > it
> does not change anything.
> >=20
> > Nevertheless, here is the boot log :
> >=20
> > [    0.000000] Built 1 zonelists in Zone order, mobility grouping
> > on.  Total pages: 16256
> > [    0.000000] Kernel command line: root=3D/dev/ram0 init=3D/linuxrc
> > console=3Dnull lpj=3D958464
> > (...)
> > [    0.560000] Warning: unable to open an initial console.
> >=20
> > As you can see no problem is reported at all.
> >=20
> > Does anyone have an idea about what may go wrong ?
>=20
> root=3D/dev/ram0 means that you are using an initrd, which has been
> deprecated for many years.

I don't really have another option because the board does not support U-BOO=
T (according to the manufacturer) and due to the specific bootloader on the=
 board I need an initrd : The bootloader only initialises some hardware and=
 loads the kernel image and the initrd in memory before jumping on the kern=
el code. Then it uses the "linux booting linux" technique to launch debian.
I agree with you that it is not the way of doing it today and i suspect the=
 board manufacturer to do so to sell a "fast booting board" because linux i=
s booted in less than 4 secs (of course for debian, it takes really more).
They actually made many things that seemed nice when i read the description=
 but when i wanted to develop with it I saw a lot of really strange techniq=
ue / behaviors (See the UART after for example).

>
> "unable to open an initial console" means that you will not get
> further
> output from the kernel. The kernel looks for the "/dev/null" file,
> but
> does not seem to find it. But even if it found it, it would probably
> stop outputting anything. So, I suggest you use whatever serial port
> is
> outputting these messages to see further output messages. Using
> console=3DttyS0,115200 as a kernel parameter for instance.
>=20

The UARTs accessed by ttyS0 and ttyS1 do not have any corresponding ports o=
n the board so i can't use any console.
Instead, I use a special serial output implemented on the fpga on the board=
.
The problem is that this serial output is really not standard and I don't r=
eally know how the console API works so I modified printk to also display d=
irectly on this serial output before calling the console driver. Therefore,=
 any printk displayed on the console is also displayed using this serial ou=
tput.

> If the kernel mysteriously fails when running init, you have to pay
> attention at the kernel OABI/EABI settings.
>=20
> To know if the issue is really related to xenomai, try disabling
> CONFIG_IPIPE and CONFIG_XENOMAI starting from the failing kernel
> configuration, and see if booting still fails. If it still fails,
> then
> your issue is likely not related to Xenomai or the I-pipe patch.

I have troubles only with CONFIG_XENOMAI enabled. With the normal kernel or=
 the IPIPE kernel the board is booting fine with exactly the same configura=
tion (except CONFIG_IPIPE of course).

>
> Another trick is to use an NFS mounted root filesystem, this way, by
> capturing the network traffic with wireshark, you can see in details
> what accesses the board does to the filesystem, and what fails.
>=20
> --
> =09=09=09=09=09    Gilles.
>=20
>

I will look into the OABI and EABI settings then.
I will also set up an NFS file system to mount debian from and see what is =
happening.

Thank you Gilles for your reply. I will keep posting about my progresses.

Best regards,

--=20
Aubin REBILLAT

