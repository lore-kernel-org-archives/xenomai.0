Message-ID: <45732660.6050605@domain.hid>
Date: Sun, 03 Dec 2006 20:32:48 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: =?ISO-8859-1?Q?R=E9p=2E_=3A_Re=3A_=5BXenomai-help=5D_?=
	=?ISO-8859-1?Q?_Switch_mode_with_x86?=
References: <s56d88c0.099@domain.hid>
In-Reply-To: <s56d88c0.099@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: jan.kiszka@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Nicolas BLANCHARD <n.blanchard@domain.hid>
Cc: xenomai@xenomai.org

Nicolas BLANCHARD wrote:
>>>>> "Nicolas BLANCHARD" <n.blanchard@domain.hid> 29.11 11:25 >>>
>> Hello,
>>
>> I've tested wiith Xenomai 2.3-rc2 (adeos 1.5-02)
>> and change the config : 
>>                                        - CONFIG_M586
>>                                        - disable CONFIG_INPUT_PCSPKR
> (it was on module)
>>                                        - disable prio boosting (check
> CONFIG_XENO_OPT_RPDISALBLE)
>> and it seems to work better, one hour without blocking, it's a record
>> for me.
>>
>> So, i will investigate to find which modification improve my problem.
> 
> After somes tests (kernel compil), it seems that prio boost is
> responsable of my
> problem. When it's disable (kernel option checked) my program run
> correctly.

Confirmed!

root@domain.hid :/root# cat /proc/xenomai/sched
CPU  PID    PRI      PERIOD   TIMEOUT    STAT       NAME
  0  0       99      0        0          R          ROOT
  0  837     99      9999312  0          X          TASK1
  0  838      0      10999998 0          R          TASK2

So far "only" on real hardware (P-I 133) with CONFIG_M586 and (this is
likely also very important) CONFIG_PREEMPT. I'm now about to check if I
can migrate this problem into qemu and/or capture it with the I-pipe tracer.

Jan

