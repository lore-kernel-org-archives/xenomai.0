From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <Pine.LNX.4.53.0406151339110.1831@domain.hid>
References: <Pine.LNX.4.53.0406151339110.1831@domain.hid>
Content-Type: text/plain
Message-Id: <1087395025.15584.10.camel@domain.hid>
Mime-Version: 1.0
Date: Wed, 16 Jun 2004 16:10:25 +0200
Content-Transfer-Encoding: 7bit
Subject: [Adeos-main] Re: Problem with FIFO's (maybe with RTAI/Adeos) at 2.6.x branch
Sender: adeos-main-admin@domain.hid
Errors-To: adeos-main-admin@domain.hid
List-Help: <mailto:adeos-main-request@domain.hid>
List-Post: <mailto:adeos-main@gna.org>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: <https://mail.gna.org/public/adeos-main/>
To: "Rus V. Brushkoff" <rus@domain.hid>
Cc: rtai@domain.hid, adeos-main@gna.org

On Tue, 2004-06-15 at 13:29, Rus V. Brushkoff wrote:
> 	Hi.
> 
>  After porting some stable worked on 2.4 apps to 2.6 I've noticed
> spurious traps N14 in legacy rtf_put function. While investingating this
> problem I've found an testcase - take an kernel latency example and simple
> add somewere at latency-module.c big global variable :
> 
> static char unused[1024 * 1024 * 8];
> 
> and run the example - you will receive something like :
> ....
> RTAI 3.1-test3 mounted over Adeos 2.6r5/x86.
> RTAI[malloc] loaded (global heap size=131072 bytes).
> 
> ***** STARTING THE UP REAL TIME SCHEDULER WITH LINUX *****
> ***** FP SUPPORT AND READY FOR A PERIODIC TIMER *****
> ***<> LINUX TICK AT 1000 (HZ) <>***
> ***<> CALIBRATED CPU FREQUENCY 2520162000 (HZ) <>***
> ***<> CALIBRATED TIMER-INTERRUPT-TO-SCHEDULER LATENCY 2688 (ns) <>***
> ***<> CALIBRATED ONE SHOT SETUP TIME 2010 (ns) <>***
> ***<> COMPILER: gcc version 3.3.3***
> 
> Default Trap Handler: vector 14: Suspend RT task ef8b8720
> .......
> 
> # lsmod
> Module                  Size  Used by
> latency_rt           8395792  0
> rtai_fifos             45900  3 latency_rt
> rtai_up                57272  2 latency_rt,rtai_fifos
> rtai_hal               20724  3 latency_rt,rtai_fifos,rtai_up
> .....
> 
>  Tested with latest vesuvio cvs, UP, different kernel configs and two
> different gcc - 3.3.3 and 3.4.0, hardware is ASUS P4 notebook L3H on SIS
> 96x chipset. If someone interested can supply any additional info.
> 

Uhoh... I've added this one to my check list. I don't have any clue
right now, but anyway, thanks for reporting.

> 
> 		Rus
-- 

Philippe.


