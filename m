From: Bernhard Walle <bernhard.walle@domain.hid>
Date: Mon, 10 Jul 2006 16:00:54 +0200
Message-ID: <m53ao3-hbg.ln1@domain.hid>
References: <20060710080757.4430@domain.hid> <44B21018.4060702@domain.hid>
	<20060710084549.4390@domain.hid> <44B2169F.7070205@domain.hid>
	<20060710114000.145290@domain.hid>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: news <news@domain.hid>
Subject: [Xenomai-help] Re: ISR Again
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Hi Keinen,

"Keinen Namen" <GSM909@domain.hid> [2006-07-10]:
> hi Again
> 
> witch from have a RT_ISR?
> 
> I simply want a Programm that run helloworld_isr when Interrupt 13 is fired.

Why not using the RTDM?

Just use:

  rtdm_irq_t  rt_irq_handle;

  err = rtdm_irq_request(&rt_irq_handle, 13, helloworld_isr, 0,
		"your_driver", NULL);
  if (unlikely(err != 0)) {
 	/* error handling here */
  }

  err = rtdm_irq_enable(&rt_irq_handle);
  if (unlikely(err != 0)) {
	/* error handling here */
  }

And in the cleanup function:

  rtdm_irq_free(&rt_irq_handle);

And the ISR:
 
  static int helloworld_isr(rtdm_irq_t *irq_handle)
  {
        return RTDM_IRQ_HANDLED;
  }


Regards,
  Bernhard
-- 
"Mankind invented the atomic bomb, but no mouse would ever construct a 
mousetrap."
        -- Albert Einstein


