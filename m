MIME-Version: 1.0
Sender: roland.pastorino@gmail.com
Date: Sun, 25 Jan 2015 12:15:39 +0100
Message-ID: <CABxGBLT7Y-xmzPYRjgq=XV6Gj0DmqWqOE9efgikWRVwqyT7cpQ@mail.gmail.com>
From: Roland Pastorino <roland@rolandpastorino.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Xenomai] ToD drift on i7-3740QM
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Good morning everyone,

I would like to know if some of you could give me a hint on how to
solve my ToD drift problem.
This question is similar to this one ->
http://comments.gmane.org/gmane.linux.real-time.xenomai.users/19719

Problem:
After installing Xenomai and after the first reboot, my ToD drift was
around 500000 us/s.
After the second reboot, my ToD drift is around 500 us/s which I
presume is still too high.
I checked the troubleshooting information on Xenomai website but it didn't help.

Machine and configuration:
- PC = Thinkpad w530
- cpu = i7-3740QM
- kernel configuration file is attached. I followed the Xenomai
website for the configuration.
- cobalt kernel of Xenomai 3
- Linux kernel 3.16
- ipipe-core-3.16-x86-1.patch
- Ubuntu 14.10

clocktest:

CPU      ToD offset [us] ToD drift [us/s]      warps max delta [us]
--- -------------------- ---------------- ---------- --------------
  0            -772589.4          499.629          0            0.0
  1            -772589.3          499.598          0            0.0
  2            -772590.0          499.579          0            0.0
  3            -772589.4          499.583          0            0.0

latency:

RTT|  00:00:01  (periodic user-mode task, 100 us period, priority 99)
RTH|----lat min|----lat avg|----lat max|-overrun|---msw|---lat best|--lat worst
RTD|     -2.256|     -1.682|      1.962|       0|     0|     -2.256|      1.962
RTD|     -2.264|     -1.685|      1.821|       0|     0|     -2.264|      1.962
RTD|     -2.256|     -1.670|      2.489|       0|     0|     -2.264|      2.489
RTD|     -2.250|     -1.654|      2.396|       0|     0|     -2.264|      2.489
RTD|     -2.254|     -1.506|      2.867|       0|     0|     -2.264|      2.867
RTD|     -2.258|     -1.647|      2.933|       0|     0|     -2.264|      2.933
RTD|     -2.252|     -1.696|      1.800|       0|     0|     -2.264|      2.933
RTD|     -2.265|     -1.733|      2.639|       0|     0|     -2.265|      2.933
RTD|     -2.260|     -1.684|      2.659|       0|     0|     -2.265|      2.933
RTD|     -2.261|     -1.737|      1.496|       0|     0|     -2.265|      2.933
RTD|     -2.262|     -1.709|      4.076|       0|     0|     -2.265|      4.076
RTD|     -2.259|     -1.691|      1.822|       0|     0|     -2.265|      4.076
RTD|     -2.258|     -1.658|      2.680|       0|     0|     -2.265|      4.076
RTD|     -2.259|     -1.724|      1.842|       0|     0|     -2.265|      4.076
RTD|     -2.254|     -1.552|      2.312|       0|     0|     -2.265|      4.076
^C---|-----------|-----------|-----------|--------|------|-------------------------
RTS|     -2.265|     -1.668|      4.076|       0|     0|    00:00:16/00:00:16

Thank you.
Best Regards

--
Roland Pastorino

