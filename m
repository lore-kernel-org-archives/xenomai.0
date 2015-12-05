From: Steven Seeger <steven.seeger@nasa.gov>
Date: Sat, 5 Dec 2015 13:53:22 -0500
Message-ID: <9606009.fESfxUr9Qo@wirbelwind>
In-Reply-To: <6309036.vrZ57LHtHK@wirbelwind>
References: <6309036.vrZ57LHtHK@wirbelwind>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Subject: Re: [Xenomai] powerpc 440 userspace latency test does nothing
Reply-To: steven.seeger@nasa.gov
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

More info on this.

timer_gettime() on latency's timerfd returns 0 seconds and 1 nanosecond, 
indicating the timer has not expired. No matter how much time I sleep before 
this the result is the same. 

The output of cat /proc/xenomai/timer/coreclk:

SCLINUX: / # cat /proc/xenomai/timer/coreclk 
CPU  SCHED/SHOT            TIMEOUT     INTERVAL    NAME
0    2320/1334             1ms523us    -           [host-timer]
0    2/2                   -           -           latency
0    1/0                   -           100us       timerfd_handler

The "latency" with 2/2 is a couple of sleep(1) I added for debugging purposes 
during the beginning of the program.

I've modified latency to look like this:

133     err = clock_gettime(CLOCK_MONOTONIC, &expected);
134     if (err)
135         error(1, errno, "clock_gettime()");
136 
137     printf("expected is: %Ld %ld\n", (long long int)expected.tv_sec, 
expected.tv_nsec);
138     sleep(1);
139     err = clock_gettime(CLOCK_MONOTONIC, &expected);
140     printf("expected is: %Ld %ld\n", (long long int)expected.tv_sec, 
expected.tv_nsec);
141 
142     fault_threshold = CONFIG_XENO_DEFAULT_PERIOD;
143     nsamples = (long long)ONE_BILLION / period_ns;
144     /* start time: one millisecond from now. */
145     expected.tv_nsec += 1000000;
146     if (expected.tv_nsec > ONE_BILLION) {
147         expected.tv_nsec -= ONE_BILLION;
148         expected.tv_sec++;
149     }
150     timer_conf.it_value = expected;
151     timer_conf.it_interval.tv_sec = period_ns / ONE_BILLION;
152     timer_conf.it_interval.tv_nsec = period_ns % ONE_BILLION;
153 
154     printf("expected is: %Ld %ld\n", (long long int)expected.tv_sec, 
expected.tv_nsec);
155     err = timerfd_settime(tfd, TFD_TIMER_ABSTIME, &timer_conf, NULL);
156     if (err)
157         error(1, errno, "timerfd_settime()");
158 
159 sleep(1);
160     err = timerfd_gettime(tfd, &timer_conf);
161     if(err) error(1, errno, "steven temp");
162     printf("timer got time %Ld %ld\n", (long long 
int)timer_conf.it_value.tv_sec, timer_conf.it_value.tv_n    sec);

Which yields the output:

expected is: 1582352598 771936946
expected is: 1582352599 772083521
expected is: 1582352599 773083521
timer got time 0 1

I've also confirmed that timerfd_read() reaches xnsynch_sleep_on

Seeing as how coreclk is also used for the host-timer and that works correctly 
I am totally stumped. Anybody have any ideas? :)

Steven



