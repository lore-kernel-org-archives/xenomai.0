From: Julian Viereck <jviereck@tuebingen.mpg.de>
Message-ID: <9dee4e70-9bce-2fac-2aba-f27e65a9c1ba@tuebingen.mpg.de>
Date: Mon, 26 Feb 2018 16:34:04 -0500
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Subject: [Xenomai] Low latency under stress, otherwise high latency
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi folks,

after installing Xenomai 3.0.5/kernel 4.9.38 following [1] on our Dell 
Precision 5820 machine (Intel Xeon W-2145), there are high latencies 
when the system is at rest. When starting a stress test via `stress -v 
-c 8 -i 10 -d 8`, the latency goes down (see terminal output below).

Usually I would assume the latency increases with higher load and not go 
down. Does someone has an idea where to start in debugging / fixing the 
high latencies? Note that the cores are in C0 state 100% of the time 
(with and without the load on the machine).

Thanks,
Julian

[1]: http://rtt-lwr.readthedocs.io/en/latest/rtpc/xenomai3.html


```bash
root@broadway:~# /usr/xenomai/bin/xeno latency
== Sampling period: 100 us
== Test mode: periodic user-mode task
== All results in microseconds
warming up...
RTT|  00:00:01  (periodic user-mode task, 100 us period, priority 99)
RTH|----lat min|----lat avg|----lat max|-overrun|---msw|---lat 
best|--lat worst
RTD|      0.415|      3.945|    133.817|       1|     0| 0.415|    133.817
RTD|      1.049|      3.941|    147.671|       2|     0| 0.415|    147.671
RTD|      0.145|      3.971|     63.298|       2|     0| 0.145|    147.671
RTD|      0.226|      4.145|     81.019|       2|     0| 0.145|    147.671
RTD|      0.431|      3.938|     96.371|       2|     0| 0.145|    147.671
RTD|      0.646|      4.030|    112.014|       3|     0| 0.145|    147.671
RTD|      0.203|      3.929|    126.839|       4|     0| 0.145|    147.671
RTD|      0.471|      3.957|    146.049|       5|     0| 0.145|    147.671
RTD|      0.285|      3.940|     58.224|       5|     0| 0.145|    147.671
RTD|      0.466|      3.957|     72.123|       5|     0| 0.145|    147.671
RTD|      0.039|      3.913|     90.435|       5|     0| 0.039|    147.671
RTD|      0.246|      3.942|    107.835|       6|     0| 0.039|    147.671
^NRTD|      0.518|      3.946|    123.637|       7|     0| 0.039|    
147.671
RTD|      1.161|      3.953|    137.671|       8|     0| 0.039|    147.671
RTD|      0.407|      3.933|     53.388|       8|     0| 0.039|    147.671
RTD|      0.461|      3.963|     67.896|       8|     0| 0.039|    147.671
RTD|      0.237|      3.953|     85.147|       8|     0| 0.039|    147.671
RTD|      0.162|      4.022|     26.846|       8|     0| 0.039|    147.671
RTD|      0.054|      4.191|    100.386|       8|     0| 0.039|    147.671
RTD|      0.130|      3.936|    114.158|       9|     0| 0.039|    147.671
RTD|      0.587|      3.949|    133.358|      10|     0| 0.039|    147.671
RTT|  00:00:22  (periodic user-mode task, 100 us period, priority 99)
RTH|----lat min|----lat avg|----lat max|-overrun|---msw|---lat 
best|--lat worst
RTD|      0.285|      4.161|     49.695|      10|     0| 0.039|    147.671
RTD|      0.119|      4.018|      9.336|      10|     0| 0.039|    
147.671  <<<< Started command `stress -v -c 8 -i 10 -d 8`
RTD|      0.159|      3.992|     12.851|      10|     0| 0.039|    147.671
RTD|      0.130|      4.159|     12.748|      10|     0| 0.039|    147.671
RTD|      0.159|      4.107|     12.417|      10|     0| 0.039|    147.671
RTD|      0.024|      4.037|     12.519|      10|     0| 0.024|    147.671
RTD|      0.195|      4.042|      7.506|      10|     0| 0.024|    147.671
RTD|      0.157|      4.069|     11.314|      10|     0| 0.024|    147.671
RTD|      0.205|      4.309|     10.719|      10|     0| 0.024|    147.671
RTD|      0.259|      4.142|     13.414|      10|     0| 0.024|    147.671
RTD|      0.306|      4.216|     10.378|      10|     0| 0.024|    147.671
RTD|      0.143|      4.287|     13.803|      10|     0| 0.024|    147.671
RTD|      0.241|      4.110|     11.305|      10|     0| 0.024|    147.671
RTD|      0.219|      4.228|     12.024|      10|     0| 0.024|    
147.671  <<<< termianted `stress` command
RTD|      0.132|      4.013|     66.058|      10|     0| 0.024|    147.671
RTD|      0.448|      3.965|     83.214|      10|     0| 0.024|    147.671
RTD|      0.228|      3.933|     97.855|      10|     0| 0.024|    147.671
RTD|      1.771|      3.946|    112.659|      11|     0| 0.024|    147.671
RT671
RTD|      0.759|      3.964|    123.672|      15|     0| 0.024|    147.671
```

