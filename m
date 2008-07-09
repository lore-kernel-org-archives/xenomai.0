Message-ID: <48745B79.7020100@domain.hid>
Date: Wed, 09 Jul 2008 08:32:25 +0200
From: =?ISO-8859-15?Q?Thomas_H=E4berle?= <thomas.haeberle@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] rt_task_set_periodic() question
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

I am using Xenomai 2.3.5 with a Linux Kernel 2.4 on an MPC5200.

One of my periodic Xenomai tasks has to be rescheduled now and than for
some -for the question unimportant- reasons.
To do so I
1.) get the next planed release point with "rt_task_inquire(NULL, 
&tt_info)"
2.) add the desired delay to the sheduling point with "t_start = 
RTIME(tt_info.relpoint + delay)"
    (delay is always a positive value)
3.) call "rt_task_set_periodict_task_set_periodic( NULL, t_start, 
ONE_MS)" to reshedule the task

 From step 3 I get the return value "-110" which is "ETIMEDOUT" (AFAIK)
thus according to the Xenomai-documentation the calculated new 
sheduling  point allready passed.
I miss the point where I do something wrong!?!?
It doesn't seem to matter how much I increase "t_start", the return 
value stays at -110,
so I guess I missunderstood the usage of one of the functions!?!?

Any hints or suggestions?

Thanks & Greetings,
Thomas

