Date: Tue, 04 Oct 2011 09:10:11 +0200
From: "Petr Cervenka" <grugh@domain.hid>
References: <20110926090226.9C75AD68@domain.hid>,
	<20111003103914.8A2B636C@centrum.cz>
	<CAPASGLohhztGb0h97QAReSS1z3p++iPOEhNfEGXew3A9P5VmZw@domain.hid>
In-Reply-To: <CAPASGLohhztGb0h97QAReSS1z3p++iPOEhNfEGXew3A9P5VmZw@domain.hid>
MIME-Version: 1.0
Message-Id: <20111004091011.AE85F1D2@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] Frequency downscaling of new intel CPU
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai-help <xenomai@xenomai.org>


> On Mon, Oct 3, 2011 at 4:39 AM, Petr Cervenka <grugh@domain.hid> wrote:

> >  Any ideas that could help me?

> What about looking at /proc/cpuinfo while running your system ? If you
> see that the speed is not the maximal, indeed, the frequency scaling
> system changes the speed of the processor.

/proc/cpuinfo shows always full frequency clock (3292.500 MHz)

More details:
1) two xenomai tasks are running with 100us period (controlled by externa=
l hardware)
2) one task communicates with hardware (receives data via rtnet) and pass=
es them by rt_queue to the second task (on  another core)
3) second task does some computations and returns processed data to the f=
irst task
4) first task sends data to hardware

The problem is that during waiting on new data from hw CPU puts itself in=
 some deeper idle state with lower frequency. A then, when the data are a=
vailable, it slowly wakes up to normal state.
In other words: computation takes longer time than it takes on older comp=
uters (depends on overall CPU load).
When some artificial 100% load is running on another core, the computatio=
n is as fast as it should be.

Petr

