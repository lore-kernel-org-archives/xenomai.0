Message-ID: <47D7C855.7060007@domain.hid>
Date: Wed, 12 Mar 2008 13:11:01 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <47D65A87.3020004@domain.hid>	
	<18391.3778.511531.87742@domain.hid>	
	<47D7AEDD.90605@domain.hid>
	<2ff1a98a0803120336r7906e4f5kad3329925a7aa4ad@domain.hid>
In-Reply-To: <2ff1a98a0803120336r7906e4f5kad3329925a7aa4ad@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

Gilles Chanteperdrix wrote:
> On Wed, Mar 12, 2008 at 11:22 AM, Wolfgang Grandegger <wg@domain.hid> wrote:
>> Gilles Chanteperdrix wrote:
>>  > Wolfgang Grandegger wrote:
>>  >  > Hello,
>>  >  >
>>  >  > I tried to test the POSIX example program satch.c under Linux 2.4.25 for
>>  >  > PPC. I was able to fix a few issues but the module does still not load.
>>  >  > I have attached a patch for Xenomai 2.4.2 fixing:
>>  >  >
>>  >  > - User-space satch: It was necessary to move time.h and signal.h to the
>>  >  >   end of the include block to get it compiled (otherwise clockid_t is
>>  >  >   defined, etc.)
>>  >  >
>>  >  > - User-space satch: It was necessary to move "#define xnprintf printf"
>>  >  >   behind the include block, otherwise the linker complains about missing
>>  >  >   symbols. I wonder how this can work with 2.6. And what is the status
>>  >  >   of xnprintf?
>>  >  >
>>  >  > - Makefile: to avoid a mixup of CFLAG definitions for compiling the
>>  >  >   user-space and kernel-space part, I renamed CFLAGS to UCFLAGS etc.
>>  >  >   (see patch). Note sure if this is an issue for 2.6 as well.
>>  >  >
>>  >  > - Makefile: I added -DPRODUCER to the module build with Linux 2.4.
>>  >  >
>>  >  > - I got the module build, but insmod fails with:
>>  >  >
>>  >  >   bash-2.05b# insmod satch.o
>>  >  >   satch.o: unresolved symbol shm_unlink
>>  >  >   satch.o: unresolved symbol ftruncate
>>  >  >   satch.o: unresolved symbol shm_open
>>  >  >   satch.o: unresolved symbol munmap
>>  >  >   satch.o: unresolved symbol mmap
>>  >  >   satch.o: unresolved symbol pse51_shm_close
>>  >  >
>>  >  >   Any idea why?
>>  >  >
>>  >  > Thanks,
>>  >
>>  > Does the following patch improve anything ?
>>
>>  Yes, the order of the include files does not make trouble any more.
>>  Nevertheless, I need the attached patch to fix the remaining problems
>>  with CFLAGS mangling and missing -DPRODUCER.
> 
> Do we really need the UCFLAGS stuff ? CFLAGS is a standard thing, how
> do the other examples cope with the same problem ? Perhaps  we could
> put modules compilation in a separated makefile name Kbuild ?

For Linux 2.4 we use this module capturing trick to get the CFLAGS of
the kernel. That's what makes trouble. So, the problem only shows up
when modules need to be built for Linux 2.4 together with at least on
application. Yes, it might be better to use KCFLAGS for module
compilation for 2.4. Going to find a better solution a.s.a.p.

Wolfgang.


