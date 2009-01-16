Content-Disposition: inline
From: BERRUER =?iso-8859-1?q?S=E9bastien?= <sebastien.berruer@domain.hid>
Date: Fri, 16 Jan 2009 21:02:16 +0100
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Message-Id: <200901162102.16706.sebastien.berruer@domain.hid>
Subject: Re: [Xenomai-help] Xenomai on Gumstix
Reply-To: sebastien.berruer@domain.hid
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

Hello,

I finally find a way to make it works. You showed me the way:
>my bitbake recipe does have a few modifications to auto-patch adeos into t=
he=20
kernel
I've add only one line to my recipe for the kernel (~/gumstix/gumstix-
oe/user.collection/packages/linux/gumstix-kernel_2.6.24.bb). After all the=
=20
require files and specifics patchs, I've add:
file://adeos-ipipe-2.6.24-arm-1.9-01.patch; patch=3D1

That patch file come directly from Xenomai 2.4.3=20
(Xenomai-2.4.3/ksrc/arch/arm/patches/). I've made a local copy of it in the=
=20
specific kernel directory=20
(~/gumstix/gumstixoe/use.collection/packages/linux/gumstix-kernel-2.6.24/).=
=20
Then, I only ran:
bitbake gumstix-kernel -c rebuild
To produce the uImage.

