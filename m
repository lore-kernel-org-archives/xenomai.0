From: Niklaus Giger <niklaus.giger@domain.hid>
Date: Wed, 13 Dec 2006 23:15:54 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612132315.54899.niklaus.giger@domain.hid>
Subject: [Xenomai-help] Handling a interrupt from user space on PPC405
Reply-To: niklaus.giger@domain.hid
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

Hi

I tried to use the FIT (Fixed Interrupt Timer) on my PPC405GPr board, which 
uses 0x1010 as its interrupt vector in a user space (vxworks-skin) 
application.
<..>
  RT_INTR FITnterrupt;
  res = rt_intr_create(&FITnterrupt, 0, 0x1010, I_NOAUTOENA);
<..>
But I got -22 EINVAL as error.
Could somebody please tell me, what is wrong with my example.
I would like to have as little as possible code in the kernel and handling the 
whole interrupt in a RT (vxworks-skin) user space task.

And how do I have to handle the case, where my interrupt handler is only 
interested in one of external interrupts of the PPC405?

A good answer would enable me to publish afterwards a working example code.

Best regards.

-- 
Niklaus Giger

