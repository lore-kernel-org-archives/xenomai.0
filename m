Message-ID: <20100906080353.574@domain.hid>
Date: Mon, 06 Sep 2010 08:03:53 -0400
From: "C Robinson" <starknight__@domain.hid>
Content-transfer-encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai-help] Xenomai-help Digest, Vol 60, Issue 2
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai@xenomai.org

Thanks Philippe for the detailed response, that clears up several things.   =
However, some things are a bit more confusing.   I've divided my reply into =
three section, my aim,  the current state of affairs and what I will try nex=
t. (Thanks for your patience with me).


=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3DSection 1 ----My goal

Can I say that I'm looking for the most straight-forward method of getting X=
enomai up and running on my Ubuntu system.   I have software that requires t=
he Xenomai OS.


>From Philippe's comment, "If you plan to rebuild your own kernel with Xenoma=
i support instead of picking the one shipped with the distro" I get the impr=
ession that I have taken the long way?
Bear in mind that my first question to the mailing list was asking if the Xe=
nomai packages available from the repository (i.e. installing xenomai-runtim=
e, linux-patch-xenomai, libxenomai1 ) were sufficient to turn a Ubuntu insta=
llation into a Xenomai OS.   I was directed to the Debian installation guide=
.   This indicated to me that it was necessary to build and install the Debi=
an packages, but in addition it was still necessary to compile a new kernel =
patched during the process (so I wonder what is the purpose of the linux-pat=
ch-xenomai).

The requirement to compile the kernel I took from the mentioned guide:
"for "production" systems, you should just need xenomai-runtime und libxenom=
ai1 (together with the self built kernel as described in the next section)"



=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3DSection 2 ----My situation before Philippe'=
s last email


I found another testsuite located in the install directory of /home/<user>/x=
enomai-2.5.4/src/testsuite, from which I was able to build the examples.   H=
owever, I still got the following:

> clocktest man
> The program 'clocktest' is currently not installed.  You can install it by=
 typing:
> sudo apt-get install xenomai-runtime

 (despite synaptic showing it as installed and v2.5.4)


The following steps were done while following the guide:
----------------------------------------------------------------------------=
-------------------------------------------------
fakeroot make-kpkg --initrd --append-to-version -xenomai-2.5.4 --revision 1.=
0 binary-arch
dpkg -i linux-image*.deb
update-initramfs -c -k 2.6.32.15-xenomai-2.5.4 && update-grub
----------------------------------------------------------------------------=
-------------------------------------------------

and with xenomai-runtime still undetected, I found another guide with some a=
dditional steps (so I believed) :
----------------------------------------------------------------------------=
-------------------------------------------------
 User Part

cd /usr/xenomai
./configure
make
make install

Test Xenomai:

cd /usr/xenomai/bin
./latency -p0 -t1
----------------------------------------------------------------------------=
-------------------------------------------------

No success (the configure did work though),  I still received the instructio=
n to install xenomai-runtime


=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3DSection 3 ----Philippe's last suggestion.

Right, so the following are the packages installed according to a cache sear=
ch for xenomai:

linux-image-2.6.32.15-xenomai-2.5.4 - Linux kernel binary image for version =
2.6.32.15-xenomai-2.5.4
linux-patch-xenomai - Linux kernel patches for Xenomai
xenomai-doc - Xenomai documentation
linux-image-2.6.32.15-xenomai-2.5.4-dbg - Linux kernel debug image for versi=
on 2.6.32.15-xenomai-2.5.4
libxenomai1 - Shared libraries for Xenomai
libxenomai-dev - Headers and static libs for Xenomai
xenomai-runtime - Xenomai runtime utilities


Before I follow the steps provided by Philippe, I'm going to try the package=
s provided in the Ubuntu repository.   I realise these are out of date, but =
if they allow me to finally ave a Xenomai OS on which I can install the soft=
ware I will be working with, then I can perhaps have another go later when I=
 have some of my project underway.

So I will uninstall the following packages and replace with the ubuntu ones =
after which, if not working,  I will try Philippe's steps

xenomai-doc - Xenomai documentation
libxenomai1 - Shared libraries for Xenomai
libxenomai-dev - Headers and static libs for Xenomai
xenomai-runtime - Xenomai runtime utilities


Cheers,
Charles

