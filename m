MIME-Version: 1.0
In-Reply-To: <CAOiXNkCWAOjufZAg0eFA5tv3N6v9Yiy0GFt6_hHQj+k48TFrFQ@mail.gmail.com>
References: <52039EC3.4050908@gmail.com>
	<2A0F278E-ED28-46CC-8727-DC97BB89A6D6@mah.priv.at>
	<68671d77.6ce2003b.520526a4.3e2c@o2.pl>
	<52060B80.1080601@gmail.com>
	<ca8c552.13b41e8d.52063223.12f46@o2.pl>
	<CAOiXNkCWAOjufZAg0eFA5tv3N6v9Yiy0GFt6_hHQj+k48TFrFQ@mail.gmail.com>
Date: Sat, 10 Aug 2013 17:19:40 +0200
Message-ID: <CAOiXNkCknexVMA3vMwZGYzSHeLM9V7TxdDP-j5vS=0pdXxA4JQ@mail.gmail.com>
From: Andrey Nechypurenko <andreynech@googlemail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Xenomai] Using hardware PWM generators with Xenomai
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Robert <robert-km@o2.pl>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 10 August 2013 17:14, Andrey Nechypurenko <andreynech@googlemail.com> wrote:
>> My program differs a little from Andrey.
>> I'm using hardware interrupts from timers to change value on gpio pin and
>> he was using rtdm_sleep*() (as far as I remember).
>
> Right. We started with thread-based approach (task/sleep) but results
> were not good enough and we switch to timer-based implementation. If
> you are interested, here is the corresponding source code:
> https://github.com/andreynech/rtdm-pwm/ . In particular, you can take
> a look at this file:
> https://github.com/andreynech/rtdm-pwm/blob/master/pwm-task-proc.c

Forget to say - this example uses direct memory access to toggle pins.
This one here:
https://github.com/veter-team/tb6612fng/blob/master/pwm-task-proc.c is
rewritten with gpio_set_value & co.

