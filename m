Message-ID: <4B3B7FE7.4000504@domain.hid>
Date: Wed, 30 Dec 2009 17:29:27 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <4B3B7831.8060806@domain.hid> <4B3B7D11.6050400@domain.hid>
In-Reply-To: <4B3B7D11.6050400@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Build problem with xenomai-2.4 git head
List-Id: Xenomai life and development <xenomai.xenomai.org>
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
> Wolfgang Grandegger wrote:
>> Hello,
>>
>> I get the following error when building GIT head of xenomai-2.4 for PowerPC:
>>
>> Making all in cyclic
>> make[3]: Entering directory `/work/wolf/pdm360ng/xenomai-2.4/src/testsuite/cyclic'
>> /bin/sh ../../../libtool --tag=CC   --mode=link ../../../scripts/wrap-link.sh ppc-linux-gcc   -Wl,@/work/wolf/pdm360ng/xenomai-2.4/src/skins/posix/posix.wrappers   -o cyclictest cyclictest-cyclictest.o ../../skins/posix/libpthread_rt.la -lpthread -lrt 
>> libtool: link: ../../../scripts/wrap-link.sh ppc-linux-gcc -Wl,@/work/wolf/pdm360ng/xenomai-2.4/src/skins/posix/posix.wrappers -o .libs/cyclictest cyclictest-cyclictest.o  ../../skins/posix/.libs/libpthread_rt.so -lpthread -lrt -Wl,-rpath -Wl,/root/xenomai-2.4/lib
>> ../../skins/posix/.libs/libpthread_rt.so: undefined reference to `__real_shm_open'
>> ../../skins/posix/.libs/libpthread_rt.so: undefined reference to `__real_shm_unlink'
>> collect2: ld returned 1 exit status
>> make[3]: *** [cyclictest] Error 1
>> make[3]: Leaving directory `/work/wolf/pdm360ng/xenomai-2.4/src/testsuite/cyclic'
>> make[2]: *** [all-recursive] Error 1
>> make[2]: Leaving directory `/work/wolf/pdm360ng/xenomai-2.4/src/testsuite'
>> make[1]: *** [all-recursive] Error 1
>> make[1]: Leaving directory `/work/wolf/pdm360ng/xenomai-2.4/src'
>> make: *** [all-recursive] Error 1
>>
>> Any idea why the functions are missing?
> 
> Yes, it is due to a recent patch. Though when they do not exist, they
> should not be called, could you show us the results of:
> 
> grep HAVE_SHM src/include/xeno_config.h

  $ export CROSS_COMPILE=ppc_6xx-
  $ export ARCH=powerpc
  $ ./configure --host=ppc-linux
  $ grep HAVE_SHM src/include/xeno_config.h
  #define HAVE_SHM_OPEN 1
  #define HAVE_SHM_UNLINK 1

Wolfgang.

