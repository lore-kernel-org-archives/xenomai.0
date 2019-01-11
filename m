Subject: Re: I-pipe 4.4.x-cip
References: <169e6cda-32e6-0dd9-f709-ef2de587a77a@siemens.com>
 <20190110162720.zou735azbtpir64y@jholzmayr.localdomain>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <a7c9a412-4e28-1fff-44f8-7290536c6bd6@siemens.com>
Date: Fri, 11 Jan 2019 10:26:29 +0800
MIME-Version: 1.0
In-Reply-To: <20190110162720.zou735azbtpir64y@jholzmayr.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Josef Holzmayr <holzmayr@rsi-elektrotechnik.de>, xenomai@xenomai.org

On 11.01.19 00:27, Josef Holzmayr via Xenomai wrote:
> On Thu, Dec 20, 2018 at 05:32:37PM +0100, Jan Kiszka wrote:
>> https://gitlab.denx.de/Xenomai/ipipe/tree/ipipe-4.4.y-cip
>>
>> For now, I would ask everyone interested in this baseline, may it be on x86
>> or ARM, to try out the new branch.
> 
> So here's some proper test results for 4.4.166-cip29 / 60a778a4a6aebf030d12c0eeab08ea9b060389b1
> on the Beaglebone Black (ARM32).
> As far as I can say, looks good.
> 

Indeed, thanks for testing!

Jan

