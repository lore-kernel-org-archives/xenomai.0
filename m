Message-ID: <46B1A842.1090708@domain.hid>
Date: Thu, 02 Aug 2007 11:47:46 +0200
From: Johan Borkhuis <j.borkhuis@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] Unexpected switch to secondary mode
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Xenomai-help@domain.hid

I am experiencing an unexpected switch to secondary mode in a 
rt_timer_tsc2ns call from userspace.

The following code give a switch:
    SRTIME timeStamp;
    timeStamp = rt_timer_tsc2ns(rt_timer_tsc());
    while((rt_timer_tsc2ns(rt_timer_tsc()) - timeStamp) < (usecs*1000)) {}

while the following code does not:
    RTIME timeStamp;
    timeStamp = rt_timer_tsc();
    while((rt_timer_tsc() - timeStamp) < (usecs*1000)) {}

(I know that the second example causes a longer timeout, but this was to 
show the testcase).

When splitting up the 2nd line in the first example I see that the 
rt_timer_tsc() call does not cause a switch, but the rt_timer_tsc2ns 
does. What am I doing wrong here?

I am using Xenomai-2.3.2.

Kind regards,
    Johan Borkhuis


