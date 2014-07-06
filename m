Message-ID: <53B91595.9060604@xenomai.org>
Date: Sun, 06 Jul 2014 11:23:33 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <1404638402.36454.YahooMailNeo@web171603.mail.ir2.yahoo.com>
In-Reply-To: <1404638402.36454.YahooMailNeo@web171603.mail.ir2.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Question about threadobj_irq_prio
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Matthias Schneider <ma30002000@yahoo.de>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 07/06/2014 11:20 AM, Matthias Schneider wrote:
> Hi all,
>
> I was under the expression that the max cobal scheduling prio in
> forge was now 256 and that SCHED_COBALT had been replaced with
> SCHED_FIFO. Is this correct?
>

Yes.

> Anyway,
>
> threadobj_pkg_init(void) initializes
> threadobj_irq_prio = __RT(sched_get_priority_max(SCHED_CORE));
> which is still mapping to 258 - however I would rather expect
> 256...
>

256 regular FIFO levels, +2 special levels for scheduler lock (mercury 
only) and interrupt service emulation (both cores).

> Thanks for clarification,
>
> regards,
> Matthias
>
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> http://www.xenomai.org/mailman/listinfo/xenomai
>


-- 
Philippe.

