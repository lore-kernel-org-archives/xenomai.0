Message-ID: <4F83F321.2030300@domain.hid>
Date: Tue, 10 Apr 2012 10:45:21 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4F50A422.50208@domain.hid> <4F55C306.8020307@domain.hid>
	<4F55D765.7040705@domain.hid> <4F55E390.8090706@domain.hid>
	<4F55FE81.6000904@domain.hid> <4F560A6C.2080306@domain.hid>
	<4F560B76.5080606@domain.hid> <4F5629D2.50304@domain.hid>
	<4F562B53.7070400@domain.hid> <4F562EC2.6040604@domain.hid>
	<4F56387B.40702@domain.hid> <4F575BA3.7060404@domain.hid>
	<4F576622.1030509@domain.hid> <4F57A567.7030008@domain.hid>
	<4F7C127D.2010400@domain.hid> <4F7C1484.5090406@domain.hid>
	<4F7C183F.5040009@domain.hid> <4F7F0D4E.8080906@domain.hid>
	<4F7F0E8A.70702@domain.hid> <4F7F20F0.9070007@domain.hid>
	<4F80BD10.2060200@domain.hid> <4F83F2C3.50704@domain.hid>
In-Reply-To: <4F83F2C3.50704@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] preemptive doesn't work
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Roberto Bielli <roberto.bielli@domain.hid>
Cc: xenomai@xenomai.org

On 04/10/2012 10:43 AM, Roberto Bielli wrote:
> Hi Gilles,
> 
> I don't find the end of last __ipipe_grab_irq in the trace that i send you.
> Is it correct ?

Yes, because the timer interrupt reschedules and wakes up the periodic
task. I had a look at the timer programming events, it is true that the
timer ticks more often than it should. Generally, this is an indication
that the timer frequency is not what xenomai believe it is. xenomai idea
of the timer frequency is given by __ipipe_mach_ticks_per_jiffy. Anyway,
this should not cause the timer not to tick, only to tick it more often.

What you should do now is try and reproduce the same conditions under an
unpatched linux to see if you get the same phenomenon.

Did you have a look a the processor errata ?

-- 
                                                                Gilles.

