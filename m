Message-ID: <511D4559.5030505@xenomai.org>
Date: Thu, 14 Feb 2013 21:13:13 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <511CD2FB.7010502@gmail.com>
In-Reply-To: <511CD2FB.7010502@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] (Boot)-problems with (current) ipipe patch on AMD FX
 61000 - 2.6.38.8 & 3.5.7
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Manuel Huber <manuel.h87@gmail.com>
Cc: xenomai@xenomai.org

On 02/14/2013 01:05 PM, Manuel Huber wrote:

> Hello!
> 
> We use an AMD FX-61000 CPU and we are having trouble using kernel versions
> 2.6.38.8 and 3.5.7 (newest) and some more... The only version that
> worked is 2.6.35.9 (so far). But let's focus on 3.5.7:
> 
> I finally managed to get error messages from the 3.5.7 kernel (Thanks to
> Philippe Gerum, who was so kind to direct me to the mailing list and also
> gave me some hints about debugging,... ). I've seen that there is a
> kernel BUG on line 139 and 170. Maybe thats the reason for the problem?
> I included the kernel config and the full log from startup. Of course it can
> very well be a wrong configuration...
> 
> However, it seems like I could avoid the problemes with the 2.6.35.9
> kernel (It was related to RTnet + rt8169 sometimes getting stuck;
> it doesn't happen on the 3.5.7 kernel, as far as I can tell
> [tested on an AMD Athlon 64 X2]; now I'm using the rt8139C card which
> works like a charm), so I just wanted to submit the problem,
> maybe it helps to further improve this project...
> 
> Of coure I would love to use the current version and I can test
> configurations and boot the system with different options if that
> helps with finding the error...
> 
> Best regards, Manuel
> -------------- next part --------------
[    1.201759] kernel BUG at arch/x86/kernel/ipipe.c:589!


Could you try the following patch?

diff --git a/arch/x86/kernel/ipipe.c b/arch/x86/kernel/ipipe.c
index f833663..6d0fd72 100644
--- a/arch/x86/kernel/ipipe.c
+++ b/arch/x86/kernel/ipipe.c
@@ -586,6 +586,8 @@ int __ipipe_handle_irq(struct pt_regs *regs)
 
 	if (likely(vector < 0)) {
 		irq = __this_cpu_read(vector_irq[~vector]);
+		if (irq < 0)
+			printk("invalid irq for vector 0x%08x\n", vector);
 		BUG_ON(irq < 0);
 	} else { /* Software-generated. */
 		irq = vector;


-- 

                                                                Gilles.

