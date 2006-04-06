Message-ID: <44354B75.5070101@domain.hid>
Date: Thu, 06 Apr 2006 19:10:13 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Frozen timer IRQ
References: <4432E540.1010108@domain.hid>	<17459.46030.997560.684058@domain.hid>
	<4433BA43.7000807@domain.hid> <4433C087.3020403@domain.hid>
	<44341AE6.5030804@domain.hid>
In-Reply-To: <44341AE6.5030804@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
> Philippe Gerum wrote:
> 
>>Philippe Gerum wrote:
>>
>>>Gilles Chanteperdrix wrote:
>>>
>>>
>>>>Jan Kiszka wrote:
>>>> > Hi,
>>>> >  > my colleagues and I need some hint where to continue our search
>>>>for the
>>>> > cause of a weird cleanup issue:
>>>> >  > An application of our robotics framework sometimes terminates
>>>>(though
>>>> > successfully) in a way that the system timer IRQ no longer arrives
>>>> > afterwards or no re-program takes place anymore. All other Linux IRQs
>>>> > are fine (Ethernet, keyboard, etc.). I cannot provide an easy test
>>>>case
>>>> > yet as besides the framework some expensive gyroscope and the 16550A
>>>> > driver are involved.
>>>>
>>>>I observed a similar issue when xnpod_stop_timer was called when
>>>>shutting down the posix skin. I assumed that the problem was that
>>>>xnpod_shutdown already called xnpod_stop_timer, so xnpod_stop_timer (and
>>>>in particular xnarch_stop_timer) ended up being called twice.
>>>>
>>>
>>>Err, sorry. Forget about my previous reply: xnarch_stop_timer is _not_
>>>protected by the XNTIMED flag, but only the last part of the
>>>housekeeping chores performed upon stopping the systimer are. IOW,
>>>this is a latent bug, and xnpod_stop_timer should be fixed.
>>>
>>
>>Commit 884 should do that.
>>
> 
> 
> Sorry for replying late: nope, this has no influence on our issue.
> 

This fix was not intended to address this issue, but rather to cleanup 
the timer management code so that multiple releases as described by 
Gilles don't cause havoc anymore, hopefully. So that's ok.

-- 

Philippe.

