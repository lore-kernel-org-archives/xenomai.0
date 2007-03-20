Message-ID: <46000AFE.9070504@domain.hid>
Date: Tue, 20 Mar 2007 11:25:34 -0500
From: Bill Gatliff <bgat@domain.hid>
MIME-Version: 1.0
References: <1174379951.5068.5.camel@domain.hid>
In-Reply-To: <1174379951.5068.5.camel@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Re: [Xenomai-help] Xenomai v2.3.1
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai@xenomai.org, xenomai@xenomai.org

Guys:

Philippe Gerum wrote:
> 	[posix]
> 	* Fix pthread_cond_wait() upon signal receipt (grab mutex anew).
>   

Probably OT, but someone was complaining to me the other day that 
pthreads running on SCHED_FIFO/SCHED_RR that are blocked on mutexes 
don't release in priority order.  This was on a stock 2.6.18 kernel, 
"recent glibc" (I didn't catch which version or config), ARM9 platform.

First question: Is this actually true?

Second question: Does Xenomai fix this?  Do more recent kernel 
developments fix this?

Point me at the appropriate RTFM or code if that's the appropriate 
answer.  :)


Thanks,


b.g.

-- 
Bill Gatliff
bgat@domain.hid


