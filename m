Message-ID: <4B45F163.4000504@domain.hid>
Date: Thu, 07 Jan 2010 15:36:19 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4B45F088.9010603@domain.hid>
In-Reply-To: <4B45F088.9010603@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] native skin 2.5.0: rt_task_create() segfaults if
 stacksize parameter too small
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Stefan Kisdaroczi <kisda@domain.hid>
Cc: xenomai@xenomai.org

Stefan Kisdaroczi wrote:
> hi,
> 
> i have upgraded xenomai to 2.5.0 (x86,32bit). My application segfaults when I
> try to create a task with stacksize 2048, this worked with 2.4.10.
> Because my app is written in pascal i have reproduced the problem with the
> xenomai trivial-periodic.c example:
> 
> -	rt_task_create(&demo_task, "trivial", 0, 99, 0);
> +	rt_task_create(&demo_task, "trivial",16911, 99, 0);
> 
> Stacksize 0 -> default stack size : ok
> Stacksize > 0 and <= 16911 : Segmentation fault
> Stacksize >= 16912 : ok
> 
> Any hints ?

What does the task do? If it uses printf, printf needs a lot of room on
the stack.

-- 
					    Gilles.

