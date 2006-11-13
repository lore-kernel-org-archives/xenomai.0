Message-ID: <4558339F.5070500@domain.hid>
Date: Mon, 13 Nov 2006 09:58:07 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Undefined reference to ___wrap_pthread_mutex_lock
	and friends on Blackfin
References: <822467320611121613u2cbcd224nc3afedd43d4b4463@domain.hid>
In-Reply-To: <822467320611121613u2cbcd224nc3afedd43d4b4463@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
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
To: Terry Laurenzo <tlaurenzo@domain.hid>
Cc: xenomai@xenomai.org

Terry Laurenzo wrote:
> Hello.  I'm new to this list and new to Xenomai.  I am getting the
> following when trying to build Xenomai 2.2.3:
> 
> -------------
> cyclictest.elf2flt(.text+0x4946): In function `_pthread_key_delete':
> : undefined reference to `___wrap_pthread_mutex_lock'
> cyclictest.elf2flt(.text+0x4970): In function `_pthread_key_delete':
> : undefined reference to `___wrap_pthread_mutex_unlock'
> cyclictest.elf2flt(.text+0x49c8): In function `_pthread_key_delete':
> : undefined reference to `___wrap_pthread_mutex_unlock'
> cyclictest.elf2flt(.text+0x49e8): In function `_pthread_key_create':
> : undefined reference to `___wrap_pthread_mutex_lock'
> cyclictest.elf2flt(.text+0x4a10): In function `_pthread_key_create':
> : undefined reference to `___wrap_pthread_mutex_unlock'
> cyclictest.elf2flt(.text+0x4a2e): In function `_pthread_key_create':
> : undefined reference to `___wrap_pthread_mutex_unlock'
> collect2: ld returned 1 exit status
> -------------
> 
> The problem seems to be that the version of libpthread.a that I am
> using makes reference to the pthread_mutex_lock and
> pthread_mutex_unlock functions from a couple of places including
> pthread_key_create and pthread_key_delete.

The problem is that pthread_key_create and pthread_key_delete should use
the libpthread.a versions of pthread_mutex_lock and pthread_mutex_unlock
not xenomai versions. In order to avoid this, you have to do the
link-edit in two stages: first do a partial link with libpthread_rt.a
with the --wrap options, second a final link with libpthread.a without
the --wrap options.

> 
> Since the Posix testsuite programs link libpthread after
> libpthread_rt, these references (which are defined in libpthread_rt)
> cannot be resolved.  I don't know if these calls are recent additions
> or what, but the uClibc/libpthread and libpthread_rt libraries are
> mutually dependent on each other.
> 
> I don't know enough about what is going on with the Xenomai Posix skin
> to figure out the right way to fix this problem, but the attached
> patch fixes the build failures by passing the --start-group linker
> flag, forcing ld to resolve circular references for all subsequent
> object files.    I know it's not great but it gets me going.  You have
> to rerun automake to get the changes.
> 
> Applying the patch makes it build but the testsuites for the Posix
> skin don't seem to work.  For example, here is what I get when trying
> to run cyclictest:
>  root:/usr/xenomai/testsuite/cyclic> ./cyclictest
>  Xenomai Posix skin init: pthread_atfork: Unknown error -1

Maybe pthread_atfork is not working at all on uclibc ?

> 
> The native testsuites seem to function as expected.
> 
> Does anyone have any ideas what the issue is?
> 
> Here is my platform specs:
>   - Blackfin BF537-STAMP
>   - uClinux R06R1-RC2 with corresponding toolchain
>   - gcc4.1.0
> 
> Xenomai configure was run per the README like so:
> $XENOMAI_DIR/configure --build=i686-pc-linux-gnu
> --host=bfinnommu-unknown-linux-gnu CC=bfin-uclinux-gcc
> CXX=bfin-uclinux-gcc AR=bfin-uclinux-ar LD=bfin-uclinux-ld
> --disable-shared
> 
> Also, it would appear that Xenomai releases post 2.2.3 will not run on
> an unpatched uClinux R06R1-RC2.  The problem seems to be that some
> macros were added to the newer kernel for addressing various
> peripherals.  Xenomai > 2.2.3 uses these macros which are not defined
> in this official uClinux release.  It would be nice to note something
> to this effect in the readme.

What macros ?

-- 
                                                  Gilles Chanteperdrix

