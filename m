Message-ID: <4FBC0582.2060707@xenomai.org>
Date: Tue, 22 May 2012 23:30:42 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4FBADE7D.5030609@bbn.com> <4FBB4951.5070803@xenomai.org>
	<4FBC0383.3020608@bbn.com>
In-Reply-To: <4FBC0383.3020608@bbn.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] A possible mis-interaction between CONFIG_PREEMPT and
 GPIO IRQ handling for ARM, leading to extreme latency
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Mitchell Tasman <tasman@bbn.com>
Cc: xenomai@xenomai.org

On 05/22/2012 11:22 PM, Mitchell Tasman wrote:
> Gilles,
> 
> On 05/22/2012 04:07 AM, Gilles Chanteperdrix wrote:
>> On 05/22/2012 02:31 AM, Mitchell Tasman wrote:
>>> Hi.  I'm running an OMAP DM3725-based board with a 2.6.38.8 kernel, a
>>> mid-May 2012 git snapshot of xenomai-2.6, and a backport (really just
>>> application) of the patch that Gilles referenced in the "IRQ latency"
>>> thread last week:
>>>
>>> http://git.xenomai.org/?p=ipipe-gch.git;a=commit;h=81bfc05c4716b76e79f5e486baf4c52015a3b92c
>>
>> Please try the following patch instead:
> 
> Thank you very much for your prompt and most helpful response.
> 
> I have applied the patch that you supplied, and find a dramatic 
> reduction in the maximum latency experienced in servicing edge-triggered 
> GPIO interrupts.  In testing so far today with the new patch, I have not 
> encountered a single instance of the sort of extreme latency that 
> prompted my query to the mailing list.
> 
> Might you consider applying the new patch to I-Pipe for ARM 2.6.38.8, 
> and publishing a new revision of that patch set?  This could be of 
> significant benefit to those members of the Xenomai community that are 
> presently using a 2.6.38.8 kernel on ARM platforms.
> 
> You might also consider addressing/replacing the original "ipipe/arm: 
> defer chained interrupts handling" patch that was applied to I-Pipe for 
> ARM 3.0.13, if the new patch is relevant to that kernel as well.
> 
> Thanks again and Best Regards,

Yes, that's the plan. I am just waiting for Jean-Pascal's result to
confirm that everything is fine.

Regards.

-- 
                                                                Gilles.

