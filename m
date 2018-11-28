MIME-Version: 1.0
References: <CAOuPNLias38WgrA7SeQxC-Nh47q7kM8vRVR=ex_yFzQT1pnDZg@mail.gmail.com>
 <CAOuPNLgNoHKH5EA3aanAqSMXQn1Y25oM3rCWNN7-5DUJxc=sBQ@mail.gmail.com>
 <CALLqZ8TNfqRY0vqfCqExS+CxWGqTDe9Tm5-q3sMzbaY5Vi1nHQ@mail.gmail.com>
 <CAOuPNLjpiUzDTskhMHfRpqsoPU_1gd1n3PrXa=K0GGbsG+WoNA@mail.gmail.com>
 <CAOuPNLi0k3KmzKJjyE5vqQmW-92DoRXyB+pGMqqwSiwY7Tz8Sw@mail.gmail.com>
 <CAOuPNLhQ-f_wm9u8ikWf_yB43f6c+8f8bm8zo36vEE+43ZpKtQ@mail.gmail.com>
 <20180627143752.648bb696@md1pvb1c.ad001.siemens.net>
 <CAOuPNLjW5AY1yMYux4FQXzvzd6FpyTP8tZ4JEJq3DZa3C5kiuA@mail.gmail.com>
 <CAOuPNLgbE8iySGr12b8-eRdyr5iN3jhJ38iS9aZDprJUs+zRYw@mail.gmail.com>
 <CAOuPNLg9Tw_MK2UrazRc2Bwg0Jsi2PU=aL2tzSaDRiY6qUhFww@mail.gmail.com>
 <20180628173615.10a16310@md1pvb1c.ad001.siemens.net>
 <CAOuPNLgBVJPHOyzOypiCG0VkAZMG+EjSe-cAjALKS=rXm8t27w@mail.gmail.com>
 <20180629174205.70feb18e@md1pvb1c.ad001.siemens.net>
 <e7a00208-aa12-7896-9a59-4d821ec6e35c@xenomai.org>
 <20180629180708.52975276@md1pvb1c.ad001.siemens.net>
 <CAOuPNLi-20WpAYQ=ZWg_JRqKWFarso-qhcHkkBdVomrbNda5sQ@mail.gmail.com>
 <CAOuPNLj1YCGUN9wSmP01d6k_YQZUgRim3kRQk_5ni0g_X+yvRQ@mail.gmail.com>
 <CAOuPNLi9YWoy2a=_LovkA5yuSgzwjmbkXAtuffcrZWdv7prKbA@mail.gmail.com>
In-Reply-To: <CAOuPNLi9YWoy2a=_LovkA5yuSgzwjmbkXAtuffcrZWdv7prKbA@mail.gmail.com>
From: Pintu Agarwal <pintu.ping@gmail.com>
Date: Wed, 28 Nov 2018 17:39:18 +0530
Message-ID: <CAOuPNLiUSDcMGbA7e1q-7gnTLSFcRAZcTSwxe-=zG=0VEYycSQ@mail.gmail.com>
Subject: Re: beaglebone: arm: xeno-test gives segmentation fault - test dlopen
 failed
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Henning Schild <henning.schild@siemens.com>
Cc: Philippe Gerum <rpm@xenomai.org>, Greg Gallagher <greg@embeddedgreg.com>, "Xenomai@xenomai.org" <xenomai@xenomai.org>

Hi,

What is the problem with "rt_queue_create" in the below code:

static size_t def_mem_pool_size = 1024 * 1024;
int libalchemy_func(void)
{
        RT_QUEUE queue;
        int ret=0;

        printf("%s called..\n", __func__);

 //       ret = rt_queue_create(&queue, "q0", def_mem_pool_size,
 //                     Q_UNLIMITED, Q_FIFO);
        if (ret) {
                printf("rt_queue_create - failed...\n");
                return ret;
        }
//      ret = rt_queue_delete(&queue);

        return ret;
}

xenomai-3/testsuite/smokey/dlopen# ./dlopentest
Segmentation fault

The dlopentest gives Segmentation Fault only if rt_queue_create is
invoked, else it works.
However, libposix-test.so works without any issue.

Any clue on this?

Thanks,
Pintu

