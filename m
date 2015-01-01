Date: Thu, 1 Jan 2015 15:43:01 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150101144301.GE1544@daedalus>
References: <CALe7ZU1ONd1p9OFOYfHHh_FfHnmyFc-UuC6kBVQw4gQrCi2KWA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALe7ZU1ONd1p9OFOYfHHh_FfHnmyFc-UuC6kBVQw4gQrCi2KWA@mail.gmail.com>
Subject: Re: [Xenomai] cross compiling xenomai application
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: JAY KOTHARI <jaikothari10@gmail.com>
Cc: xenomai <xenomai@xenomai.org>

On Thu, Jan 01, 2015 at 08:05:32PM +0530, JAY KOTHARI wrote:
> Hi,
>     I am trying to cross compile xenomai user space application with this
> command for Beagle Bone Black
> 
> arm-linux-gnueabihf-gcc -I/usr/xenomai/include -I/usr/xenomai -D_GNU_SOURCE
> -D_REENTRANT -D__XENO__ -lnative -L/usr/xenomai/lib -L/usr/xenomai/
> -lxenomai -lpthread -lrt -Xlinker -rpath -Xlinker /usr/xenomai/lib
> 1_trivial-periodic.c -o 1_trivial-periodic -lnative -lpthread -lxenomai
> 
> But I am facing linking error as follows
> 
> 
>  In file included from /usr/xenomai/include/nucleus/trace.h:53:0,
> 
> from /usr/xenomai/include/nucleus/system.h:27,
> 
> from /usr/xenomai/include/asm/xenomai/system.h:128,
> 
> from /usr/xenomai/include/nucleus/types.h:36,
> 
> from /usr/xenomai/include/nucleus/thread.h:25,
> 
> from /usr/xenomai/include/nucleus/sched.h:31,
> 
> from /usr/xenomai/include/native/task.h:25,
> 
> from 1_trivial-periodic.c:6:
> 
> /usr/xenomai/include/asm/xenomai/tsc.h: In function ‘__xn_rdtsc’:
> 
> /usr/xenomai/include/asm/xenomai/tsc.h:37:2: warning: left shift count >=
> width of type [enabled by default]
> 
> return ((unsigned long)__a) | (((unsigned long)__d) << 32);

This __xn_drtsc is the one for the x86_64 architecture, not for the ARM
architecture. So, what you have in fact done is install xenomai on
your x86_64 host, and using that installation to compile arm code.
This can not work.

How to install Xenomai in cross-compiled environment is thoroughly
documented in Xenomai installation instructions.

-- 
					    Gilles.

