Date: Thu, 17 Dec 2015 10:25:59 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20151217092559.GB15964@hermes.click-hack.org>
References: <2004286.fnOG18ZY9A@soho> <3338349.5bsveW0zyp@soho>
 <20151217000518.GC25151@hermes.click-hack.org>
 <5183191.iz6aZqeNVV@soho>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5183191.iz6aZqeNVV@soho>
Subject: Re: [Xenomai] Porting a library to Xenomai
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Leopold Palomo-Avellaneda <leo@alaxarxa.net>
Cc: Xenomai list <xenomai@xenomai.org>

On Thu, Dec 17, 2015 at 10:00:17AM +0100, Leopold Palomo-Avellaneda wrote:
> El Dijous, 17 de desembre de 2015, a les 01:05:18, Gilles Chanteperdrix va 
> escriure:
> [...]
> > > 
> > > - Some of you have tried to "Xenomaize" a common POSIX library, for
> > > instance with threads and sockets (Poco?... )?
> > 
> > Yes, back in 2006 to 2009, I ported several applications related to
> > VOIP to use Xenomai and RTnet. From this experience, I wrote this
> > guide:
> > https://xenomai.org/2014/08/porting-a-linux-application-to-xenomai-dual-kern
> > el/
> 
> the famous great page ...
> 
> > > - If I create a library (POSIX) and I wrap the functions (-
> > > Wl,@/usr/lib/x86_64-linux-gnu/posix.wrappers). The library users must wrap
> > > wrap their code too, right? (for instance if they have a
> > > printf...)
> > 
> > You should compile (and more importantly link edit) all your code,
> > whether library or executable, with the flags obtained via
> > xeno-config. 
> 
> ok, that's clear. For the current case I suppose that it's be the same if the 
> library is C++ or C. To be more concisely, if I create a dynamic C++ library 
> (*) (libXenofoo), with some *.cpp files. I understand that:
> 
> - to compile the files I have to pass the POSIX cflags obtained by xeno-config
> - to link that library, I have to pass the POSIX ldflags obtained by xeno-config 
> (wrap, etc)
> 
> After, if I have a program the uses libXenofoo (dynamic)
> - to compile my program, If I don't uses any __Xeno__ * flag I don't need to 
> pass the POSIX cflags. Right?

It is recommended to use them. Xenomai interposes its own header,
which add some definitions, for instance of functions implemented in
xenomai posix skin, but not in glibc. By including these headers:
- you get the declaration of the __real functions, in case you want
to use the unwrapped function (says __real_pthread_create, to create
a plain Linux thread).
- you get the declaration for Xenomai-specific _np functions, such
as pthread_setmode_np.

> - to link the program against libXenofoo, I understand that yes, that I should 
> uses the POSIX ldflags obtained by xeno-config (wrap, etc). Right?
> 
> > If you want to use the static version of the POSIX skin
> > library, it gets a little more complicated, you do not want to wrap
> > the symbols of the POSIX skin library itself and you should use the
> > "wrap-link.sh" script, to do the link edit in two stages.
> 
> I don't understand that, probably because I use cmake and hides this. But, I 
> have created my static version of libXenofoo passing _only_ one time and the 
> program have worked. Please, could you elaborate a bit more this?

This all happens in the POSIX skin library. The typical __wrap
function calls the __real function under the hood, and a .c file
contains the definition of the __real functions used by the POSIX
skin library itself. So, for instance __wrap_pthread_create calls
__real_pthread_create, which is implemented as a simple call to
pthread_create. If you link that with --wrap (what is vicious is
that I am not sure it happens on all architecture), the call to
pthread_call will be turned into a call to __wrap_pthread_create,
and you get, at run time,  an infinite recursion which ends up with
a segmentation fault due to a stack overflow.

When you generate the POSIX skin library dynamically, this is not a
problem, you just have to link the POSIX skin dynamic library itself
without the --wrap flags.

But when you link your program with the static library, if you do:

gcc -o program program.o libposix.a -lpthread -lrt

The symbols in program.o are not wrapped, so Xenomai functions are
not called.

If you do:

gcc -o program -Wl,--wrap=pthread_create program.o libposix.a -lpthread -lrt

The implementation of __real_pthread_create in libposix.a ends-up
calling __wrap_pthread_create and you get the infinite recursion.

So, the solution is to do:

gcc -Wl,-r -o program.partial-link -Wl,--wrap=pthraed_create program.o
gcc -o program program.partial-link libposix.a -lpthread -lrt

wrap-link.sh saves you the trouble from doing this yoursel, if you do:

wrap-link.sh -o program -Wl,--wrap=pthread_create program.o libposix.a -lpthread -lrt

It will split the link-edit in two stages. I see no reason why cmake
would do that automatically.


> 
> Leopold
> 
> 
> (*) C++ simple, nothing sophisticated with templates, dynamic memory 
> allocations, garbage collection. Some classes taking care about
> memory, etc.

I do not think the C++ features you use matter. What could matter
are static/global objects initializations (as explained in the
document), but I think this has been resolved in Xenomai 3.

-- 
					    Gilles.
https://click-hack.org

