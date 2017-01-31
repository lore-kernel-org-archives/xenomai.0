Message-ID: <1485850637.4051.13.camel@smigroup.net>
From: Mauro Salvini <mauro.salvini@smigroup.net>
Date: Tue, 31 Jan 2017 09:17:17 +0100
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] ARM L2C-310 cahce controller enabling
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi,
I'm working on a iMX6SX custom platform and I'm trying to use Xenomai on
top of it.
In the past, I tried Xenomai on a iMX6SX SabreSD demoboard using kernel
branch 4.1.15 from Freescale patched with Xenomai 3.0.1 (some little
rejections corrected by hand), and I was able to get a maximum latency
around 25us.
Now, using kernel 4.1.36 from Freescale Community (that integrates the
Freescale kernel branch) patched with Xenomai 3.0.3 I get maximum
latencies around 45us.

Trying to figure out what is the source(s) of increased latencies, I
found these two kernel logs:

[    0.000000] L2C: I-pipe: revision >= L310-r3p2 detected, forcing WA.
[    0.000000] L2C: I-pipe: write-allocate enabled, induces high
latencies.

I wonder why L2C-310 cache controllers that are greater or equal to r3p2
revision must be forced enabled.

In past I read (and asked) in this mailing list that L2 cache should be
disabled to avoid higher latencies (as kernel log says).

Thanks in advance, best regards

Mauro


