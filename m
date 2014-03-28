Message-ID: <53352740.3060900@mail.de>
Date: Fri, 28 Mar 2014 08:39:44 +0100
From: Ralf <ralf.moder@mail.de>
MIME-Version: 1.0
References: <5334334D.4050300@mail.de>
In-Reply-To: <5334334D.4050300@mail.de>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] error / bugfix in ipipe-core-3-10.28-powerpc-1.patch
 (from eldk 5.5, company denx)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org


Hello,

i have found an error in the ipipe-patch above.
Here ist the error description:

Our system:
Linux 3.10.28 with xenomai 2.6 patch on a PowerPC MPC5200

Error description:
We use the xenomai-(posix-skin-)function clock_gettime(
CLOCK_HOST_REALTIME, ..) to read out our system time. Thus, we set up a
NTP clock that runs on an FPGA. Later, we compare the system time and
NTP time deviations. Unfortunately we recognize in any comparison with
the nanoseconds a deviation of at least 100 million nsecs. We then
started the xenomai test suite and get the following prints on our console:

root@hbm-000a0f(NFS):/$clocktest -D -C
42                                      
hostrt data area is
live                                                       
Sequence counter :
92323948                                                    
wall_time_sec    :
1395909476                                                  
wall_time_nsec   :
49                                                          
wall_to_monotonic                                                              

tv_sec : -1395754171                                                 
tv_nsec : 750313156                                                   
cycle_last       :
5127088924084                                               
mask             :
0xffffffffffffffff                                          
mult             :
508284933                                                   
shift            :
24                                                          
                                                                               

== Tested clock: 42
(CLOCK_HOST_REALTIME)                                      
CPU      ToD offset [us] ToD drift [us/s]      warps max delta
[us]            
--- -------------------- ---------------- ----------
--------------            
  0            -990145.8       -11538.531       2740         6253.3

As you can see, only 8 bits of the nanosecond value (wall_time_nsec)
will be displayed. Instrumentation (printks) has shown that these are
the most significant 8 bits of the value.

Reason:
The function tk_xtime(struct timekeeper *tk) (in file
include/linux/timekeeper_internal.h)

static inline struct timespec tk_xtime(struct timekeeper *tk)
{
    struct timespec ts;

    ts.tv_sec = tk->xtime_sec;
    ts.tv_nsec = (long)(tk->xtime_nsec >> tk->shift);
    return ts;
}

is applied twice to the system time. First in this function (in file
include/linux/timekeeper_internal.h):

static inline void update_vsyscall(struct timekeeper *tk)
{
    struct timespec xt;

    xt = tk_xtime(tk);
    update_vsyscall_old(&xt, &tk->wall_to_monotonic, tk->clock, tk->mult);
}

and then in this function (in file /kernel/ipipe/timer.c):

void ipipe_update_hostrt(struct timekeeper *tk)
{
    struct ipipe_hostrt_data data;
    struct timespec xt;

    xt = tk_xtime(tk);
    ipipe_root_only();
    data.live = 1;
    data.cycle_last = tk->clock->cycle_last;
    data.mask = tk->clock->mask;
    data.mult = tk->mult;
    data.shift = tk->shift;
    data.wall_time_sec = xt.tv_sec;
    data.wall_time_nsec = xt.tv_nsec;
    data.wall_to_monotonic = tk->wall_to_monotonic;
    __ipipe_notify_kevent(IPIPE_KEVT_HOSTRT, &data);
}

tk_xtime() makes a shift to the right on the nanoseconds. This shift is
at our clock source 24. If this shift now run twice consecutively, that
explains naturally why we only get the most significant 8 bits of the
nanosecond value.

a fix that might solve the problem, looks like this

void ipipe_update_hostrt(struct timekeeper *tk)
{
    struct ipipe_hostrt_data data;
    struct timespec xt;

//     xt = tk_xtime(tk);
    ipipe_root_only();
    data.live = 1;
    data.cycle_last = tk->clock->cycle_last;
    data.mask = tk->clock->mask;
    data.mult = tk->mult;
    data.shift = tk->shift;
    data.wall_time_sec = tk->xtime_sec;
    data.wall_time_nsec = (long)tk->xtime_nsec;
    data.wall_to_monotonic = tk->wall_to_monotonic;
    __ipipe_notify_kevent(IPIPE_KEVT_HOSTRT, &data);
}

I have successfully tested this fix on our system.

Regards

Ralf


