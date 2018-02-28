References: <9dee4e70-9bce-2fac-2aba-f27e65a9c1ba@tuebingen.mpg.de>
 <50805f15-f8c3-a47d-0b05-7b722d44a73e@xenomai.org>
From: Julian Viereck <jviereck@tuebingen.mpg.de>
Message-ID: <9607c407-8524-0006-910d-941a07d1f9d8@tuebingen.mpg.de>
Date: Wed, 28 Feb 2018 16:40:22 -0500
MIME-Version: 1.0
In-Reply-To: <50805f15-f8c3-a47d-0b05-7b722d44a73e@xenomai.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Subject: Re: [Xenomai] Low latency under stress, otherwise high latency
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, xenomai@xenomai.org

Thanks for your pointer to hwlatdetect and possible SMI issues.

It looks like the hwlatdetect script is not working with the latest 
kernel anymore. However, it appears the hwlat is now part of the 
kernel's ftrace [1]. Here is the kernel documentation about how to use 
and understand the trace loge file [2].

Using a trace window of 1sec, trace width of 0.5 sec and tracing_thresh 
of 20 microseconds, there are no unexpected latencies detected by the 
hwlat tool. Therefore, I doubt the issue is due to SMI interrupts.

In the meantime, I've also tested:

1) disable hyperthreading and running a single core
2) run the xenomai latency test from the console before booting the x11 
desktop (to rule out any graphics issues)

In both cases, the high latencies under no-workload remains.

Any other ideas what to look into / debug / run traces on?

Best,
Julian


PS: Here are more details on my analysis.


Using only a single core without hyperthreading, the recorded trace 
looks like in [3]. The recording was done using the default setting (1 
sec window, 0.5 sec width, threshold 10 microseconds).

While the recording shows events of exceeding the threshold (there are 
entries in the file), note that the timing is equally spaced. Another 
experiment showed that the spacing between recorded events is correlated 
with the `hwlat_detector/window` option. Therefore, I hypothesize the 
recorded events are artificual

[1]: 
https://github.com/torvalds/linux/blob/master/Documentation/trace/hwlat_detector.txt#L34
[2]: 
https://github.com/torvalds/linux/blob/master/Documentation/trace/ftrace.txt#L1914
[3]:

```
  tracer: hwlat
#
# entries-in-buffer/entries-written: 33/33   #P:1
#
#                              _-----=> irqs-off
#                             / _----=> need-resched
#                            | / _---=> hardirq/softirq
#                            || / _--=> preempt-depth
#                            ||| /     delay
#           TASK-PID   CPU#  ||||    TIMESTAMP  FUNCTION
#              | |       |   ||||       |         |
            <...>-2906  [000] d...   356.575455: #34 inner/outer(us):   
15/14    ts:1519851039.304934827
            <...>-2906  [000] d...   357.599441: #35 inner/outer(us):   
13/15    ts:1519851040.328934857
            <...>-2906  [000] d...   358.623458: #36 inner/outer(us):   
13/15    ts:1519851041.352934886
            <...>-2906  [000] d...   359.647456: #37 inner/outer(us):   
14/15    ts:1519851042.376934915
            <...>-2906  [000] d...   360.671457: #38 inner/outer(us):   
13/15    ts:1519851043.400934944 nmi-total:10 nmi-count:1
            <...>-2906  [000] d...   361.695449: #39 inner/outer(us):   
15/16    ts:1519851044.424934974
            <...>-2906  [000] d...   362.719456: #40 inner/outer(us):   
15/15    ts:1519851045.448935003
            <...>-2906  [000] d...   363.743464: #41 inner/outer(us):   
15/15    ts:1519851046.472935032
            <...>-2906  [000] d...   364.767453: #42 inner/outer(us):   
13/15    ts:1519851047.496935061
            <...>-2906  [000] d...   365.791453: #43 inner/outer(us):   
15/14    ts:1519851048.520935090
            <...>-2906  [000] d...   366.815470: #44 inner/outer(us):   
14/17    ts:1519851049.544935120
            <...>-2906  [000] d...   367.839453: #45 inner/outer(us):   
14/15    ts:1519851050.568935149
            <...>-2906  [000] d...   368.863102: #46 inner/outer(us):   
15/15    ts:1519851051.592935178
            <...>-2906  [000] d...   369.887465: #47 inner/outer(us):   
15/16    ts:1519851052.616935207
            <...>-2906  [000] d...   370.911458: #48 inner/outer(us):   
14/15    ts:1519851053.640935237
            <...>-2906  [000] d...   371.935486: #49 inner/outer(us):   
15/15    ts:1519851054.664935266
            <...>-2906  [000] d...   372.959466: #50 inner/outer(us):   
15/16    ts:1519851055.688935295
            <...>-2906  [000] d...   373.983465: #51 inner/outer(us):   
16/15    ts:1519851056.712935324
            <...>-2906  [000] d...   375.007104: #52 inner/outer(us):   
13/13    ts:1519851057.736935353
            <...>-2906  [000] d...   376.031460: #53 inner/outer(us):   
14/14    ts:1519851058.760935383 nmi-total:8 nmi-count:1
```




On 02/28/2018 01:06 PM, Philippe Gerum wrote:
> On 02/26/2018 10:34 PM, Julian Viereck wrote:
>> Hi folks,
>>
>> after installing Xenomai 3.0.5/kernel 4.9.38 following [1] on our Dell
>> Precision 5820 machine (Intel Xeon W-2145), there are high latencies
>> when the system is at rest. When starting a stress test via `stress -v
>> -c 8 -i 10 -d 8`, the latency goes down (see terminal output below).
>>
>> Usually I would assume the latency increases with higher load and not go
>> down. Does someone has an idea where to start in debugging / fixing the
>> high latencies? Note that the cores are in C0 state 100% of the time
>> (with and without the load on the machine).
> Maybe a SMI issue [1]. You may want to boot your hardware with a vanilla
> kernel (unpatched, no Xenomai), then run the hwlatdetect test from the
> rt testsuite [2]. If SMIs are detected, you may want to ask your BIOS
> vendor to fix their code (some do actually).
>
> [1] http://xenomai.org/2014/06/dealing-with-x86-smi-troubles/
> [2] git://git.kernel.org/pub/scm/linux/kernel/git/clrkwllms/rt-tests.git
>


