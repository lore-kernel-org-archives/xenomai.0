Message-ID: <4F6897A5.70601@domain.hid>
Date: Tue, 20 Mar 2012 15:43:49 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <623784B6C75D274389918D358E89E8BB0B78F111@domain.hid>
In-Reply-To: <623784B6C75D274389918D358E89E8BB0B78F111@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] How do I increase CPU time limit.
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Chris Stone <chris.stone@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 03/20/2012 03:09 PM, Chris Stone wrote:
> I have a thread which uses a lot of CPU and it is receiving a SIGXCPU:
> Cpu time limit exceeded. Does this message really mean I have exceeded
> some CPU time limit? If so, how do I increase or disable the CPU time
> limit? The code that I am running has been working for quite some time
> under regular Linux and I have just ported it to Xenomai, so I doubt
> there are any infinite loops in it.

This could be the runaway thread detector triggering, after 4s of 
uninterrupted runtime (which is huge, is this intended?). This is a 
debug mechanism Xenomai implements to recover from a runaway thread 
chewing CPU in primary mode, without having to resort to the reset button.
You can either extend the grace period above the default 4s, using 
CONFIG_XENO_OPT_WATCHDOG_TIMEOUT, or disable the watchdog entirely by 
switching off CONFIG_XENO_OPT_WATCHDOG. This said, 4s is really long 
already, so the regular kernel might not cope with even more starvation 
from normal interrupts.

Other explanation would be not time-related. If 
CONFIG_XENO_OPT_DEBUG_SYNCH_RELAX is enabled, any attempt to switch to 
secondary mode while holding a real-time (Xenomai created) mutex in the 
code would trigger such signal, as a warning to point out a priority 
inversion.

>
> *Chris Stone*
>
> Senior Software Engineer
>
> Optelian
>
> 1 Brewer Hunt Way
>
> Ottawa, Ontario K2K 2B5
>
> Phone: 613-287-2000 x2106
>
> _www.optelian.com <http://www.optelian.com>_
>
>
>
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help


-- 
Philippe.

