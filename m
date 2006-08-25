From: Bernhard Walle <Bernhard.Walle@domain.hid>
Date: Fri, 25 Aug 2006 19:57:15 +0200
Message-ID: <slrneeuefr.v1d.Bernhard.Walle@domain.hid>
References: <1903864415@domain.hid> <1154964748.4322.31.camel@domain.hid>
	<44EF17E8.5040606@domain.hid>
Sender: news <news@domain.hid>
Subject: [Xenomai-help] Re: Timer problems?
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

Hello,

first of all: you replied to a previous mail which results in a broken
thread three in the mail client ... Pleaes create new mail for new
requests.

* Steve Kreyer <steve.kreyer@domain.hid> [2006-08-25 17:31]:
> #define SLEEP_TIME 100000000
...
> The task did not wait for the period to which it is set.
> I get always an ETIMEDOUT error, and a timer overrun of 16 times when I 
> try to call rt_task_wait_period...

The example you've provided exits immediately here because you don't
wait in the main() function.

I modified your example to work:
http://pastie.caboo.se/10259

> Also another problem is, everytime I try to call rt_task_sleep or the 
> standard linux library functions pause,sleep or usleep,
> my system does not react on inputs anymore and I have to restart the 
> machine...
> Can anyone tell me whats going on there?
> If you need additional informations, please let me know :)

No problem here, for example I call sleep(2) in the RT thread and it
work. Calling Linux functions in RT code should work in Xenomai,
although it's not hard realtime safe any more because the thread gets
switched to the Linux scheduler.

Just for comparison:
I'm running Xenomai 2.1 with Kernel 2.6.15.7 on Debian 3.1.


Regards,
  Bernhard



