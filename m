Message-ID: <44F6E774.2000701@domain.hid>
Date: Thu, 31 Aug 2006 14:43:16 +0100
From: Marcelo Coelho <mjcoelho@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] IRQ Enable/Disable
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Xenomai help <xenomai@xenomai.org>

Hi!


I've found out in RTAI's 16550a driver, that uses RTDM, the following 
comment:

     /*We should disable the line now, but this requires counting
      * enable/disable, something not yet implemented by the core.
      * At the moment this call could starve other users sharing the
      * same line.
     rtdm_irq_disable(&ctx->irq_handle);*/
     rtdm_irq_free(&ctx->irq_handle);

Is this still true? I mean, if i free the device at device close, should 
i expect that i need to request the irq again?

I'm trying to ckeck what to expect about these calls.


Thanks for the help
DISCLAIMER: This message may contain confidential information or privileged material and is intended only for the individual(s) named. If you are not a named addressee and mistakenly received this message you should not copy or otherwise disseminate it: please delete this e-mail from your system and notify the sender immediately. E-mail transmissions are not guaranteed to be secure or error-free as information could be intercepted, corrupted, lost, destroyed, arrive late or incomplete or contain viruses. Therefore, the sender does not accept liability for any errors or omissions in the contents of this message that arise as a result of e-mail transmissions. Please request a hard copy version if verification is required. Critical Software, SA.

