From: Jan Leupold <leupold@rsi-elektrotechnik.de>
Subject: pthread_cond_wait() never returns?
Message-ID: <eeaf1989-2795-d140-5311-302f61249c6c@rsi-elektrotechnik.de>
Date: Wed, 23 Oct 2019 17:52:11 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: de-DE
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi all,

I am trying to use pthread_cond_t in a Xenomai application. When compiling
and linking with the flags from xeno-config, the condition variable stops
working as expected. It seems as if pthread_cond_wait() would never return.

Is this a known issue?
(but most probably I think it's just my fault and I would be glad if
someone could give me a hint)

BTW, "cyclictest -M" (also uses pthread_cond_t to signal a refresh) does
not work as expected either.

Regards,
Jan

Using:
------------
ipipe-arm, branched off at tag ipipe-core-4.19.33-arm-2
xenomai-3, branched off at 44065a107 (master April 2019)
custom hardware, SAMA5D2 SoC

The program:
----------------------
#include <pthread.h>
#include <stdio.h>
#include <unistd.h>

pthread_mutex_t mutex;
pthread_cond_t cond;

void*
task(void* arg)
{
    (void) arg;
    printf("task\n");
    for (int i = 0; i < 3; ++i)
    {
        pthread_mutex_lock(&mutex);
        pthread_cond_wait(&cond, &mutex);
        pthread_mutex_unlock(&mutex);
        printf("task: condition signaled (i=%d)\n", i);
    }
    printf("task: done\n");
    return NULL;
}

int
main()
{
    printf("main\n");

    pthread_mutex_init(&mutex, NULL);
    pthread_cond_init(&cond, NULL);

    pthread_t t;
    pthread_create(&t, NULL, task, NULL);

    for (int i = 0; i < 3; ++i)
    {
        sleep(1);
        pthread_cond_signal(&cond);
        printf("main: signal(i=%d)\n", i);
    }

    pthread_join(t, NULL);

    printf("main: done\n");
    return 0;
}

When compiling without Xenomai the output is:

main
task
main: signal(i=0)
task: condition signaled (i=0)
main: signal(i=1)
task: condition signaled (i=1)
main: signal(i=2)
task: condition signaled (i=2)
task: done
main: done

When compiling with Xenomai the output is:

main
task
main: signal(i=0)
main: signal(i=1)
main: signal(i=2)
^C
(pthread_join() never returns)

The difference in Makefile.am:
------------------------------

bin_PROGRAMS = test-condition-xeno test-condition-linux

test_condition_linux_SOURCES = condition_c.c
test_condition_linux_LDFLAGS = -pthread

test_condition_xeno_SOURCES = condition_c.c
test_condition_xeno_CFLAGS = $(shell xeno-config --skin=posix --cflags)
test_condition_xeno_LDADD = $(shell xeno-config --skin=posix --ldflags)

Output from --dump-config:
--------------------------
based on Xenomai/cobalt v3.1-devel -- #94e729d53 (2019-06-03 13:32:22 +0200)
CONFIG_MMU=1
CONFIG_XENO_BUILD_ARGS=" '--build=x86_64-linux'
'--host=arm-poky-linux-gnueabi' '--target=arm-poky-linux-gnueabi'
'--prefix=/usr' '--exec_prefix=/usr' '--bindir=/usr/bin'
'--sbindir=/usr/sbin' '--libexecdir=/usr/libexec' '--datadir=/usr/share'
'--sysconfdir=/etc' '--sharedstatedir=/com' '--localstatedir=/var'
'--libdir=/usr/lib' '--includedir=/usr/include/xenomai'
'--oldincludedir=/usr/include/xenomai' '--infodir=/usr/share/info'
'--mandir=/usr/share/man' '--disable-silent-rules'
'--with-libtool-sysroot=/home/jan/yocto/aertronic2.0-io/build-betrieb/tmp/work/cortexa5t2hf-vfp-poky-linux-gnueabi/xenomai/3+git999-r0/recipe-sysroot'
'--disable-static' '--disable-async-cancel' '--disable-clock-monotonic-raw'
'--with-core=cobalt' '--enable-debug=symbols' '--disable-dlopen-libs'
'--disable-doc-build' '--disable-fortify' '--disable-lores-clock'
'--disable-pshared' '--disable-registry' '--disable-smp' '--disable-tls'
'build_alias=x86_64-linux' 'host_alias=arm-poky-linux-gnueabi'
'target_alias=arm-poky-linux-gnueabi' 'CC=arm-poky-linux-gnueabi-gcc
-mthumb -mfpu=vfp -mfloat-abi=hard -mcpu=cortex-a5 -fstack-protector-strong
 -D_FORTIFY_SOURCE=2 -Wformat -Wformat-security -Werror=format-security
--sysroot=/home/jan/yocto/aertronic2.0-io/build-betrieb/tmp/work/cortexa5t2hf-vfp-poky-linux-gnueabi/xenomai/3+git999-r0/recipe-sysroot'
'CFLAGS= -O2 -pipe -g -feliminate-unused-debug-types
-fmacro-prefix-map=/home/jan/yocto/aertronic2.0-io/build-betrieb/tmp/work/cortexa5t2hf-vfp-poky-linux-gnueabi/xenomai/3+git999-r0=/usr/src/debug/xenomai/3+git999-r0

