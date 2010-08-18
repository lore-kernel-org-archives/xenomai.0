From: Krzysztof =?UTF-8?Q?B=C5=82aszkowski?= <kb@domain.hid>
In-Reply-To: <4C6BCB51.4010805@domain.hid>
References: <1282047938.5255.89.camel@domain.hid>
	<4C6B146D.9010004@domain.hid>
	<1282126974.5255.262.camel@domain.hid>
	<4C6BBD62.3050907@domain.hid>
	<1282131617.5255.286.camel@domain.hid>
	<4C6BCB51.4010805@domain.hid>
Content-Type: text/plain; charset="utf-8"
Date: Wed, 18 Aug 2010 14:17:56 +0200
Message-Id: <1282133876.5255.296.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai-core] xenomai 2.5.3/native, kernel 2.6.31.8 and fork()
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On Wed, 2010-08-18 at 14:00 +0200, Gilles Chanteperdrix wrote:
> Krzysztof Błaszkowski wrote:
> > On Wed, 2010-08-18 at 13:00 +0200, Gilles Chanteperdrix wrote:
> >> Krzysztof Błaszkowski wrote:
> >>> On Wed, 2010-08-18 at 00:59 +0200, Gilles Chanteperdrix wrote:
> >>>> - I have not really checked your user-space compilation flags, I am
> >>>> using xeno-config to get the correct ones.
> >>> xeno-config --skin=native --cflags gives:
> >>>
> >>> -I/usr/xenomai/include -D_GNU_SOURCE -D_REENTRANT -Wall -pipe -D__XENO__
> >>>
> >>>
> >>> note that there is no xenomai installed on my r&d server
> >>> in /usr/xenomai/
> >>>
> >>> i build xenomai per kernel and install it in kernel's INSTALL sub-dir
> >>> (DESTDIR=) as well as kernel's modules and other related stuff for this
> >>> particular kernel.
> >>> (otherwise i would go mad soon due to various versions ..)
> >> xeno-config handles the DESTDIR environment variable (failing to do this
> >> would be kind of silly, because a lot of people, including the
> >> maintainers, use Xenomai mostly in cross-compiled environment).
> > 
> > no, it does not.
> > 
> > ./xeno-config
> > xeno-config --verbose
> >         --version="2.5.4"
> >         --cc="gcc"
> >         --arch="x86"
> >         --prefix="/usr/xenomai"
> >         --xeno-cflags="-I/usr/xenomai/include -D_GNU_SOURCE -D_REENTRANT
> > -Wall -pipe -D__XENO__"
> >         --xeno-ldflags="-L/usr/xenomai/lib -lxenomai -lpthread "
> >         --posix-cflags=""
> > POSIX support is not available
> >         --posix-ldflags=""
> >         --library-dir="/usr/xenomai/lib"
> > Usage xeno-config --skin=skinname OPTIONS
> > Options :
> >         --help
> >         --v,--verbose
> >         --version
> >         --cc
> >         --arch
> >         --prefix
> >         --skin native|posix|psos|rtai|rtdm|uitron|vrtx|vxworks
> >         --cflags
> >         --ldflags
> >         --lib*-dir,--libdir,--user-libdir
> > 
> > Deprecated options:
> >         --xeno-cflags
> >         --xeno-ldflags
> >         --posix-cflags
> >         --posix-ldflags
> > 
> > 
> > while it was built like this:
> > 
> > make DESTDIR=/root/... install
> 
> You are not paying attention. 


happens. i recall you spent an hour yesterday on inquiring libc.so
instead of looking into test program output and its source.


> I said it "handles the DESTDIR environment
>  variable". So, you should pass DESTDIR as an environment variable to
> xeno-config. As in:


fine. this will simplify scripts machinery.


> 
> DESTDIR=/root/.... xeno-config --skin=native --cflags
> 
> The xeno-config script is built when Xenomai is compiled, not installed,
> at this point, it would be against the rules to assume that a DESTDIR is
> set, and hardcode a DESTDIR value into xeno-config.
> 
> See GNU make documentation:
> http://www.gnu.org/software/make/manual/html_node/DESTDIR.html
> 
> And for a good reason, the final destination of Xenomai on your system
> may be different from where you initially installed it. So, handling
> DESTDIR dynamically in xeno-config makes things more flexible.
> 
> > but there is still a difference in xeno-shmem-fork behavior when linked
> > with pthread or not from command line.
> 
> Ok. But linking with pthread is the only supported way of using Xenomai. A
> >> What version of opensuse?
> > 
> > 11.1 - 32. i do not crosscompile on x86_64 to x86 because i have
> > encountered various strange mismatches in the past.
> > 
> > rather i use native clean x86 environment (on e.g. x86_64)
> 
> I do this all the time, and never had any problem.

i had lots with header files mainly.
and i am happy with my way.

> Also, why not running 64 bits code on your atom? There are some x86_32
> only atoms? What about SMP?

for some other constraints i will not mention i use 32 bits now.

this is single core cpu so no point to use smp for e.g. 8 cpus (nor
bigsmp)

> 
> By the way, did you forget to semd me your .config ?
> 

it should be included in the kernel.tgz i have sent already.


-- 
Krzysztof Blaszkowski