When I ran bitbake the first time to get the sources, I ran the previous=20
command (Yes, I only focus now that it wasn't the right thing to do). There=
=20
was a complete compilation on this source code. Only after that, I applied =
the=20
Xenomai patch. So, when I compiled again, I suppose there would have been s=
ome=20
object code that would not be compile again. So, those parts would never kn=
ow=20
the existance of Adeos. It's probably that which gave me an error.

Now, Adeos works ! I have to see what will append with the Xenomai=20
userspace...

Really great thanks !

Regards,


Le vendredi 16 janvier 2009 17:57:40 Felipe Brand=E3o Cavalcanti, vous avez=
=20
=E9crit :
> On Fri, Jan 16, 2009 at 11:42 AM, <Sebastien.Berruer@domain.hid>wro=
te:
> > Hello,
> >
> > KERNEL VERSIONING
> >
> > > I've patched the kernel with Adeos. I followed the instruction of
> > >
> >> > Xenomai 2.4.3 for a linux kernel 2.6.24.
> >>
> >> Please use the latest version from the 2.4 (stable) branch: Xenomai
> >> 2.4.6.1.
> >
> > I've tried to update from the repository using:
> >
> > svn update
> >
> > But, I still have only kernel minor versions 21, 22, 24 of kernel 2.6.
> > (NOTE: letting svn using the content of .svn/ to find the repository
> > or typing the complete address does the same)
> > Then, I've tried to list the repository with:
> >
> > svn list
> >
> > There is still the same directory structure, so it's logical nothing
> > append. I'm ready to use the patch 2.6.26 from Xenomai 2.4.6.1, but I
> > need to be able to download the sources of the corresponding kernel.
> > May I not looking for at the right place ? May I do my own recipe ?
>
> I grabbed the latest Adeos patch from their website:
> http://home.gna.org/adeos/
> (actually, http://download.gna.org/adeos/patches/v2.6/arm/older/)
> I chose the appropriate architecture and kernel version and used it by
> passing an extra argument to the ./prepare-kernel script so that it would
> use the apropriate version of the adeos patch. I don't remember it off the
> top of my head, however a --help in the script should point you in the
> right direction.
>
> > KERNEL COMPILATION
> >
> >
> >  After getting everything set up (including the removal of several
> > features
> >
> >> witch you might not really need - the kernel needs to be less than 1
> >> Mb)[...]
> >
> > (NOTE: I've done my changes from the original copy of the kernel)
> > I've tried to remove the device drivers for USB using the menuconfig:
> >
> > bitbake -c menuconfig gumstix-kernel
> >
> > Then, I still have done the manual patch for Xenomai and copied the
> > .config over the defconfig.
> > (NOTE: It would not change anything to patch first and then removing
> > the USB drivers using the menuconfig (?) Furthermore, doing the copy ov=
er
> > defconfig, I write definitively the default defconfig)
>
> This should be fine - the important part is that the kernel is properly
> configured (i.e., Gumstix selected as the target machine, etc..) and that
> the xenomai options are properly configured as well (there should be a
> whole section for xenomai and real-time options).
>
> > I force the compilation:
> >
> > bitbake -f -c compile gumstix-kernel
> >
> > I saw that Adeos doesn't work in the final kernel. During the boot in
> > simulation with Qemu, I've got this kind of messages:
> >
> > [...]
> > <4>smc91x: Unknown symbol __ipipe_unstall_root
> > <4>smc91x: Unknown symbol __ipipe_root_status
> > <4>smc91x: Unknown symbol __ipipe_restore_root
> > <4>smc911x: Unknown symbol __ipipe_root_status
> > <4>smc911x: Unknown symbol __ipipe_restore_root
> > <4>evdev: Unknown symbol __ipipe_unstall_root
> > <4>evdev: Unknown symbol __ipipe_root_status
> > <4>mmc_core: Unknown symbol __ipipe_root_status
> > <4>mmc_core: Unknown symbol __ipipe_restore_root
> > <4>mmc_block: Unknown symbol __ipipe_unstall_root
> > <4>mmc_block: Unknown symbol __ipipe_root_status
> > [...]
> >
> > I'm disappointed and I'm asking myself if don't need to add something to
> > the recipe that manage the modules (i.e task-base-gumstix) ?
> >
> > Regards,
>
> Well, try to patch it with the other version of Adeos. I never really
> worked with Qemu, so I am not sure where the problem might be. I always
> generate a new image for my gumstix (using the bitbake gumstix-basic-image
> -c rebuild command,
> as well as rebuilding task-base-gumstix) and flash it in order to do the
> testing - however, Adeos is loaded way before any modules, so I doubt that
> it has anything to do with that.
>
> Anyway, try this out - if everything goes wrong, I can send you my own
> kernel for testing, and I can take a quick look at your .config files to
> see if there is anything wrong.
>
> Hope this helps,
>       -Felipe Brand=E3o Cavalcanti
>       LARA - Laboratory of Robotics and Automation
>       Department of Electrical Engineering
>       UnB - University of Bras=EDlia, Brazil
>       http://www.lara.unb.br/
>
> PS: Don't forget to send the messages to the list!
>
> Felipe Brand=E3o Cavalcanti <cavalkaf@domain.hid> a =E9crit :
> >  Well, I did have a few issues with the initial kernel config - what I
> > did
> >
> >> to
> >> get the kernel working was to copy the original (i.e., the one that ca=
me
> >> with the Gumstix) defconfig file to the working directory (IIRC,
> >> ~/gumstix/gumstix-oe/tmp/work/....) as .config BEFORE running the
> >> command bitbake -c menuconfig gumstix-kernel. This will give you the
> >> default gumstix
> >> config to start off the kernel customization procedure.
> >> After getting everything set up (including the removal of several
> >> features witch you might not really need - the kernel needs to be less
> >> than 1 Mb), I
> >> copied the new .config over to the defconfig file. Than I just went on
> >> to compile the kernel as usual (however, my bitbake recipe does have a
> >> few modifications to auto-patch adeos into the kernel).
> >>
> >> BTW, keep in mind that you also need to install the xenomai userspace
> >> packages, that will take up around 7 Mb in your system.
> >>
> >> I will be happy to help if you have any other specific questions - I
> >> have a
> >> fully custom gumstix distribution with Xenomai (it is a work in
> >> progress, but it does seem to work fine at the moment), with a working
> >> kernel and xenomai packages (stripped-out, no documentation, etc...) I
> >> would also be happy to receive any interesting info on this area (any
> >> new solutions, etc)
> >> - not many people seem to be using the gumstix platform for
> >> real-time purposes, but it seems like an excellent choice. I do plan on
> >> organizing all of this information sooner or later on a webpage (the
> >> last step of my project involves porting the OROCOS plataform over to
> >> the XScale
> >> processor, and than getting it working on the gumstix - after thats
> >> done, I
> >> will document the entire process).
> >>
> >> Hope this helps!
> >>        -Felipe Brand=E3o Cavalcanti
> >>        LARA - Laboratory of Robotics and Automation
> >>        Department of Electrical Engineering
> >>        UnB - University of Bras=EDlia, Brazil
> >>        http://www.lara.unb.br/
> >>
> >> On Mon, Jan 12, 2009 at 8:14 AM, Gilles Chanteperdrix <
> >> gilles.chanteperdrix@xenomai.org> wrote:
> >>
> >>  Sebastien.Berruer@domain.hid wrote:
> >>> > Hi,
> >>> >
> >>> > I'm a student and I work on a project to get Xenomai running on a
> >>> > gumstix platform. I'm using a Verdex board and OpenEmbedded as my
> >>> > development environment. Prior to re-flashing the board, I'm testing
> >>> > the RAM image with Qemu.
> >>> >
> >>> > I've patched the kernel with Adeos. I followed the instruction of
> >>> > Xenomai 2.4.3 for a linux kernel 2.6.24.
> >>>
> >>> Please use the latest version from the 2.4 (stable) branch: Xenomai
> >>> 2.4.6.1.
> >>>
> >>> > I've been careful to run the command :
> >>> > bitbake gumstix-kernel -c menuconfig
> >>> > to force the copy of
> >>>
> >>> ~/gumstix/gumstix-oe/tmp/work/gumstix-custom-verdex-angstrom-linux-gn=
ue
> >>>abi/gumstix-kernel-2.6.24-r1/linux-2.6.24/.config
> >>>
> >>> > to
> >>>
> >>> ~/gumstix/gumstix-oe/user.collection/packages/linux/gumstix-kernel-2.=
6.
> >>>24/gumstix-custom-verdex/defconfig
> >>>
> >>> > Then, I tried to recompile the kernel source code (without that
> >>> > bitbake unpacked the archive of the previous version)
> >>> > bitbake gumstix-kernel -f -c compile
> >>> >
> >>> > And create the new images
> >>> > bitbake task-base-gumstix -c rebuild
> >>> > bitbake gumstix-basic-image -c rebuild
> >>> >
> >>> > I've made an image of RAM with the dd command to run in Qemu. But,
> >>> > when I'm trying to boot this image, the boot stop and said me :
> >>> > Copying kernel to 0xa2000000 from 0x01f00000 (length
> >>> > 0x00100000)...done ## Booting image at a2000000 ...
> >>> >      Image Name:   Angstrom/2.6.24/gumstix-custom-v
> >>> >      Image Type:   ARM Linux Kernel Image (uncompressed)
> >>> >      Data Size:    1124960 Bytes =3D  1.1 MB
> >>> >      Load Address: a0008000
> >>> >      Entry Point:  a0008000
> >>> > OK
> >>> >
> >>> > Starting kernel ...
> >>> >
> >>> > ran out of input data
> >>>
> >>> It looks like a memory layout issue, such as the bootloader not copyi=
ng
> >>> the kernel completely, or the places where the kernel is copied
> >>> overlapping with something else like an initrd.
> >>>
> >>>
> >>> --
> >>>                                                 Gilles.
> >>>
> >>> _______________________________________________
> >>> Xenomai-help mailing list
> >>> Xenomai-help@domain.hid
> >>> https://mail.gna.org/listinfo/xenomai-help
> >>>
> > |=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D|
> > | BERRUER S=E9bastien        |                                  |
> > | 2 rue du Vieil Armand    | Tel : 06-76-35-29-55             |
> > | Studio 112               | Email : sberruer@domain.hid     |
> > | 67100 STRASBOURG         |                                  |
> > |=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D|

