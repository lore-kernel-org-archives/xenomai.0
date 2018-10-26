MIME-Version: 1.0
References: <20181023151647.25508-1-norbert.lange@andritz.com>
 <7571eedc-7844-2703-e553-72cf9a1abbe0@siemens.com>
In-Reply-To: <7571eedc-7844-2703-e553-72cf9a1abbe0@siemens.com>
From: Norbert Lange <nolange79@gmail.com>
Date: Fri, 26 Oct 2018 18:35:40 +0200
Message-ID: <CADYdroNgOFKaEQ0UfcxhdniU54PYt119g+Y9Gnz7SGrCtBGiUA@mail.gmail.com>
Subject: Re: improve and provide a header for bootstrapping
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: jan.kiszka@siemens.com
Cc: Xenomai <xenomai@xenomai.org>

Am Fr., 26. Okt. 2018 um 15:48 Uhr schrieb Jan Kiszka <jan.kiszka@siemens.com>:
>
> On 23.10.18 16:16, Norbert Lange wrote:
> > Hello,
> >
> > the following patches allow a variety of options additional
> > to the linker magic involved for hijacking the aplications main
> > function.
> >
> > the original method will still continue to work, differences are
> >
> > *   the code dealing with retrieving the commandline arguments
> >      is moved into libcobale/libmercury. Making the necessary per-application
> >      code much smaller.
> >
> > *   the implementation was moved into a header, with several macros
> >      controlling functionality (not everyone wants to define a main function).
> >
> >
> > The approach I use personally is to compile and link my own bootstrap code,
> > which is preferable in many build systems as source-files are understood while
> > objects files generally need some special care. (And it cant hurt if the compiler
> > flags match exactly).
> >
> > As example:
> >
> > ----- add this to your file  containing main
> >
> > int xenomai_init_getargv(int *argc, char *const** argv);
> >
> > int main(int argc, char *const argv[])
> > {
> > #if defined(__COBALT__) || defined(__MERCURY__)
> >      xenomai_init_getargv(&argc, &argv);
> > #endif
> >       ....
> > }
> >
> > ----- create another file, lets call it mybootstrap.c
> >
> > #define _XENOMAI_BOOTSTRAP_GLIBC_CONSTRUCTORS
> > #include <xenomai/bootstrap-template.h>
> >
> > ----------------------------------------------
> >
> > Norbert
> >
> > [PATCH 1/2] separate bootstrap code to get commandline, move it into
> > [PATCH 2/2] add a header to create flexible bootstrap code
> >
> >
>
> I need to look more carefully at the details and your use case, but my first
> impression is that at least patch 2 is not very beautiful due to that large
> template header. Could you explain again why explicitly calling the bootstrap
> code in a library is not sufficient?

Just so that we are on the same page, the bootstrap code thats
generated looks like this
(in a couple variants):
----------------
#include <xenomai/init.h>

static int early_argc;
static char *const *early_argv;

int xenomai_bootstrap_getargv(int *argc, char *const** argv)
{
if (early_argc)
{
*argc = early_argc;
*argv = early_argv;
return 1;
}
return 0;
}

__bootstrap_ctor static void xenomai_bootstrap(void)
{
char *const *argv;
int argc;
if (xenomai_init_fetchargv(&argc, &argv) != 0)
return;
xenomai_init(&argc, &argv);
early_argc = argc;
early_argv = argv;
}
----------------------

I believe what you meant with bootstrap code is called with 'xenomai_init',
and I dont plan to touch or replace that.

The code further replicates the code from lib/boilerplate/init/bootstrap.c,
with the important difference, that you can chose not to define a main
function and assorted wrappers (one of my main motivations is to
disable/separate that).

>
> Also note that this pattern may make it harder to maintain a compatible
> interface along updates, increasing the risk of having to recompile your
> application, rather than just replacing some central library, when Xenomai changes.

before Patch #2:
your-app --links-> lib/xenomai/bootstrap.o --calls->xenomai_init

after Patch #2 (and an optional variant):
your-app --contains-> include/xenomai/bootstrap-template.h
--calls->xenomai_init

this means I need no precompiled object 'lib/xenomai/bootstrap.o', and
the ABI to the libs has not changed.

You call a large header with functions not beautiful, I would call
precompiled objects and the linker wrapping not beautiful.
If we are pragmatic, with Patch #2 you can pick between 2 not
beautiful solutions =)

Patch #1 is the one changing the ABI in a not BW-compatible manner
(adds one function),
but Patch #2 arguably improves on that, as the .o objects from a
compiler have no ABI stability guarantee whatsoever.

Further I can freely use no-pic/pic/pie and other ABI-changing
settings, as there is no need to link a object
with potentially incompatible ABI (compiler,-version or settings).

Norbert

