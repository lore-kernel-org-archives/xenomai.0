Message-ID: <2ff1a98a0711260204pe62112eg286b578d7a8e8742@domain.hid>
Date: Mon, 26 Nov 2007 11:04:54 +0100
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <e4ef24880711260136h885899aw1dd4e8342d9a2bd1@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <e4ef24880711260132h730207b3j5629ff42805add6d@domain.hid>
	<e4ef24880711260136h885899aw1dd4e8342d9a2bd1@domain.hid>
Subject: Re: [Xenomai-help] Xenomai on a Dell 6850; /usr/xenomai/bin/latency
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Robert Gubler <rgubler@domain.hid>
Cc: xenomai@xenomai.org

On Nov 26, 2007 10:36 AM, Robert Gubler <rgubler@domain.hid> wrote:
> Typo correction:  I am using the adeos-ipipe-2.6.22-i386-1.10-12.patch
>
>
>
>
>
> On Nov 26, 2007 1:32 AM, Robert Gubler <rgubler@domain.hid> wrote:
>
> > I am trying to get Xenomai 2.4-rc6 running on an SMP machine.  I am
> running a 2.6.22 kernel, with adeos-ipipe-2.6.23-i386-1.10-12.patch.
> >
> > After building the kernel I ran /usr/xenomai/bin/latency as a sanity
> check.  This is what I am getting as output:
> >
> > == Sampling period: 100 us
> > == Test mode: periodic user-mode task
> > == All results in microseconds
> > warming up...
> > RTT|  00:00:09  (periodic user-mode task, 100 us period, priority 99)
> > RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat
> worst
> > RTD|     -32.686| -352137.118| -230860.905|249855280|     -32.686|
> -230860.905
> > RTD|     -36.039| -609219.441| -883326.616|481801356|     -36.039|
> -883326.616
> > RTD|     -31.010| -259632.371| -151198.013|735561242|      -36.039|
> -883326.616
> > RTD|     -32.686| -578358.265| 1084683.558|968914361|     -36.039|
> 1084683.558
> >
> >
> >
> > It took a few attempts to Xenomai to build, in a way that the executables
> in /usr/xenomai/bin/ would execute without complaining:
> >
> > (required="sep tsc", present="sep", missing="tsc").
> >
> > The arguments that ended up making it work were:
> >
> > ./configure --enable-x86-sep --disable-x86-tsc
> >
> >
> > Any thoughts or suggestions as to whats going on?  This machine has
> considerably more 'horsepower' than the Desktop machines I am also running
> Xenomai on.  But, these latency times are *way* out there.

Could you try compiling the kernel for a processor which has a tsc ?
It is usually a good idea to select in kernel configuration the real
processor on which the kernel is going to run, it allows Linux
makefiles to pass the best optimization options for your processor to
gcc.

Also, since you run on SMP, you should pass the --enable-smp option to
Xenomai user-space configure script.

-- 
                                               Gilles Chanteperdrix

