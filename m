From: "Schrenkhammer, Martin" <MSchrenkhammer@data-modul.com>
Date: Tue, 13 Mar 2018 11:33:53 +0000
Message-ID: <0B8B4C90A6FEA34E9EA10570C016C358BB7C0839@DEMUC-SMX001.data-modul.local>
Content-Language: de-DE
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] Latency Peaks with Skylake vs. Haswell
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

I am currently porting a project from Haswell to Skylake (i5-6440EQ). When in desktop, I observe latency peaks when windows are moved around or zoomed. With Haswell CPUs, there is not impact of graphic workload. Unfortunately everything above 10us  is an issue in our real time system application.
Currently I am using Xubuntu 16.04 + Kernel 4.9.51 + Xenomai 3.0.6
I already disabled all power- and performance features like Hyper-Threading, SpeedStep, Turbo Mode, C-States in BIOS and also by kernel parameters. Also disabled i915 power savings like i915.enable_dc=0,  i915.enable_rc6=0, i915.enable_execlists=0... and disabled grafik turbo gt_max_freq_mhz = 350  gt_boost_freq_mhz = 350

One difference we see between Haswell and Skylake: i915 raises a lot of MSI when moving windows around where there are almost zero at Haswell.

Any ideas for bringing the peaks down?

== Sampling period: 100 us
== Test mode: periodic user-mode task
== All results in microseconds
warming up...
RTT|  00:00:01  (periodic user-mode task, 100 us period, priority 99)
RTH|----lat min|----lat avg|----lat max|-overrun|---msw|---lat best|--lat worst
RTD|     -0.368|     -0.210|      0.259|       0|     0|     -0.368|      0.259
RTD|     -0.259|     -0.161|      1.601|       0|     0|     -0.368|      1.601
RTD|     -0.290|     -0.174|      1.367|       0|     0|     -0.368|      1.601
RTD|     -0.269|     -0.190|      1.004|       0|     0|     -0.368|      1.601
RTD|     -0.256|     -0.185|      1.000|       0|     0|     -0.368|      1.601
RTD|     -0.267|     -0.148|      1.370|       0|     0|     -0.368|      1.601
RTD|     -0.262|     -0.052|      9.010|       0|     0|     -0.368|      9.010
RTD|     -0.256|     -0.027|     12.111|       0|     0|     -0.368|     12.111   <<-- moved terminal window around
RTD|     -0.266|     -0.146|     13.730|       0|     0|     -0.368|     13.730
RTD|     -0.276|     -0.175|      5.509|       0|     0|     -0.368|     13.730
RTD|     -0.314|     -0.159|      6.377|       0|     0|     -0.368|     13.730
RTD|     -0.269|     -0.144|      4.462|       0|     0|     -0.368|     13.730
RTD|     -0.274|     -0.178|      1.749|       0|     0|     -0.368|     13.730
RTD|     -0.267|     -0.123|      2.436|       0|     0|     -0.368|     13.730
RTD|     -0.285|     -0.153|      1.387|       0|     0|     -0.368|     13.730
RTD|     -0.285|     -0.141|      3.113|       0|     0|     -0.368|     13.730
RTD|     -0.313|     -0.160|      1.021|       0|     0|     -0.368|     13.730
RTD|     -0.274|     -0.107|     20.256|       0|     0|     -0.368|     20.256  <<-- opened File Manager
RTD|     -0.273|     -0.165|      1.797|       0|     0|     -0.368|     20.256
RTD|     -0.270|     -0.152|      5.486|       0|     0|     -0.368|     20.256
RTD|     -0.328|     -0.189|      1.070|       0|     0|     -0.368|     20.256
RTT|  00:00:22  (periodic user-mode task, 100 us period, priority 99)
RTH|----lat min|----lat avg|----lat max|-overrun|---msw|---lat best|--lat worst
RTD|     -0.275|     -0.201|      2.641|       0|     0|     -0.368|     20.256
RTD|     -0.275|     -0.142|      3.372|       0|     0|     -0.368|     20.256
RTD|     -0.275|     -0.191|      1.020|       0|     0|     -0.368|     20.256
---|-----------|-----------|-----------|--------|------|-------------------------
RTS|     -0.368|     -0.153|     20.256|       0|     0|    00:00:24/00:00:24


Here's what we get with Haswell:
== Sampling period: 100 us
== Test mode: periodic user-mode task
== All results in microseconds
warming up...
RTT|  00:00:01  (periodic user-mode task, 100 us period, priority 99)
RTH|----lat min|----lat avg|----lat max|-overrun|---msw|---lat best|--lat worst
RTD|     -0.399|     -0.341|      1.515|       0|     0|     -0.399|      1.515
RTD|     -0.392|     -0.310|      0.835|       0|     0|     -0.399|      1.515
RTD|     -0.500|     -0.335|      0.634|       0|     0|     -0.500|      1.515
RTD|     -0.529|     -0.333|      0.223|       0|     0|     -0.529|      1.515
RTD|     -0.584|     -0.335|      1.217|       0|     0|     -0.584|      1.515
RTD|     -0.399|     -0.335|      0.566|       0|     0|     -0.584|      1.515
RTD|     -0.502|     -0.336|      0.328|       0|     0|     -0.584|      1.515
RTD|     -0.399|     -0.340|      0.523|       0|     0|     -0.584|      1.515
RTD|     -0.530|     -0.237|      1.819|       0|     0|     -0.584|      1.819
RTD|     -0.212|     -0.159|      2.192|       0|     0|     -0.584|      2.192
RTD|     -0.218|     -0.170|      2.125|       0|     0|     -0.584|      2.192
---|-----------|-----------|-----------|--------|------|-------------------------
RTS|     -0.584|     -0.293|      2.192|       0|     0|    00:00:12/00:00:12


Thanks a lot,
Martin


________________________________
Vertrauliche E-Mail von / Confidential e-mail from Data Modul AG
Vorstand / CEO: Dr. Florian Pesahl
Vorsitzende des Aufsichtsrates / Chairwoman of the Supervisory Board: Kristin D. Russell
Sitz der Gesellschaft / Registered Office: M?nchen
Registergericht / Registration Court: M?nchen - Handelsregister B 85 591

Datamodul
[cid:007f-0001@01d3babf.2b093302]
-------------- next part --------------
A non-text attachment was scrubbed...
Name: EW-SEE_2018_d.gif
Type: image/gif
Size: 10542 bytes
Desc: EW-SEE_2018_d.gif
URL: <http://xenomai.org/pipermail/xenomai/attachments/20180313/5dc32f75/attachment.gif>
