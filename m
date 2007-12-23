MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18286.24088.191796.349268@domain.hid>
Date: Sun, 23 Dec 2007 14:09:44 +0100
In-Reply-To: <0B45E93C5FF65740AEAE690BF3848B7A4AB2DF@rennsmail04.eu.thmulti.com>
References: <0B45E93C5FF65740AEAE690BF3848B7A4AB2DF@rennsmail04.eu.thmulti.com>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Xenomai-help] RTDM mmap and DMA
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Fillod Stephane <stephane.fillod@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

Fillod Stephane wrote:
 > Perrine Martignoni wrote:
 > >Currently, I write an RTDM module and I would like to do DMA and mmap
 > to perform transfers who have hard constraints.
 > >I would like to know if there is an example in a driver who would help
 > me to do this.
 > 
 > I'm looking for the same need, except I'm not using RTDM, and everything
 > is in userland. Using the attached patch against Xenomai 2.4.0, I hope
 > to make it to work with something like this:
 > 
 >         RT_HEAP_INFO info;
 >         RT_HEAP heap;
 >         void *user_addr;	/* DMA buffer, user access */
 >         unsigned long dma_addr;	/* for use with the DMA controller */
 > 
 >         /* Allocate memory, suitable for DMA. This occurs before
 > entering RT land. */
 >         err = rt_heap_create (&heap,
 >                         name,
 >                         heapsz,
 >                         H_SHARED|H_DMA);
 >         if (err) { /* ... */ }
 > 
 >         err = rt_heap_alloc (&heap, 0, TM_INFINITE, &user_addr);
 >         if (err) { /* ... */ }
 > 
 >         err = rt_heap_inquire (&heap, &info);
 >         if (err) { /* ... */ }
 > 
 >         dma_addr = info.phys_addr;
 > 
 > Any comments?

You patch looks OK. However, a small detail: can not we use the constant
KMALLOC_MAX_SIZE defined in linux/slab.h instead of defining our own
constant ?

-- 


					    Gilles Chanteperdrix.

