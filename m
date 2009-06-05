Message-ID: <4A2920C7.40200@domain.hid>
Date: Fri, 05 Jun 2009 15:42:31 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4A28F029020000F80002DB14@domain.hid>	<4A28FAD4020000F80002DB27@domain.hid>
	<4A28FAD7.3E52.00F8.0@domain.hid><4A28FAD7.3E52.00F8.0@domain.hid>
	<4A28E5E0.9020805@domain.hid> <4A2907EF.3E52.00F8.0@domain.hid>
In-Reply-To: <4A2907EF.3E52.00F8.0@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] IRQ-Latency when in idle State on ARM
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Karl Tyss <tyss.k@domain.hid>
Cc: xenomai@xenomai.org

Karl Tyss wrote:
> Hi,
> 
> thank you for the quick answer.
> 
> The idea with deactivating the caches is to see if they are influencing
> this behavior. I also tried out the FCSE option and it did not help. My
> issue is that if there is a user space application that starts lots of
> short processes/threads and sleeps for a short time, in this case I get
> a large jitter. Till this point I was able to find out that it makes a
> difference if the idle task is running. 
> 
> These simple tests I was running weren't supposed to be relevant stress
> tests. I only tried to prevent the kernel entering the idle task and the
> simplest way was to start an endless loop doing noting.
> 
> So my question was actually is there any explanation to this behavior
> and in both cases (yes or no) is this behavior predictable? Perhaps one
> can avoid this by modifying the cpu_idle task, so that the system
> doesn't necessarily go in a sleep mode.

Ok. If I understand correctly, the AT91SAM9G20 uses an arm926ejs core,
and in arch/arm/mm/proc-arm926.S, the idle function disables and
re-enables the I-cache, so, that may be the source of your problems.

-- 
					    Gilles.

