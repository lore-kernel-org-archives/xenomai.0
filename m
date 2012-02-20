Message-ID: <4F427796.60400@domain.hid>
Date: Mon, 20 Feb 2012 17:40:54 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <4F36B4A5.8080202@domain.hid>
In-Reply-To: <4F36B4A5.8080202@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Adeos-main] ipipe_request_tickdev issue
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/options/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Adeos <adeos-main@gna.org>

On 02/11/2012 07:34 PM, Gilles Chanteperdrix wrote:
>
> Hi,
>
> I found this out a long time ago on AT91 and worked around it but am
> starting to see the same issue on hardware which hardware timer does not
> wrap as fast: when xenomai calls ipipe_request_tickdev, the clockevent
> structure max_delta_ns member is set to ULONG_MAX, but on most ARM
> platforms, the reason for max_delta_ns is not only the timer hardware
> limit, it is also necessary to call eg. update_sched_clock at least once
> every max_delta_ns in order to avoid the hardware counter wrapping
> without the system noticing it.
>
> What do you think is the best way to avoid this issue? I would propose
> simply removing the line which does:
> 	evtdev->max_delta_ns = ULONG_MAX;

Assuming we never go through clockevents_program_event() to program the 
next real-time shot, I don't see any issue killing this line in the 
current pipeline implementation. This said, it is unlikely that we would 
want to program delays larger than what the kernel defined as the 
maximum for the clock chip anyway.

> in ipipe_request_tickdev, but maybe someone else sees a better solution.
>


-- 
Philippe.

