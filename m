Message-ID: <20100828044534.21096@domain.hid>
Date: Sat, 28 Aug 2010 05:03:24 -0400
From: "C Robinson" <starknight__@domain.hid>
Content-transfer-encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Subject: [Xenomai-help] Ubuntu packages
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

I'm seeking some clarification on a few points.   The background is that I h=
ave some software I need to install which requires Xenomai on Ubuntu.   Bein=
g fairly recent on the Linux scene, following the installation guide for Xen=
omai has been something of a voyage of exploration, as yet unfinished - and =
somewhat more complicated as I'm doing this on a bootable usb key.

In any case, a colleague mentioned there was an easier way using the availab=
le packages in the Ubuntu repositories, i.e. the xenomai-runtime and associa=
ted packages.  It was implied that with a straight-forward 'aptitude install=
 xenomai-runtime' and voila I have a RTOS ready to use.   Given the descript=
ions of these packages (and no mention of patching of the kernel for example=
), I don't think that this is their purpose, particularly when I tried downl=
oading the xenomai examples where the second step is :

make XENO=3D<xenomai-installation-path> KSRC=3D<xenomai-kernel-source>

Could someone confirm (or refute) this suspicion (that the packages do not p=
rovide access to a RTOS) and perhaps explain the intended use of the xenomai=
 packages available on the ubuntu repositories - I've not seen any detailed =
reference as to why one would download and install these packages (say, in a=
ddition to having already gone through the long process of kernel patching +=
 compilation + user space setup).

Thanks for any assistance,
Charles

