From: Leopold Palomo-Avellaneda <leo@domain.hid>
Date: Thu, 29 Oct 2009 11:05:05 +0100
References: <200910281314.00378.leo@domain.hid> <4AE85EE2.60209@domain.hid>
In-Reply-To: <4AE85EE2.60209@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200910291105.05820.leo@domain.hid>
Subject: Re: [Xenomai-help] Xenomai patches
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Stefan Kisdaroczi <kisda@domain.hid>
Cc: xenomai@xenomai.org

Hi Stefan,

first of all thanks for the guide. I knew more or less all the steps, but you 
have helped me a lot.

[...]

> Try to modify the line starting with KVERSION=... in the file
> /usr/src/kernel-patches/$ARCH/apply/xenomai
> Replace the 4 digit version numbers with 3 digits.

Ok, good to know. This is in same line as Gilles Chanteperdrix mail.

[...]
>
> 4) repack the archive (*tar.bz2 -> *orig.tar.gz):
> ~/src/xenomai$ bzcat xenomai-2.4.7.tar.bz2 | gzip >
> xenomai_2.4.7.orig.tar.gz && rm xenomai-2.4.7.tar.bz2

I don't think that this is necessary. At last I didn't need it.

> 5) extract the archive:
> ~/src/xenomai$ tar -zxf xenomai_2.4.7.orig.tar.gz
>
> 6) change dir:
> ~/src/xenomai$ cd xenomai-2.4.7/
>
> 7) update debian/changelog:
> ~/src/xenomai/xenomai-2.4.7$ debchange -v 2.4.7-0 Release 2.4.7

I did it with dch -i . Both are valid.

>
> 8) build:
> ~/src/xenomai/xenomai-2.4.7$ debuild

it builds the tar.orig.gz

[...]

>
> 6) patch the kernel with xenomai:
> ~/src/linux/linux-2.6.28.7$ /usr/src/kernel-patches/i386/apply/xenomai
>
> 7) configure the kernel:
> [optional] copy a kernel config to .config and run "make oldconfig"
> [/optional] ~/src/linux/linux-2.6.28.7$ make menuconfig
>
> 8) compile the kernel with make-kpkg:
> ~/src/linux/linux-2.6.28.7$ fakeroot make-kpkg --initrd --append-to-version
> -xenomai-2.4.7 --revision 1.0 binary-arch

you can do it alltogether with:

fakeroot make-kpkg --initrd --added-patches xenomai --config 
menuconfig --append-to-version "-xenomai-2.4.10" -revision 1.0 binary-arch

also, instead of binary-arch, with kernel_image kernel_headers it's ok.


> if you have a multicore box, use CONCURRENCY_LEVEL= to speed up the build:
> ~/src/linux/linux-2.6.28.7$ CONCURRENCY_LEVEL=2 fakeroot make-kpkg --initrd
> --append-to-version -xenomai-2.4.7 --revision 1.0 binary-arch


FANTASTIC!!!!

the CONCURRENCY_LEVEL it's great. I didn't know it!!! thanks a lot.

OTOH, the debian package has a bug. I cannot compile xenomai, using the debian 
way on kernels 2.6.28, 2.6.29 and 2.6.30 because the package add something 
that fails with make menuconfig. I should write a bug. Just for information, 
it's not a xenomai upstream related question. ;-)

Thanks for all,

Best regards,

Leo

