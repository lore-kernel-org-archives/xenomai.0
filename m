MIME-Version: 1.0
Date: Tue, 22 Apr 2014 18:02:35 +0200
Message-ID: <CAPRPZsBD_5ufxFAhPCFqRf9YZSm1FhqfcmL+MTbhJ=1Sb7ED_g@mail.gmail.com>
From: Jeroen Van den Keybus <jeroen.vandenkeybus@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Xenomai] Reading /proc/xenomai/stat causes high latencies
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Using a 3.10.18 kernel with Xenomai 2.6.3, reading the stat entry of
/proc/xenomai causes high latencies in RT tasks. I've found a report
on a similar issue in
https://sites.google.com/site/manisbutareed/linuxcnc-2-5/xenomai-user-threads.
We also had this occurring on a 3.8.13 kernel.

A typical latency test run looks like:

RTT|  00:00:01  (periodic user-mode task, 100 us period, priority 99)
RTH|----lat min|----lat avg|----lat max|-overrun|---msw|---lat best|--lat worst
RTD|     -2.382|     -2.357|     -1.945|       0|     0|     -2.382|     -1.945
RTD|     -2.577|     -2.360|     -1.749|       0|     0|     -2.577|     -1.749
RTD|     -2.380|     -2.360|     -1.865|       0|     0|     -2.577|     -1.749
RTD|     -2.568|     -2.361|     -1.530|       0|     0|     -2.577|     -1.530
RTD|     -2.379|     -2.359|     -1.732|       0|     0|     -2.577|     -1.530
RTD|     -2.381|     -2.361|     -2.008|       0|     0|     -2.577|     -1.530
RTD|     -2.381|     -2.360|     -2.085|       0|     0|     -2.577|     -1.530
RTD|     -2.699|     -2.359|      2.566|       0|     0|     -2.699|      2.566
RTD|     -2.380|     -2.320|     -1.876|       0|     0|     -2.699|      2.566
RTD|     -2.381|     -2.359|      2.528|       0|     0|     -2.699|      2.566
RTD|     -2.380|     -2.360|     -1.805|       0|     0|     -2.699|      2.566
RTD|     -2.579|     -2.311|     -0.045|       0|     0|     -2.699|      2.566
RTD|     -2.380|     -2.359|     -2.072|       0|     0|     -2.699|      2.566
RTD|     -2.575|     -2.360|      2.065|       0|     0|     -2.699|      2.566
RTD|     -2.381|     19.028|   3043.067|      31|     0|     -2.699|   3043.067
RTD|     -2.566|     26.488|    105.823|      32|     0|     -2.699|   3043.067
RTD|     -2.443|     -2.276|      0.597|      32|     0|     -2.699|   3043.067
RTD|     -2.584|     -2.306|      2.032|      32|     0|     -2.699|   3043.067
RTD|     -2.377|     -2.242|      4.106|      32|     0|     -2.699|   3043.067
RTD|     -2.537|     -2.291|      4.394|      32|     0|     -2.699|   3043.067

It is obvious where I issued the 'cat /proc/xenomai/stat' command.

I will try to create an I-trace now. (config is same as under my
previous post 'Slow execution of RT task' - I'm still looking into
that issue as well).


Jeroen.

