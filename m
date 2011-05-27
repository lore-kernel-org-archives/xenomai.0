Message-ID: <4DDF475A.5080504@domain.hid>
Date: Fri, 27 May 2011 08:40:26 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4DDE8DC9.2020905@domain.hid>
In-Reply-To: <4DDE8DC9.2020905@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Huge clock drift
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jonas Witt <jonas.witt@domain.hid>
Cc: xenomai@xenomai.org

On 05/26/2011 07:28 PM, Jonas Witt wrote:
> Hi all,
> 
> i am having a problem concerning the clock drift under load:
> 
> # /usr/xenomai/bin/clocktest
> == Tested clock: 0 (CLOCK_REALTIME)
> CPU      ToD offset [us] ToD drift [us/s]      warps max delta [us]
> --- -------------------- ---------------- ---------- --------------
>    0          775571614.0       166776.858          0            0.0
> 
> 
> It remains in the hundreds of MILLIseconds, changing constantly. My 
> setup consists of an embedded Intel Atom board (1.6GHz Z530 processor) 
> with a 2.6.32.7 kernel and Xenomai 2.5.2.

Hi Jonas,

Could you try and see if 2.5.6 with latest I-pipe patches has the same
behaviour?

> Latencies under load are 
> reasonable. Mean latency < 10us. Maximum latency < 40us.
> 
> Without load the ToD offset is approximately constant over time with a 
> ToD drift in the range of 10 microseconds (strangely after a while this 
> settles in a range of 2 microseconds). Does anyone have an idea how this 
> can be caused?

First, I am not sure clocktest is meant to be use under load. Second,
does your system uses ntp?

> As a workaround I currently use rt_timer_read() in all
> relevant programs (also the non-realtime ones), since I need consistent 
> timestamps between realtime and non-realtime tasks.

In order to solve this particular issue, we have a solution, but not yet
in stable released versions.

> 
> One other (maybe unrelated) strange behavior is occasional secondary 
> mode switches when calling rt_queue_read(...).

For this error, we need more details, such as a simple test case
allowing to reproduce the issue, and again, you need to be sure to
reproduce the issue on latest stable release with latest I-pipe patches.

Regards.

-- 
                                                                Gilles.

