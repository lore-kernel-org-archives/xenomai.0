MIME-Version: 1.0
Sender: had2006@gmail.com
In-Reply-To: <54F6EF2E.1090705@xenomai.org>
References: <CAKk99t1N5b0_iQerSxPyKmMTLC8PePTJCO9zzFLdkmt_mDiiVg@mail.gmail.com>
 <54F58A4C.7030006@xenomai.org>
 <CAKk99t3_g0ZODEe32KGAzfHckWC=-Gqr6CrFa5yRh-hLF5Ttow@mail.gmail.com>
 <54F5BE3F.4010008@xenomai.org> <54F5C020.8090102@xenomai.org>
 <CAKk99t14k19FhkgMm1FymkjaKWngMG3FQL8mkm6tBOdth4X7sQ@mail.gmail.com>
 <54F5CD4D.8080004@xenomai.org>
 <CAKk99t22fhrbc0GwURNJjdUfVfwmBvVyAWYYArVMgJfh4_JF+Q@mail.gmail.com>
 <54F5D6C6.40908@xenomai.org>
 <CAKk99t13XsRYBA15ws6ZbUsrqe5+b7D1xRM5NGKrUkvrLJWPCw@mail.gmail.com>
 <54F5E958.2090701@xenomai.org> <54F5EA06.4040104@xenomai.org>
 <CAKk99t1DtxOFmTpf2ZgJ2coh_tNqMPY4VX0pAdEJZB6oGvko3g@mail.gmail.com>
 <54F60A62.3020708@xenomai.org> <54F60C16.5070500@xenomai.org>
 <CAKk99t0qwyG2wuMAvQ7U-Ed_AR7jJ3vK=Ok4dK5kLj1VbrvxUg@mail.gmail.com>
 <54F614EF.7040307@xenomai.org>
 <CAKk99t0Xh01uxG7jd=oEDD71LBHvTnbCnejwiP2bzGN63Yo-ZA@mail.gmail.com>
 <54F6C50F.5040301@xenomai.org>
 <CAKk99t1LaQg9HJkXuiXbi09Mhr5H2EXqcmHw5PPTN4=V7mT3Dg@mail.gmail.com>
 <54F6EF2E.1090705@xenomai.org>
Date: Wed, 4 Mar 2015 14:25:03 +0000
Message-ID: <CAKk99t3K=+Eo+Z_+nPEgi6FNWzg8gigZGfMnVW3Ap+XkVb5aTg@mail.gmail.com>
From: Helder Daniel <hdaniel@ualg.pt>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] Xenomai/cobalt: low_init(): binding failed: Function
 not implemented error issued when trting to run latency app on xeno 3.x-rc3
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: "Xenomai@xenomai.org" <Xenomai@xenomai.org>

I reinstalled xenomai with pshared enabled but it still do not work.
Second process gives now a segmentation fault when trying to bind.
If executed with --no-registry (it will not bind of course) but it does not
segment fault also.

/usr/xenomai/sbin/version -a
Xenomai/mercury v3.0-rc3 --
Target: i686-pc-linux-gnu
Compiler: gcc version 4.7.2 (Debian 4.7.2-5)
Build args:  '--with-core=mercury' '--enable-registry' '--enable-pshared'
'--prefix=/usr/xenomai'


On 4 March 2015 at 11:40, Philippe Gerum <rpm@xenomai.org> wrote:

> On 03/04/2015 12:21 PM, Helder Daniel wrote:
> > Ok.
> > This way I can recover registry.
> > I did not find yet when and why registry crashes.
> > If I found the scenario I'll report it.
> >
> > Meanwhile I am having roubles binding to a semaphore created in one
> > process, from another process.
> > I used a simple demo app to show what is happening (full source code
> > attached)
> >
> > From one process (creator.c) a semaphore is created and binded by its
> > registry name "namedSem":
> >
> > rt_task_shadow (&task, "creatorTask", 20, 0);
> > rt_sem_create(&sem, "namedSem", 0, S_FIFO);
> > rt_sem_bind(&sem, "namedSem", TM_INFINITE);
> > for (;;) sleep (100);
> >
> > So all ok here.
> >
> > Now keeping creator.c running in an xterm and trying to bind to this
> > semaphore from another process (binder.c), from another xterm, it does
> > not work:
> >
> > rt_task_shadow (&task, "binderTask", 20, 0);
> > rt_sem_bind(&sem, "namedSem", TM_INFINITE);
> >
> > rt_sem_bind() never binds to the semaphore "namedSem".
> > It seams it does not find it.
> > If a timeout is set:
> >
> > err=rt_sem_bind(&sem, "namedSem", TM_INFINITE);
> >
> > it returns with error -110 (ETIMEDOUT)
> >
> > But the semaphore exists in registry:
> >
> > $> cat /var/run/xenomai/anon/4267/alchemy/semaphores/namedSem
> > =0
> >
> > I think on version 2.5.x a named object is global to the system.
> > So when creating a semaphore named "namedSem" by a process it is visible
> > for all other processes.
> >
> > Maybe in 3.x semaphores (and other objects) are local to processes?
> > Since they are stored in the registry under the pid of the creator
> process?
>
> With 3.x, --enable-pshared must be passed to enable object sharing
> between processes. The actual registry is not maintained in kernel space
> anymore, so the support libraries have to know whether they should
> maintain it.
>
> --
> Philippe.
>



-- 
Helder Daniel
UALG - FCT
DEEI

http://w3.ualg.pt/~hdaniel
