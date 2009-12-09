Message-ID: <4B1F9E26.7070900@domain.hid>
Date: Wed, 09 Dec 2009 13:55:02 +0100
From: Jozsef Lazar <jlazar@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] Waiting w/o burning CPU
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

Hi,

Could anyone tell me which Xenomai function should I use to wait (even 
up to 100msecs) without burning CPU. I tried using nanosleep() but it 
was always returning with 1 (one) and analyzing my output pins with an 
oscilloscope I couldn't see any time delays. Now I use rt_timer_spin() 
but I'm not sure whether I'm doing any wrong to my rt threads (or anyone 
else in the kernel). My environment: a kernel driver with lots of rt 
threads controlling stepper motors. The function where I want to wait is 
a work_struct task (called by a schedule_work). Thanks.

-- joseph

