Message-ID: <4A02D381.8020506@domain.hid>
Date: Thu, 07 May 2009 14:26:41 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <OFEAD5CF08.F6D90D65-ONC12575AF.0040F159-C12575AF.00433C0E@datacon.at>
In-Reply-To: <OFEAD5CF08.F6D90D65-ONC12575AF.0040F159-C12575AF.00433C0E@datacon.at>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] gatekeeper/0
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: henning.richter@domain.hid
Cc: xenomai@xenomai.org

henning.richter@domain.hid wrote:
> Things are strange. Now my application works without crashing. I haven't
> changed anything.
> Btw. what should be a "normal" value of /proc/xenomai/latency ?
> I've got 1676

/proc/xenomai/latency is the anticipation of the Xenomai timer. It is
actually a value for you to tweak with a default value that does not
cause any pathological behaviour.

> 
> Back to my main problem:
> Sending / Receiving Frames is still too slow. At a framesize of around 700
> byte it takes around
> 350 us before the next frame is send. And this at a given cycle time of 250
> us at a priority of 90.
> All printf's and other logs are removed. No Modeswitches are done during
> run of my application.
> Btw. what counts CSW at /proc/xenomai/stat ?

CSW is context switches.
But IMO, first things should be done first, and you should investigate
the crashes. And it would be still be interesting to know if switchtest
works on your platform.

As for the latency, as I think I already told you, you should run the
latency test at the same frequency as the one of your application with
which you see problems. If you see problems with the latency test, then
Xenomai has a problem on your platform, otherwise, the problem is in
your application.

> 
> 
>    ethercat@domain.hid:~$ cat /proc/xenomai/sched
> 
>    CPU         PID    PRI         PERIOD           TIMEOUT    TIMEBASE
> STAT       NAME
>          0     0           -1          0           0           master    R
> ROOT/0
>          0     0           98          0           0           master    W
> rtnet-stack
>          0     0           0                 0           0           master
> W          rtnet-rtpc
>          0     5259     0              0                 0
> master    X          master_test
>          0     5260    90              249752     1109638            master
> w          myRtTask
> 
> 
> 
>    ethercat@domain.hid:~$ cat /proc/xenomai/stat
>    CPU  PID          MSW        CSW        PF    STAT       %CPU  NAME
>      0         0           0          436897       0     00500080   74.9
> ROOT/0
>      0   0           0          435422       0     00000082    1.0
> rtnet-stack
>      0         0           0          1            0     00000082    0.0
> rtnet-rtpc
>      0   5259   1          1                       0     00300380    0.0
> master_test
>      0         5260   24         59775             0     00300186    0.1
> myRtTask
>      0         0           0          870784       0     00000000    3.6
> IRQ6: rt_eepro100
>      0         0           0          527744       0     00000000    2.6
> IRQ233: [timer]
> 
> I think I will start tracing with the ipipe tracer.

The I-pipe tracer will not help you understand what happens in
user-space. For this, you are probably better of measuring things with
rt_timer_tsc() or clock_gettime().

-- 
                                                 Gilles.

