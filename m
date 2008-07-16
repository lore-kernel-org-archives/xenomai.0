Message-ID: <487D9520.3080505@domain.hid>
Date: Wed, 16 Jul 2008 08:28:48 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <487CF556.5090309@domain.hid>
	<b1ff76438a96cc50798c2d82c0d50e09@domain.hid>
In-Reply-To: <b1ff76438a96cc50798c2d82c0d50e09@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] xenomai scheduler's ticks period
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: matthieu.connaulte_xenomai@domain.hid
Cc: xenomai@xenomai.org

Matthieu wrote:
> 
> On Tue, 15 Jul 2008 21:07:02 +0200, Philippe Gerum <rpm@xenomai.org> wrote:
>> Matthieu wrote:
>>> Hi,
>>>
>>> I would like to know if you finally plan to implement
>> xntbase_bind/unbind ?
>> Why?
> 
> You told in one of your answers :
> 
> Normally, solving your issue would require to make the master timebase
> paced by your PCI card, which would in turn provide the correct timing for
> the VxWorks timebase (as the timebase doc states, periodic timebases are
> cascaded from the master aperiodic one). However, doing so would also
> require to adapt the Xenomai HAL code accordingly, and a PCI hw that is
> oneshot programmable as well.
> 
> If you want to hack the Xenomai timer sub-system in order to only affect
> the VxWorks timebase, what you actually need is to control the coupling
> between the master timebase (paced by decrementer) and the slave VxWorks
> one, so that decrementer ticks may be prevented from kicking the VxWorks
> timebase. This way, you would be able to call tickAnnounce() freely to
> announce any incoming VxWorks tick (i.e. from your PCI handler).
> 
> In short, when paced by the PCI interrupt, you will need to:
> 
> - call xntslave_stop(base2slave(wind_tbase))
> - call tickAnnounce() from your PCI IRQ handler
> 
> When paced normally (simulation, "somebody stole by PCI card" mode), just
> leave the burden to the system timer (i.e. ppc decrementer) as usual, by
> coupling the VxWorks slave timebase to the master one anew:
> 
> - call xntslave_start(base2slave(wind_tbase),  xnarch_get_cpu_time() +
> period, period); /* period is given in nanoseconds, depends on the master
> timebase */
> 
> In any case, you don't need to change the VxWorks tick period.
> Starting/stopping the VxWorks timebase should do the trick. NOTE: this is a
> hack exposing Xenomai internals -- we should probably encapsulate this into
> new xntbase_bind/unbind calls if this does eventually works for you.
> 
> ...End of quote.
> 
> Well, it works for me. So do you intend to implement xntbase_bind/unbind
> calls or do I use directly xntslave_start/stop ? Both solutions are ok for
> me ...
>

Well, "it works for me" is the kind of feedback I have been waiting for so far.
In extenso, my latest reply should read as: "why do you want me to care about
xntbase_bind/unbind, since I have no idea of whether my suggestion worked for
you or not?".

Now that I do have that information, the answer to your question is yes, likely.
ETA: undefined yet.

-- 
Philippe.

