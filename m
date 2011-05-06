Message-ID: <4DC43293.8000907@domain.hid>
Date: Fri, 06 May 2011 19:40:35 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <2A5271086BF5EA4A891F3804135DEA82069C8336@domain.hid>
In-Reply-To: <2A5271086BF5EA4A891F3804135DEA82069C8336@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Installation problem
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: BONOS Antonis <antonis.bonos@domain.hid>
Cc: xenomai@xenomai.org

On 05/06/2011 05:18 PM, BONOS Antonis wrote:
> Hello,
> 
> I'm compiling a 2.6.35.9 kernel patched with xenomai 2.5.6, on a Core I7
> PC, and experiencing problems running xeno-test, and my own real time
> programs.
> 
> I attached the .config file I used for the kernel, the dmesg log, and
> xeno-test result ( redacted because /proc/ipipe/Linux was quite
> uninterresting).
> I have a problem with theses errors, for instance with xeno-test: 
> 
> ...
> running: ./run -- -sh -T 120 -t0 # latency ....
> Xenomai: native skin or CONFIG_XENO_OPT_PERVASIVE disabled.
> (modprobe xeno_native?)
> ERROR: Module xeno_timerbench does not exist in /proc/modules
> ERROR: Module xeno_rtdm does not exist in /proc/modules
> ERROR: Module xeno_native does not exist in /proc/modules
> ERROR: Module xeno_nucleus does not exist in /proc/modules
> 
> 
> I do have compiled with CONFIG_XENO_OPT_PERVASIVE, and " modprobe
> xeno_native "  does nothing to help At startup I do have 
> [    1.246870] I-pipe: Domain Xenomai registered.
> [    1.246959] Xenomai: hal/x86_64 started.
> [    1.246972] Xenomai: scheduling class idle registered.
> [    1.246974] Xenomai: scheduling class rt registered.
> [    1.247822] Xenomai: real-time nucleus v2.5.6 (Wormhole Wizards)
> loaded.
> [    1.247978] Xenomai: starting native API services.
> [    1.247980] Xenomai: starting POSIX services.
> [    1.247996] Xenomai: starting RTDM services.
> 
> 
> I'm quite stuck with this issue, I've tried searching on the net, but
> I'm unable to find a pr <<.config>> o <<dmesg.log>> b <<xeno-test.log>>
> lem similar to this one

Could you try configuring xenomai user-space support with
--enable-x86-sep if you have not done it yet? Or on the contrary disable
it if it is enabled?

-- 
                                                                Gilles.

