Message-ID: <4D9EB96D.3090309@domain.hid>
Date: Fri, 08 Apr 2011 09:29:49 +0200
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

Could you try disabling debug in Xenomai configuration, as well as the
function tracer?


-- 
					    Gilles.

