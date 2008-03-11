Message-ID: <2ff1a98a0803110325w5f497596tb7206095aa211a65@domain.hid>
Date: Tue, 11 Mar 2008 11:25:35 +0100
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <47D65A87.3020004@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <47D65A87.3020004@domain.hid>
Subject: Re: [Xenomai-core] Problems with satch.c under Linux 2.4
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Wolfgang Grandegger <wg@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

On Tue, Mar 11, 2008 at 11:10 AM, Wolfgang Grandegger <wg@domain.hid> wrote:
> Hello,
>
>  I tried to test the POSIX example program satch.c under Linux 2.4.25 for
>  PPC. I was able to fix a few issues but the module does still not load.
>  I have attached a patch for Xenomai 2.4.2 fixing:
>
>  - User-space satch: It was necessary to move time.h and signal.h to the
>   end of the include block to get it compiled (otherwise clockid_t is
>   defined, etc.)

This should not happen, header file should not depend on the inclusion order.

>
>  - User-space satch: It was necessary to move "#define xnprintf printf"
>   behind the include block, otherwise the linker complains about missing
>   symbols. I wonder how this can work with 2.6. And what is the status
>   of xnprintf?
>
>  - Makefile: to avoid a mixup of CFLAG definitions for compiling the
>   user-space and kernel-space part, I renamed CFLAGS to UCFLAGS etc.
>   (see patch). Note sure if this is an issue for 2.6 as well.
>
>  - Makefile: I added -DPRODUCER to the module build with Linux 2.4.

I tested satch recently on trunk. I had to make the printf change
(xnprintf is now defined in xenomai include files to xnarch_printf,
but xnarch_printf is not defined when compiling in user space, so I
replaced #define xnprintf printf with #define xnarch_printf printf) to
make it work again, but I saw no problem with include file order.

>
>  - I got the module build, but insmod fails with:
>
>   bash-2.05b# insmod satch.o
>   satch.o: unresolved symbol shm_unlink
>   satch.o: unresolved symbol ftruncate
>   satch.o: unresolved symbol shm_open
>   satch.o: unresolved symbol munmap
>   satch.o: unresolved symbol mmap
>   satch.o: unresolved symbol pse51_shm_close
>
>   Any idea why?

Because satch uses xenomai posix shared memories, so you have to
enable support for shared memories in the posix module configuration.

>
>  Thanks,
>
>  Wolfgang.
>
>
>
> _______________________________________________
>  Xenomai-core mailing list
>  Xenomai-core@domain.hid
>  https://mail.gna.org/listinfo/xenomai-core
>
>



-- 
 Gilles Chanteperdrix

