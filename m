Message-ID: <519CB04E.902@xenomai.org>
Date: Wed, 22 May 2013 13:47:26 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <595E8529-F95D-4AF7-990C-1E513191EC3B@mah.priv.at>
	<519CAB81.40403@xenomai.org>
In-Reply-To: <519CAB81.40403@xenomai.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] kernel equivalent of SIGXCPU
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Michael Haberler <mail17@mah.priv.at>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 05/22/2013 01:26 PM, Gilles Chanteperdrix wrote:

> On 05/22/2013 12:01 PM, Michael Haberler wrote:
> 
>> I'm trying to trap scheduling violations through an exception handler
> 
> 
> How do you define "scheduling violations" ?
> 
>>
>> in user RT it's straightforward - use the SIGXCPU handler
> 
> 
> No, SIGXCPU detect involuntary mode switches to secondary mode, if you
> have the XNWARNSW bit set, it traps Linux system calls made by a thread
> running in secondary mode.
> 
>>
>> is rthal_trap_catch() the way to go? 
> 
> 
> rthal_trap_catch, allows to trap machine exceptions.
> 
>>
>> or is it just evaluating the rt_task_wait_period() returns ? 
> 
> 
> rt_task_wait_period returns an error when an overrun happens, that is
> when the timer ticks twice without the periodic thread having called
> rt_task_wait_period.


Sorry, when the thread finally wakes up more than one period after its
expected wake up time. So, when the timer ticks twice without the
periodic thread having been scheduled out of rt_taskw_wait_period.

-- 
                                                                Gilles.

