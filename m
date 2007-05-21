Message-ID: <46519AD0.80804@domain.hid>
Date: Mon, 21 May 2007 17:12:48 +0400
From: Igor Plyatov <plyatov@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] 10us periodical task (Xenomai vs. RTAI)
Reply-To: plyatov@domain.hid
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

Hello!

Thank to all excellent guys who make Xenomai (great work)!

I'm novice in Xenomai.
One day I read the article at "Linux Devices" about software radio on
Linux with RTAI:
http://www.linuxdevices.com/articles/AT3239582376.html

"Coupard's demo generate a carrier frequency of 153 KHz, based on
running the real-time task on every system timer interrupt, or 306,000
times per second. Since at that rate it required a 500 MHz Pentium or
faster."

I try to make something like this with Xenomai's RTDM, but do not get
good results.
I need a kernel task, with period 10us, which do little calculations and
output data to the LPT port.
What I can get with acceptable jitter (and without any calculations in
task):
  20us on 2.4GHz Pentium4
  100us on 150MHz Pentium

Is it possible to get 10us results in Xenomai or not?
May be better to use only ADEOS functions for my task, is it faster then
RTDM?
What is the state of RTAI nowadays, is it still a live?

-- 
Igor Plyatov



