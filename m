Message-ID: <51F5990B.9010600@xenomai.org>
Date: Mon, 29 Jul 2013 00:19:55 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <51F3B976.3020802@163.com>
In-Reply-To: <51F3B976.3020802@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Real Time about user thread
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: aking <jinxin16897123@163.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 07/27/2013 02:13 PM, aking wrote:

> Hi,all


Hi,

>       RTDM is in the xenoami domain ,


A thread or an interrupt can be in the xenomai or linux domain, but RTDM 
is a skin, so, it does not really make sense to say that it is in the 
xenomai domain. RTDM allows to create real-time threads or to register 
interrupt handlers which can be executed in the Xenomai domain, but also 
allows defining callback executed in Linux domain.

 > and it's  driven by the IRQ so that could provide hard real time.

RTDM is no more driven by IRQ than the Linux kernel is driven by IRQ, 
and this is not sufficient to provide hard real-time (otherwise, the 
Linux kernel would provide hard real-time). The mechanism allowing hard 
real-time response to interrupts is the so-called "Optimistic interrupt 
protection" scheme, see [1] for more details.

>       The userspace thread is in Linux domain(maybe?)


Or maybe not, see above.

  , what mechanism
> was implemented to provide a Linux userspace thread real time?
>           Thank you very much.
>


Xenomai uses the Adeos patch to allow executing user-space threads in 
Xenomai domain, see [1] for more detains, and implements the classic 
real-time scheduling policies, aka SCHED_FIFO and SCHED_RR to provide 
deterministic scheduling.

[1] 
http://www.xenomai.org/documentation/branches/v2.3.x/pdf/Life-with-Adeos-rev-B.pdf

-- 
                                                                 Gilles.

