MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17359.37814.257893.95482@domain.hid>
Date: Thu, 19 Jan 2006 14:27:18 +0100
Subject: Re: [Xenomai-core] Missing IRQ end function on PowerPC
In-Reply-To: <43CF8ECF.4020805@domain.hid>
References: <43CE1C28.6060001@domain.hid>
	<17359.34362.870823.168739@domain.hid>
	<43CF8ECF.4020805@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Wolfgang Grandegger <wg@domain.hid>
Cc: xenomai@xenomai.org

Wolfgang Grandegger wrote:
 > Therefore we need a dedicated function to re-enable interrupts in the 
 > ISR. We could name it *_end_irq, but maybe *_enable_isr_irq is more 
 > obvious. On non-PPC archs it would translate to *_irq_enable. I 
 > realized, that *_irq_enable is used in various place/skins and therefore 
 > I have not yet provided a patch.

The function xnarch_irq_enable seems to be called in only two functions,
xintr_enable and xnintr_irq_handler when the flag XN_ISR_ENABLE is set.

In any case, since I am not sure if this has to be done at the Adeos
level or in Xenomai, we will wait for Philippe to come back and decide.

-- 


					    Gilles Chanteperdrix.

