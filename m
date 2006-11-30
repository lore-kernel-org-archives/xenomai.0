Message-ID: <456E9BAC.3060508@domain.hid>
Date: Thu, 30 Nov 2006 09:51:56 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] structure alignement problem in RTDM?
References: <20061130073522.3BBF9EE753@domain.hid>
	<456E8F94.8050600@domain.hid>
In-Reply-To: <456E8F94.8050600@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
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
Cc: xenomai@xenomai.org

Jan Kiszka wrote:
> Marc Brown wrote:
> 
>>Hi,
>>
>>It seems that there are still structure alignment problems in RTDM (while running xenotest), as already 
>>talked about with Philippe. Compiled with a GCC 4.0.3-2 (on x86), here is the 
>>problem (output trace and xenomai /proc are provided herewith):
> 
> 
> I rather suspect that you built all testing devices into the kernel or
> loaded xeno_switchtest before xeno_timerbench so that the latency test
> happens to open the switchtest device. Try "-D1" with latency, or check
> /proc/xenomai/rtdm/rttestX/information for the actual mapping.
> [We need to resolve this more gracefully...]

A way to solve this may be to use the same method as switchtest: open
all rttest devices in turn until the first ioctl succeeds.

-- 
                                                 Gilles Chanteperdrix

