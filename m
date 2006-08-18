Message-ID: <44E60313.8000803@domain.hid>
Date: Fri, 18 Aug 2006 12:12:35 -0600
From: Jim Cromie <jim.cromie@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Re: Test, benchmark
References: <44DA896F.9060102@domain.hid>	<44DB1865.90004@domain.hid>	<44DB9958.10109@domain.hid>	<44DCAF88.2060801@domain.hid>	<44E5F0B4.8070405@domain.hid>
	<17637.63157.596008.331241@domain.hid>
In-Reply-To: <17637.63157.596008.331241@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai-core <xenomai@xenomai.org>

Gilles Chanteperdrix wrote:
> Jim Cromie wrote:
>  > [ 1574.162754] Xenomai: starting RTDM services.
>  > cpu 0: 2079 context switches.
>  > cpu 0: 4212 context switches.
>  > cpu 0: 6336 context switches.
>  > cpu 0: 8442 context switches.
>  > ...
>  > cpu 0: 246981 context switches.
>  > cpu 0: 249096 context switches.
>  > cpu 0: 250263 context switches.
>  > [ 1698.479703] Xenomai: stopping RTDM services.
>  > 
>  > wrt the data emitted, what can we learn from the numbers ?
>  > They look to be increasing linearly, with some noise/perturbations.
>  > We could do some statistics, but whats useful ?
>  > Histogramming, averaging the delta-context-switches ?
>  > 
>  > Also, I see from the help-text that it does many kinds of context switches.
>  > Does it make sense to run each kind for a bunch of samples,
>  > so that we can see # and variation for each kind of switch ?
>
> No, because one of the threads in the chain of context switches is
> sleeping, otherwise the program would completely block your box. So, the
> figures are largely irrelevant, the only important thing about them is
> that they are increasing, it proves that the test is really switching
> contexts. But the test fails if the value stop increasing, so no, the
> output is useless. Note that if you add the -q option, the program will
> be silent and only print the final count of context switches.
>
> A question: I see that you always use the -n option, do you have
> problems running the test without this option ? When launched with the
> -n option switchtest does not test cpu context switches.
>
>   

I think I added it at some point when I wasnt getting output.
It works without the -n too,  which should be added via XENOT_SWITCHTEST,
not stuffed in by default.   You could just edit it out of patch, if 
otherwize satisfied...

fwiw, Im not averse to expanding to XENOTEST_OPTS_<foo>,
if you think thats better  (its probly more self-explanatory when found 
in an .rc file)

(its obviously trivial to redo the patch, lemme know)

BTW, running without -n, and with -T 120 (same as before)
I get more total context switches:


[ 1075.064980] Xenomai: starting RTDM services.
Testing FPU check routines...
r0: 1 != 2
r1: 1 != 2
r2: 1 != 2
r3: 1 != 2
r4: 1 != 2
r5: 1 != 2
r6: 1 != 2
r7: 1 != 2
FPU check routines OK.
cpu 0: 5727 context switches.
cpu 0: 11477 context switches.
cpu 0: 17227 context switches.
cpu 0: 23000 context switches.
...
cpu 0: 673164 context switches.
cpu 0: 678914 context switches.
cpu 0: 684664 context switches.
cpu 0: 688620 context switches.
[  708.976879] Xenomai: stopping RTDM services.

Offhand, that seems counterintuitive that -n gives lower growth-rate of 
total switches,
since its equivalent to a shorter list of 'threadspec's


Also, 2 possible output change requests:

a - print per-sample measures, not accumulating ones.
    this is more consistent with latency, which prints the latencies
    seen over the 1-sec sample period
    This also feeds better into histogram, w/o adding 'delta' logic to 
histogrammer

b - label output lines more in spirit of latency

RTT|  00:00:01  (in-kernel periodic task, 100 us period, priority 99)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat 
worst
RTD|       4.733|      13.145|      18.518|       0|       4.733|      
18.518
RTD|       4.868|      13.169|      24.735|       0|       4.733|      
24.735
RTD|       5.014|      13.104|      36.270|       0|       4.733|      
36.270
RTD|       4.905|      13.111|      36.394|       0|       4.733|      
36.394

I have some misgivings about asking for this :

- current output needs massaging, esp b4 feeding to gnuplot
    Someday, I'll sit down and write a script to reformat the data the 
way gnuplot wants it,
    then we'll have some idea whether current form is sub-optimal.

- Ideally, we'd be using relayfs to collect data.
    More library-fodder ??


Lastly, we once had testsuite/README, I suppose it was dropped as being
fatally-out-of-date.  Presuming we want a new fresh one, could you add
an empty file to svn, so that we can patch against it ?

thanks
jimc

