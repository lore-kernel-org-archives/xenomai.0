Message-ID: <4D9EB884.6020804@domain.hid>
Date: Fri, 08 Apr 2011 09:25:56 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <F73025C3-F590-4CB7-A8E1-0EFF62E9A656@domain.hid>
In-Reply-To: <F73025C3-F590-4CB7-A8E1-0EFF62E9A656@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Total system lockup doing anything real-time
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Nolan Waite <nolan@domain.hid>
Cc: xenomai@xenomai.org

Nolan Waite wrote:
> I've attached a zip containing the output of dmesg (as run just
> before running the latency test), the output of `cat
> /proc/interrupts`, and my kernel .config file. I set up netconsole
> immediately prior to running the latency test, but received nothing,
> so I believe the attached kernel log to be whole.

Is there any way you could set up a serial console instead? Could you
try running latency in text mode?

If the latency test succeeds, how do the figures it prints look?

Could you try
latency -p 1000
?

-- 
					    Gilles.

