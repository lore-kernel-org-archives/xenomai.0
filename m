Message-ID: <52413E95.3010003@mitrol.it>
Date: Tue, 24 Sep 2013 09:26:13 +0200
From: Paolo Minazzi <Paolo.Minazzi@mitrol.it>
MIME-Version: 1.0
References: <5240004A.6070703@mitrol.it> <52408790.3070907@xenomai.org>
In-Reply-To: <52408790.3070907@xenomai.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] rt_intr_wait bug during debugging
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
Cc: xenomai@xenomai.org

Il 23/09/2013 20.25, Gilles Chanteperdrix ha scritto:
> On 09/23/2013 10:48 AM, Paolo Minazzi wrote:
>> Hi to all,
>> the problem arise when I debug an application that uses an external
>> interrupt.
>> Below there is a sample (pseudo) code that show how I can see the problem.
>> The irq stuff is related on my specific machine, so I think it is not
>> important
>> give details about GPIO programming and interrupt clear (CLEAR_IRQ).
> Could you try reproducing this issue with a recent I-pipe patch? Say the
> I-pipe patch for Linux 3.5 or 3.8?
>
>
I see the problem with xenomai 2.5.6, linux kernel 2.6.31.8.
I cannot try with a new i-pipe.

I realize that the issue is very closed to our arm board and our porting 
of xenomai.
I think that timers and tasks related to time are more general, while 
tasks connected to
irq line are more specific to hardware and porting. So it is difficult 
reproduce it.

What I'd like to know if it is normal do it in user space (directly 
programming the registers) both
- enable at every cycle the interrupt on the line
- ack the interrupt

The xenomai example you give in the documentation does not show these 
steps,
maybe because this should be done in kernel space.

Thanks for support,

Regards

Paolo Minazzi

