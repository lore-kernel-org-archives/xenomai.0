Message-ID: <50390A87.5050409@xenomai.org>
Date: Sat, 25 Aug 2012 19:25:27 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAKKWdtdG5L24kjZ_WkWhLDL2iL2inCHP_5RE9JPgudEwkWuSuQ@mail.gmail.com>
In-Reply-To: <CAKKWdtdG5L24kjZ_WkWhLDL2iL2inCHP_5RE9JPgudEwkWuSuQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] The functionality of rthal_irq_enable()
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: hagigatali@gmail.com
Cc: xenomai@xenomai.org

Le 25/08/2012 12:49, ali hagigat a écrit :
> If i use rthal_irq_enable() inside a real time interrupt handler for
> an IRQ. What happens if i receive the same IRQ and interrupt after
> rthal_irq_enable()?
> As far as life-with-adeos-rev-B.pdf is saying,  rthal_irq_enable()
> does two things:
> 1) it enables IRQ in hardware
> 2) it unstalls the domain pipeline stage
> And when the domain stage is unstalled, if the interrupt is received
> the handler of that interrupt is called. So we have nested interrupt
> handling here. Is that right?

Look at rthal_irq_enable code, that is simply not what it does: it does 
not unstall the pipeline stage.
But assuming that you unstall the pipeline stage by calling 
hard_local_irq_enable() for instance, yes, you have nested interrupts 
handling here, but there is a high risk for stack overflow. Simply 
unstalling the domain in the interrupt handler means that at a given 
time there can not be more than the number of primary interrupt 
controller interrupts being stacked (which may be already high). But 
enabling the currently handled interrupt means that you simply have no 
limit on the current number of stacked interrupt contexts. So, that does 
not look like a good idea.

As I already told you: an interrupt handler should be short, anything 
long should not be done by an interrupt handler. In that case, you do 
not need nested interrupt handling. And, as I did not tell you: root 
domain interrupt handlers are completely preemptible by head domain 
interrupts of course, so, you do have a sort of nested interrupt 
handling, but again, in a controlled fashion; there can not be more than 
2 nested levels.

--
Gilles.

