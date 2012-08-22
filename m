Message-ID: <50350712.4020704@xenomai.org>
Date: Wed, 22 Aug 2012 18:21:38 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <50350308.8010405@openwide.fr>
In-Reply-To: <50350308.8010405@openwide.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] s3c24xx: Priority rotate enable !?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Romain Naour <romain.naour@openwide.fr>
Cc: xenomai@xenomai.org

On 08/22/2012 06:04 PM, Romain Naour wrote:
> Hello,
> 
> On s3c24xx processors the interrupt source priority isn't fixed by Adeos 
> patch (ARB_SEL bits in PRIORITY register).
> Is it intentional ?
> It may be possible to give priority to an interrupt simultaneously 
> arrived that the interruption IRQ_TIMER4 (before being grabbed by 
> Adeos). Therefore, we can have more jitter for real time applications.

This can always happen even with interrupt priorities: imagine that the
first interrupt happens 1 microsecond before the timer interrupt, even
with the priority, the handler for first interrupt will be executed and
the timer interrupt will have to wait for the end of this handler before
it is serviced.

> 
> Do we need to fix the priority at this level ?

I do not think so. However, what can be done is implement interrupt
controller muting using the priority register, see:
http://www.xenomai.org/index.php/I-pipe-core:ArmPorting#Priority_based_interrupt_controller_muting

-- 
					    Gilles.

