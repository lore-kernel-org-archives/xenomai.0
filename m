Message-ID: <475E76A0.4010007@domain.hid>
Date: Tue, 11 Dec 2007 12:38:08 +0100
From: =?ISO-8859-1?Q?Ignacio_Garc=EDa_P=E9rez?= <iggarpe@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] Application broken 2.3.4 ---> 2.4.0
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

I've compiled a previously 100% working application under the new 2.4.0 
release and found the following issues:


1- rt_task_set_periodic does not work sometimes?

In this application I have a periodic task (250ms period) which is used 
to blink some lights. The blinking is occasionally resynchronized to 
some external event, and this is what I do:

In the periodic task:

blink_count = 0;
rt_task_set_periodic();
for (;;) {
    whatever();
    blink_count = (blink_count + 1) & 3;
    rt_task_wait_period();
}

Some somewhere else, when I want to synchronize the blinking:

    blink_count = 0;
    rt_task_set_periodic();

This has worked perfectly until version 2.4.0. It seems that further 
calls to rt_task_set_periodic (from a different task) break the 
periodicity (the periodic task enters rt_task_wait_period() and never 
leaves again).

Any clues?



2- ENOBUFS error in rt_pipe_read upon userland close of the pipe.

This is weird and I still have to investigate it further. When the 
userland program closes the pipe, the RT kernel module gets a ENOBUFS 
error from rt_pipe_read.

Any clues?



Thanks.

