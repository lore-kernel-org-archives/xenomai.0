Message-ID: <458B8D26.4030407@domain.hid>
Date: Fri, 22 Dec 2006 08:45:42 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Patches: README.install & examples/common for
	cross-compiling
References: <200612212259.06016.niklaus.giger@domain.hid>
In-Reply-To: <200612212259.06016.niklaus.giger@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: niklaus.giger@domain.hid
Cc: xenomai@xenomai.org

Hi Niklaus,

Niklaus Giger wrote:
> Hi
> 
> After switching my development environment to a MacMini and using the ELDK 4.0 
> I discovered that my examples for building using a cross-compiler for my 
> PPC405 target were not correct. (Maybe a few of my previous problems were 
> caused by not correctly specifying the target ARCH.)
> 
> Also I would like to adapt and document the examples/common/Makefile to the 
> needs for cross-compiling (KSRC/XENOCONFIG/DESTDIR useage). Also I added a 
> target "install" to copy the generated application to $(DESTDIR)/usr/xenomai.

Hm, I don't have examples/common/Makefile in my SVN Xenomai tree. And 
/usr/xenomai should be the configurable.

> Could someone please commit these (or a improved version of it) patches?

> Thanks in advance
> 
> 
> 
> ------------------------------------------------------------------------
> 
> Index: examples/common/Makefile
> ===================================================================
> --- examples/common/Makefile	(Revision 1970)
> +++ examples/common/Makefile	(Arbeitskopie)
> @@ -3,9 +3,9 @@
>  ### List of applications to be build
>  APPLICATIONS = hw_direct_io
>  
> -### Note: to override the search path for the xeno-config script, use "make XENO=..."
> +### Note: to override the search path for the xeno-config script, use "make XENOCONFIG=..."
> +### Note: if you installed it into a non standard place add DESTDIR=/path/to/installed/xenomai"
>  
> -
>  ### List of modules to be build
>  MODULES =
>  
> @@ -24,7 +24,9 @@
>  ### Sanity check
>  ifeq ($(XENOCONFIG),)
>  all::
> -	@echo ">>> Invoke make like this: \"make XENO=/path/to/xeno-config\" <<<"
> +	@echo ">>> Invoke make like this: \"make XENOCONFIG=/path/to/xeno-config\" <<<"
> +	@echo ">>> add KSRC=.. to override the default kernel source at /lib/modules/$(shell uname -r)/build <<<"
> +	@echo ">>> add DESTDIR=/path/to/installed/xenomai if you installed it into a non standard place <<<"
>  	@echo
>  endif
>  
> @@ -40,6 +42,9 @@
>  clean::
>  	$(RM) $(APPLICATIONS) *.o
>  
> +install:   $(APPLICATIONS)
> +	cp $(APPLICATIONS) $(DESTDIR)/usr/xenomai/bin
> +
>  endif
>  
>  
> @@ -80,3 +85,4 @@
>  	$(RM) -R .tmp*
>  
>  endif
> +
> 
> 
> ------------------------------------------------------------------------
> 
> Index: README.INSTALL
> ===================================================================
> --- README.INSTALL	(Revision 1957)
> +++ README.INSTALL	(Arbeitskopie)
> @@ -276,19 +276,20 @@
>  -----------------------------------------
>  
>  A typical cross-compilation setup, in order to build Xenomai for a
> -PowerPC-405-based system:
> +PowerPC-405-based system (assuming an ELDK cross-compiler and a 2.6.14 kernel)
>  
>  $ $xenomai_root/scripts/prepare-kernel.sh --arch=powerpc \
>    --adeos=$xenomai_root/ksrc/arch/powerpc/patches/adeos-ipipe-2.6.14-ppc-X.Y-ZZ.patch \
>    --linux=$linux_tree

For the time beeing, we must distinguish between --arch=ppc (ARCH=ppc) 
and --arch=powerpc (ARCH=powerpc). The latter is not yet supported.

>  $ cd $linux_tree
> -$ mkdir ../build-powerpc-405-2.6.14
> -$ make ARCH=ppc CROSS_COMPILE=powerpc-405-linux-gnu- O=../build-powerpc-405-2.6.14 xconfig/gconfig/menuconfig 

For the ELDK CROSS_COMPILE must be ppc_4xx- for AMCC 4xx processors.

> +$ build_root /path/to/build-powerpc-405-2.6.14
> +$ mkdir $build_root
> +$ make ARCH=ppc CROSS_COMPILE=powerpc-405-linux-gnu- O=$build_root xconfig/gconfig/menuconfig 
>  # select the kernel and Xenomai options
> -$ make ARCH=ppc CROSS_COMPILE=powerpc-405-linux-gnu- O=../build-powerpc-405-2.6.14 bzImage modules 
> +$ make ARCH=ppc CROSS_COMPILE=powerpc-405-linux-gnu- O=$build_root bzImage modules 
>  # then install as needed
> -$ mkdir $build_root && cd $build_root
> -$ $xenomai_root/configure --build=i686-linux --host=powerpc-405-linux-gnu
> +$ cd $build_root
> +$ $xenomai_root/configure --build=i686-linux --host=powerpc-405-linux-gnu CC=ppc_4xx-gcc CXX=ppc_4xx-g++ LD=ppc_4xx-ld

    $ $xenomai_root/configure --host=ppc-linux

    already works fine for all ELDK tool chains. The --prefix should also
    be configurable.

>  $ make install
>  
>  2.3 Building for the IPF
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core


