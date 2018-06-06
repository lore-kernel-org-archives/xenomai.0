MIME-Version: 1.0
From: Pintu Kumar <pintu.ping@gmail.com>
Date: Wed, 6 Jun 2018 11:11:33 +0530
Message-ID: <CAOuPNLjnhO+vFwdQkM513kZrcxTq95ivHFWVf+boGdke42R4hQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Xenomai] rpi3 - very high negative latency for simple xeno task
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Xenomai@xenomai.org" <xenomai@xenomai.org>

Hi,

I have a simple demo program, which just create one rt_task (using
native API) and inside the task, I just rt_printf "some logs" for 10
times, with 100us interval.

Today I checked this program first time on Raspberry Pi 3, Model B.
Xenomai: 3.0.6
ARCH = arm32
Kernel: 4.9.80 for rpi3

Here is the output:
-------------------------
native $ sudo ./simple_xeno_task 10
main: creating task name: task0, priority: 99
Task: 0, Iteration: 10, Sleep duration: 100 us

Task[0] - Avg Latency: -9.630 us
Task[0] - Max Latency: 0.052 us
Task[0] - Min Latency: -67.448 us
1 32.552 -67.448
2 75.261 -24.739
3 97.657 -2.343
4 99.479 -0.521
5 99.791 -0.209
6 99.740 -0.260
7 100.052 0.052
8 99.635 -0.365
9 99.740 -0.260
10 99.792 -0.208
ALL FINISHED.......!!!
-------------------------------

If you see, the first 2 iterations have very large negative values.
What could be the cause of this?
As per RTOS, I expect the output to be close to 100us always.


When I run the same program on x86_64 machine I get the below output:
--------------------------------
./simple_xeno_task 10
main: creating task name: task0, priority: 99
Task: 0, Iteration: 10, Sleep duration: 100 us

Task[0] - Avg Latency: -0.680 us
Task[0] - Max Latency: 0.043 us
Task[0] - Min Latency: -5.868 us
1 94.132 -5.868
2 99.127 -0.873
3 99.955 -0.045
4 100.043 0.043
5 99.990 -0.010
6 99.959 -0.041
7 100.017 0.017
8 99.977 -0.023
9 99.965 -0.035
10 100.039 0.039
ALL FINISHED.......!!!
--------------------------------

So, I wonder what could be the cause of negative latency on Rpi3 with Xenomai.


This is the latency output on Rpi3:
----------------------------------------------
sudo /usr/xenomai/bin/latency
== Sampling period: 1000 us
== Test mode: periodic user-mode task
== All results in microseconds
warming up...
RTT|  00:00:01  (periodic user-mode task, 1000 us period, priority 99)
RTH|----lat min|----lat avg|----lat max|-overrun|---msw|---lat best|--lat worst
RTD|      0.625|      1.374|      5.312|       0|     0|      0.625|      5.312
RTD|      0.624|      1.376|      5.468|       0|     0|      0.624|      5.468
RTD|      0.624|      1.373|      5.676|       0|     0|      0.624|      5.676
RTD|      0.623|      1.372|      9.426|       0|     0|      0.623|      9.426
RTD|      0.467|      1.355|      4.582|       0|     0|      0.467|      9.426
RTD|      0.623|      1.384|      9.113|       0|     0|      0.467|      9.426
RTD|      0.622|      1.379|      5.935|       0|     0|      0.467|      9.426
RTD|      0.622|      1.359|      4.581|       0|     0|      0.467|      9.426
RTD|      0.622|      1.372|      7.028|       0|     0|      0.467|      9.426
RTD|      0.621|      1.361|      6.038|       0|     0|      0.467|      9.426
RTD|      0.621|      1.360|      4.267|       0|     0|      0.467|      9.426
RTD|      0.673|      1.364|     10.256|       0|     0|      0.467|     10.256
RTD|      0.672|      1.363|      6.453|       0|     0|      0.467|     10.256
RTD|      0.620|      1.352|      4.161|       0|     0|      0.467|     10.256
RTD|      0.619|      1.373|      7.234|       0|     0|      0.467|     10.256
RTD|      0.619|      1.352|      6.140|       0|     0|      0.467|     10.256
RTD|      0.671|      1.352|      4.733|       0|     0|      0.467|     10.256
RTD|      0.566|      1.363|      5.514|       0|     0|      0.467|     10.256
RTD|      0.618|      1.368|      6.712|       0|     0|      0.467|     10.256
RTD|      0.618|      1.353|      4.420|       0|     0|      0.467|     10.256
RTD|      0.617|      1.368|      6.815|       0|     0|      0.467|     10.256
^C---|-----------|-----------|-----------|--------|------|-------------------------

----------------------------------------------


Thanks,
Pintu

