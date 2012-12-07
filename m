Message-ID: <50C236B9.3030507@xenomai.org>
Date: Fri, 07 Dec 2012 19:34:33 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <50C1EF04.1090506@wanadoo.fr>
In-Reply-To: <50C1EF04.1090506@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] iMX6q 1Hz tick
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Thierry Bultel <thierry.bultel@wanadoo.fr>
Cc: xenomai@xenomai.org

On 12/07/2012 02:28 PM, Thierry Bultel wrote:

> Hi,
> 
> I have "successfully" patched a 3.0.35 kernel from Freescale with
> adeos-ipipe-3.0.36-1.18.11
> 
> I have -not- applied the adeos-ipipe-3.0.36-arm-1.18-11-pre.patch
> that showed too much "revert patch detected" errors.



The patch should apply cleanly, the question, if you get too many
rejections, it is because you do not apply it to the proper branch.

> 
> BTW, I have understand that its purpose was mainly to upgrade to 3.0.36,
> but what is actually the role of the
> adeos-ipipe-3.0.36-arm-1.18-11-post.patch ? (I applied it).


I have explained this in a previous mail.

> 
> I had to deal with some rejections but at least the kernel is booting
> and my application running.
> 
> But the target is very slow, and /proc/xenomai/irq shows that the
> [timer] irq only comes about every 1 second.
> 
> The /proc/interrupts shows an IRQ every 10ms, which was expected
> since I have CONFIG_HZ=100
> 
> I am pretty sure that I messed up something in the patch process,
> however I do not know where to start to look for.


Apply the patches to the proper imx release, and everything should be fine.

-- 
                                                                Gilles.

