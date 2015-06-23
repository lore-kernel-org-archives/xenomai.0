MIME-Version: 1.0
In-Reply-To: <20150623160736.GL17436@csclub.uwaterloo.ca>
References: <CAOL1OyMgNHaY4tgbUXM0Ytm9YnR3VGaJN-c60_5fuMayjz4aSw@mail.gmail.com>
 <558843FB.3040704@siemens.com>
 <CAOL1OyOWmGY2TFo6LaydWmeFqThHnVHNHtgk_iFZJ9aiwOM6uw@mail.gmail.com>
 <5588FA58.2080403@siemens.com>
 <CAOL1OyMJ9BS8jHWrHHVeCbP7tYJ7-Kgz6KzB4DAkBDpAGENUVA@mail.gmail.com>
 <20150623141142.GK17436@csclub.uwaterloo.ca> <55896A1A.2030408@siemens.com>
 <c2c68cadb110b6c7963aa06cadde978b.squirrel@sourcetrek.com>
 <CAOL1OyM2ViCuuD1BPRze0yhX6cSNqCRxMvu3mM=frnXA5Ly5NA@mail.gmail.com>
 <20150623160736.GL17436@csclub.uwaterloo.ca>
From: Antoine Durand <wanipof@gmail.com>
Date: Tue, 23 Jun 2015 18:18:05 +0200
Message-ID: <CAOL1OyOdg9S=G412PAsiJCkaSii9Pgu17a_0=gOHaOyr=fHaDQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] I-Pipe Tracer and linux ftrace
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@xenomai.org

booting with 'maxcpus=2' in my case has the same behavior than
CONFIG_NR_CPUS=2
the clocksource switche to refined-jiffies and system time is wrong (very
very slow)

I only get
refined-jiffies jiffies and tsc
in /sys/devices/system/clocksource/clocksource0/available_clocksource

the 8254 isn't seen.


2015-06-23 18:07 GMT+02:00 Lennart Sorensen <lsorense@csclub.uwaterloo.ca>:

> On Tue, Jun 23, 2015 at 04:41:06PM +0200, Antoine Durand wrote:
> > The clocksource switching is due to the config option
> >
> > CONFIG_NR_CPUS=2
> >
> > the CPU is quad core and i would like to use only two of them to emulate
> a
> > cheaper board.
> >
> > now the time run normally
> >
> > i will check if the other problems are resolved.
>
> Wouldn't booting with 'maxcpus=2' be good enough for that test and avoid
> any breaking of the system?
>
> --
> Len Sorensen
>
