Message-ID: <305035a40705230025q50e05401xa76dbb966a24c254@domain.hid>
Date: Wed, 23 May 2007 09:25:37 +0200
From: "Gregory CLEMENT" <gclement00@domain.hid>
In-Reply-To: <528bc2040705222310j179c996w9f7732032038886b@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <528bc2040705222310j179c996w9f7732032038886b@domain.hid>
Subject: Re: [Xenomai-core] getting negative values in interrupt latency in
	xenomai
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: manoj kumar <manojkpanghal@domain.hid>
Cc: xenomai@xenomai.org

2007/5/23, manoj kumar <manojkpanghal@domain.hid>:
> Hi,
>
> i am runnigthe latency test on i386 platform with 1 GB ram and intel pentium
> 4 runnig at 2.66GHz . i am getting some negative values as lat best and avg.
> The results are as below
>
>
>     User space interrupt latency output
>
>     == Sampling period: 10000 us
>
> == Test mode: periodic user-mode task
>
> == All results in microseconds
>
> warming up...
>
> RTT|  00:00:01   (periodic user-mode task, 10000 us period, priority 99)
>
> RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat
> worst
>
> RTD|      -1.775|       -1.374|       0.953|       0|      -1.775|
> 0.953
>
> RTD|      -1.790|      -1.355|       3.142|       0|      -1.790|
> 3.142
>
> RTD|      -1.812|       -1.266|       4.158|       0|      -1.812|
> 4.158
>
> RTD|      -1.797|       -1.272|       6.602|       0|      -1.812|
> 6.602
>
> RTD|      -1.764|       -1.365|       0.575|       0|      -1.812|
> 6.602
>
> RTD|      -1.895|       -1.370|       0.859|       0|      -1.895|
> 6.602
>
> RTD|      -1.857|       -1.421|       0.908|       0|      -1.895|
> 6.602
>
> RTD|      -1.782|       -1.293|       5.845|       0|      -1.895|
> 6.602
>
> RTD|      -1.929|       -1.362|       1.204|       0|      -1.929|
> 6.602
>
> RTD|      -1.775|       -1.359|       0.844|       0|      -1.929|
> 6.602
>
> RTD|      -1.794|       -1.346|       0.724|       0|      -1.929|
> 6.602
>
> RTD|      -1.756|      -1.318|       1.021|       0|      -1.929|
> 6.602
>
> RTD|      -1.775|       -1.269|       8.064|       0|      -1.929|
> 8.064
>
> RTD|      -1.805|       -1.395|       0.893|       0|      -1.929|
> 8.064
>
> RTD|      -1.779|        1.530|     281.147|       0|      -1.929|
> 281.147
>
> RTD|      -1.959|       -1.362|       1.118|       0|      -1.959|
> 281.147
> Could any figure out why these negative values are coming and reason behind
> that and how i can avoid these.
>
> is it a configuration issuse.

You have to calibrate xenomai by feeding with your average latency
/proc/xenomai/latency



>
> Thanks & regards
> Manoj


-- 
Gregory CLEMENT
Adeneo
2, chemin du Ruisseau - BP21
69136 Ecully Cedex
France
Tel : +33-4 72 18 08 40

