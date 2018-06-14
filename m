MIME-Version: 1.0
Sender: kiwamu@gmail.com
In-Reply-To: <99BAB48E90E86D42AD41F0BCE3225AEB019FC2A4FA@GRZSMS582.andritz.com>
References: <CAEvX6dnegM8CXwc7zGCsvyWNMziEcjdjB0fJRH_NMdTO2vdWgA@mail.gmail.com>
 <99BAB48E90E86D42AD41F0BCE3225AEB019FC2A4FA@GRZSMS582.andritz.com>
From: Kiwamu Okabe <kiwamu@debian.or.jp>
Date: Thu, 14 Jun 2018 14:42:05 +0900
Message-ID: <CAEvX6dkxs+pdZTJaeATtviKzV+LvQPY-d_wg2TfEjk=xXPCRfQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Xenomai] Why get low latency while running stress command?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Dear Lange,

On Wed, Jun 13, 2018 at 7:47 PM, Lange Norbert
<norbert.lange@andritz.com> wrote:
> I guess what happens is, that the CPU will be put to sleep and/or lower frequency and voltage between calls,
> These transitions are rather slow and will then have to happen on wake-up
> Disable any kind of powersaving features in Linux and possibly BIOS (C-States).

Thanks for your reply.

After read following:

* https://www.thomas-krenn.com/en/wiki/Processor_P-states_and_C-states
* https://gist.github.com/wmealing/2dd2b543c4d3cff6cab7
* https://wiki.archlinux.org/index.php/CPU_frequency_scaling#Scaling_governors
* https://wiki.debian.org/HowTo/CpuFrequencyScaling

I set up some parameters:

```
$ sudo vi /etc/default/grub
--snip--
GRUB_CMDLINE_LINUX_DEFAULT="quiet processor.max_cstate=1
intel_idle.max_cstate=0"
--snip--
$ sudo update-grub
$ sudo apt install cpufrequtils
$ sudo vi /etc/default/cpufrequtils
GOVERNOR="performance"
$ sudo reboot
```

Then I have better latency:

```
$ sudo /usr/lib/xenomai/testsuite/latency
== Sampling period: 100 us
== Test mode: periodic user-mode task
== All results in microseconds
warming up...
RTT|  00:00:01  (periodic user-mode task, 100 us period, priority 99)
RTH|----lat min|----lat avg|----lat max|-overrun|---msw|---lat best|--lat worst
RTD|      0.417|      2.658|      4.211|       0|     0|      0.417|      4.211
RTD|      0.843|      2.718|      4.780|       0|     0|      0.417|      4.780
RTD|      0.726|      2.689|      4.456|       0|     0|      0.417|      4.780
RTD|      0.923|      2.731|      5.068|       0|     0|      0.417|      5.068
RTD|      0.908|      2.676|      4.906|       0|     0|      0.417|      5.068
RTD|      0.402|      2.686|      4.784|       0|     0|      0.402|      5.068
RTD|      0.907|      2.617|      4.501|       0|     0|      0.402|      5.068
RTD|      0.928|      2.615|      5.730|       0|     0|      0.402|      5.730
RTD|      0.538|      2.630|      4.245|       0|     0|      0.402|      5.730
RTD|      0.399|      2.638|      4.607|       0|     0|      0.399|      5.730
RTD|      0.414|      2.613|      4.114|       0|     0|      0.399|      5.730
RTD|      0.502|      2.620|      4.486|       0|     0|      0.399|      5.730
RTD|      0.694|      2.625|      4.292|       0|     0|      0.399|      5.730
RTD|      0.618|      2.641|      4.847|       0|     0|      0.399|      5.730
```

Thanks a lot!
-- 
Kiwamu Okabe at METASEPI DESIGN

