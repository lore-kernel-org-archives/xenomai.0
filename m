From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <1308652557.2125.45.camel@domain.hid>
References: <3FF315C710820E47A04E55C6F7D9B0AD7FE9FF@AREXCH02.mra.roland-man.biz>
	<1308044391.2699.2.camel@domain.hid>
	<3FF315C710820E47A04E55C6F7D9B0AD7FEA2C@AREXCH02.mra.roland-man.biz>
	<1308387052.2122.14.camel@domain.hid>  <4DFCABDA.6000702@domain.hid>
	<1308406918.2122.24.camel@domain.hid>
	<3FF315C710820E47A04E55C6F7D9B0AD7FECDA@AREXCH02.mra.roland-man.biz>
	<1308652557.2125.45.camel@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Sun, 03 Jul 2011 17:48:26 +0200
Message-ID: <1309708106.2127.0.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Xenomai 2.5.6 with PPC-Kernel 2.4.25
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: roderik.wildenburg@domain.hid
Cc: xenomai@xenomai.org

On Tue, 2011-06-21 at 12:35 +0200, Philippe Gerum wrote:
> On Tue, 2011-06-21 at 12:04 +0200, roderik.wildenburg@domain.hid
> wrote:
> > I confirm that switchtest runs (nearly) perfectly on PPC-Kernel 2.6.34 with Xenomai 2.5.6. The only anomaly I could see is a "collapse" of the number of context switches exactly every 7 seconds by 2% (see below).  Is this worth to pay attention to? (No other Xenomai-Task is running except for a watchdog task with a period of 500ms)
> 
> 2% off seems a lot for a transient load, and this would not happen on a
> periodic basis anyway. This needs to be investigated. Could you run
> switchtest in nofpu mode?
> 
> >  
> > On the opposite, switchtest runs erratic on PPC-2.4.25 with Xenomai 2.5.6 as you already mentioned: The number of context switches is much smaller then (only about 2%) with  PPC-2.6.34 and fluctuate very much (see below).
> > Do you think you will find some spare time to fix this Problem?
> > 
> 
> Spare time has become a luxury over the last months. I'll try to find a
> time slot next week to have a look at this again.

This should help, no I-pipe update needed.

http://git.xenomai.org/?p=xenomai-rpm.git;a=commit;h=35e9df567e19410526089e24fbbaf92c47de9c43

-- 
Philippe.



