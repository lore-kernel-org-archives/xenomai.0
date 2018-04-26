MIME-Version: 1.0
In-Reply-To: <CALLqZ8TvFOdwgVpKQn2Ni90BAMEtddEnZqJwEEmLSMyGu2BSYA@mail.gmail.com>
References: <CAOkoxmtZkcrWjcfm3ySkOiucqfCoKT6tUv4JHfV3H3PNs6xk4A@mail.gmail.com>
 <h8k8o2nn4gj7hrnjep8rlfqb.1524759069245@embeddedgreg.com>
 <CAOkoxmt4-eEcWCc21_AM2CwatWP1kLY7vmRJrJsWf_ZRjMn1ew@mail.gmail.com>
 <CALLqZ8TadWG+XetGJTFA93PxWBonhCrzstf_NHJfUhs2tZ5mMw@mail.gmail.com>
 <CAOkoxms_Dt3-Le8OF9tuuGjWANBU3d5kzMj-uatfSLP3YsT9zg@mail.gmail.com>
 <CALLqZ8Q=1eoUqi38k8GjWgSpEs8LYOM9=Q8zaWfO3DyHwC9nrw@mail.gmail.com>
 <CAOkoxmsYrbY_72-wBFNw5HFZ+p6q00BnRfuNcrhyPUwarTczVw@mail.gmail.com>
 <CALLqZ8SAqH5Gsc+edEhGFAz=x1qn-qVVF6u_86zyquJArRma+Q@mail.gmail.com>
 <CAOkoxmuTuVmtoKADwtm6ujXMz-ZdxaJnUntAFJFfRsAMrstFmg@mail.gmail.com>
 <CALLqZ8TvFOdwgVpKQn2Ni90BAMEtddEnZqJwEEmLSMyGu2BSYA@mail.gmail.com>
From: Salvatore Barone <salvator.barone@gmail.com>
Date: Thu, 26 Apr 2018 19:05:25 +0200
Message-ID: <CAOkoxmuwS98pG5tYhXpEwh+U+oEKKePJip9fRn8=VftBxXWDsw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Issue with Xenomai 3.0.6,
 I-Pipe 4.9.51 and Linux 4.9.51 on Xilinx Zynq 7000 MPSOC
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Greg Gallagher <greg@embeddedgreg.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Ok, I'll try.

I keep you updated
Thanks a lot!

2018-04-26 19:02 GMT+02:00 Greg Gallagher <greg@embeddedgreg.com>:

