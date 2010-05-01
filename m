Message-ID: <4BDC57EB.3030106@domain.hid>
Date: Sat, 01 May 2010 18:33:47 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <20100430233410.GA8991@domain.hid>,
	<4BDBF265.7080501@domain.hid>
	<245373446233674495BCA5CA2FC1EB17378D015935@domain.hid>
In-Reply-To: <245373446233674495BCA5CA2FC1EB17378D015935@domain.hid>
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
To: Andreas Glatz <AndreasGlatz@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Andreas Glatz wrote:
>>> We are running our tests now where Linux is bombarded with interrupts. Under certain conditions
>>> we found that we get page faults in IRQ Tasks which cause a secondary mode switch. To my understanding
>>> and what makes things worse is that, ISR tasks always run with the scheduler lock bit set (T_LOCK).
>>> In our case this means that when we switch to the secondary mode from the ISR Task, all other Xenomai
>>> tasks don't get scheduled until the ISR task returns to primary mode. Since Linux is under heavy
>>> interrupt load, it takes about 1-2sec for any Xenomai task to start running again.
>>>
>>> I attached a LTTng trace where you can see whats going on. Here the short version:
>> Could you tell us what version of Xenomai you are using?
> 
> Linux 2.6.32-5, Xenomai 2.4.10.1, Ipipe 2.8
> 
> 
>> And if your program uses fork() (or anything which uses fork such as
>> system(), or popen())?
> 
> Yes but all the real-time threads are created in the parent. 
> The children are just helper processes which don't make use of Xenomai APIs at all.

It does not matter. When you call fork, the linux kernel sets up copy on
write for most mappings such as the stacks in both the parent and the
child. The I-pipe patch for other architectures sets up a (costly, so
best avoided anyway) protection for this case but not on powerpc.

If the helper processes are only needed at the beginning of the process
life, you can fault all the mappings after the last fork (I have a piece
of code which does that if you are interested).

If the helper processes are created all along the life of your process
you are out of luck. You will get faults. So, you are probably better
handle these helpers in another process.


-- 
					    Gilles.

