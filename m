Message-ID: <5164936A.8000005@xenomai.org>
Date: Wed, 10 Apr 2013 00:17:14 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1362068715-3458-1-git-send-email-sr@denx.de>
In-Reply-To: <1362068715-3458-1-git-send-email-sr@denx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PATCH] ipipe: MPC5200: Fix problem with
	external	interrupts
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Stefan Roese <sr@denx.de>, Xenomai <xenomai@xenomai.org>

On 02/28/2013 05:25 PM, Stefan Roese wrote:

> The MPC5200 external interrupt are not working at all in the Linux
> context with the current I-pipe support enabled. For example a
> PCI firewire chip connected to an external interrupt doesn't generate
> interrupts any more using the Linux FW drivers. With I-pipe
> disabled or without the current I-pipe patch for the mpc52xx_pic.c
> file, the external interrupts work just fine.
> 
> This patch now introduces the xxx_mask_ack() function for these
> external interrupts as already done for the other interrupts handled
> in this driver. With this change, the interrupts work regardless
> if I-pipe support is enabled or not.
> 
> Additionally a small coding style issue has been included (spaces
> around "-").
> 
> Signed-off-by: Stefan Roese <sr@denx.de>
> Cc: Philippe Gerum <rpm@xenomai.org>


Philippe, has this patch been forgotten? I can't seem to find it in the
core-next branch.

-- 
                                                                Gilles.

