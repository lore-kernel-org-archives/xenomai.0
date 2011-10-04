MIME-Version: 1.0
In-Reply-To: <20111004091011.AE85F1D2@domain.hid>
References: <20110926090226.9C75AD68@domain.hid>
	<20111003103914.8A2B636C@centrum.cz>
	<CAPASGLohhztGb0h97QAReSS1z3p++iPOEhNfEGXew3A9P5VmZw@domain.hid>
	<20111004091011.AE85F1D2@domain.hid>
Date: Tue, 4 Oct 2011 09:39:09 +0200
Message-ID: <CAPASGLr9mJfredUkfQTMS1q5kCU9uVNCQRMR6jxFrueQZnKj7g@domain.hid>
From: Eric Noulard <eric.noulard@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
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
To: Petr Cervenka <grugh@domain.hid>, Xenomai help <xenomai@xenomai.org>

2011/10/4 Petr Cervenka <grugh@domain.hid>:
>
>> On Mon, Oct 3, 2011 at 4:39 AM, Petr Cervenka <grugh@domain.hid> wrote:
>
>> > =A0Any ideas that could help me?
>
>> What about looking at /proc/cpuinfo while running your system ? If you
>> see that the speed is not the maximal, indeed, the frequency scaling
>> system changes the speed of the processor.
>
> /proc/cpuinfo shows always full frequency clock (3292.500 MHz)
>
> More details:
> 1) two xenomai tasks are running with 100us period (controlled by externa=
l hardware)
> 2) one task communicates with hardware (receives data via rtnet) and pass=
es them by rt_queue to the second task (on =A0another core)
> 3) second task does some computations and returns processed data to the f=
irst task
> 4) first task sends data to hardware
>
> The problem is that during waiting on new data from hw CPU puts itself in=
 some deeper idle state with lower frequency. A then, when the data are ava=
ilable, it slowly wakes up to normal state.
> In other words: computation takes longer time than it takes on older comp=
uters (depends on overall CPU load).
> When some artificial 100% load is running on another core, the computatio=
n is as fast as it should be.

Then may be you should ask your computer provider (for the BIOS main board)
and/or intel representative (for more info. about Sandy Bridge dynamic
frequency features)
whether if it's an expected behavior of this kind of processor to
behave like that?

I think it would be nice to know because you assume the processor is
"slowing down" but this
cannot be stated from usual way monitoring processor frequency.

That said, from this small pieces of informations:
http://www.anandtech.com/show/3922/intels-sandy-bridge-architecture-exposed=
/7

Sandy Bridge seems to be a deterministic computing nightmare,
unless all those nice features (TurboBoost and the like) could be disabled =
...
I mean for sure not theoretically.

May be the BIOS is flawed and it is not disabling the dynamic
frequency features properly?
--=20
Erk
Membre de l'April - =AB promouvoir et d=E9fendre le logiciel libre =BB -
http://www.april.org

