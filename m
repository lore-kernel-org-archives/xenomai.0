From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17366.38740.873554.911951@domain.hid>
Date: Tue, 24 Jan 2006 22:08:36 +0100
Subject: Re: [Adeos-main] wake_up_interruptible ?
In-Reply-To: <43D67ECD.5020309@domain.hid>
References: <43D2B94C.3000202@domain.hid>
	<200601230144.31936.berlemont.hauw@domain.hid>
	<17364.46664.389729.166491@domain.hid>
	<43D65F27.7000908@domain.hid> <43D67ECD.5020309@domain.hid>
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Hannes Mayer <h.mayer@domain.hid>
Cc: adeos-main@gna.org

Hannes Mayer wrote:
 > 
 > Gilles, now I think I've got what you mean.
 > 
 > Something like this ?
 > 
 > inter_domain_irq = ipipe_alloc_virq();
 > ret = request_irq(inter_domain_irq, linux_handler, SA_INTERRUPT, "virtualIRQ", NULL);
 > enable_irq(inter_domain_irq);
 > 
 > void ipipe_handler(unsigned irq) {
 > 	[...]
 > 	ipipe_trigger_irq(inter_domain_irq);
 > 	[...]
 > }
 > 
 > void linux_handler(void) {
 > 	wake_up_interruptible(&skeleton_wait);
 > }
 > 
 > 
 > I've tried this, but the linux_handler is never called.
 > I bet I'm missing something very trivial here, but it
 > doesn't come to mind...
 > 
 > On the other hand, if I request_irq() for the parallelport
 > INT and pass that INT from IPIPE to linux, the linux_handler
 > is called. But it doesn't work with a virq.

If you have a real irq, you do not need to allocate a virtual irq. 

intall an handler in the HRT domain with ipipe_virtualize_irq(), a
handler in the Linux domain with request_irq(), and call
ipipe_propagate_irq() from within the HRT domain interrupt handler.

-- 


					    Gilles Chanteperdrix.

