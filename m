Message-ID: <4D91E30A.2070702@domain.hid>
Date: Tue, 29 Mar 2011 15:47:54 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <COL122-W1001B88CC08016B1C1774EBDCE0@domain.hid>,
	<4D80BA8B.7050803@domain.hid>, <4D81C6AD.8050803@domain.hid>,
	<COL122-W637BE46C7D8B2CB7F79760BDB50@domain.hid>, ,
	<4D88925C.3040609@domain.hid>,
	<COL122-W1673FD60DDA60D713554EBDB40@domain.hid>,
	<4D88D39D.907@domain.hid>, <4D88D66F.6020605@domain.hid>,
	<COL122-W659C1B6386C63F74DEBCA2BDB40@domain.hid>,
	<COL122-W5950CD7CCEB15743DB8B9BBDB90@domain.hid>
	<COL122-W63A38C16F12405076DCC54BDBD0@domain.hid>
In-Reply-To: <COL122-W63A38C16F12405076DCC54BDBD0@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] MSI support in Xenomai
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: krishna m <krishnamurthyjs@domain.hid>
Cc: jan.kiszka@domain.hid, xenomai@xenomai.org

krishna m wrote:
> Just wanted to add 3 more questions:
> 1. Which versions of Linux, Adeos patch and xenomai are tested for stable MSI functionality ? Please let me know.
> 2. I am using the Xenomai Version linux-2.6.37, xenomai-2.5.6 and adeos-ipipe-2.6.37-x86-2.9-00. Is this combination fine ?
> 3. I looked at the /proc/interrupts and with out xenomai loaded [i.e. default linux kernel] I see my card beaing assigned MSI-EDGE interrupt and with xenomai kernel i don't see the entry in the /proc/interrupts but in /proc/xenomai/irq i see this entry 
> IRQ           CPU0   
> 16:              0       test_drv
> 521:             0       [IPI]
> 524:        869467       [timer]
> 525:             0       [critical sync]
> 546:             0       [virtual]
>  
> Hi Jan and Chanteperdrix,
> Any thoughts or inputs on my updates of MSI not working ?

Ok. Since you are asking me directly I am going to answer:
my point of view is, as I already told you, that MSI are not supported,
so still from my point of view the answer to question 1 is: "none"

Question 2 is yes, it is fine, but since MSI is not supported, it is not
supposed to work.

Answer to question 3 is that /proc/interrupts shows the interrupts
registered with request_irq whereas /proc/xenomai/irq shows the
interrupts which have been registered by xnintr_init, which
rtdm_request_irq uses. So, this is not the same code, the two files do
not have the same layout.

The reason why I did not answer is that Jan probably has a different
point of view for question 1, so, I let him answer you. But as far as I
know, Jan asked you some questions, in answer to your last post, to
which you did not answer.

-- 
					    Gilles.