> You can clone this:
> git://git.xenomai.org/ipipe-arm.git
>
> Then when you patch the kernel with scripts/prepare-kernel.sh leave
> --ipipe=3D blank or not add that argument.  If you add --verbose to
> prepare-kernel you should see that the script detects the ipipe is
> already present in the tree and then just creates the symlinks.  Or at
> least that's how I think it works :)
>
> -Greg
>
> On Thu, Apr 26, 2018 at 12:58 PM, Salvatore Barone
> <salvator.barone@gmail.com> wrote:
> > Thanks, but I have to got it by myself. It's a matter of principle now!
> > Can I patch the 4.14 Xilinx Kernel with the 4.9.51 I-Pipe patch and get
> > Xenomai working on it?
> >
> > 2018-04-26 18:56 GMT+02:00 Greg Gallagher <greg@embeddedgreg.com>:
> >>
> >> okay, I will try to reproduce tonight.  If you need to be up and
> >> running i can send you a 4.14 image, (4.14 kernel with Ubuntu 16.04
> >> fs) to test out.
> >>
> >> -Greg
> >>
> >> On Thu, Apr 26, 2018 at 12:54 PM, Salvatore Barone
> >> <salvator.barone@gmail.com> wrote:
> >> > Just before the last attempt! About two hours ago...
> >> >
> >> > 2018-04-26 18:43 GMT+02:00 Greg Gallagher <greg@embeddedgreg.com>:
> >> >>
> >> >> git clone git://git.xenomai.org/xenomai-3.git
> >> >> git checkout stable-3.0.x
> >> >>
> >> >> When was the last time you sync'd with the Linux stable tree?
> >> >>
> >> >> On Thu, Apr 26, 2018 at 12:39 PM, Salvatore Barone
> >> >> <salvator.barone@gmail.com> wrote:
> >> >> > Which repo sould I use?
> >> >> >
> >> >> >
> >> >> > 2018-04-26 18:35 GMT+02:00 Greg Gallagher <greg@embeddedgreg.com>=
:
> >> >> >>
> >> >> >> My email cutoff the last part of your panic, I can see the full
> log
> >> >> >> now.
> >> >> >> Try using the latest git repo, so checkout the stable-3.0.x bran=
ch
> >> >> >> for
> >> >> >> Xenomai.  The only difference between my test setup is I'm using
> the
> >> >> >> stable
> >> >> >> branch.  I'll attempt to reproduce tonight if you still see the
> >> >> >> error.
> >> >> >>
> >> >> >> On Thu, Apr 26, 2018 at 12:29 PM, Salvatore Barone
> >> >> >> <salvator.barone@gmail.com> wrote:
> >> >> >>>
> >> >> >>> No, I'm patching the 4.9.51 mainline Linux Kernel with the 4.9.=
51
> >> >> >>> I-Pipe
> >> >> >>> patch. I'm using Xenomai 3.0.6 library and Linaro latest debian
> >> >> >>> root
> >> >> >>> filesystem (2017 something)
> >> >> >>>
> >> >> >>> 2018-04-26 18:11 GMT+02:00 Greg Gallagher <greg@embeddedgreg.co=
m
> >:
> >> >> >>>>
> >> >> >>>>
> >> >> >>>> Are you patching the Xilinx Linux kernel with the Xenomai patc=
h?
> >> >> >>>> Have
> >> >> >>>> you tried mainline?
> >> >> >>>>
> >> >> >>>> Greg
> >> >> >>>> From: salvator.barone@gmail.com
> >> >> >>>> Sent: April 26, 2018 12:01 PM
> >> >> >>>> To: greg@embeddedgreg.com
> >> >> >>>> Cc: xenomai@xenomai.org
> >> >> >>>> Subject: Re: [Xenomai] Issue with Xenomai 3.0.6, I-Pipe 4.9.51
> and
> >> >> >>>> Linux
> >> >> >>>> 4.9.51 on Xilinx Zynq 7000 MPSOC
> >> >> >>>>
> >> >> >>>> Hi Greg! I've read all your blog post on this argument! With t=
he
> >> >> >>>> xilinz
> >> >> >>>> linux kernel i have no problem!
> >> >> >>>>
> >> >> >>>> Saluti,
> >> >> >>>> Salvatore Barone.
> >> >> >>>>
> >> >> >>>> Il Gio 26 Apr 2018, 16:25 Greg Gallagher <greg@embeddedgreg.co=
m
> >
> >> >> >>>> ha
> >> >> >>>> scritto:
> >> >> >>>>>
> >> >> >>>>> If you load a non Xenomai kernel do you see the panic?  I thi=
nk
> >> >> >>>>> there's an issue with your rootfs. I've tested zynq running o=
n
> >> >> >>>>> 4.14
> >> >> >>>>> ipipe and 4.9 ipipe with Xenomai 3.0.x stable using both a
> ubuntu
> >> >> >>>>> and
> >> >> >>>>> busybox file system with no issues.  I've tested on Zybo,
> Minized
> >> >> >>>>> and
> >> >> >>>>> the Zc702 board.  If it's a rootfs problem and not Xenomai
> >> >> >>>>> related I
> >> >> >>>>> can help you off list.  Try loading a non Xenomai kernel and
> see
> >> >> >>>>> if
> >> >> >>>>> the panic still exists.
> >> >> >>>>>
> >> >> >>>>>
> >> >> >>>>> -Greg
> >> >> >>>>>
> >> >> >>>>> On Thu, Apr 26, 2018 at 10:10 AM, Salvatore Barone
> >> >> >>>>> <salvator.barone@gmail.com> wrote:
> >> >> >>>>> > Hi all,
> >> >> >>>>> > I'm trying to run Xenomai 3 on a Xilinx Zynq 7000 MPSOC (on=
 a
