Message-ID: <4450B760.4060201@domain.hid>
Date: Thu, 27 Apr 2006 14:21:52 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <b647ffbd0604120138p5088006aqf074c711a0478487@domain.hid>	
	<44416943.4070702@domain.hid>	
	<b647ffbd0604220254l154fcc7dh462c7d45bcd2c441@domain.hid>	
	<444C89F4.3040302@domain.hid>	
	<b647ffbd0604240228sb8d58a3kc3b780a576c2d95a@domain.hid>
	<b647ffbd0604270116j5a32bb22j26e3317488ec8f42@domain.hid>
In-Reply-To: <b647ffbd0604270116j5a32bb22j26e3317488ec8f42@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Re: [REQUEST] eliminate the
	rthal_critical_enter/exit() from rthal_irq_request()
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Dmitry Adamushko <dmitry.adamushko@domain.hid>
Cc: xenomai@xenomai.org

Dmitry Adamushko wrote:
> Hello,
> 
> this fix prevents possible deadlocks in rt_intr_delete() vs. ISR
> handlers that I have mentioned earlier.

Applied, thanks.

-- 

Philippe.

