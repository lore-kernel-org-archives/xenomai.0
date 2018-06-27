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
In-Reply-To: <CAOuPNLgbE8iySGr12b8-eRdyr5iN3jhJ38iS9aZDprJUs+zRYw@mail.gmail.com>
From: Pintu Kumar <pintu.ping@gmail.com>
Date: Wed, 27 Jun 2018 18:51:03 +0530
Message-ID: <CAOuPNLg9Tw_MK2UrazRc2Bwg0Jsi2PU=aL2tzSaDRiY6qUhFww@mail.gmail.com>
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
To: Henning Schild <henning.schild@siemens.com>
Cc: "Xenomai@xenomai.org" <xenomai@xenomai.org>

Hi,

Sorry, but both the below patches are already applied to my xenomai-next repo:
build: link dlopen libs with "nodelete"
smokey/dlopen: fix testcase

Still I am facing dlopen issue.
Is there any other patches I am missing?


Thanks,
Pintu

On Wed, Jun 27, 2018 at 6:47 PM Pintu Kumar <pintu.ping@gmail.com> wrote:
>
> Hi,
>
> One doubt, how do we clone 3.0.7 ?
> Is it part of the following branches?
>   remotes/origin/next
>   remotes/origin/stable/v3.0.x
>
> I could not find any branch with the name 3.0.7.
>
> Is all 3 patches important, or only this is fine:
> build: link dlopen libs with "nodelete"
> smokey/dlopen: fix testcase
>
> Sorry, but can you list down all 3 commits.
>
>
> Thanks,
> Pintu
>
>
>
> Thanks,
> Pintu
> On Wed, Jun 27, 2018 at 6:30 PM Pintu Kumar <pintu.ping@gmail.com> wrote:
> >
> > Dear Henning,
> >
> > Thanks so much for your reply.
> > I am actually using xenomai-next branch.
> > With last commit as:
> > commit ffb68112e2342a62a1f70916a35a3d68e875b12c
> > Author: Philippe Gerum <rpm@xenomai.org>
> > Date:   Mon May 21 12:54:59 2018 +0200
> >
> >     scripts/prepare-kernel.sh: drop left overs from obsolete ports
> >
> > Anyways, I will check with your reference commits.
> >
> > Thanks,
> > Pintu
> > On Wed, Jun 27, 2018 at 6:07 PM Henning Schild
> > <henning.schild@siemens.com> wrote:
> > >
> > > Hi Pintu,
> > >
> > > i guess you might be using v3.0.6. There are a couple of commits on top
> > > of that
> > > https://gitlab.denx.de/Xenomai/xenomai/commit/aa008686091484c88cbb809bc190133a98769a30
> > > and 2 parents
> > > All three are in v3.0.7, which hopefully solves your problem.
> > >
> > > regards,
> > > Henning
> > >
> > > Am Wed, 27 Jun 2018 16:11:43 +0530
> > > schrieb Pintu Kumar <pintu.ping@gmail.com>:
> > >
> > > > Dear Henning,
> > > >
> > > > I saw your commit regarding dlopen here:
> > > > https://xenomai.org/pipermail/xenomai/2018-February/038351.html
> > > >
> > > > We are facing dlopen error with xeno-test on arm (beagle bone) and
> > > > arm64 (hikey) boards.
> > > > Segmentation fault
> > > > /usr/xenomai/bin/smokey: test dlopen failed: Unknown error -1
> > > >
> > > > Do you have any clue regarding this issue.
> > > > Earlier xeno-test worked for us, but after this commit xeno-test is
> > > > failing.
> > > >
> > > > Currently we dont need dlopen test.
> > > > So, please let us know how to disable dlopen test to pass the
> > > > xeno-test report.
> > > >
> > > >
> > > > Thanks,
> > > > Pintu
> > > >
> > > >
> > > >
> > > > On Tue, Jun 26, 2018 at 11:07 PM Pintu Kumar <pintu.ping@gmail.com>
> > > > wrote:
> > > > >
> > > > > One more thing,
> > > > > On x86 xeno-test works fine even with dlopen.
> > > > >
> > > > > This problem is seen only of arm and arm64 boards.
> > > > >
> > > > > Thanks,
> > > > > Pintu
> > > > > On Tue, Jun 26, 2018 at 10:16 PM Pintu Kumar <pintu.ping@gmail.com>
> > > > > wrote:
> > > > > >
> > > > > > Ok Greg thanks a lot.
> > > > > >
> > > > > > Yes, I can recompile it, but for now I want to get rid of this
> > > > > > dlopen to pass rest of xeno-test.
> > > > > > Please let me know how to disable it from configure.ac
> > > > > >
> > > > > > Thanks,
> > > > > > Pintu
> > > > > > On Tue, Jun 26, 2018 at 8:57 PM Greg Gallagher
> > > > > > <greg@embeddedgreg.com> wrote:
> > > > > > >
> > > > > > > Hi,
> > > > > > >   I'll take a look at this tonight.  I'll confirm if this test
> > > > > > > is crashing on all platforms or just BB.  To disable I believe
> > > > > > > you'll have to recompile the tests.
> > > > > > >
> > > > > > > -Greg
> > > > > > >
> > > > > > > On Tue, Jun 26, 2018 at 10:43 AM, Pintu Kumar
> > > > > > > <pintu.ping@gmail.com> wrote:
> > > > > > > > Dear Greg,
> > > > > > > >
> > > > > > > > Please let me know how to disable "dlopen" test in
> > > > > > > > xenomai-next.
> > > > > > > >
> > > > > > > > I even tried, without dlopen parameter during ./configure but
> > > > > > > > still I get the same issue.
> > > > > > > > #  ./configure --enable-smp
> > > > > > > >
> > > > > > > > We did not face this issue earlier on xenomai-3 stable branch.
> > > > > > > > So, I am planning to disable it right now.
> > > > > > > > Please help!
> > > > > > > >
> > > > > > > >
> > > > > > > > Thanks,
> > > > > > > > Pintu
> > > > > > > >
> > > > > > > > On Tue, Jun 26, 2018 at 12:52 PM Pintu Kumar
> > > > > > > > <pintu.ping@gmail.com> wrote:
> > > > > > > >>
> > > > > > > >> Hi,
> > > > > > > >> I am using Kernel 4.9.51 for beagle bone black with xenomai
> > > > > > > >> patches from xenomai-next repo.
> > > > > > > >>
> > > > > > > >> I have installed xenomai-3-next using below:
> > > > > > > >> # ./scripts/bootstrap
> > > > > > > >> # ./configure --with-pic --with-core=cobalt --enable-smp
> > > > > > > >> --disable-tls --enable-dlopen-libs
> > > > > > > >> # make
> > > > > > > >> # make install
> > > > > > > >>
> > > > > > > >> After that when I run xeno-test I get below error, and the
> > > > > > > >> test stopped.
> > > > > > > >>
> > > > > > > >> # root@bdk:~# /usr/xenomai/bin/xeno-test
> > > > > > > >> ....
> > > > > > > >> ....
> > > > > > > >> vdso_access OK
> > > > > > > >> xddp skipped (no kernel support)
> > > > > > > >> Segmentation fault
> > > > > > > >> /usr/xenomai/bin/smokey: test dlopen failed: Unknown error -1
> > > > > > > >>
> > > > > > > >> If you have any clue about this error, please let me know.
> > > > > > > >>
> > > > > > > >>
> > > > > > > >> Thanks,
> > > > > > > >> Pintu
> > >

