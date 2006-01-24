Message-ID: <43D69A34.1030106@domain.hid>
Date: Tue, 24 Jan 2006 22:20:52 +0100
From: Hannes Mayer <h.mayer@domain.hid>
MIME-Version: 1.0
Subject: Re: [Adeos-main] wake_up_interruptible ?
References: <43D2B94C.3000202@domain.hid>	<200601230144.31936.berlemont.hauw@domain.hid>	<17364.46664.389729.166491@domain.hid>	<43D65F27.7000908@domain.hid>	<43D67ECD.5020309@domain.hid>
	<17366.38740.873554.911951@domain.hid>
In-Reply-To: <17366.38740.873554.911951@domain.hid>
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: adeos-main@gna.org

Gilles Chanteperdrix wrote:
[...]
> If you have a real irq, you do not need to allocate a virtual irq. 
> 
> intall an handler in the HRT domain with ipipe_virtualize_irq(), a
> handler in the Linux domain with request_irq(), and call
> ipipe_propagate_irq() from within the HRT domain interrupt handler.

That is solution #2 I already tried and it works :-)
But I don't want to block almost all real IRQ's from linux and
only propagate when I have data. Instead I prefer to have a more
general driver template. But for the private project I'm working
on, this solution would be sufficient.

Thank you very much and best regards,
Hannes.


