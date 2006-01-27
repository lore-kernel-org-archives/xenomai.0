Message-ID: <43DA4DE6.3040402@domain.hid>
Date: Fri, 27 Jan 2006 17:44:22 +0100
From: Hannes Mayer <h.mayer@domain.hid>
MIME-Version: 1.0
Subject: Re: [Adeos-main] wake_up_interruptible ?
References: <43D2B94C.3000202@domain.hid>	<43D65F27.7000908@domain.hid>	<43D67ECD.5020309@domain.hid>	<200601242146.35114.berlemont.hauw@domain.hid>
	<43D6992A.60505@domain.hid>
In-Reply-To: <43D6992A.60505@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: adeos-main@gna.org
Cc: Alexis Berlemont <berlemont.hauw@domain.hid>, gilles.chanteperdrix@xenomai.org

Ciao Gilles! Ciao Alexis!

Just a quick followup:

If I assign an ISR like this

inter_domain_irq = ipipe_alloc_virq();
ipipe_virtualize_irq(ipipe_current_domain, inter_domain_irq,
	(ipipe_irq_handler_t)&wake_up_handler,NULL,NULL,IPIPE_DYNAMIC_MASK);

and I have a SYSCALL in the ISR

void wake_up_handler(unsigned irq) {
	wake_up_interruptible(&skeleton_wait);
}

will that affect other HRT interrupt handlers that *must* remain
in HRT ?

Thanks a lot,
Hannes.

