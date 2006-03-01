Message-ID: <44056561.90400@domain.hid>
Date: Wed, 01 Mar 2006 10:12:01 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [PATCH] hal/arm : rthal_irq_enable/disable/end
	corrections
References: <b647ffbd0603010009w717c59fbs@domain.hid>
In-Reply-To: <b647ffbd0603010009w717c59fbs@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Dmitry Adamushko <dmitry.adamushko@domain.hid>
Cc: xenomai@xenomai.org

Dmitry Adamushko wrote:
> 
> Hello,
> 
> Linux'es enable/disable_irq() should not be called from the primary domain.

Applied, thanks.

> 
> In short, they use a normal linux spinlock + irq are off only for the 
> Linux domain;
> the precise description is available here : 
> https://mail.gna.org/public/xenomai-core/2006-02/msg00213.html
> 
> 
> -- 
> Best regards,
> Dmitry Adamushko
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core


-- 

Philippe.

