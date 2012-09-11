Message-ID: <504EECB4.2060900@xenomai.org>
Date: Tue, 11 Sep 2012 09:48:04 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <504EC598.7050005@ebus.com>
In-Reply-To: <504EC598.7050005@ebus.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Interpreting I-pipe trace
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

On 09/11/2012 07:01 AM, Doug Brunner wrote:
> While running my latency testing earlier I saw some rather high
> worst-case latencies (~70us) compared to average case (~14us), so I ran
> again with I-pipe tracing enabled. However, I'm not sure what to make of
> the results.
> 
> My worst case involves an IRQ (common_interrupt appears in the trace
> with user value 0xFFFFFFC4) and the wiki page talks about being able to
> translate the user value 0xFFFFFFF4 into IRQ 11 but doesn't elaborate on
> how this correspondence works.

The kernel pushes ~irq_num on top of the interrupt stack.

 I'm not horribly concerned since it's a
> delay of 53 us on a rather slow processor (Geode LX800) but it would be
> nice to know what interrupt is taking so long.
> 

Looks like a very slow wakeup from idle state.

> The trace is attached.
> 
> Thanks,
> 


-- 
Philippe.

