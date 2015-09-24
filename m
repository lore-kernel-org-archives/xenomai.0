MIME-Version: 1.0
In-Reply-To: <20150923161249.GO15616@csclub.uwaterloo.ca>
References: <20150922174455.GA13976@hermes.click-hack.org>
 <CAFkYNwa-XGD+JM-5w6EGepO8XG2Ki9Tt+ocqgcd_zNmPCngdyA@mail.gmail.com>
 <20150923053843.GD13976@hermes.click-hack.org>
 <20150923070615.GI13976@hermes.click-hack.org>
 <CAFkYNwYta4TDofpKcGfkH4xUB0udKg8Q721T97LTD6ua_5MWjg@mail.gmail.com>
 <20150923115911.GB28513@hermes.click-hack.org>
 <CAFkYNwZoEEiezx1Ny+s2WXgx5xP471A1BrVEnJJ9hukjyEv4-Q@mail.gmail.com>
 <CAFkYNwbRx9ZK10_F7XfcP7U0uNBafY=xA7H_TbxbBj7CxpETrQ@mail.gmail.com>
 <20150923153413.GN15616@csclub.uwaterloo.ca>
 <CAFkYNwajO8EDfQU36znukPsbiZPKEMtXxnpzqDO-Su1=k5jWuA@mail.gmail.com>
 <20150923161249.GO15616@csclub.uwaterloo.ca>
Date: Fri, 25 Sep 2015 11:55:39 +1200
Message-ID: <CAFkYNwZOOpH5Qv7icSf9gvaOzKcecJhC_4GA2XPgfP0OS_mq=w@mail.gmail.com>
From: vibnwis <vibnwis@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Xenomai tests
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Cc: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, xenomai@xenomai.org

Do you set/unset the items in "make menuconfig" or edit them manually?

On 24 September 2015 at 04:12, Lennart Sorensen <
lsorense@csclub.uwaterloo.ca> wrote:

