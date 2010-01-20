Message-ID: <4B56EF1E.5080505@domain.hid>
Date: Wed, 20 Jan 2010 12:55:10 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <709633.57305.qm@domain.hid>
In-Reply-To: <709633.57305.qm@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Adeos-main] hw interrupts off, __ipipe_handle_irq
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: A C <adrien_chiron@domain.hid>
Cc: adeos <adeos-main@gna.org>

A C wrote:
> Hello, in the comment before the definition of the function
> __ipipe_handle_irq(), it is written : "hw interrupts are off on
> entry". For the isr of the nios2, is it done (disable hw interrupts)
> in entry.s or in __ipipe_grab_irq() ? In fact, we do not find where
> it is done. Regards Adrien Chiron & Vincent Vanbesien

That is standard behaviour for a processor to enter interrupt handling
code with interrupts disabled somehow. Otherwise, for level interrupts,
you would get an infinite loop. So, what you should look for in entry.S
are the points where interrupts are re-enabled, because this code is
entered with irqs off, mostly.

-- 
					    Gilles.

