Date: Sat, 14 Nov 2015 13:39:53 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20151114123953.GN1820@hermes.click-hack.org>
References: <BLU436-SMTP777DC6298F62C65606DFEF0100@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BLU436-SMTP777DC6298F62C65606DFEF0100@phx.gbl>
Subject: Re: [Xenomai] [PATCH] IPIPE patch for BCM2709/RPI2.
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Mathieu Rondonneau <mathieu_rondonneau@hotmail.com>
Cc: xenomai@xenomai.org

On Fri, Nov 13, 2015 at 09:31:23PM -0800, Mathieu Rondonneau wrote:
>  #ifdef CONFIG_OF
> @@ -333,6 +349,10 @@ static struct irq_chip armctrl_chip = {
>  	.irq_mask = armctrl_mask_irq,
>  	.irq_unmask = armctrl_unmask_irq,
>  	.irq_set_wake = armctrl_set_wake,
> +#ifdef CONFIG_IPIPE
> +	.irq_hold = armctrl_mask_irq,
> +	.irq_release = armctrl_unmask_irq,
> +#endif

Also, as explained during your lengthy discussion, you do not need
to define irq_hold and irq_release here.

-- 
					    Gilles.
https://click-hack.org

