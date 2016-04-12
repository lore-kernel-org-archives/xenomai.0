MIME-Version: 1.0
In-Reply-To: <20160412105712.GG8694@hermes.click-hack.org>
References: <CABprWpketiup8jSBhmbhO3vJ2PzOtj0uuOG8J6_eFkMJiUUeDg@mail.gmail.com>
 <20160412105712.GG8694@hermes.click-hack.org>
Date: Tue, 12 Apr 2016 13:30:59 +0200
Message-ID: <CABprWp=UKQD6u3+r4872OtSJDZ5FLkFr=q7SA+enMVu2J6OG1Q@mail.gmail.com>
From: Varun Deshpande <varun9485@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] IPIPE_LOCK Problem
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, xenomai@xenomai.org

Hello,

I have examined the options, only point 1,2 and
11) Device Drivers  =E2=86=92  Input device support  =E2=86=92  Miscellaneo=
us devices=E2=86=92   PC
Speaker support (Press N)
12) Device Drivers  =E2=86=92  Staging Drivers  (Press N)

Are not required by Xenomai, I tried to compile without touching them but
after some the I get the same output.
Other options are changed otherwise on the main screen there is a warning
regarding the same.

Also I dont have any problem with kernel 3.x but only when the kernel is
4.x, its a problem. I am not sure what I am doing wrong exactly, any
guidance is highly appreciated.

Best Regards
Varun Deshpande

On Tue, Apr 12, 2016 at 12:57 PM, Gilles Chanteperdrix <
gilles.chanteperdrix@xenomai.org> wrote:

> On Tue, Apr 12, 2016 at 11:55:15AM +0200, Varun Deshpande wrote:
> > Hello all,
> >
> > I am trying to compile Xenomai 3.0.2 with Kernel 4.1.18. I am running a
> > 32bit Ubuntu(14.04.04). I configured the kernel and changed the followi=
ng
> > options
> >
> > 1) Enable loadable module support  =E2=86=92   Forced module loading (P=
ress Y)
> > 2) Enable loadable module support  =E2=86=92   Forced module unloading =
(Press Y)
> > 3) Xenomai/cobalt   =E2=86=92  Drivers  =E2=86=92   RTnet  =E2=86=92   =
Protocol Stack  =E2=86=92  RTmac
> > Layer  =E2=86=92   NoMAC discipline for RTmac (Press M)
> > 4) Xenomai/cobalt   =E2=86=92  Drivers  =E2=86=92   RTnet  =E2=86=92   =
Drivers  =E2=86=92  (For All
> > requried Drivers Press M){Exclude Others by pressing N)
> > 5) Xenomai/cobalt   =E2=86=92  Drivers  =E2=86=92   RTnet  =E2=86=92  A=
dd=C2=ADOns  =E2=86=92 Real=C2=ADTime
> > Capturing Support (Press M)
> > 6) Power management and ACPI options  =E2=86=92  ACPI (Advanced Configu=
ration &
> > Power Interface)Support  =E2=86=92  Processor(Press N)
> > 7) Power management and ACPI options  =E2=86=92  APM (Advanced Power Ma=
nagement)
> > BIOS support (Press N)
> > 8) Power management and ACPI options  =E2=86=92   CPU Frequency scaling=
   =E2=86=92CPU
> > Frequency scaling (Press N)
> > 9) Power management and ACPI options  =E2=86=92  CPU Idle  =E2=86=92  C=
PU idle PM support
> > (Press N)
> > 10) Networking support  =E2=86=92  Networking Options  =E2=86=92  Times=
tamping in
> > PHYdevices (Press Y)
> > 11) Device Drivers  =E2=86=92  Input device support  =E2=86=92  Miscell=
aneous devices=E2=86=92
>  PC
> > Speaker support (Press N)
> > 12) Device Drivers  =E2=86=92  Staging Drivers  (Press N)
> > 13) Processor type and features -->  Continuous Memory Allocator (Press
> N)
> > 14) Processor type and features --> Transparent Huge Page Support (Pres=
s
> N)
> > 15) Processor type and features --> Allow for memory compaction (Press =
N)
> > 16) Processor type and features --> Page Migration (Press N)
>
> The missing key information here is the resulting kernel
> configuration. You likely have some option enabled that none of our
> build or run tests enables.
>
> --
>                                             Gilles.
> https://click-hack.org
>
