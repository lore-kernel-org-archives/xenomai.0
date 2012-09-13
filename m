Message-ID: <505211EA.2090106@xenomai.org>
Date: Thu, 13 Sep 2012 19:03:38 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <tencent_152B67887944D27650BB6237@qq.com>
In-Reply-To: <tencent_152B67887944D27650BB6237@qq.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] ipipe can't handle interrupt from ohci-s3c2410 well
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Morning <juventusgc@qq.com>
Cc: xenomai <xenomai@xenomai.org>

On 09/13/2012 06:57 PM, Morning wrote:
> Hello,I use linux kernel 2.6.33 and xenomai 2.5.3 to build my
> rt-embedded system based on S3c2440,but i found the ipipe can't
> handle interrupt from the usb host controller  well .I tried
> adeos-ipipe-2.6.33-arm-1.16-01.patch which xenomai contains and
> adeos-ipipe-2.6.33-arm-1.18-03.patch which is the newest patch for
> kernel 2.6.33, but both didn't work. I traced the code and found that
> the ipipe can handle the first few interrupts from ohci well but from
> then on the interrupts start to destroy the system as ohci interrputs
> the system over and over again .The system didn't crash but was busy
> handling the interrupts and couldn't respond to anything else. I
> found that the interrupts from ohci can't be handled because the root
> domain is always stalled as it failed the test below all the time : 
> void __ipipe_walk_pipeline(struct list_head *pos){ ...... if
> (test_bit(IPIPE_STALL_FLAG, &np->status)) break;	/* Stalled stage --
> do not go further. */
> 
> ...... } I also found that the interrupt source on ohci was not
> cleared  as I found that there was no use clearing the USBH bit on
> INTPND and SRCPND regs . The ipipe handled level interrupt with ack
> and mask but handled edge interrupt with only ack , so how did ipipe
> work when it was handling an edge interrupt and another edge
> interrupt came at the same time ? Was it the reason of ohci kept
> interrupting S3C2440 over and over again? Thank you for reading this
> message , I really appreciate your answer . GongChen 

Have you tried the suggestion at the end of this paragraph?
http://www.xenomai.org/index.php/I-pipe-core:ArmPorting#flow_handler

-- 
					    Gilles.

