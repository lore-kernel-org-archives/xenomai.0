MIME-Version: 1.0
In-Reply-To: <A2E3B789-3ADD-4D70-8414-E7533CF2A6D4@mah.priv.at>
References: <e85c77d488ea4d89e8efd14cc5d82a92.squirrel@sourcetrek.com>
 <A2E3B789-3ADD-4D70-8414-E7533CF2A6D4@mah.priv.at>
Date: Fri, 12 Jun 2015 09:23:04 -0700
Message-ID: <CA+K1mPFkzcYeaaUnChRRAjYMoKXxHzjjAfZtDi79zy59S8ZVSQ@mail.gmail.com>
From: C Smith <csmithquestions@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] Does Xenomai export shared memory keys to Linux
	kernel?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai@xenomai.org

OK, thanks, Gilles and Michael for your explanation and suggestion.
What I have works for now if I link my userspace app to Xenomai,though my
goal was to stay as "standard" as possible to maintain compatibility with
legacy POSIX code.

My vote is please keep the POSIX code in Xenomai for as long as you can -
it actually works.

On Fri, Jun 12, 2015 at 3:06 AM, Michael Haberler <mah@mah.priv.at> wrote:

>
> you might look into this:
> https://github.com/machinekit/machinekit/tree/master/src/rtapi/shmdrv
>
> the shm segments created from  userland are accessible for xenomai
> kthreads and vice versa
>
> - Michael
>
>
> > Anfang der weitergeleiteten Nachricht:
> >
> > Von: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
> > Betreff: Aw: [Xenomai] Does Xenomai export shared memory keys to Linux
> kernel?
> > Datum: 10. Juni 2015 12:23:57 MESZ
> > An: "C Smith" <csmithquestions@gmail.com>
> > Kopie: xenomai@xenomai.org
> >
> >
> > C Smith wrote:
> >> I have been developing a set of shared memory applications.
> >> The first is a real time Xenomai kernelspace app which creates a block
> of
> >> shared memory. This uses shm_open(), mmap() of the POSIX skin.
> >>
> >> Once created, the shared memory shows up OK in /proc/xenomai/heap
> >> $ cat /proc/xenomai/heap
> >>    TOTAL      USED  PAGESZ  NAME
> >>  ...
> >>    12288     12288    4096  posix shm: /shared_data_unique
> >>
> >> I can then successfully mmap() this shared memory from a userspace app
> >> which includes xenomai headers and is linked to the xenomai libraries.
> >> Here is how I compiled the userspace app for xenomai:
> >> gcc -I/usr/xenomai/include -D_GNU_SOURCE -D_REENTRANT -D__XENO__
> >> -I/usr/xenomai/include/posix -Xlinker -rpath -Xlinker /usr/xenomai/lib
> >> userspace-shmem.c  -Wl,@/usr/xenomai/lib/posix.wrappers
> -L/usr/xenomai/lib
> >> -lpthread_rt -lxenomai -lpthread -lrt  -lrtdm -L/usr/xenomai/lib
> -lxenomai
> >> -lpthread -lrt -o userspace-shmem
> >>
> >> The problem is that if I compile the userspace app without xenomai, with
> >> paths to regular Linux headers, the app cannot get the shared memory
> >> segment.
> >> Here is how I compiled the userspace app without xenomai:
> >> gcc -o userspace-shmem userspace-shmem.c -lrt
> >>
> >> The call to shm_open() in the userspace app returns -1 and errno is set
> to
> >> 2 : No such file or directory.
> >>
> >> Also,
> >> ipcs -m
> >> doesnt show the existence of my shared memory key.
> >>
> >> Does xenomai export its shared memory segments to the Linux kernel? Does
> >> the Linux kernel know about them such that a plain linux app (with no
> >> xenomai linkage) would be able to access shared memory created by a
> >> xenomai
> >> kernelspace driver?
> >
> > No. If you want to share memory between a Xenomai application and plain
> > linux application, simply disable
> > CONFIG_XENO_OPT_POSIX_SHM
> >
> > As for using the POSIX skin to share memory between a "driver" and an
> > application, using the POSIX skin in kernel-space has been deprecated for
> > a long time. You want to use the RTDM skin instead and implement its mmap
> > method. Note however that it will not solve your basic issue which is
> that
> > only a Xenomai application will be able to access this shared memory.
> >
> > --
> >                    Gilles.
> >
> >
> > _______________________________________________
> > Xenomai mailing list
> > Xenomai@xenomai.org
> > http://xenomai.org/mailman/listinfo/xenomai
>
>