> with
> $ switchtest -s 200 -Q&
> $ while :; do dd if=/dev/zero of=/dev/null bs=32M; done&
> 
> root@beaglebone-xenomai:~# latency -t0 --silent -q -s -T 86400
> == Sampling period: 1000 us
> == Test mode: periodic user-mode task
> == All results in microseconds
> warming up...
> running quietly for 86400 seconds
> HSH|--param|--samples-|--average--|---stddev--
> HSS|    min|     86399|      8.528|      1.130
> HSS|    avg|  86399988|     17.416|      5.038
> HSS|    max|     86399|     38.505|      1.526
> ---|-----------|-----------|-----------|--------|------|-------------------------
> RTS|      6.206|     17.911|     51.523|       0|     0|    24:00:00/24:00:00
> 
> root@beaglebone-xenomai:~# latency -t2 --silent -q -s -T 86400
> == Sampling period: 1000 us
> == Test mode: in-kernel timer handler
> == All results in microseconds
> warming up...
> running quietly for 86400 seconds
> HSH|--param|--samples-|--average--|---stddev--
> HSS|    min|     86399|      0.002|      0.046
> HSS|    avg|  86399988|      4.624|      1.289
> HSS|    max|     86399|     12.269|      1.688
> ---|-----------|-----------|-----------|--------|------|-------------------------
> RTS|     -1.049|      5.109|     21.314|       0|     0|    24:00:00/24:00:00
> 
> freestanding xeno-test:
> root@beaglebone-xenomai:~# xeno-test -- --silent -q -s
> Started child 16390: /bin/sh /usr/bin/xeno-test-run-wrapper /usr/bin/xeno-test -- --silent -q -s
> ++ echo 0
> ++ testdir=/usr/bin
> ++ /usr/bin/smokey --run
> arith OK
> bufp OK
> cpu_affinity OK
> iddp OK
> leaks OK
> net_packet_dgram skipped (no kernel support)
> net_packet_raw skipped (no kernel support)
> net_udp skipped (no kernel support)
> posix_clock OK
> posix_cond OK
> posix_fork OK
> mutex_trylock not supported
> posix_mutex OK
> posix_select OK
> rtdm OK
> sched_quota OK
> sched_tp OK
> setsched OK
> sigdebug OK
> timerfd OK
> tsc OK
> vdso_access OK
> xddp OK
> ++ /usr/bin/clocktest -D -T 30 -C CLOCK_HOST_REALTIME
> hostrt data area is live
> sequence counter : 575854
> wall_time_sec    : 1545676197
> wall_time_nsec   : 268000965
> wall_to_monotonic_sec    : -1545674157
> wall_to_monotonic_nsec   : 106265047
> cycle_last       : 48969069692
> mask             : 0xffffffffffffffff
> mult             : 699050667
> shift            : 24
> 
> == Testing built-in CLOCK_HOST_REALTIME (32)
> CPU      ToD offset [us] ToD drift [us/s]      warps max delta [us]
> --- -------------------- ---------------- ---------- --------------
>    0                  0.9           -0.016          0            0.0
> ++ /usr/bin/switchtest -T 30
> == Testing FPU check routines...
> d0: 1 != 2
> d1: 1 != 2
> d2: 1 != 2
> d3: 1 != 2
> d4: 1 != 2
> d5: 1 != 2
> d6: 1 != 2
> d7: 1 != 2
> d8: 1 != 2
> d9: 1 != 2
> d10: 1 != 2
> d11: 1 != 2
> d12: 1 != 2
> d13: 1 != 2
> d14: 1 != 2
> d15: 1 != 2
> == FPU check routines: OK.
> == Threads: sleeper_ufps0-0 rtk0-1 rtk0-2 rtk_fp0-3 rtk_fp0-4 rtk_fp_ufpp0-5 rtk_fp_ufpp0-6 rtup0-7 rtup0-8 rtup_ufpp0-9 rtup_ufpp0-10 rtus0-11 rtus0-12 rtus_ufps0-13 rtus_ufps0-14 rtuo0-15 rtuo0-16 rtuo_ufpp0-
> 17 rtuo_ufpp0-18 rtuo_ufps0-19 rtuo_ufps0-20 rtuo_ufpp_ufps0-21 rtuo_ufpp_ufps0-22
> RTT|  00:00:01
> RTH|---------cpu|ctx switches|-------total
> RTD|           0|       16215|       16215
> RTD|           0|       16213|       32428
> RTD|           0|       16215|       48643
> RTD|           0|       16215|       64858
> RTD|           0|       16150|       81008
> RTD|           0|       16215|       97223
> RTD|           0|       16211|      113434
> RTD|           0|       16215|      129649
> RTD|           0|       16215|      145864
> RTD|           0|       16215|      162079
> RTD|           0|       16150|      178229
> RTD|           0|       16215|      194444
> RTD|           0|       16213|      210657
> RTD|           0|       16215|      226872
> RTD|           0|       16215|      243087
> RTD|           0|       16213|      259300
> RTD|           0|       16215|      275515
> RTD|           0|       16215|      291730
> RTD|           0|       16215|      307945
> RTD|           0|       16215|      324160
> RTD|           0|       16215|      340375
> RTT|  00:00:22
> RTH|---------cpu|ctx switches|-------total
> RTD|           0|       16215|      356590
> RTD|           0|       16148|      372738
> RTD|           0|       16215|      388953
> RTD|           0|       16213|      405166
> RTD|           0|       16215|      421381
> RTD|           0|       16150|      437531
> RTD|           0|       16213|      453744
> RTD|           0|       16215|      469959
> RTD|           0|       14695|      484654
> ++ start_load
> ++ echo start_load
> ++ false
> ++ check_alive /usr/bin/latency --silent -q -s
> ++ echo check_alive /usr/bin/latency --silent -q -s
> ++ wait_load
> ++ read rc
> Started child 16488: dohell 900
> Started child 16489: /usr/bin/latency --silent -q -s
>     0"000.084| WARNING: [main] -q requires -T, ignoring -q
> == Sampling period: 1000 us
> == Test mode: periodic user-mode task
> == All results in microseconds
> warming up...
> RTT|  00:00:01  (periodic user-mode task, 1000 us period, priority 99)
> RTH|----lat min|----lat avg|----lat max|-overrun|---msw|---lat best|--lat worst
> RTD|     18.375|     29.664|     61.792|       0|     0|     18.375|     61.792
> RTD|     17.708|     29.617|     65.166|       0|     0|     17.708|     65.166
> RTD|     18.291|     29.437|     61.125|       0|     0|     17.708|     65.166
> RTD|     18.374|     29.746|     62.166|       0|     0|     17.708|     65.166
> RTD|     18.291|     29.719|     60.957|       0|     0|     17.708|     65.166
> RTD|     18.374|     29.531|     59.915|       0|     0|     17.708|     65.166
> RTD|     18.207|     29.779|     62.873|       0|     0|     17.708|     65.166
> RTD|     18.415|     29.955|     61.040|       0|     0|     17.708|     65.166
> RTD|     18.373|     29.883|     60.623|       0|     0|     17.708|     65.166
> RTD|     18.331|     29.979|     61.248|       0|     0|     17.708|     65.166
> RTD|     18.248|     29.787|     60.623|       0|     0|     17.708|     65.166
> RTD|     18.206|     29.922|     62.372|       0|     0|     17.708|     65.166
> RTD|     18.330|     30.008|     60.706|       0|     0|     17.708|     65.166
> RTD|     17.413|     29.708|     62.830|       0|     0|     17.413|     65.166
> RTD|     17.913|     29.761|     61.455|       0|     0|     17.413|     65.166
> RTD|     18.330|     29.934|     61.371|       0|     0|     17.413|     65.166
> RTD|     18.288|     29.835|     62.163|       0|     0|     17.413|     65.166
> RTD|     18.038|     29.941|     60.704|       0|     0|     17.413|     65.166
> RTD|     18.329|     29.956|     60.704|       0|     0|     17.413|     65.166
> RTD|     18.412|     29.961|     61.287|       0|     0|     17.413|     65.166
> RTD|     18.287|     30.048|     62.495|       0|     0|     17.413|     65.166
> 
> <snip/>
> 
> RTT|  00:14:43  (periodic user-mode task, 1000 us period, priority 99)
> RTH|----lat min|----lat avg|----lat max|-overrun|---msw|---lat best|--lat worst
> RTD|     18.331|     29.864|     65.665|       0|     0|     14.891|     69.746
> RTD|     17.998|     30.018|     64.248|       0|     0|     14.891|     69.746
> RTD|     17.831|     29.978|     63.706|       0|     0|     14.891|     69.746
> RTD|     17.747|     29.968|     63.997|       0|     0|     14.891|     69.746
> RTD|     18.289|     30.028|     62.205|       0|     0|     14.891|     69.746
> RTD|     17.497|     30.095|     64.163|       0|     0|     14.891|     69.746
> RTD|     18.288|     29.920|     62.997|       0|     0|     14.891|     69.746
> RTD|     18.121|     29.991|     63.830|       0|     0|     14.891|     69.746
> RTD|     18.121|     30.016|     62.579|       0|     0|     14.891|     69.746
> RTD|     17.996|     30.116|     63.329|       0|     0|     14.891|     69.746
> RTD|     18.371|     30.254|     62.579|       0|     0|     14.891|     69.746
> RTD|     18.287|     30.049|     64.954|       0|     0|     14.891|     69.746
> RTD|     18.120|     30.025|     64.953|       0|     0|     14.891|     69.746
> RTD|     17.828|     30.203|     65.703|       0|     0|     14.891|     69.746
> RTD|     18.161|     30.021|     61.370|       0|     0|     14.891|     69.746
> RTD|     18.203|     29.875|     62.661|       0|     0|     14.891|     69.746
> RTD|     18.077|     30.133|     62.911|       0|     0|     14.891|     69.746
> /usr/bin/dohell: line 94: 16490 Terminated              while :; do
>      cat /proc/interrupts;
> done > /dev/null 2>&1
> /usr/bin/dohell: line 94: 16491 Terminated              while :; do
>      ps w;
> done > /dev/null 2>&1
> /usr/bin/dohell: line 94: 16492 Terminated              dd if=/dev/zero of=/dev/null
> /usr/bin/dohell: line 94: 16493 Terminated              while :; do
>      ls -lR / > /dev/null 2>&1;
> done
> RTD|     18.411|     28.188|     59.244|       0|     0|     14.891|     69.746
> RTD|     18.577|     26.534|     49.077|       0|     0|     14.891|     69.746
> RTD|     18.702|     26.087|     51.410|       0|     0|     14.891|     69.746
> RTD|     19.118|     25.591|     54.368|       0|     0|     14.891|     69.746
> RTT|  00:15:04  (periodic user-mode task, 1000 us period, priority 99)
> RTH|----lat min|----lat avg|----lat max|-overrun|---msw|---lat best|--lat worst
> RTD|     19.118|     25.416|     54.201|       0|     0|     14.891|     69.746
> Load script terminated, terminating checked scripts
> HSH|--param|--samples-|--average--|---stddev--
> HSS|    min|       904|     17.673|      0.525
> HSS|    avg|    904530|     29.311|     11.179
> HSS|    max|       904|     61.969|      1.674
> ---|-----------|-----------|-----------|--------|------|-------------------------
> RTS|     14.891|     29.808|     69.746|       0|     0|    00:15:05/00:15:05
> pipe_in: /tmp/xeno-test-in-16390
> 
> Greetz,
> Sepp
> 


-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

