Message-ID: <4540E5E8.9010608@domain.hid>
Date: Thu, 26 Oct 2006 11:44:24 -0500
From: Jeff Webb <jeff.webb@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] switchtest and Xenomai 2.2.4
References: <1160947939.4962.27.camel@domain.hid> <453FC4C0.5070105@domain.hid>
	<453FF6AA.6030406@domain.hid> <45406FEF.90806@domain.hid>
	<4540D998.2090908@domain.hid> <4540DACA.2050406@domain.hid>
In-Reply-To: <4540DACA.2050406@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Gilles Chanteperdrix wrote:
> Jeff Webb wrote:
>> Gilles Chanteperdrix wrote:
>>
>>> After the first Ctrl-C that does not work, could you try and attach gdb
>>> to see where the threads are stopped ?
>>
>>
>> I tried to do this, but was unable to determine the stopping point 
>> using gdb.
>
> type simply: "info threads"
> then change thread to the main thread with "thread x", where x is the 
> lowest thread id as listed by "info threads"
> then type: "backtrace"

If I try to connect to the process after I press the ctrl-c one time, I get:

# gdb --pid=2660
Attaching to process 2660
warning: The current VSYSCALL page code requires an existing excuitable. [sic]
Use "add-symbol-file-from-memory" to load the VSYSCALL page by hand

Then the whole machine locks up, and I am forced to reboot.

I am able to connect before I press ctrl-c:

(gdb) thread 1
[Switching to thread 1 (Thread -1208273216 (LWP 2634))]#0  0xffffe410 in ?? ()
(gdb) backtrace
#0  0xffffe410 in ?? ()
#1  0xbfd96294 in ?? ()
#2  0x00000000 in ?? ()
(gdb) c
Continuing.

Then I type ctrl-c, and the machine locks up, as before.  The machine does not lock up, if I am not connected via gdb.

> /proc/xenomai/sched gives an information on the status that is easier to
> understand.

Before pressing ctrl-c:

$ cat /proc/xenomai/sched
CPU  PID    PRI      PERIOD   TIMEOUT    STAT       NAME
  0  0       -1      0        0          R          ROOT/0
  1  0       -1      0        0          R          ROOT/1
  0  2641     0      0        0          X          switchtest
  0  0        1      0        0          W          rtk1/0
  0  0        1      0        0          W          rtk2/0
  0  0        1      0        0          Wf         rtk3/0
  0  0        1      0        0          Wf         rtk4/0
  0  0        1      0        0          Wf         rtk5/0
  0  0        1      0        0          Wf         rtk6/0
  0  2643     1      0        0          X          rtup0-7
  0  2644     1      0        0          X          rtup0-8
  0  2645     1      0        0          X          rtup_ufpp0-9
  0  2646     1      0        0          X          rtup_ufpp0-10
  0  2647     1      0        0          W          rtus0-11
  0  2648     1      0        0          W          rtus0-12
  0  2649     1      0        0          W          rtus_ufps0-13
  0  2650     1      0        0          W          rtus_ufps0-14
  0  2651     1      0        0          X          rtuo0-15
  0  2652     1      0        0          X          rtuo0-16
  0  2653     1      0        0          X          rtuo_ufpp0-17
  0  2654     1      0        0          X          rtuo_ufpp0-18
  0  2655     1      0        0          X          rtuo_ufps0-19
  0  2656     1      0        0          X          rtuo_ufps0-20
  0  2657     1      0        0          X          rtuo_ufpp_ufps0-21
  0  2658     1      0        0          X          rtuo_ufpp_ufps0-22
  1  0        1      0        0          W          rtk1/1
  1  0        1      0        0          W          rtk2/1
  1  0        1      0        0          Wf         rtk3/1
  1  0        1      0        0          Wf         rtk4/1
  1  0        1      0        0          Wf         rtk5/1
  1  0        1      0        0          Wf         rtk6/1
  1  2660     1      0        0          X          rtup1-7
  1  2661     1      0        0          X          rtup1-8
  1  2662     1      0        0          X          rtup_ufpp1-9
  1  2663     1      0        0          X          rtup_ufpp1-10
  1  2664     1      0        0          W          rtus1-11
  1  2665     1      0        0          W          rtus1-12
  1  2666     1      0        0          W          rtus_ufps1-13
  1  2667     1      0        0          W          rtus_ufps1-14
  1  2668     1      0        0          W          rtuo1-15
  1  2669     1      0        0          W          rtuo1-16
  1  2670     1      0        0          W          rtuo_ufpp1-17
  1  2671     1      0        0          W          rtuo_ufpp1-18
  1  2672     1      0        0          W          rtuo_ufps1-19
  1  2673     1      0        0          W          rtuo_ufps1-20
  1  2674     1      0        0          W          rtuo_ufpp_ufps1-21
  1  2675     1      0        0          W          rtuo_ufpp_ufps1-22

