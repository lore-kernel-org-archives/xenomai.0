Message-ID: <46529EF3.8060005@domain.hid>
Date: Tue, 22 May 2007 11:42:43 +0400
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

>> > Is it possible to get 10us period for task in Xenomai or not?
> 
> Running a task with a period of 10us is usually considered a bit out of
> the scope of Xenomai. Nevertheles, there were some recent improvements
> on Xenomai trunk that might make this possible. It would be interesting
> if you tested this with trunk and tell us whether it works.
Can somebody recommend applicable opensource RTOS extension for Linux
(with support for x86 and ARM)?

> Also note that in order to get ultra-low latencies, you have to properly
> calibrate the nucleus latency (/proc/xenomai/latency).
How to do this? (Please, navigate me to the rigth documentation or 
answer in this list).

>> > May be better to use only ADEOS functions for my task, is it faster then
>> > RTDM?
> 
> Adeos has no notion of a "task", so, you would have to implement your
> task in an interrupt handler, and yes, you would get better performance
> (see for example the difference between latency -t 2 and latency -t 1).
Can somebody give me a simple example of fast periodical "task" with 
usage of only ADEOS functions.

-- 
Igor Plyatov





