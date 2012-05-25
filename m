Message-ID: <4FBF78FE.3020300@xenomai.org>
Date: Fri, 25 May 2012 14:20:14 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4FBADE7D.5030609@bbn.com> <4FBB4951.5070803@xenomai.org>
	<4FBC0383.3020608@bbn.com> <4FBC0582.2060707@xenomai.org>
	<4FBF4E69.1010200@bbn.com>
In-Reply-To: <4FBF4E69.1010200@bbn.com>
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

On 05/25/2012 11:18 AM, Mitchell Tasman wrote:
> Gilles,
> 
> On 05/22/2012 05:30 PM, Gilles Chanteperdrix wrote:
>> On 05/22/2012 11:22 PM, Mitchell Tasman wrote:
>>> I have applied the patch that you supplied, and find a dramatic
>>> reduction in the maximum latency experienced in servicing edge-triggered
>>> GPIO interrupts.  In testing so far today with the new patch, I have not
>>> encountered a single instance of the sort of extreme latency that
>>> prompted my query to the mailing list.
>>>
>>> Might you consider applying the new patch to I-Pipe for ARM 2.6.38.8,
>>> and publishing a new revision of that patch set?  This could be of
>>> significant benefit to those members of the Xenomai community that are
>>> presently using a 2.6.38.8 kernel on ARM platforms.
>>>
>>> You might also consider addressing/replacing the original "ipipe/arm:
>>> defer chained interrupts handling" patch that was applied to I-Pipe for
>>> ARM 3.0.13, if the new patch is relevant to that kernel as well.
> 
>> Yes, that's the plan. I am just waiting for Jean-Pascal's result to
>> confirm that everything is fine.
> 
> I thought I'd report that testing of 
> adeos-ipipe-2.6.38.8-arm-1.18-06.patch plus the revised "IRQ Chaining" 
> patch that you e-mailed continues to show a dramatic reduction in the 
> maximum latency in servicing edge-triggered GPIO interrupts.  Good news 
> as well is that the load on the Linux domain (e.g. dohell vs. idle) 
> appears to have much less effect on the latency in servicing such 
> interrupts than was previously the case.
> 
> I noticed that Jean-Pascal reported success as well, on 23 May.
> 
> Thank you once again for your excellent support, and I very much look 
> forward to the updated I-Pipe for ARM 2.6.38.8 patch set.

You are welcome. The patch should be done during the week-end.

-- 
					    Gilles.

