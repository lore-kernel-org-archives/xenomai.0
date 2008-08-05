Message-ID: <48985CD1.5000505@domain.hid>
Date: Tue, 05 Aug 2008 15:59:45 +0200
From: Theo Veenker <Theo.Veenker@domain.hid>
MIME-Version: 1.0
References: <20080804144936.45B241C066@domain.hid>
	<2b490f270808050422r2997ded4ta2ee4de6206bb0e5@domain.hid>
In-Reply-To: <2b490f270808050422r2997ded4ta2ee4de6206bb0e5@domain.hid>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] xenomai version 2.4.4 with linux kernel
 2.6.25.11 under ubuntu problem
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Dehann Fourie <dehann.fourie@domain.hid>
Cc: xenomai@xenomai.org

Dehann Fourie wrote:
>=20
> HI,
>=20
> Im not the expert but I had the same problem under xubuntu 7.10. I trie=
d=20
> mkinitrd, but this command doesn't come standard with Ubuntu. I resorte=
d=20
> to Debian and installed under an unencrypted fs. I think that the fs=20
> encryption could be ur problem.
>=20
> Dehann
>=20
> On Mon, Aug 4, 2008 at 4:49 PM, <stefano.franzoni@domain.hid
> <mailto:stefano.franzoni@domain.hid>> wrote:
>=20
>=20
>     Dear
>=20
>     I am trying to install Xenomai under Ubuntu following this guide:
>     http://www.xenomai.org/index.php/Xenomai_quick_build_quide
>=20
>     I have successfully patched the kernel with xenomai and compiled it=
.
>=20
>     I have created a new entry in grub/menu.lst
>=20
>     title kernel 2.6.25.11 <http://2.6.25.11> with xenomai 2.4.4 and
>     Ubuntu 8.04
>     root (hd0,2)
>     kernel /boot/vmlinuz-2.6.25.11-xenomai-2.4.4 root=3D/dev/hdb3 ro
>     zeno_nucleus.xenomai_gid=3D1004
>=20
>     I have one hard disk with two partitions and I am working on hdb3.
>=20
>     At the reboot of the PC I see the message:
>=20
>     cannot open root device "hdb3" or unknown-block(0,0)
>     please append a correct root=3D boot option; here are the available
>     partitions:
>     0100 65536 ram0 (driver?)
>     0101 65536 ram1 (driver?)
>     =85
>     010f 65536 ram15 (driver?)
>=20
>     kernel panic - not syncing: VFS unable to mount root fs on
>     unknown-block(0,0)
>=20
>     - I have included in the kernel, not as module the File System EXT3=
.
>     - I have also included in the kernel, not as module, the
>     ATA/ATAPI/MFM/RLL Support -> Enhanced IDE/MFM

You should also compile in the chipset stuff needed for the drive you boo=
t
from if you don't want the hassle of creating an initrd. I had to compile
in BLK_DEV_PIIX for mine and also added some generic ones as non-modules.

Theo


