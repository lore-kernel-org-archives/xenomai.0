From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <OFE12CA909.5E198139-ONC1257363.0033BA79-C1257364.002A5484@domain.hid>
References: <OFE12CA909.5E198139-ONC1257363.0033BA79-C1257364.002A5484@domain.hid>
Content-Type: text/plain
Date: Mon, 01 Oct 2007 11:17:12 +0200
Message-Id: <1191230232.5989.75.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-help] newbie question : xenomai tasks and
	linux	interrupts
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: alberto.tomasi@domain.hid
Cc: xenomai@xenomai.org

On Fri, 2007-09-28 at 09:45 +0200, alberto.tomasi@domain.hid wrote:
> 
> Hi everybody
> I'm a xenomai (and linux) newbie and I'm trying to understand what's
> happening on the serial device of my system
> My serial device is controlled by a linux driver and used by a linux
> task
> Often the serial line dialog stops : no enough bytes received or CRC
> errors are the warning indications coming from the linux task
> 
> Problems started when I've introduced an "heavy" xenomai (real time)
> task and seems to have an higher frequency if I use an higher baud
> rate on the serial line
> In this condition the linux driver says that a lot of overrun error
> occurs in the serial device
> 
> My question is : when the xenomai task is running, all the interrupts
> managed by linux are always blocked and delayed until the task has
> finished its job ?
> (I'm almost sure about but finding a confirmation of this in the
> xenomai sources I haven't understood if and where this happen...)
> 
> If the answer is yes, how can I manage the serial device without
> overrun ?
> 
> Is it possible to setup a "special" management (no mask or immediate
> propagation...) on specific interrupts used by linux ?

https://mail.gna.org/public/xenomai-core/2007-09/msg00002.html

In short, switching to the Linux domain to process a low priority event
whilst high priority ones may still be pending in the Xenomai domain
makes no sense. As soon as your Xenomai code switches to the Linux
domain, it loses real-time predictability.

> Another possible solution could be to realize a rtdm driver : doing
> this interrupts from the serial device will not be masked by
> xenomai...
> But how to link this with the linux driver system (uart device, tty
> device etc) ? 
> Having a look at rtdm, it seems (if I haven't misunderstood...) well
> designed for real time task user (to reduce reception and response
> timing trough devices connecting a control application with the
> external world : the chain from data producer to consumer all in real
> time)  
> 
> Is there a general issue about timing management of hardware resources
> not involved with the real time application constraints but (already)
> totally managed by the linux side system ? Does exist a sort of model
> or examples for this "bridge-to-linux" drivers in xenomai ?
> 
> Thanks in advance for any hint
> Alberto Tomasi
> 
> 
> This e-mail and any attachments is confidential and may contain
> privileged information intended for the addressee(s) only.
> Dissemination, copying, printing or use by anybody else is
> unauthorised. If you are not the intended recipient, please delete
> this message and any attachments and advise the sender by return
> e-mail.Thank you.
> 
> Questo messaggio e i suoi allegati sono indirizzati esclusivamente
> alle persone indicate. La diffusione, copia o qualsiasi altra azione
> derivante dalla conoscenza di queste informazioni sono rigorosamente
> vietate.Qualora abbiate ricevuto questo documento per errore siete
> cortesemente pregati di darne immediata comunicazione al mittente e di
> provvedere alla sua distruzione, Grazie.
> 
> Informativa sul trattamento dei dati personali (D. Lgs. 196/2003). I
> dati utilizzati per la spedizione del presente messaggio sono
> utilizzati da Gefran S.p.A., titolare del trattamento, per l'invio
> delle comunicazioni dei diversi settori aziendali, non essendo
> autorizzata la divulgazione a terzi. Potrete rivolgere alla seguente
> mail richieste di verifica, rettifica o cancellazione dei Vostri dati:
> ufficio.legale@domain.hid
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
-- 
Philippe.



