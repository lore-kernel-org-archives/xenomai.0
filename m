Message-ID: <52408790.3070907@xenomai.org>
Date: Mon, 23 Sep 2013 20:25:20 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <5240004A.6070703@mitrol.it>
In-Reply-To: <5240004A.6070703@mitrol.it>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] rt_intr_wait bug during debugging
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Paolo Minazzi <Paolo.Minazzi@mitrol.it>
Cc: xenomai@xenomai.org

On 09/23/2013 10:48 AM, Paolo Minazzi wrote:
> Hi to all,
> the problem arise when I debug an application that uses an external 
> interrupt.
> Below there is a sample (pseudo) code that show how I can see the problem.
> The irq stuff is related on my specific machine, so I think it is not 
> important
> give details about GPIO programming and interrupt clear (CLEAR_IRQ).

Could you try reproducing this issue with a recent I-pipe patch? Say the
I-pipe patch for Linux 3.5 or 3.8?


-- 
                                                                Gilles.

