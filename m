Message-ID: <4E1B469A.8000703@domain.hid>
Date: Mon, 11 Jul 2011 20:53:14 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <E1QfDvt-0003TN-G7@domain.hid>
In-Reply-To: <E1QfDvt-0003TN-G7@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [Xenomai-git] Jan Kiszka : nucleus: Fix race
 between gatekeeper and	thread deletion
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Xenomai core <Xenomai-core@domain.hid>, Jan Kiszka <jan.kiszka@domain.hid>

On 07/08/2011 06:29 PM, GIT version control wrote:
> @@ -2528,6 +2534,22 @@ static inline void do_taskexit_event(struct task_struct *p)
>  	magic = xnthread_get_magic(thread);
>  
>  	xnlock_get_irqsave(&nklock, s);
> +
> +	gksched = thread->gksched;
> +	if (gksched) {
> +		xnlock_put_irqrestore(&nklock, s);

Are we sure irqs are on here? Are you sure that what is needed is not an
xnlock_clear_irqon? Furthermore, I do not understand how we
"synchronize" with the gatekeeper, how is the gatekeeper garanteed to
wait for this assignment?


-- 
                                                                Gilles.

