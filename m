Message-ID: <50771645.6020705@xenomai.org>
Date: Thu, 11 Oct 2012 20:56:05 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <20121011170958.40C8E372@centrum.cz>
In-Reply-To: <20121011170958.40C8E372@centrum.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Shared interrupts
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Petr Cervenka <grugh@centrum.cz>
Cc: xenomai@xenomai.org

On 10/11/2012 05:09 PM, Petr Cervenka wrote:
> I'm using xenomai 2.5.6, adeos 2.6.38.8-x86-2.10-01

> 
> My primary questions: Is there a possibility to have the rtdm driver
> compatible with both cases?


Well, yes, enable CONFIG_XENO_OPT_SHIRQ, and pass RTDM_IRQTYPE_SHARED
when registering the irq handlers. And do not return XN_ISR_PROPAGATE.

> 
> Do I loose deterministic rt latency when there is no non-rt device? I
> think that all my interrupts should be handled by rt devices in such
> case, so no propagating to linux should happen. Am I wrong?


You are not wrong. But if you do not want propagation to linux, you
should not return XN_ISR_PROPAGATE.

-- 
                                                                Gilles.

