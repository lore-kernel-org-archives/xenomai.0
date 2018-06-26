MIME-Version: 1.0
References: <CAOuPNLias38WgrA7SeQxC-Nh47q7kM8vRVR=ex_yFzQT1pnDZg@mail.gmail.com>
 <CAOuPNLgNoHKH5EA3aanAqSMXQn1Y25oM3rCWNN7-5DUJxc=sBQ@mail.gmail.com>
 <CALLqZ8TNfqRY0vqfCqExS+CxWGqTDe9Tm5-q3sMzbaY5Vi1nHQ@mail.gmail.com>
 <CAOuPNLjpiUzDTskhMHfRpqsoPU_1gd1n3PrXa=K0GGbsG+WoNA@mail.gmail.com>
In-Reply-To: <CAOuPNLjpiUzDTskhMHfRpqsoPU_1gd1n3PrXa=K0GGbsG+WoNA@mail.gmail.com>
From: Pintu Kumar <pintu.ping@gmail.com>
Date: Tue, 26 Jun 2018 23:07:01 +0530
Message-ID: <CAOuPNLi0k3KmzKJjyE5vqQmW-92DoRXyB+pGMqqwSiwY7Tz8Sw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Xenomai] beaglebone: arm: xeno-test gives segmentation fault -
	test dlopen failed
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Greg Gallagher <greg@embeddedgreg.com>
Cc: "Xenomai@xenomai.org" <xenomai@xenomai.org>

One more thing,
On x86 xeno-test works fine even with dlopen.

This problem is seen only of arm and arm64 boards.

Thanks,
Pintu
On Tue, Jun 26, 2018 at 10:16 PM Pintu Kumar <pintu.ping@gmail.com> wrote:
>
> Ok Greg thanks a lot.
>
> Yes, I can recompile it, but for now I want to get rid of this dlopen
> to pass rest of xeno-test.
> Please let me know how to disable it from configure.ac
>
> Thanks,
> Pintu
> On Tue, Jun 26, 2018 at 8:57 PM Greg Gallagher <greg@embeddedgreg.com> wrote:
> >
> > Hi,
> >   I'll take a look at this tonight.  I'll confirm if this test  is
> > crashing on all platforms or just BB.  To disable I believe you'll
> > have to recompile the tests.
> >
> > -Greg
> >
> > On Tue, Jun 26, 2018 at 10:43 AM, Pintu Kumar <pintu.ping@gmail.com> wrote:
> > > Dear Greg,
> > >
> > > Please let me know how to disable "dlopen" test in xenomai-next.
> > >
> > > I even tried, without dlopen parameter during ./configure but still I
> > > get the same issue.
> > > #  ./configure --enable-smp
> > >
> > > We did not face this issue earlier on xenomai-3 stable branch.
> > > So, I am planning to disable it right now.
> > > Please help!
> > >
> > >
> > > Thanks,
> > > Pintu
> > >
> > > On Tue, Jun 26, 2018 at 12:52 PM Pintu Kumar <pintu.ping@gmail.com> wrote:
> > >>
> > >> Hi,
> > >> I am using Kernel 4.9.51 for beagle bone black with xenomai patches
> > >> from xenomai-next repo.
> > >>
> > >> I have installed xenomai-3-next using below:
> > >> # ./scripts/bootstrap
> > >> # ./configure --with-pic --with-core=cobalt --enable-smp --disable-tls
> > >> --enable-dlopen-libs
> > >> # make
> > >> # make install
> > >>
> > >> After that when I run xeno-test I get below error, and the test stopped.
> > >>
> > >> # root@bdk:~# /usr/xenomai/bin/xeno-test
> > >> ....
> > >> ....
> > >> vdso_access OK
> > >> xddp skipped (no kernel support)
> > >> Segmentation fault
> > >> /usr/xenomai/bin/smokey: test dlopen failed: Unknown error -1
> > >>
> > >> If you have any clue about this error, please let me know.
> > >>
> > >>
> > >> Thanks,
> > >> Pintu

