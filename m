Message-ID: <4538BB85.4060106@domain.hid>
Date: Fri, 20 Oct 2006 14:05:25 +0200
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Testsuite latency
References: <54b161f50610200324q625b79bcg45e1c3d0b2b19b77@domain.hid>
In-Reply-To: <54b161f50610200324q625b79bcg45e1c3d0b2b19b77@domain.hid>
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
To: Frits de Klark <mailing.xenomai@domain.hid>
Cc: xenomai@xenomai.org

Frits de Klark wrote:
> Hello everyone,
> 
> as sort of a newbie to Xenomai (and realtime Linux in general) I'm the 
> moment running the (unmodified) latency test included in the testsuite  
> in different situations:
> 
> Situation A: Running as little daemons as possible in the background. 
> The chart I produced from the testdata, after running it for about 15 
> minutes, without doing anything else on the machine, shows very stable 
> results, that is: there a no visible peaks downwards. Iin the case of 
> MAX for example, the value is most of the time between 2.7 and 2.9, 
> occasionly going straight up in the air, but NEVER below 2.7.
> WORST is 5.33, BEST is 0.40.
> 
> Situation B: Running 1 'unneccesary' daemon, mysqld, but performing no 
> database operations whatsoever. The chart I produced from this testdata 
> (it also ran for 15 minutes) is completely different and the line 
> representing MAX is going up and down all the time, it looks VERY unsteady.
> In this case WORST is 16.52 and BEST is 1.11.
> 
> How is this possible? I'm ofcourse aware that Linux is constantly 
> heeding the mysql daemon, but I can't imagine this produces suc 
> relatively large differences between testresults. I'm sure there is a 
> perfectly sane explanation for it, but I need a little help to 
> understand things like this.
> The platform I'm testing on is an x86.

On medium to high end CPUs, most of the latency is caused by hardware 
(cache refills, TLB misses, bus congestions, etc.). Without load, your 
RT code will remain in the cache for a long time resulting in short 
latencies. With load, the cache will be used by low-priority Linux tasks 
and must be regained for RT activity. Therefore the only useful figure 
is the worst case latency under load.

Wolfgang.


