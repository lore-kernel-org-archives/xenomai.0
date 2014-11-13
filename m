Date: Thu, 13 Nov 2014 14:19:51 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20141113131951.GU4656@sisyphus.hd.free.fr>
References: <CALTC7XJqCSDfPR8bx4VKLdUQtNgKG5yuWW4CNJSnc_hjJ9Aqyw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALTC7XJqCSDfPR8bx4VKLdUQtNgKG5yuWW4CNJSnc_hjJ9Aqyw@mail.gmail.com>
Subject: Re: [Xenomai] Call to clock_gettime from xenomai blocking for more
 than 2 seconds
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Cris Almaraz <cristina.almaraz@gmail.com>
Cc: xenomai <xenomai@xenomai.org>

On Thu, Nov 13, 2014 at 02:01:58PM +0100, Cris Almaraz wrote:
> Hi all,
> 
> 
> 
> Xenomai version 2.6.3 . Native skin.
> 
> CentOS 6.4
> 
> 
> 
> I am having some problems with a Xenomai task and the clock_gettime
> function. My application is launching several Xenomai tasks in parallel and
> some of them need to access the current time. For that, I’ve been using the
> clock_gettime(CLOCK_REALTIME,..) function, but I noticed that if the
> application is running during several minutes, sometimes the Xenomai
> watchdog is triggered from the clock_gettime call, as it is taking more
> than 2 seconds to be executed. The behavior is not always the same,
> sometimes the watchdog is triggered after 5 mins, 10 mins… and even when
> the delay is not long enough to trigger the 2 seconds watchdog, I’ve seen
> in the logs that there are some unexpected delays in the application.
> 
> 
> 
> I’ve read about a similar issue in the Xenomai mailing list, but it was
> reported as fixed with Xenomai 2.6. Is there any chance that it is still
> happening or is the problem somewhere else? Any ideas and workarounds are
> welcome.

The short story.
Yes, it is fixed. But you can not use clock_gettime(CLOCK_REALTIME)
from a thread running in primary mode, this can not be made to work. 

You have to compile for the Xenomai posix skin and use
clock_gettime(CLOCK_HOST_REALTIME). The problem if you do that, is
that all your calls to posix functions will be replaced with Xenomai
posix skin calls. So, since there is currently no solution to read
the CLOCK_HOST_REALTIME from the native skin in Xenomai 2.x, and
there is no plan to change it, in your code, use the function

__wrap_clock_gettime(CLOCK_HOST_REALTIME, &ts);

And DO NOT use xeno-config --skin=posix --ldflags to obtain the
LDFLAGS, simply pass the -L /path/to/libdir -lpthread_rt.so part as
LDFLAGS. Do not pass the -Wl,--wrap.

Another way would be to dlopen libpthread_rt.so and dlsym
__wrap_clock_gettime.

Finally, if you do not mind that Xenomai clock drifts compared to
Linux clock, you can use rt_timer_read and add the wallclock offset,
computed at program start, to obtain the wallclock time. Actually,
there is a way to set the rt_timer_read wallclock_offset, but it
involves the posix skin again.

These shortcomings are fixed in Xenomai 3.x.

-- 
					    Gilles.

