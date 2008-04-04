Message-ID: <47F5FC80.3060603@domain.hid>
Date: Fri, 04 Apr 2008 12:01:36 +0200
From: =?ISO-8859-15?Q?Thomas_H=E4berle?= <thomas.haeberle@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] problem with trivial-periodic.c example
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

I am running Xenomai 2.3.5 on my MPC5200S on a STK52xx with a Linux 
2.4.25-DENX kernel (cross-compiling to the target).

When I try to compile the "trivial-periodic.c" example with
 >>> $ ppc_6xx-gcc SimpleTask.c -I $XENOINSTALL/include -L 
$XENOINSTALL/lib -o SimpleTask -Wall

I get the following:
 >>>
/tmp/ccwxJiOz.o(.text+0x30): In function `demo':
: undefined reference to `rt_task_set_periodic'
/tmp/ccwxJiOz.o(.text+0x34): In function `demo':
: undefined reference to `rt_timer_read'
/tmp/ccwxJiOz.o(.text+0x4c): In function `demo':
: undefined reference to `rt_task_wait_period'
/tmp/ccwxJiOz.o(.text+0x50): In function `demo':
: undefined reference to `rt_timer_read'
/tmp/ccwxJiOz.o(.text+0x160): In function `main':
: undefined reference to `rt_task_create'
/tmp/ccwxJiOz.o(.text+0x178): In function `main':
: undefined reference to `rt_task_start'
/tmp/ccwxJiOz.o(.text+0x188): In function `main':
: undefined reference to `rt_task_delete'
collect2: ld returned 1 exit status
<<<

Aren't the functions used in the example in the libraries in the 
"$XENOINSTALL/lib" directory?
Or do I have to tell the compiler and/or linker about any of the Xenomai 
source paths to get this working?

Thanks & Greetings,
Thomas

