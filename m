Message-ID: <4C053C51.4090903@domain.hid>
Date: Tue, 01 Jun 2010 18:58:57 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <20100601135005.GA5483@domain.hid>	<1275402757.27918.151.camel@domain.hid>
	<20100601155403.GA8240@domain.hid>
In-Reply-To: <20100601155403.GA8240@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Handling Linux Signals in primary domain context
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Tschaeche IT-Services <services@domain.hid>
Cc: xenomai@xenomai.org

Tschaeche IT-Services wrote:
> On Tue, Jun 01, 2010 at 04:32:37PM +0200, Philippe Gerum wrote:
>> Not in the absence of syscall. We thought about this once already, when
>> considering how a watchdog preempting a runaway task in primary mode
>> could force a secondary mode switch: there is no sane and easy solution
>> to this unfortunately.
> 
> This is exactly Sigmatek's problem: Our customers develop code
> within our debugging/development environment. We want to catch
> this situation (the developer implements a while(1)) with a
> watchdog throwing SIGTRAP so that our debugger gets active
> and can locate the problem according to the stack frame...

CONFIG_XENO_OPT_WATCHDOG is probably what you are looking for. It tries
to catch "well-behaving" broken threads via SIGDEBUG and kills the
hopelessly broken rest - system alive again.

You can then debug the former and need to do code review on the latter.
Or you could also try to add some loop-breaking Xenomai syscalls (or
even more clever checks) to library services the code under suspect
usually invokes.

Jan

-- 
Siemens AG, Corporate Technology, CT T DE IT 1
Corporate Competence Center Embedded Linux

