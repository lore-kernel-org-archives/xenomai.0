Message-ID: <4BDBF265.7080501@domain.hid>
Date: Sat, 01 May 2010 11:20:37 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <20100430233410.GA8991@domain.hid>
In-Reply-To: <20100430233410.GA8991@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Page fault and secondary mode switch on PowerPC
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Andreas Glatz <andreasglatz@domain.hid>
Cc: xenomai@xenomai.org

Andreas Glatz wrote:
> Hi,
> 
> We are running our tests now where Linux is bombarded with interrupts. Under certain conditions 
> we found that we get page faults in IRQ Tasks which cause a secondary mode switch. To my understanding
> and what makes things worse is that, ISR tasks always run with the scheduler lock bit set (T_LOCK). 
> In our case this means that when we switch to the secondary mode from the ISR Task, all other Xenomai
> tasks don't get scheduled until the ISR task returns to primary mode. Since Linux is under heavy 
> interrupt load, it takes about 1-2sec for any Xenomai task to start running again.
> 
> I attached a LTTng trace where you can see whats going on. Here the short version:

Could you tell us what version of Xenomai you are using?
And if your program uses fork() (or anything which uses fork such as
system(), or popen())?

-- 
					    Gilles.

