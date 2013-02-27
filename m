Message-ID: <512E5DA5.8060905@xenomai.org>
Date: Wed, 27 Feb 2013 20:25:25 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAD1EtojOLiC5L=NE7nkCTqoYwLpqWFigWG-yqGMtuJsWt0AEbg@mail.gmail.com>
In-Reply-To: <CAD1EtojOLiC5L=NE7nkCTqoYwLpqWFigWG-yqGMtuJsWt0AEbg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Failing to recognize/use PEAK PCAN-miniPCIe card
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Daniel M. Drucker, Ph.D." <dmd@interactive-motion.com>
Cc: xenomai@xenomai.org

On 02/27/2013 08:04 PM, Daniel M. Drucker, Ph.D. wrote:

> Hello all,
> 
> We have a PC/104 computer with a PEAK PC/104-PLUS card which we are
> successfully using to talk CAN from within Xenomai. For various reasons, we
> want to switch to using a mini-ITX board.
> 
> We're trying to use the PEAK PCAN-miniPCIe card on the mini-ITX board, but
> we are having no luck - the card doesn't seem to get seen by Xenomai.
> 
> We're not sure if this is an IRQ problem or something else. On the PC104
> system, we had an IRQ conflict which we were able to solve by changing a
> jumper - the new card has no jumpers to change, and our motherboard's BIOS
> does not have any settings that allow changing of daughterboard IRQs.
> 
> Both systems are running the same OS install with the same kernel. The
> 'latency' command in the Xenomai testsuite runs correctly on both systems.
> 
> I have put together a comparison of command outputs on the old (working)
> and new (non-working) systems:  http://goo.gl/GBy8h
> 
> Any insight into what's wrong in our new system and how to get it working
> would be greatly appreciated!


What does lspci say? Is your card listed? If yes, are the IDs of this
card in the list of IDs which the xenomai driver supports?
-- 
                                                                Gilles.