After pressing ctrl-c once:

$ cat /proc/xenomai/sched
CPU  PID    PRI      PERIOD   TIMEOUT    STAT       NAME
  0  0       -1      0        0          R          ROOT/0
  1  0       -1      0        0          R          ROOT/1
  0  2641     0      0        0          X          switchtest
  0  0        1      0        0          W          rtk1/0
  0  0        1      0        0          W          rtk2/0
  0  0        1      0        0          Wf         rtk3/0
  0  0        1      0        0          Wf         rtk4/0
  0  0        1      0        0          Wf         rtk5/0
  0  0        1      0        0          Wf         rtk6/0
  0  2647     1      0        0          R          rtus0-11
  0  2648     1      0        0          R          rtus0-12
  0  2649     1      0        0          R          rtus_ufps0-13
  0  2650     1      0        0          R          rtus_ufps0-14
  0  2651     1      0        0          R          rtuo0-15
  0  2652     1      0        0          R          rtuo0-16
  0  2653     1      0        0          R          rtuo_ufpp0-17
  0  2654     1      0        0          R          rtuo_ufpp0-18
  0  2655     1      0        0          R          rtuo_ufps0-19
  0  2656     1      0        0          R          rtuo_ufps0-20
  0  2657     1      0        0          R          rtuo_ufpp_ufps0-21
  0  2658     1      0        0          R          rtuo_ufpp_ufps0-22
  1  0        1      0        0          W          rtk1/1
  1  0        1      0        0          W          rtk2/1
  1  0        1      0        0          Wf         rtk3/1
  1  0        1      0        0          Wf         rtk4/1
  1  0        1      0        0          Wf         rtk5/1
  1  0        1      0        0          Wf         rtk6/1
  1  2660     1      0        0          X          rtup1-7
  1  2661     1      0        0          X          rtup1-8
  1  2662     1      0        0          X          rtup_ufpp1-9
  1  2663     1      0        0          X          rtup_ufpp1-10
  1  2664     1      0        0          W          rtus1-11
  1  2665     1      0        0          W          rtus1-12
  1  2666     1      0        0          W          rtus_ufps1-13
  1  2667     1      0        0          W          rtus_ufps1-14
  1  2668     1      0        0          X          rtuo1-15
  1  2669     1      0        0          X          rtuo1-16
  1  2670     1      0        0          X          rtuo_ufpp1-17
  1  2671     1      0        0          X          rtuo_ufpp1-18
  1  2672     1      0        0          X          rtuo_ufps1-19
  1  2673     1      0        0          X          rtuo_ufps1-20
  1  2674     1      0        0          X          rtuo_ufpp_ufps1-21
  1  2675     1      0        0          X          rtuo_ufpp_ufps1-22

After pressing ctrl-c twice:

webb-ja@domain.hid:~$ cat /proc/xenomai/sched
CPU  PID    PRI      PERIOD   TIMEOUT    STAT       NAME
  0  0       -1      0        0          R          ROOT/0
  1  0       -1      0        0          R          ROOT/1
  0  0        1      0        0          W          rtk1/0
  0  0        1      0        0          W          rtk2/0
  0  0        1      0        0          Wf         rtk3/0
  0  0        1      0        0          Wf         rtk4/0
  0  0        1      0        0          Wf         rtk5/0
  0  0        1      0        0          Wf         rtk6/0
  1  0        1      0        0          W          rtk1/1
  1  0        1      0        0          W          rtk2/1
  1  0        1      0        0          Wf         rtk3/1
  1  0        1      0        0          Wf         rtk4/1
  1  0        1      0        0          Wf         rtk5/1
  1  0        1      0        0          Wf         rtk6/1
  1  2665     1      0        0          R          rtus1-12
  1  2666     1      0        0          R          rtus_ufps1-13
  1  2667     1      0        0          R          rtus_ufps1-14

