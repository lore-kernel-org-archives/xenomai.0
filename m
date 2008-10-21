Message-ID: <48FE00F9.6040609@domain.hid>
Date: Tue, 21 Oct 2008 18:19:05 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <loom.20081016T124807-588@domain.hid>
	<1224605536.10407.15.camel@domain.hid>
In-Reply-To: <1224605536.10407.15.camel@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Reducing Kernel Mode Interrupt Latency
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Henry Bausley <hbausley@domain.hid>
Cc: xenomai@xenomai.org

Henry Bausley wrote:
> Is there any way the kernel mode interrupt handling maximum times can be
> decreased.  I very much need to reduce my kernel mode interrupt
> latencies.  I know my hardware is capable of better performance based
> upon measurements done with RT Linux.  Below is our timing comparison,
> all times are the maximums.

I will let the PPC specialists answer, but you can:
- make sure that Xenomai is compiled in kernel and not as a module,
- increase /proc/xenomai/latency (you can write a new value to it), but
in this case, you have to accept to be woken up before the timers shots.

-- 
                                                 Gilles.