> On Thu, Sep 24, 2015 at 04:11:25AM +1200, vibnwis wrote:
> > On 24 September 2015 at 03:34, Lennart Sorensen <
> > lsorense@csclub.uwaterloo.ca> wrote:
> >
> > > On Thu, Sep 24, 2015 at 01:26:31AM +1200, vibnwis wrote:
> > > > To do a quick test if these CONFIG_LOCKDEP_SUPPORT
> > > > CONFIG_TRACE_IRQFLAGS_SUPPORT ever able to be changed. I simply tur=
n
> off
> > > > everything in make menuconfig. I mean everything and these two flag=
s
> are
> > > > still there unchanged.
> > > > FYI, I had the .config opened in a editor. Whenever changes were
> made, it
> > > > would prompt in the editor to reload the contents.
> > >
> > > Certainly looking at lib/Kconfig.debug, nowhere else can turn on
> > > CONFIG_LOCKDEP except stuff in there.  Doing a search in make
> menuconfig
> > > for LOCKDEP should show you that symbol and even explain (at least
> > > usually it seems to) why the setting is what it is.
> > >
> > > Here is what I see on 3.14 where I do have LOCKDEP disabled and
> > > ipipe/xenomai in use:
> > >
> > >  .config - Linux/arm 3.14.51 Kernel Configuration
> > >  > Search (LOCKDEP)
> > > -----------------------------------------------------------
> > >   +---------------------------- Search Results
> > > -----------------------------+
> > >   | Symbol: LOCKDEP [=3Dn]
> > >   |
> > >   | Type  : boolean
> > >  |
> > >   |   Defined at lib/Kconfig.debug:928
> > >   |
> > >   |   Depends on: DEBUG_KERNEL [=3Dy] && TRACE_IRQFLAGS_SUPPORT [=3Dy=
] &&
> > >  |
> > >   |               STACKTRACE_SUPPORT [=3Dy] && LOCKDEP_SUPPORT [=3Dy]
> > >  |
> > >   |   Selects: STACKTRACE [=3Dy] && FRAME_POINTER [=3Dn] && KALLSYMS =
[=3Dy]
> &&
> > >   |
> > >   |            KALLSYMS_ALL [=3Dy]
> > >   |
> > >   |   Selected by: DEBUG_LOCK_ALLOC [=3Dn] && DEBUG_KERNEL [=3Dy] &&
> > >   |
> > >   |                TRACE_IRQFLAGS_SUPPORT [=3Dy] && STACKTRACE_SUPPOR=
T
> [=3Dy]
> > > &&|
> > >   |                LOCKDEP_SUPPORT [=3Dy] || PROVE_LOCKING [=3Dn] &&
> > >   |
> > >   |                DEBUG_KERNEL [=3Dy] && TRACE_IRQFLAGS_SUPPORT [=3D=
y] &&
> > >   |
> > >   |                STACKTRACE_SUPPORT [=3Dy] && LOCKDEP_SUPPORT [=3Dy
> > >  |
> > >   |
> > >  |
> > >   |
> > >  |
> > >   | Symbol: DEBUG_LOCKDEP [=3Dn]
> > >   |
> > >   | Type  : boolean
> > >  |
> > >   | Prompt: Lock dependency engine debugging
> > >   |
> > >   |   Location:
> > >  |
> > >   |     -> Kernel hacking
> > >  |
> > >   | (1)   -> Lock Debugging (spinlocks, mutexes, etc...)
> > >   |
> > >   |   Defined at lib/Kconfig.debug:957
> > >   |
> > >   |   Depends on: DEBUG_KERNEL [=3Dy] && LOCKDEP [=3Dn]
> > >  |
> > >   |
> > >  |
> > >   |
> > >  |
> > >   | Symbol: LOCKDEP_SUPPORT [=3Dy]
> > >   |
> > >   | Type  : boolean
> > >  |
> > >   |   Defined at arch/arm/Kconfig:169
> > >  |
> > >   |
> > >  |
> > >
> > >
> +-----------------------------------------------------------------(100%)-=
-+
> > >   |                                < Exit >
> > >  |
> > >
> > >
> +------------------------------------------------------------------------=
-+
> > >
> > > So in this case since the 'Selected by' says DEBUG_LOCK_ALLOC is off,
> > > then the first block (up to ||) is false, and PROVE_LOCKING is off,
> > > so the next block is false, which means all selectors of LOCKDEP are
> > > false and it is itself false.
> > >
> >
> > Tried it here.
> >
> > kernel hacking --->
> >               Lock Debugging (spinlocks, mutexes, etc...)  --->
> >                  [ ] RT Mutex debugging, deadlock
> > detection                       =E2=94=82 =E2=94=82
> >   =E2=94=82 =E2=94=82    [ ] Spinlock and rw-lock debugging: basic chec=
ks
>  =E2=94=82
> > =E2=94=82
> >   =E2=94=82 =E2=94=82    [ ] Mutex debugging: basic checks
>   =E2=94=82
> > =E2=94=82
> >   =E2=94=82 =E2=94=82    [ ] Wait/wound mutex debugging: Slowpath testi=
ng
>  =E2=94=82
> > =E2=94=82
> >   =E2=94=82 =E2=94=82    [ ] Lock debugging: detect incorrect freeing o=
f live locks
>  =E2=94=82
> > =E2=94=82
> >   =E2=94=82 =E2=94=82    [ ] Lock debugging: prove locking correctness
>   =E2=94=82
> > =E2=94=82
> >   =E2=94=82 =E2=94=82    [ ] Lock usage statistics
>   =E2=94=82
> > =E2=94=82
> >   =E2=94=82 =E2=94=82    [ ] Sleep inside atomic section checking
>  =E2=94=82
> > =E2=94=82
> >   =E2=94=82 =E2=94=82    [ ] Locking API boot-time self-tests
>  =E2=94=82
> > =E2=94=82
> >   =E2=94=82 =E2=94=82    < > torture tests for locking
> >
> > All items under Lock Debugging are disabled, yet LOCKDEP and
> TRACE_IRQFLAGS
> > remain unchanged.;-(
>
> Hit '/' Then type 'LOCKDEP' and see what it says is causing it to be on.
> Looking at the menu will not help you.
>
> --
> Len Sorensen
>
