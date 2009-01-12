Message-ID: <496B1807.8090600@domain.hid>
Date: Mon, 12 Jan 2009 10:14:31 +0000
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <20090112110445.gupikke2o4o40kko@domain.hid>
In-Reply-To: <20090112110445.gupikke2o4o40kko@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Xenomai on Gumstix
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Sebastien.Berruer@domain.hid
Cc: xenomai@xenomai.org

Sebastien.Berruer@domain.hid wrote:
> Hi,
> 
> I'm a student and I work on a project to get Xenomai running on a
> gumstix platform. I'm using a Verdex board and OpenEmbedded as my
> development environment. Prior to re-flashing the board, I'm testing
> the RAM image with Qemu.
> 
> I've patched the kernel with Adeos. I followed the instruction of
> Xenomai 2.4.3 for a linux kernel 2.6.24.

Please use the latest version from the 2.4 (stable) branch: Xenomai 2.4.6.1.

> 
> I've been careful to run the command :
> bitbake gumstix-kernel -c menuconfig
> to force the copy of
> ~/gumstix/gumstix-oe/tmp/work/gumstix-custom-verdex-angstrom-linux-gnueabi/gumstix-kernel-2.6.24-r1/linux-2.6.24/.config
> to
> ~/gumstix/gumstix-oe/user.collection/packages/linux/gumstix-kernel-2.6.24/gumstix-custom-verdex/defconfig
> 
> Then, I tried to recompile the kernel source code (without that
> bitbake unpacked the archive of the previous version)
> bitbake gumstix-kernel -f -c compile
> 
> And create the new images
> bitbake task-base-gumstix -c rebuild
> bitbake gumstix-basic-image -c rebuild
> 
> I've made an image of RAM with the dd command to run in Qemu. But,
> when I'm trying to boot this image, the boot stop and said me :
> Copying kernel to 0xa2000000 from 0x01f00000 (length 0x00100000)...done
> ## Booting image at a2000000 ...
>      Image Name:   Angstrom/2.6.24/gumstix-custom-v
>      Image Type:   ARM Linux Kernel Image (uncompressed)
>      Data Size:    1124960 Bytes =  1.1 MB
>      Load Address: a0008000
>      Entry Point:  a0008000
> OK
> 
> Starting kernel ...
> 
> ran out of input data

It looks like a memory layout issue, such as the bootloader not copying
the kernel completely, or the places where the kernel is copied
overlapping with something else like an initrd.


-- 
                                                 Gilles.