-fdebug-prefix-map=/home/jan/yocto/aertronic2.0-io/build-betrieb/tmp/work/cortexa5t2hf-vfp-poky-linux-gnueabi/xenomai/3+git999-r0=/usr/src/debug/xenomai/3+git999-r0

-fdebug-prefix-map=/home/jan/yocto/aertronic2.0-io/build-betrieb/tmp/work/cortexa5t2hf-vfp-poky-linux-gnueabi/xenomai/3+git999-r0/recipe-sysroot=

-fdebug-prefix-map=/home/jan/yocto/aertronic2.0-io/build-betrieb/tmp/work/cortexa5t2hf-vfp-poky-linux-gnueabi/xenomai/3+git999-r0/recipe-sysroot-native=
' 'LDFLAGS=-Wl,-O1 -Wl,--hash-style=gnu -Wl,--as-needed
-fstack-protector-strong -Wl,-z,relro,-z,now' 'CPPFLAGS='
'CPP=arm-poky-linux-gnueabi-gcc -E
--sysroot=/home/jan/yocto/aertronic2.0-io/build-betrieb/tmp/work/cortexa5t2hf-vfp-poky-linux-gnueabi/xenomai/3+git999-r0/recipe-sysroot
 -mthumb -mfpu=vfp -mfloat-abi=hard -mcpu=cortex-a5
-fstack-protector-strong  -D_FORTIFY_SOURCE=2 -Wformat -Wformat-security
-Werror=format-security'
'PKG_CONFIG_PATH=/home/jan/yocto/aertronic2.0-io/build-betrieb/tmp/work/cortexa5t2hf-vfp-poky-linux-gnueabi/xenomai/3+git999-r0/recipe-sysroot/usr/lib/pkgconfig:/home/jan/yocto/aertronic2.0-io/build-betrieb/tmp/work/cortexa5t2hf-vfp-poky-linux-gnueabi/xenomai/3+git999-r0/recipe-sysroot/usr/share/pkgconfig'
'PKG_CONFIG_LIBDIR=/home/jan/yocto/aertronic2.0-io/build-betrieb/tmp/work/cortexa5t2hf-vfp-poky-linux-gnueabi/xenomai/3+git999-r0/recipe-sysroot/usr/lib/pkgconfig'"
CONFIG_XENO_BUILD_STRING="x86_64-pc-linux-gnu"
CONFIG_XENO_COBALT=1
CONFIG_XENO_COMPILER="gcc version 9.2.0 (GCC) "
CONFIG_XENO_DEFAULT_PERIOD=1000000
CONFIG_XENO_FORTIFY=1
CONFIG_XENO_HEAPMEM=1
CONFIG_XENO_HOST_STRING="arm-poky-linux-gnueabi"
CONFIG_XENO_LORES_CLOCK_DISABLED=1
CONFIG_XENO_PREFIX="/usr"
CONFIG_XENO_REVISION_LEVEL=90
CONFIG_XENO_SANITY=1
CONFIG_XENO_TLS_MODEL="initial-exec"
CONFIG_XENO_UAPI_LEVEL=15
CONFIG_XENO_VERSION_MAJOR=3
CONFIG_XENO_VERSION_MINOR=0
CONFIG_XENO_VERSION_STRING="3.1-devel"
---
CONFIG_SMP is OFF
CONFIG_XENO_ASYNC_CANCEL is OFF
CONFIG_XENO_COPPERPLATE_CLOCK_RESTRICTED is OFF
CONFIG_XENO_DEBUG is OFF
CONFIG_XENO_DEBUG_FULL is OFF
CONFIG_XENO_LAZY_SETSCHED is OFF
CONFIG_XENO_LIBS_DLOPEN is OFF
CONFIG_XENO_MERCURY is OFF
CONFIG_XENO_PSHARED is OFF
CONFIG_XENO_RAW_CLOCK_ENABLED is OFF
CONFIG_XENO_REGISTRY is OFF
CONFIG_XENO_REGISTRY_ROOT is OFF
CONFIG_XENO_TLSF is OFF
CONFIG_XENO_VALGRIND_API is OFF
CONFIG_XENO_WORKAROUND_CONDVAR_PI is OFF
CONFIG_XENO_X86_VSYSCALL is OFF
---
PTHREAD_STACK_DEFAULT=65536
AUTOMATIC_BOOTSTRAP=0


Mit freundlichen Grüßen

*Jan Leupold*
Entwicklung
Development
-- 
---------------------------------------------------------------------------
R-S-I Logo <https://www.rsi-elektrotechnik.de/>

R-S-I Elektrotechnik GmbH & Co. KG
Woelkestraße 11
D-85301 Schweitenkirchen
www.rsi-elektrotechnik.de <https://www.rsi-elektrotechnik.de/>

Tel: +49 8444 9204-32
Fax: +49 8444 9204-50
leupold@rsi-elektrotechnik.de <mailto:leupold@rsi-elektrotechnik.de>
---------------------------------------------------------------------------

Amtsgericht Ingolstadt - GmbH: HRB 191328 - KG: HRA 170363
Geschäftsführer: Dr.-Ing. Michael Sorg, Dipl.-Ing. Franz Sorg
USt-IdNr.: DE 128592548



