From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <28c396720908070308t544c6cb7y45ed53c11dfee30c@domain.hid>
References: <28c396720908070308t544c6cb7y45ed53c11dfee30c@domain.hid>
Content-Type: text/plain
Date: Fri, 07 Aug 2009 12:19:56 +0200
Message-Id: <1249640396.5957.5.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Interrupt workqueue and Xenomai 2.4.0
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Yang <hegallis@domain.hid>
Cc: xenomai@xenomai.org

On Fri, 2009-08-07 at 11:08 +0100, Yang wrote:
> Hi
> 
> I am working on BF527 at the moment while we queue work item upon GPI
> interrupt to a work queue as delayed work. This kernel driver works
> fine without Xenomai patch turned on. However, it stops working after
> applying Xenomai patch. It appears that the interrupt handler was
> triggered but the work item in the work queue is not being processing
> (by kernel thread which is supposed to work on).
> 
> 
> my assumption was that ipipe should pass through non-rt interrupts to
> Linux domain. Linux kernel tasks such as work queue will still be
> handled in the same way by kthread. However, it seems that
> 
> 1. the interrupt line never gets cleared
> 
> 2. kthread which handles work structure in the work queue not doing
> its work (or cannot switch to linux kthread context I suspect)
> 
> Any suggestions?

Yes, I understand this may not be the kind of suggestion you want, but
you should definitely upgrade to 2.4.8, and use the 2.6.28 kernel that
comes with a recent uClinux/blackfin distro.

IRQs are no more threaded there.

> 
> 
> Thanks
> 
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
-- 
Philippe.