> >> >> >>>>> > Digilent Zybo
> >> >> >>>>> > development board). I've read a lot of tutorial and
> >> >> >>>>> > documentation
> >> >> >>>>> > before
> >> >> >>>>> > posting here.
> >> >> >>>>> > I run into a "kernel panic" and I cannot solve it.
> >> >> >>>>> > I know to be annoying, but just to be not prone to
> >> >> >>>>> > misunderstanding,
> >> >> >>>>> > I'm
> >> >> >>>>> > going to report my personal walk-through below!
> >> >> >>>>> >
> >> >> >>>>> > In short: I've downloaded Linux stable sources from git,
> >> >> >>>>> > Xenomai 3
> >> >> >>>>> > and
> >> >> >>>>> > I-Pipe. I checkout the 4.9.51 branch, applied the I-Pipe
> patch
> >> >> >>>>> > as
> >> >> >>>>> > follow
> >> >> >>>>> > -----------------------------------------------
> >> >> >>>>> > git clone git://
> >> >> >>>>> > git.kernel.org/pub/scm/linux/kernel/git/stable/linux-
> stable.git
> >> >> >>>>> > git clone git://git.xenomai.org/xenomai-3.git
> >> >> >>>>> > wget -O $IPIPE
> >> >> >>>>> >
> >> >> >>>>> >
> >> >> >>>>> >
> >> >> >>>>> > https://xenomai.org/downloads/ipipe/v4.x/arm/ipipe-core-4.9=
.
> 51-arm-4.patch
> >> >> >>>>> > cd xenomai-3
> >> >> >>>>> > ./scripts/prepare-kernel.sh
> >> >> >>>>> > --linux=3Dlinux-stable --ipipe=3D../ipipe-core-4.9.51-
> arm-4.patch
> >> >> >>>>> > --arch=3Darm
> >> >> >>>>> > -----------------------------------------------
> >> >> >>>>> > Then, I copied the "xilinx_zynq_defconfig" file, from Xilin=
x,
> >> >> >>>>> > into
> >> >> >>>>> > the
> >> >> >>>>> > arch/arm/configs directory, and then
> >> >> >>>>> > -----------------------------------------------
> >> >> >>>>> > export ARCH=3Darm
> >> >> >>>>> > export CROSS_COMPILE=3Darm-linux-gnueabihf-
> >> >> >>>>> > make xilinx_zynq_defconfig
> >> >> >>>>> > make menuconfig
> >> >> >>>>> > -----------------------------------------------
> >> >> >>>>> > I've
> >> >> >>>>> > 1) disabled frequency scaling
> >> >> >>>>> > 2) disabled CMA
> >> >> >>>>> > 3) disabled kernel hacks
> >> >> >>>>> > and then
> >> >> >>>>> > -----------------------------------------------
> >> >> >>>>> > make
> >> >> >>>>> > make UIMAGE_LOADADDR=3D0x8000 uImage modules
> >> >> >>>>> > make modules_install INSTALL_MOD_PATH=3D$ZYNQ_MODULES
> >> >> >>>>> > -----------------------------------------------
> >> >> >>>>> > So, I compiled the Xenomai 3 library
> >> >> >>>>> > -----------------------------------------------
> >> >> >>>>> > cd xenomai3
> >> >> >>>>> > git checkout tags/v3.0.6 -b xenomai_3.0.6
> >> >> >>>>> > ./scripts/bootstrap
> >> >> >>>>> > mkdir xeno3_build
> >> >> >>>>> > cd xeno3_build
> >> >> >>>>> > ../configure CFLAGS=3D"-march=3Darmv7-a -mfpu=3Dvfp3
> >> >> >>>>> > -mfloat-abi=3Dhard"
> >> >> >>>>> > LDFLAGS=3D"-march=3Darmv7-a" --build=3Dx86_64-pc-linux-gnu
> >> >> >>>>> > --host=3Darm-none-linux-gnueabi --with-core=3Dcobalt --enab=
le-smp
> >> >> >>>>> > --enable-tls
> >> >> >>>>> > CC=3Darm-linux-gnueabihf-gcc LD=3Darm-linux-gnueabihf-ld
> >> >> >>>>> > make DESTDIR=3D$XENO_ZYNQ_STAGE install
> >> >> >>>>> > ---------------------------------------------
> >> >> >>>>> >
> >> >> >>>>> > All work as expected.
> >> >> >>>>> > I used linaro latest root fs, adding the xenomai3 library a=
nd
> >> >> >>>>> > kernel
> >> >> >>>>> > modules, but, at the system boot, I run into "kernel panic"=
.
> >> >> >>>>> > Dump follows
> >> >> >>>>> > ---------------------------------------------
> >> >> >>>>> > [16:06:07:495] EXT4-fs (mmcblk0p2): recovery complete=E2=90=
=8D=E2=90=8A
> >> >> >>>>> > [16:06:07:495] EXT4-fs (mmcblk0p2): mounted filesystem with
> >> >> >>>>> > ordered
> >> >> >>>>> > data
> >> >> >>>>> > mode. Opts: (null)=E2=90=8D=E2=90=8A
> >> >> >>>>> > [16:06:07:495] VFS: Mounted root (ext4 filesystem) on devic=
e
> >> >> >>>>> > 179:2.=E2=90=8D=E2=90=8A
> >> >> >>>>> > [16:06:07:511] devtmpfs: mounted=E2=90=8D=E2=90=8A
> >> >> >>>>> > [16:06:07:511] Freeing unused kernel memory: 1024K (c090000=
0
> -
> >> >> >>>>> > c0a00000)=E2=90=8D=E2=90=8A
> >> >> >>>>> > [16:06:07:591] random: fast init done=E2=90=8D=E2=90=8A
> >> >> >>>>> > [16:06:07:639] /sbin/init:
> >> >> >>>>> > /lib/arm-linux-gnueabihf/libseccomp.so.2:
> >> >> >>>>> > no
> >> >> >>>>> > version information available (required by /sbin/init)=E2=
=90=8D=E2=90=8A
> >> >> >>>>> > [16:06:07:655] /sbin/init:
> >> >> >>>>> > /lib/arm-linux-gnueabihf/libseccomp.so.2:
> >> >> >>>>> > no
> >> >> >>>>> > version information available (required by /sbin/init)=E2=
=90=8D=E2=90=8A
> >> >> >>>>> > [16:06:07:655] /sbin/init:
> >> >> >>>>> > /lib/arm-linux-gnueabihf/libseccomp.so.2:
> >> >> >>>>> > no
> >> >> >>>>> > version information available (required by /sbin/init)=E2=
=90=8D=E2=90=8A
> >> >> >>>>> > [16:06:07:671] /sbin/init:
> >> >> >>>>> > /lib/arm-linux-gnueabihf/libseccomp.so.2:
> >> >> >>>>> > no
> >> >> >>>>> > version information available (required by /sbin/init)=E2=
=90=8D=E2=90=8A
> >> >> >>>>> > [16:06:07:687] /sbin/init:
> >> >> >>>>> > /lib/arm-linux-gnueabihf/libseccomp.so.2:
> >> >> >>>>> > no
> >> >> >>>>> > version information available (required by /sbin/init)=E2=
=90=8D=E2=90=8A
> >> >> >>>>> > [16:06:07:687] /sbin/init:
> >> >> >>>>> > /lib/arm-linux-gnueabihf/libseccomp.so.2:
> >> >> >>>>> > no
> >> >> >>>>> > version information available (required by /sbin/init)=E2=
=90=8D=E2=90=8A
> >> >> >>>>> > [16:06:07:703] /sbin/init:
> >> >> >>>>> > /lib/arm-linux-gnueabihf/libseccomp.so.2:
> >> >> >>>>> > no
> >> >> >>>>> > version information available (required by /sbin/init)=E2=
=90=8D=E2=90=8A
> >> >> >>>>> > [16:06:07:703] /sbin/init:
> >> >> >>>>> > /lib/arm-linux-gnueabihf/libseccomp.so.2:
> >> >> >>>>> > no
> >> >> >>>>> > version information available (required by /sbin/init)=E2=
=90=8D=E2=90=8A
> >> >> >>>>> > [16:06:07:719] /sbin/init:
> >> >> >>>>> > /lib/arm-linux-gnueabihf/libseccomp.so.2:
> >> >> >>>>> > no
> >> >> >>>>> > version information available (required by /sbin/init)=E2=
=90=8D=E2=90=8A
> >> >> >>>>> > [16:06:07:735] /sbin/init:
> >> >> >>>>> > /lib/arm-linux-gnueabihf/libseccomp.so.2:
> >> >> >>>>> > no
> >> >> >>>>> > version information available (required by /sbin/init)=E2=
=90=8D=E2=90=8A
> >> >> >>>>> > [16:06:07:735] /sbin/init:
> >> >> >>>>> > /lib/arm-linux-gnueabihf/libseccomp.so.2:
> >> >> >>>>> > no
> >> >> >>>>> > version information available (required by
> >> >> >>>>> > /lib/arm-linux-gnueabihf/libselinux.so.1)=E2=90=8D=E2=90=8A
> >> >> >>>>> > [16:06:07:751] /sbin/init:
> >> >> >>>>> > /lib/arm-linux-gnueabihf/libseccomp.so.2:
> >> >> >>>>> > no
> >> >> >>>>> > version information available (required by
> >> >> >>>>> > /lib/arm-linux-gnueabihf/libselinux.so.1)=E2=90=8D=E2=90=8A
> >> >> >>>>> > [16:06:07:767] /sbin/init:
> >> >> >>>>> > /lib/arm-linux-gnueabihf/libseccomp.so.2:
> >> >> >>>>> > no
> >> >> >>>>> > version information available (required by
> >> >> >>>>> > /lib/arm-linux-gnueabihf/libselinux.so.1)=E2=90=8D=E2=90=8A
> >> >> >>>>> > [16:06:07:783] /sbin/init:
> >> >> >>>>> > /lib/arm-linux-gnueabihf/libseccomp.so.2:
> >> >> >>>>> > no
> >> >> >>>>> > version information available (required by
> >> >> >>>>> > /lib/arm-linux-gnueabihf/libcap.so.2)=E2=90=8D=E2=90=8A
> >> >> >>>>> > [16:06:07:783] /sbin/init:
> >> >> >>>>> > /lib/arm-linux-gnueabihf/libseccomp.so.2:
> >> >> >>>>> > no
> >> >> >>>>> > version information available (required by
> >> >> >>>>> > /lib/arm-linux-gnueabihf/libcap.so.2)=E2=90=8D=E2=90=8A
> >> >> >>>>> > [16:06:07:799] /sbin/init:
> >> >> >>>>> > /lib/arm-linux-gnueabihf/libseccomp.so.2:
> >> >> >>>>> > no
> >> >> >>>>> > version information available (required by
> >> >> >>>>> > /lib/arm-linux-gnueabihf/libcap.so.2)=E2=90=8D=E2=90=8A
> >> >> >>>>> > [16:06:07:815] /sbin/init:
> >> >> >>>>> > /lib/arm-linux-gnueabihf/libseccomp.so.2:
> >> >> >>>>> > no
> >> >> >>>>> > version information available (required by
> >> >> >>>>> > /lib/arm-linux-gnueabihf/librt.so.1)=E2=90=8D=E2=90=8A
> >> >> >>>>> > [16:06:07:831] /sbin/init:
> >> >> >>>>> > /lib/arm-linux-gnueabihf/libseccomp.so.2:
> >> >> >>>>> > no
> >> >> >>>>> > version information available (required by
> >> >> >>>>> > /lib/arm-linux-gnueabihf/librt.so.1)=E2=90=8D=E2=90=8A
> >> >> >>>>> > [16:06:07:831] /sbin/init:
> >> >> >>>>> > /lib/arm-linux-gnueabihf/libseccomp.so.2:
> >> >> >>>>> > no
> >> >> >>>>> > version information available (required by
> >> >> >>>>> > /lib/arm-linux-gnueabihf/libseccomp.so.2)=E2=90=8D=E2=90=8A
> >> >> >>>>> > [16:06:07:847] /sbin/init:
> >> >> >>>>> > /lib/arm-linux-gnueabihf/libseccomp.so.2:
> >> >> >>>>> > no
> >> >> >>>>> > version information available (required by
> >> >> >>>>> > /lib/arm-linux-gnueabihf/libpam.so.0)=E2=90=8D=E2=90=8A
> >> >> >>>>> > [16:06:07:863] /sbin/init:
> >> >> >>>>> > /lib/arm-linux-gnueabihf/libseccomp.so.2:
> >> >> >>>>> > no
> >> >> >>>>> > version information available (required by
> >> >> >>>>> > /lib/arm-linux-gnueabihf/libpam.so.0)=E2=90=8D=E2=90=8A
> >> >> >>>>> > [16:06:07:879] /sbin/init:
> >> >> >>>>> > /lib/arm-linux-gnueabihf/libseccomp.so.2:
> >> >> >>>>> > no
> >> >> >>>>> > version information available (required by
> >> >> >>>>> > /lib/arm-linux-gnueabihf/libaudit.so.1)=E2=90=8D=E2=90=8A
> >> >> >>>>> > [16:06:07:879] /sbin/init:
> >> >> >>>>> > /lib/arm-linux-gnueabihf/libseccomp.so.2:
> >> >> >>>>> > no
> >> >> >>>>> > version information available (required by
> >> >> >>>>> > /lib/arm-linux-gnueabihf/libaudit.so.1)=E2=90=8D=E2=90=8A
> >> >> >>>>> > [16:06:07:895] /sbin/init:
> >> >> >>>>> > /lib/arm-linux-gnueabihf/libseccomp.so.2:
> >> >> >>>>> > no
> >> >> >>>>> > version information available (required by
> >> >> >>>>> > /lib/arm-linux-gnueabihf/libkmod.so.2)=E2=90=8D=E2=90=8A
> >> >> >>>>> > [16:06:07:911] /sbin/init:
> >> >> >>>>> > /lib/arm-linux-gnueabihf/libseccomp.so.2:
> >> >> >>>>> > no
> >> >> >>>>> > version information available (required by
> >> >> >>>>> > /lib/arm-linux-gnueabihf/libkmod.so.2)=E2=90=8D=E2=90=8A
> >> >> >>>>> > [16:06:07:927] /sbin/init:
> >> >> >>>>> > /lib/arm-linux-gnueabihf/libseccomp.so.2:
> >> >> >>>>> > no
> >> >> >>>>> > version information available (required by
> >> >> >>>>> > /lib/arm-linux-gnueabihf/libkmod.so.2)=E2=90=8D=E2=90=8A
> >> >> >>>>> > [16:06:07:943] /sbin/init:
> >> >> >>>>> > /lib/arm-linux-gnueabihf/libseccomp.so.2:
> >> >> >>>>> > no
> >> >> >>>>> > version information available (required by
> >> >> >>>>> > /lib/arm-linux-gnueabihf/libapparmor.so.1)=E2=90=8D=E2=90=
=8A
> >> >> >>>>> > [16:06:07:943] /sbin/init:
> >> >> >>>>> > /lib/arm-linux-gnueabihf/libseccomp.so.2:
> >> >> >>>>> > no
> >> >> >>>>> > version information available (required by
> >> >> >>>>> > /lib/arm-linux-gnueabihf/libapparmor.so.1)=E2=90=8D=E2=90=
=8A
> >> >> >>>>> > [16:06:07:959] /sbin/init:
> >> >> >>>>> > /lib/arm-linux-gnueabihf/libseccomp.so.2:
> >> >> >>>>> > no
> >> >> >>>>> > version information available (required by
> >> >> >>>>> > /lib/arm-linux-gnueabihf/libapparmor.so.1)=E2=90=8D=E2=90=
=8A
> >> >> >>>>> > [16:06:07:975] /sbin/init:
> >> >> >>>>> > /lib/arm-linux-gnueabihf/libseccomp.so.2:
> >> >> >>>>> > no
> >> >> >>>>> > version information available (required by
> >> >> >>>>> > /lib/arm-linux-gnueabihf/libapparmor.so.1)=E2=90=8D=E2=90=
=8A
> >> >> >>>>> > [16:06:07:991] /sbin/init:
> >> >> >>>>> > /lib/arm-linux-gnueabihf/libseccomp.so.2:
> >> >> >>>>> > no
> >> >> >>>>> > version information available (required by
> >> >> >>>>> > /lib/arm-linux-gnueabihf/libmount.so.1)=E2=90=8D=E2=90=8A
> >> >> >>>>> > [16:06:07:991] /sbin/init:
> >> >> >>>>> > /lib/arm-linux-gnueabihf/libseccomp.so.2:
> >> >> >>>>> > no
> >> >> >>>>> > version information available (required by
> >> >> >>>>> > /lib/arm-linux-gnueabihf/libmount.so.1)=E2=90=8D=E2=90=8A
> >> >> >>>>> > [16:06:08:007] /sbin/init:
> >> >> >>>>> > /lib/arm-linux-gnueabihf/libseccomp.so.2:
> >> >> >>>>> > no
> >> >> >>>>> > version information available (required by
> >> >> >>>>> > /lib/arm-linux-gnueabihf/libmount.so.1)=E2=90=8D=E2=90=8A
> >> >> >>>>> > [16:06:08:023] /sbin/init:
> >> >> >>>>> > /lib/arm-linux-gnueabihf/libseccomp.so.2:
> >> >> >>>>> > no
> >> >> >>>>> > version information available (required by
> >> >> >>>>> > /lib/arm-linux-gnueabihf/libmount.so.1)=E2=90=8D=E2=90=8A
> >> >> >>>>> > [16:06:08:039] /sbin/init:
> >> >> >>>>> > /lib/arm-linux-gnueabihf/libseccomp.so.2:
> >> >> >>>>> > no
> >> >> >>>>> > version information available (required by
> >> >> >>>>> > /lib/arm-linux-gnueabihf/libmount.so.1)=E2=90=8D=E2=90=8A
> >> >> >>>>> > [16:06:08:039] /sbin/init:
> >> >> >>>>> > /lib/arm-linux-gnueabihf/libseccomp.so.2:
> >> >> >>>>> > no
> >> >> >>>>> > version information available (required by
> >> >> >>>>> > /lib/arm-linux-gnueabihf/libmount.so.1)=E2=90=8D=E2=90=8A
> >> >> >>>>> > [16:06:08:055] /sbin/init:
> >> >> >>>>> > /lib/arm-linux-gnueabihf/libseccomp.so.2:
> >> >> >>>>> > no
> >> >> >>>>> > version information available (required by
> >> >> >>>>> > /lib/arm-linux-gnueabihf/libmount.so.1)=E2=90=8D=E2=90=8A
> >> >> >>>>> > [16:06:08:072] /sbin/init:
> >> >> >>>>> > /lib/arm-linux-gnueabihf/libseccomp.so.2:
> >> >> >>>>> > no
> >> >> >>>>> > version information available (required by
> >> >> >>>>> > /lib/arm-linux-gnueabihf/libgcc_s.so.1)=E2=90=8D=E2=90=8A
> >> >> >>>>> > [16:06:08:087] /sbin/init:
> >> >> >>>>> > /lib/arm-linux-gnueabihf/libseccomp.so.2:
> >> >> >>>>> > no
> >> >> >>>>> > version information available (required by
> >> >> >>>>> > /lib/arm-linux-gnueabihf/libpthread.so.0)=E2=90=8D=E2=90=8A
> >> >> >>>>> > [16:06:08:103] /sbin/init:
> >> >> >>>>> > /lib/arm-linux-gnueabihf/libseccomp.so.2:
> >> >> >>>>> > no
> >> >> >>>>> > version information available (required by
> >> >> >>>>> > /lib/arm-linux-gnueabihf/libpthread.so.0)=E2=90=8D=E2=90=8A
> >> >> >>>>> > [16:06:08:103] /sbin/init:
> >> >> >>>>> > /lib/arm-linux-gnueabihf/libseccomp.so.2:
> >> >> >>>>> > no
> >> >> >>>>> > version information available (required by
> >> >> >>>>> > /lib/arm-linux-gnueabihf/libpcre.so.3)=E2=90=8D=E2=90=8A
> >> >> >>>>> > [16:06:08:119] /sbin/init:
> >> >> >>>>> > /lib/arm-linux-gnueabihf/libseccomp.so.2:
> >> >> >>>>> > no
> >> >> >>>>> > version information available (required by
> >> >> >>>>> > /lib/arm-linux-gnueabihf/libdl.so.2)=E2=90=8D=E2=90=8A
> >> >> >>>>> > [16:06:08:135] /sbin/init:
> >> >> >>>>> > /lib/arm-linux-gnueabihf/libseccomp.so.2:
> >> >> >>>>> > no
> >> >> >>>>> > version information available (required by
> >> >> >>>>> > /lib/arm-linux-gnueabihf/libdl.so.2)=E2=90=8D=E2=90=8A
> >> >> >>>>> > [16:06:08:151] /sbin/init:
> >> >> >>>>> > /lib/arm-linux-gnueabihf/libgcc_s.so.1:
> >> >> >>>>> > version
> >> >> >>>>> > `UUID_1.0' not found (required by
> >> >> >>>>> > /lib/arm-linux-gnueabihf/libblkid.so.1)=E2=90=8D=E2=90=8A
> >> >> >>>>> > [16:06:08:151] /sbin/init:
> >> >> >>>>> > /lib/arm-linux-gnueabihf/libseccomp.so.2:
> >> >> >>>>> > no
> >> >> >>>>> > version information available (required by
> >> >> >>>>> > /lib/arm-linux-gnueabihf/libblkid.so.1)=E2=90=8D=E2=90=8A
> >> >> >>>>> > [16:06:08:167] /sbin/init:
> >> >> >>>>> > /lib/arm-linux-gnueabihf/libseccomp.so.2:
> >> >> >>>>> > no
> >> >> >>>>> > version information available (required by
> >> >> >>>>> > /lib/arm-linux-gnueabihf/libblkid.so.1)=E2=90=8D=E2=90=8A
> >> >> >>>>> > [16:06:08:183] /sbin/init:
> >> >> >>>>> > /lib/arm-linux-gnueabihf/libseccomp.so.2:
> >> >> >>>>> > no
> >> >> >>>>> > version information available (required by
> >> >> >>>>> > /lib/arm-linux-gnueabihf/libblkid.so.1)=E2=90=8D=E2=90=8A
> >> >> >>>>> > [16:06:08:199] /sbin/init:
> >> >> >>>>> > /lib/arm-linux-gnueabihf/libseccomp.so.2:
> >> >> >>>>> > no
> >> >> >>>>> > version information available (required by
> >> >> >>>>> > /lib/arm-linux-gnueabihf/libblkid.so.1)=E2=90=8D=E2=90=8A
> >> >> >>>>> > [16:06:08:231] Kernel panic - not syncing: Attempted to kil=
l
> >> >> >>>>> > init!
> >> >> >>>>> > exitcode=3D0x00000100=E2=90=8D=E2=90=8A
> >> >> >>>>> > [16:06:08:231] =E2=90=8D=E2=90=8A
> >> >> >>>>> > [16:06:08:231] CPU0: stopping=E2=90=8D=E2=90=8A
> >> >> >>>>> > [16:06:08:231] CPU: 0 PID: 0 Comm: swapper/0 Not tainted
> >> >> >>>>> > 4.9.24-xilinx-dirty #1=E2=90=8D=E2=90=8A
> >> >> >>>>> > [16:06:08:231] Hardware name: Xilinx Zynq Platform=E2=90=8D=
=E2=90=8A
> >> >> >>>>> > [16:06:08:247] I-pipe domain: Linux=E2=90=8D=E2=90=8A
> >> >> >>>>> > [16:06:08:247] Backtrace: =E2=90=8D=E2=90=8A
> >> >> >>>>> > [16:06:08:247] [<c010b2c4>] (dump_backtrace) from
> [<c010b538>]
> >> >> >>>>> > (show_stack+0x18/0x1c)=E2=90=8D=E2=90=8A
> >> >> >>>>> > [16:06:08:247]  r6:00000080 r5:00000000 r4:c0a140b8=E2=90=
=8D=E2=90=8A
> >> >> >>>>> > [16:06:08:247] [<c010b520>] (show_stack) from [<c031e618>]
> >> >> >>>>> > (dump_stack+0x90/0xb4)=E2=90=8D=E2=90=8A
> >> >> >>>>> > [16:06:08:263] [<c031e588>] (dump_stack) from [<c010e238>]
> >> >> >>>>> > (handle_IPI+0xe0/0x16c)=E2=90=8D=E2=90=8A
> >> >> >>>>> > [16:06:08:263]  r7:00000004 r6:00000000 r5:c0a03608
> >> >> >>>>> > r4:c094b51c=E2=90=8D=E2=90=8A
> >> >> >>>>> > [16:06:08:263] [<c010e158>] (handle_IPI) from [<c010e2f0>]
> >> >> >>>>> > (__ipipe_do_IPI+0x2c/0x38)=E2=90=8D=E2=90=8A
> >> >> >>>>> > [16:06:08:279]  r10:c0a40ac0 r9:dfbd080c r8:dfbd0810
> >> >> >>>>> > r7:dfbd0818
> >> >> >>>>> > r6:c0a50c00 r5:00000404=E2=90=8D=E2=90=8A
> >> >> >>>>> > [16:06:08:279]  r4:c094ab4c=E2=90=8D=E2=90=8A
> >> >> >>>>> > [16:06:08:279] [<c010e2c4>] (__ipipe_do_IPI) from
> [<c018bcf8>]
> >> >> >>>>> > (__ipipe_do_sync_stage+0x224/0x268)=E2=90=8D=E2=90=8A
> >> >> >>>>> > [16:06:08:295]  r5:c0a40b00 r4:00000404=E2=90=8D=E2=90=8A
> >> >> >>>>> > [16:06:08:295] [<c018bad4>] (__ipipe_do_sync_stage) from
> >> >> >>>>> > [<c018be40>]
> >> >> >>>>> > (ipipe_unstall_root+0x40/0x50)=E2=90=8D=E2=90=8A
> >> >> >>>>> > [16:06:08:295]  r10:00000000 r9:c094c5bc r8:00000001
> >> >> >>>>> > r7:c0a0346c
> >> >> >>>>> > r6:c0a00000 r5:c0a269cc=E2=90=8D=E2=90=8A
> >> >> >>>>> > [16:06:08:311]  r4:c0948808=E2=90=8D=E2=90=8A
> >> >> >>>>> > [16:06:08:311] [<c018be00>] (ipipe_unstall_root) from
> >> >> >>>>> > [<c0152464>]
> >> >> >>>>> > (cpu_startup_entry+0x144/0x1d4)=E2=90=8D=E2=90=8A
> >> >> >>>>> > [16:06:08:311]  r4:dfbd45c0=E2=90=8D=E2=90=8A
> >> >> >>>>> > [16:06:08:311] [<c0152320>] (cpu_startup_entry) from
> >> >> >>>>> > [<c064fec8>]
> >> >> >>>>> > (rest_init+0x78/0x90)=E2=90=8D=E2=90=8A
> >> >> >>>>> > [16:06:08:327]  r7:c0a03440=E2=90=8D=E2=90=8A
> >> >> >>>>> > [16:06:08:327] [<c064fe50>] (rest_init) from [<c0900c74>]
> >> >> >>>>> > (start_kernel+0x308/0x368)=E2=90=8D=E2=90=8A
> >> >> >>>>> > [16:06:08:327]  r4:c0a30bcc=E2=90=8D=E2=90=8A
> >> >> >>>>> > [16:06:08:327] [<c090096c>] (start_kernel) from [<0000807c>=
]
> >> >> >>>>> > (0x807c)=E2=90=8D=E2=90=8A
> >> >> >>>>> > [16:06:08:343] ---[ end Kernel panic - not syncing: Attempt=
ed
> >> >> >>>>> > to
> >> >> >>>>> > kill
> >> >> >>>>> > init!
> >> >> >>>>> > exitcode=3D0x00000100=E2=90=8D=E2=90=8A
> >> >> >>>>> > --------------------------------------------
> >> >> >>>>> >
> >> >> >>>>> > What sould I do to solve the issue?
> >> >> >>>>> > Thanks in advance.
> >> >> >>>>> >
> >> >> >>>>> >
> >> >> >>>>> >
> >> >> >>>>> > --
> >> >> >>>>> > Saluti,
> >> >> >>>>> > Salvatore Barone
> >> >> >>>>> > _______________________________________________
> >> >> >>>>> > Xenomai mailing list
> >> >> >>>>> > Xenomai@xenomai.org
> >> >> >>>>> > https://xenomai.org/mailman/listinfo/xenomai
> >> >> >>>
> >> >> >>>
> >> >> >>>
> >> >> >>>
> >> >> >>> --
> >> >> >>> Saluti,
> >> >> >>> Salvatore Barone
> >> >> >>
> >> >> >>
> >> >> >
> >> >> >
> >> >> >
> >> >> > --
> >> >> > Saluti,
> >> >> > Salvatore Barone
> >> >
> >> >
> >> >
> >> >
> >> > --
> >> > Saluti,
> >> > Salvatore Barone
> >
> >
> >
> >
> > --
> > Saluti,
> > Salvatore Barone
>



--=20
Saluti,
Salvatore Barone
