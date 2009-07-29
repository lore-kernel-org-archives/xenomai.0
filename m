Date: Wed, 29 Jul 2009 13:40:13 +0200 (CEST)
From: Kolja Waschk <xenoka09@domain.hid>
In-Reply-To: <Pine.LNX.4.62.0907291210470.20869@domain.hid>
Message-ID: <Pine.LNX.4.62.0907291226390.20869@domain.hid>
References: <Pine.LNX.4.62.0907241731170.11473@domain.hid>
	<1248453047.3998.168.camel@domain.hid>
	<alpine.DEB.2.00.0907241917480.4343@domain.hid>
	<1248461458.3998.183.camel@domain.hid>
	<alpine.DEB.2.00.0907242259430.4343@domain.hid>
	<1248517986.4438.1.camel@domain.hid>
	<alpine.DEB.2.00.0907281859210.4673@domain.hid>
	<1248855797.3247.16.camel@domain.hid>
	<Pine.LNX.4.62.0907291210470.20869@domain.hid>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: "Kolja Waschk,,," <xenoka09@domain.hid>
Subject: Re: [Xenomai-help] Stack sizes etc. (Re: POSIX skin/Blackfin:
 SIGSEGV when stracing or gdb'ing)
Reply-To: xenoka09@domain.hid
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

> One of the problems appears when the following code is run via
> gdbserver, a breakpoint is hit at main() and I "step" over
> rt_task_shadow:
>
>> Xenomai: fatal: xnshadow_relax() failed for thread maintask[222]

I just observed the same without gdb in play, with main extended a bit,
creating a second (RT) thread from main (after rt_task_shadow in main).

Xenomai: fatal: xnshadow_relax() failed for thread logger[219]
  CPU  PID    PRI      TIMEOUT  STAT      NAME
    0  0       50      0        00400088  ROOT
    0  217     50      0        00300380  maintask
>  0  219     50      0        00300380  logger
Master time base: clock=74044591006

However, it doesn't happen with the simple example I posted last week.
Maybe I can find some evolutional stage between that example and my
larger application that just causes the failure.

Kolja