On Tue, Nov 27, 2018 at 6:30 PM Pintu Agarwal <pintu.ping@gmail.com> wrote:
>
> On Tue, Nov 27, 2018 at 3:28 PM Pintu Agarwal <pintu.ping@gmail.com> wrote:
> >
> > Dear Henning, Greg and all,
> >
> > Sorry, re-checking after a long time.
> >
> > The dlopen test is still failing on Beagle Bone black with xenomai-3.
> > Yesterday, I just freshly cloned the xenomai-3 repo, build and install
> > on beagle bone black, then run xeno-test/smokey test.
> > Found that dlopen test is still crashing. I though this issue is
> > already fixed, but not.
> >
> > Here are the results:
> >
> > ~/xenomai-3# cat .git/config
> > url = https://git.xenomai.org/xenomai-3.git
> >
> > ~/xenomai-3# git branch
> > * master
> >
> > ./configure --with-pic --with-core=cobalt --enable-smp --disable-tls
> > --enable-dlopen-libs
> > make
> > make install
> >
> > :/usr/xenomai/bin# ./smokey --run
> > arith OK
> > bufp skipped (no kernel support)
> > cpu_affinity OK
> > fpu_stress OK
> > iddp skipped (no kernel support)
> > leaks OK
> > memory_coreheap OK
> > memory_heapmem OK
> > memory_tlsf OK
> > net_packet_dgram skipped (no kernel support)
> > net_packet_raw skipped (no kernel support)
> > net_udp skipped (no kernel support)
> > posix_clock OK
> > posix_cond OK
> > posix_fork OK
> > posix_mutex OK
> > posix_select OK
> > rtdm skipped (no kernel support)
> > sched_quota skipped (no kernel support)
> > sched_tp skipped (no kernel support)
> > setsched OK
> > sigdebug skipped (no kernel support)
> > timerfd OK
> > tsc OK
> > vdso_access OK
> > xddp skipped (no kernel support)
> > Segmentation fault
> > ./smokey: test dlopen failed: Unknown error -1
> >
> > ~/xenomai-3# /usr/xenomai/bin/dlopentest
> > Segmentation fault
> >
> > So, basically, dlopentest results into Segmentation Fault on arm.
> >
> > Note:
> > Disabling dlopen from "configure" does not cause this issue, and
> > xeno-test/smokey test pass successfully.
> > But I am wondering why dlopen test may fail on arm (on x86 it works).
> >
> > So, it some packages or configuration that I am missing on my Beagle Bone ?
> > Can anybody describe the root cause (if already investigated earlier)...
> >
>
> Hi,
>
> I am investigating this issue.
> Currently I found that normal "dlopen" tests is working fine on Beagle Bone.
> There is some crash happening in: my_dlopen()
>
> Hopefully, I might be able to fix this issue and release a patch, in 2
> weeks times.
>
> Thanks,
> Pintu
>
> > Thanks,
> > Pintu
> >
> > On Fri, Jun 29, 2018 at 10:42 PM Pintu Kumar <pintu.ping@gmail.com> wrote:
> > >
> > > On Fri, Jun 29, 2018 at 9:37 PM Henning Schild
> > > <henning.schild@siemens.com> wrote:
> > > >
> > > > Am Fri, 29 Jun 2018 17:52:44 +0200
> > > > schrieb Philippe Gerum <rpm@xenomai.org>:
> > > >
> > > > > On 06/29/2018 05:42 PM, Henning Schild wrote:
> > > > > > Hi,
> > > > > >
> > > > > > i had a closer look. You might want to revert the following commit
> > > > > > https://gitlab.denx.de/Xenomai/xenomai/commit/408c93e26438c83c08f216a2c8bd7079253cf71a
> > > > > >
> > > > > > It does include the testcase in the build even if the feature is
> > > > > > disabled.
> > > > > >
> > > > >
> > > > > I don't think so. It includes the testcase in the source distribution
> > > > > allowing "make distcheck" to succeed, even if the test has not be
> > > > > built in the smokey driver, which fixes a build regression introduced
> > > > > by dlopen. Tests built in the executable must be listed in
> > > > > COBALT_SUBDIRS, which dlopen isn't unless --enable-dlopen-libs has
> > > > > been given.
> > > >
> > > > Yes, you are right. I just saw a "+= dlopen" in the resulting Makefile
> > > > but that should not cause the problem.
> > > >
> > > > Pintu: Please build in a completely fresh environment i.e. "git clean
> > > > -dfx; autoreconf -i; ./configure". And now give me
> > > >
> > > > grep dlopening -A1 config.log
> > > > grep am__append_1 testsuite/smokey/Makefile
> > > > autoreconf --version
> > > >
> > >
> > > OK. Thank you so much.
> > > I will try this on Monday and let you know.
> > >
> > > > Ideally with a hash i can find on gitlab.denx.de.
> > > >
> > > > Henning
> > > >
> > > >
> > > > > If you want to exclude the dlopen test from the test series at
> > > > > runtime, you can pass "--exclude=dlopen" on the command line to
> > > > > smokey, as mentioned in the help strings (smokey --help).
> > > > >
> > >
> > > OK. Thanks for this info. However, when I run xeno-test it
> > > automatically includes smokey test.
> > > How do I exclude from xeno-test itself ?
> > > We have a criteria to attach xeno-test report as the success result.
> > >
> > > >

