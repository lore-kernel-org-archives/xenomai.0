MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17430.59156.719375.430724@domain.hid>
Date: Tue, 14 Mar 2006 16:53:56 +0100
Subject: Re: [Xenomai-help] the same error
In-Reply-To: <4416D650.3040609@domain.hid>
References: <4416CC6A.8030605@domain.hid>
	<17430.53111.874553.840320@domain.hid>
	<4416D650.3040609@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: marcellin <marcellin.fotze@domain.hid>
Cc: xenomai@xenomai.org

marcellin wrote:
 > About rt_task_set_periodic()/rt_task_wait_periode() is there a 
 > drift with the "second time top" of the RTC IRQ ?

The RTC probably drift less than Xenomai system clock, but according to
an FAQ (http://www.beaglesoft.com/mainfaqclock.htm), the RTC drift is
typically 5 or 6 seconds a day. One way to have your system synchronized
with a precise time source is by using NTP. Unfortunately, Xenomai does
not benefit from using NTP. I guess you may plug a GPS system to the
serial port and get precise timings from there.

The reason why I suggest rt_task_set_periodic()/rt_task_wait_period() is
because they use Xenomai system clock, which compensate a constant part
of the interrupt and scheduling latencies. So, using them should lead to
the small latencies the "latency" test give you.

-- 


					    Gilles Chanteperdrix.

