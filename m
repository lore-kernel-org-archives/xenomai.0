Message-ID: <4416D650.3040609@domain.hid>
Date: Tue, 14 Mar 2006 15:42:24 +0100
From: marcellin <marcellin.fotze@domain.hid>
Subject: Re: [Xenomai-help] the same error
References: <4416CC6A.8030605@domain.hid>
	<17430.53111.874553.840320@domain.hid>
In-Reply-To: <17430.53111.874553.840320@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, xenomai@xenomai.org

Hi Gilles,
lsmod say nothing because Xenomai is configured in Static with the 
kernel. About rt_task_set_periodic()/rt_task_wait_periode() is there a 
drift with the "second time top" of the RTC IRQ ? because my acquisition 
works the for time stamping of sample electrical values. If after a few 
mounths there is a drift of some seconds, we can't use the samples. If 
the rt_task_set_periodic()/rt_task_wait_periode() are synchronize ( or 
if it's possible ) with the RTC irq, then it's Ok.

regards

Marcell1

