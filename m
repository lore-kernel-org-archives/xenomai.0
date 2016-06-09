Date: Thu, 9 Jun 2016 19:41:18 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20160609174118.GD1785@hermes.click-hack.org>
References: <D9EDB4F689BF9F4EA6F2158A073942732E8007D6@de08ex3008.global.ds.honeywell.com>
 <20160608193911.GA31360@hermes.click-hack.org>
 <D9EDB4F689BF9F4EA6F2158A073942732E8008F3@de08ex3008.global.ds.honeywell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D9EDB4F689BF9F4EA6F2158A073942732E8008F3@de08ex3008.global.ds.honeywell.com>
Subject: Re: [Xenomai] Xenomai/Cobalt on i7-3770S CPU
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Heinick, J Michael" <Michael.Heinick@Honeywell.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Thu, Jun 09, 2016 at 05:32:51PM +0000, Heinick, J Michael wrote:
> 
> -----Original Message-----
> From: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org] 
> Sent: Wednesday, June 08, 2016 3:39 PM
> To: Heinick, J Michael
> Cc: xenomai@xenomai.org
> Subject: Re: [Xenomai] Xenomai/Cobalt on i7-3770S CPU
> 
> On Wed, Jun 08, 2016 at 09:42:26AM +0000, Heinick, J Michael wrote:
> > 
> > We currently have an RTDM driver that is running well on Xenomai/Cobalt 3.0.1 on 2 Dell computers with Core2 processors, but will hang (unresponsive mouse and keyboard, no discernable activity) an entire SuperLogics i7 computer with a Core i7-3770S processor (4 physical cores, 4 logical cores).  The hang occurs in the ioctl function at an rtdm_sem_down call that waits for the interrupt handler to signal the handling of an interrupt.  We suspect that we have a problem with our kernel build/installation configuration options.  We have attempted to configure the Core i7-3770S system so that Xenomai/Cobalt only uses 2 cores like the other 2 working Core2 computers, but the system still hangs (more detail on the results of our attempt is included beow).  Eventually, we would like to configure Xenomai/Cobalt to run on 4 cores of the i7 computer if possible.
> > 
> > Any suggestions to help us make/install/configure Xenomai/Cobalt to run on the SuperLogics computer with the i7-3770S processor so that the rtdm_sem_down call in the RTDM driver does not hang the entire system would be appreciated.
> 
> This sounds like an irq conflict: a device handled by an RTDM driver can not use the same irq line as a device handled by a plain Linux driver without modifying the plain Linux driver. See FAQ for solutions to that problem.
> 
> -- 
> 					    Gilles.
> https://click-hack.org
> 
> 
> Thanks for the reply, Gilles.
> 
> Yes, there was a conflict on irq 16. We disabled the conflicting
> component so that now our driver is the only one on irq 16, but
> the i7-3770S system is still hanging. We know the interrupt
> handler is receiving the interrupts and handling them without
> hanging the i7 system. With the interrupts running at 20Hz, the
> handler stores counts of the second and sub-second interrupts that
> we can retrieve with a different ioctl call that does not wait for
> an interrupt. The hang only occurs in the ioctl call at the wait
> with the rtdm_sem_down call. The contents of selected files from
> the /proc directory are included below.


Could you post the simplest driver which generates this issue?

-- 
					    Gilles.
https://click-hack.org

