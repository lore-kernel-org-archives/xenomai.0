Message-ID: <43C0EF40.6090501@domain.hid>
Date: Sun, 08 Jan 2006 11:53:52 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Two patches for the documentation
References: <200601072103.32588.niklaus.giger@domain.hid>
In-Reply-To: <200601072103.32588.niklaus.giger@domain.hid>
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
Cc: xenomai-core <xenomai@xenomai.org>

Niklaus Giger wrote:
> Hi
> 
> xeno.sim.patch contains some clarification on how to build the xenoscope. (GCC 
> 3.4 worked for me on a x86 system, but with a lot of warnings, that fwritable 
> is deprecated)
> 
> xeno.patch is a shorter way how to cross-compile using the CROSS_COMPILE 
> variable. It worked for me without any problems for my board.
> Also contains a hint to use O=../a-build-dir to compile the linux kernel.
> 
> Best regards
> 
> 
> 
> ------------------------------------------------------------------------
> 
> Index: README.INSTALL
> ===================================================================
> --- README.INSTALL	(Revision 392)
> +++ README.INSTALL	(Arbeitskopie)
> @@ -150,20 +150,22 @@
>  needed, but if you do not use it, configure emit a warning, which may be
>  confusing.
>  
> +The easiest way to build a GNU cross-compiler might involve using Dan Kegel 
> +crosstools found at http://kegel.com/crosstool.
> +
>  Since cross-compiling requires specific tools, such tools are generally prefixed
>  with the host architecture name; for example, a compiler for the power PC
> -architecture may be named powerpc-linux-gcc.
> +architecture may be named powerpc-405-linux-gnu-gcc.
>  
> -When this prefix contains the name of the architecture, you may pass this prefix
> -to the --host option of configure. For example, if you type :
> -configure --host=powerpc-linux
> -
> -configure will automatically use powerpc-linux- as a prefix too all compilation
> +configure will automatically use powerpc-405-linux-gnu- as a prefix too all compilation
>  tools names and deduce the architecture name. If configure is unable to deduce
>  the architecture name from this prefix, you will have to manually pass the name
>  of all compilation tools on configure command line. As in:
>  
> -configure --build=i686-pc-linux-gnu --host=powerpc-unknown-linux-gnu CC=ppc_82xx-gcc CXX=ppc_82xx-gcc AR=ppc_82xx-ar LD=ppc_82xx-ld
> +It might be a good idea to put all the output into a differen build directory
> +as to build from from linux source several targets. For each target add 
> +O=../build-<target> to each make invocation.
> +configure CROSS_COMPILE=powerpc-405-linux-gnu-
>  
>  For more details:
>  http://sourceware.org/autobook/autobook/autobook_264.html#SEC264
> @@ -204,16 +206,18 @@
>  2.2 Building for the PowerPC architecture
>  
>  A typical cross-compilation setup, in order to build Xenomai for a
> -82xx-based system:
> +PowerPC-405-based system:
>  
>  $ $xenomai_root/scripts/prepare-kernel.sh --arch=powerpc \
>    --adeos=$xenomai_root/ksrc/arch/powerpc/patches/adeos-ipipe-2.6.14-ppc-X.Y-ZZ.patch \
>    --linux=$linux_tree
>  $ cd $linux_tree
> -$ make xconfig/gconfig/menuconfig # select the kernel and Xenomai options
> -$ make bzImage modules # then install as needed
> +$ make CROSS_COMPILE=powerpc-405-linux-gnu- O=../build-powerpc-405-2.6.14 xconfig/gconfig/menuconfig 
> +# select the kernel and Xenomai options
> +$ make CROSS_COMPILE=powerpc-405-linux-gnu- O=../build-powerpc-405-2.6.14 bzImage modules 
> +# then install as needed
>  $ mkdir $build_root && cd $build_root
> -$ $xenomai_root/configure --build=i686-pc-linux-gnu --host=powerpc-unknown-linux-gnu CC=ppc_82xx-gcc CXX=ppc_82xx-gcc AR=ppc_82xx-ar LD=ppc_82xx-ld
> +$ $xenomai_root/configure CROSS_COMPILE=powerpc-405-linux-gnu-
>  $ make install
>  
>  2.3 Building for the IPF
> 

Applied, thanks.

> 
> ------------------------------------------------------------------------
> 
> Index: sim/README
> ===================================================================
> --- sim/README	(Revision 392)
> +++ sim/README	(Arbeitskopie)
> @@ -28,7 +28,11 @@
>  Building the simulator
>  ======================
>  
> -You will need the libelf, libpng, tcl8.x/tk8.x and tix41 _development
> +The simulator does not build with GCC 4.0 or later.
> +
> +Currently it does not work on PowerPC systems.
> +

Why?

> +You will need the libelf, libpng, tcl8.x/tk8.x and tix81 _development
>  packages_ in order to build the simulator and its companion tools.
>  For instance, on Debian systems, you will need to install
>  libelfg0-dev, libpng2-dev, tcl8.3-dev, tk8.3-dev and tix41-dev (any
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core


-- 

Philippe.

