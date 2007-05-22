From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18003.20070.112837.6291@domain.hid>
Date: Tue, 22 May 2007 22:11:18 +0200
In-Reply-To: <46529EF3.8060005@domain.hid>
References: <46529EF3.8060005@domain.hid>
Subject: Re: [Xenomai-help] 10us periodical task (Xenomai vs. RTAI)
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: plyatov@domain.hid
Cc: xenomai@xenomai.org

Igor Plyatov wrote:
 > Hello!
 > 
 > >> > Is it possible to get 10us period for task in Xenomai or not?
 > > 
 > > Running a task with a period of 10us is usually considered a bit out of
 > > the scope of Xenomai. Nevertheles, there were some recent improvements
 > > on Xenomai trunk that might make this possible. It would be interesting
 > > if you tested this with trunk and tell us whether it works.
 > Can somebody recommend applicable opensource RTOS extension for Linux
 > (with support for x86 and ARM)?

On this list, we talk about Xenomai. We hope you will try Xenomai trunk
and its improvements will suit your needs.

 > > Also note that in order to get ultra-low latencies, you have to properly
 > > calibrate the nucleus latency (/proc/xenomai/latency).
 > How to do this? (Please, navigate me to the rigth documentation or 
 > answer in this list).

Just run:
echo 5000 > /proc/xenomai/latency
if you want Xenomai to tick 5us in advance. To get an idea of how you
should set this latency, run the latency test. Re-run the latency test
after having set /proc/xenomai/latency to see the consequences of the
value you chose.

 > 
 > >> > May be better to use only ADEOS functions for my task, is it faster then
 > >> > RTDM?
 > > 
 > > Adeos has no notion of a "task", so, you would have to implement your
 > > task in an interrupt handler, and yes, you would get better performance
 > > (see for example the difference between latency -t 2 and latency -t 1).
 > Can somebody give me a simple example of fast periodical "task" with 
 > usage of only ADEOS functions.

Using an RTDM interrupt handler should not be slower than using an Adeos
interrupt handler. For an example using RTDM API to register an
interrupt handlers, have a look at Xenomai drivers, in the ksrc/drivers
directory.

P.S: you do not want to run a 10us periodic task on ARM, do you ? that is
impossible.

-- 


					    Gilles Chanteperdrix.

