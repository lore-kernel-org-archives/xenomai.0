Message-ID: <54C648B7.8040105@xenomai.org>
Date: Mon, 26 Jan 2015 15:01:27 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <129277905.Ag2XebZWbK@soho> <8367559.zdLagntR1r@indiana>
 <20150126120824.GF12812@hermes.click-hack.org> <2052908.cWhQn5Pgch@soho>
In-Reply-To: <2052908.cWhQn5Pgch@soho>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Packaging Xenomai-3
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Leopold Palomo-Avellaneda <leo@alaxarxa.net>, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On 01/26/2015 01:39 PM, Leopold Palomo-Avellaneda wrote:

> Maybe I'm wrong. But after reading this thread I understood that to have a 
> kernel with both patches (i-pipe and preempt_rt) and, I understand, Xenomai-3 
> with the two versions could be a very interesting system to work on.
> 
> For instance, I'm in the robotics field, and after that mails I thought that 
> it could be a good solution that fit the cases where you have several loops, 
> with several rates with different importance.
> 

You are missing an important point: Xenomai 3 over Mercury is about
running non-POSIX RTOS APIs over a native kernel (with or without
preempt-rt, this is orthogonal to the issue).

All projects using mixed dual kernel + native preemption systems I came
to know wanted:

- guaranteed low latency figures from the dual kernel side, regardless
of the API, regardless of the regular kernel activity, with the least
possible overhead on the latter.
- POSIX interface with short and bounded response times from the native
preemption side, for talking to the regular driver stack.

Non POSIX API with Xenomai either means: 1) the former native API (aka
"alchemy"), 2) some RTOS emulator such as VxWorks or pSOS. People
running the former native API already will most likely stay with the
dual kernel side, which is how they currently run it over Xenomai 2.6,
unless they move to a pure native preemption system, in which case the
original point is moot.

Therefore, your proposal mainly addresses the issue of running a mixed
configuration, with some Mercury-based application(s) ported from a
traditional RTOS to linux, and other application(s) running over Cobalt
in dual kernel mode, concurrently on the same system. People who just
want to run POSIX apps over a native kernel don't need Xenomai 3. In
short, the potential user base for the mixed setup as described is quite
small.

With that in mind, using a mixed installation root between Mercury and
Cobalt also means that any 2.x Makefile currently using "xeno-config"
would have to be fixed up, to reflect the new suffixed path or call
pkg-config to retrieve it, whatever fits. We have been advertising
xeno-config since years, as a mean to stay away from installation
specifics, so this would be quite wrong to end up asking people to run
xeno-config-cobalt or xeno-config-mercury.

As I mentioned already, we won't go for single binaries running over
both cores, the performance and maintenance impact would be a nightmare.
Since all our build system is autoconfiscated, you can pick any root
prefix that makes sense, and even fine tune every installation directory
already (lib, include, bin etc). This means that having multiple roots
is definitely a non-issue, and does not introduce any limitation.

I don't buy the "suffix to disambiguate" argument either:
/usr/lib/libvxworks-m.so is not clearer than
/usr/lib/mercury/libvxworks.so, or
/usr/xenomai/mercury/lib/libvxworks.so. And this does not even work
better with /usr/lib/libvxworks-mercury.so.

Besides, there is no shortage of ways to find out which Xenomai
configuration your build system and even your application is currently
depending on. The only requirement is to query the right xeno-config
script or application, which may be as simple as setting the PATH
variable appropriately for your setup:

$ xeno-config --core
mercury
$ xeno-config --cflags
-I/usr/xenomai/mercury/include/mercury -I/usr/xenomai/mercury/include
-D_GNU_SOURCE -D_REENTRANT -D__MERCURY__
$ latency --dump-config
CONFIG_MMU=1
CONFIG_SMP=1
CONFIG_XENO_ASYNC_CANCEL=1
CONFIG_XENO_BUILD_ARGS=" '-prefix=/usr/xenomai/mercury'
'--disable-doc-install' '--enable-async-cancel' '--enable-lores-clock'
'--enable-debug=full' '--enable-smp' '--enable-tls'
'--with-core=mercury' '--enable-registry' '--enable-pshared'
'--enable-condvar-workaround'"
CONFIG_XENO_BUILD_STRING="x86_64-unknown-linux-gnu"
CONFIG_XENO_COMPILER="gcc version 4.8.3 20140911 (Red Hat 4.8.3-7) (GCC) "
CONFIG_XENO_DEBUG=1
CONFIG_XENO_DEBUG_FULL=1
CONFIG_XENO_DEFAULT_PERIOD=100000
CONFIG_XENO_FORTIFY=1
CONFIG_XENO_HOST_STRING="x86_64-unknown-linux-gnu"
CONFIG_XENO_MERCURY=1
CONFIG_XENO_PREFIX="/usr/xenomai/mercury"
CONFIG_XENO_PSHARED=1
CONFIG_XENO_REGISTRY=1
CONFIG_XENO_REGISTRY_ROOT="/var/run/xenomai"
CONFIG_XENO_REVISION_LEVEL=10
CONFIG_XENO_SANITY=1
CONFIG_XENO_TLS_MODEL="initial-exec"
CONFIG_XENO_UAPI_LEVEL=10
CONFIG_XENO_VALGRIND_API=1
CONFIG_XENO_VERSION_MAJOR=2
CONFIG_XENO_VERSION_MINOR=99
CONFIG_XENO_VERSION_NAME="Exact Zero"
CONFIG_XENO_VERSION_STRING="3.0-rc2"
CONFIG_XENO_WORKAROUND_CONDVAR_PI=1
CONFIG_XENO_X86_VSYSCALL=1
---
CONFIG_XENO_ARM_SA1100 is OFF
CONFIG_XENO_ARM_TSC_TYPE is OFF
CONFIG_XENO_COBALT is OFF
CONFIG_XENO_COPPERPLATE_CLOCK_RESTRICTED is OFF
CONFIG_XENO_CPU_XSC3 is OFF
CONFIG_XENO_LIBS_DLOPEN is OFF
CONFIG_XENO_LORES_CLOCK_DISABLED is OFF
CONFIG_XENO_RAW_CLOCK_ENABLED is OFF
CONFIG_XENO_TLSF is OFF

-- 
Philippe.

