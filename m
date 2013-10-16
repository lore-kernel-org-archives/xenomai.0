Message-ID: <525E73FB.4060809@xenomai.org>
Date: Wed, 16 Oct 2013 13:09:47 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <525DC044.6090201@steinkuehler.net>
In-Reply-To: <525DC044.6090201@steinkuehler.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Hung task on Xenomai patched ARM 3.8.13 BeagleBone
 Kernel
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Charles Steinkuehler <charles@steinkuehler.net>
Cc: xenomai@xenomai.org

On 10/16/2013 12:23 AM, Charles Steinkuehler wrote:
> There seems to be some minor issue with the Xenomai patches for the
> BeagleBone 3.8.13 ARM target.  Occasionally, the eMMC task will hang for
> greater than 60 seconds, causing the kernel to kill it, which basically
> brings down the system (root is on the eMMC device).
> 
> I was writing this off to bad SD cards, and indeed I did have a card
> that exhibited these symptoms on an x86 Linux system that had no xenomai
> patches at all.  I pitched this card and didn't have any more consistent
> problems, but it turns out the bug is fairly simple to 'tickle'.  Just
> boot the xenomai patched kernel and run:
> 
> grep "TestConfig" /usr -r
> 
> ...after a while, the mmcqd task will hang.  I have not yet had a
> xenomai kernel survive this test, while a "stock" kernel has gotten
> through the whole /usr directory multiple times without issue.
> 
> So...how do I go about debugging this problem?  Will testing with
> different xenomai kernel configuration options (which ones?) possibly
> shed any light on what's going wrong?
> 
> I'm not totally out of my depth here (I design hardware, so the
> lower-level the code the easier it is for me to understand), but I don't
> really do a lot of Linux Kernel hacking.  I'm muddling forward as best I
> can, but any advice would be appreciated.

Could you attach:
- the full boot logs
- the kernel configuration
- the result of cat /proc/interrupts, cat /proc/xenomai/irq, cat
/proc/timer_list, cat /proc/xenomai/timer


-- 
                                                                Gilles.

