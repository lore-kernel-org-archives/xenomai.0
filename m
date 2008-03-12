Message-ID: <2ff1a98a0803120336r7906e4f5kad3329925a7aa4ad@domain.hid>
Date: Wed, 12 Mar 2008 11:36:16 +0100
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <47D7AEDD.90605@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <47D65A87.3020004@domain.hid>
	<18391.3778.511531.87742@domain.hid>
	<47D7AEDD.90605@domain.hid>
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

On Wed, Mar 12, 2008 at 11:22 AM, Wolfgang Grandegger <wg@domain.hid> wrote:
>
> Gilles Chanteperdrix wrote:
>  > Wolfgang Grandegger wrote:
>  >  > Hello,
>  >  >
>  >  > I tried to test the POSIX example program satch.c under Linux 2.4.25 for
>  >  > PPC. I was able to fix a few issues but the module does still not load.
>  >  > I have attached a patch for Xenomai 2.4.2 fixing:
>  >  >
>  >  > - User-space satch: It was necessary to move time.h and signal.h to the
>  >  >   end of the include block to get it compiled (otherwise clockid_t is
>  >  >   defined, etc.)
>  >  >
>  >  > - User-space satch: It was necessary to move "#define xnprintf printf"
>  >  >   behind the include block, otherwise the linker complains about missing
>  >  >   symbols. I wonder how this can work with 2.6. And what is the status
>  >  >   of xnprintf?
>  >  >
>  >  > - Makefile: to avoid a mixup of CFLAG definitions for compiling the
>  >  >   user-space and kernel-space part, I renamed CFLAGS to UCFLAGS etc.
>  >  >   (see patch). Note sure if this is an issue for 2.6 as well.
>  >  >
>  >  > - Makefile: I added -DPRODUCER to the module build with Linux 2.4.
>  >  >
>  >  > - I got the module build, but insmod fails with:
>  >  >
>  >  >   bash-2.05b# insmod satch.o
>  >  >   satch.o: unresolved symbol shm_unlink
>  >  >   satch.o: unresolved symbol ftruncate
>  >  >   satch.o: unresolved symbol shm_open
>  >  >   satch.o: unresolved symbol munmap
>  >  >   satch.o: unresolved symbol mmap
>  >  >   satch.o: unresolved symbol pse51_shm_close
>  >  >
>  >  >   Any idea why?
>  >  >
>  >  > Thanks,
>  >
>  > Does the following patch improve anything ?
>
>  Yes, the order of the include files does not make trouble any more.
>  Nevertheless, I need the attached patch to fix the remaining problems
>  with CFLAGS mangling and missing -DPRODUCER.

Do we really need the UCFLAGS stuff ? CFLAGS is a standard thing, how
do the other examples cope with the same problem ? Perhaps  we could
put modules compilation in a separated makefile name Kbuild ?

-- 
 Gilles Chanteperdrix

