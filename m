Date: Mon, 19 Nov 2018 10:40:16 +0100
From: Henning Schild <henning.schild@siemens.com>
Subject: Re: [PATCH] testsuite/smokey: relax posix-clock time dependancy
Message-ID: <20181119104016.7f303e5c@md1za8fc.ad001.siemens.net>
In-Reply-To: <6bcda9af-aea0-970d-59f2-ed7a49222fe2@siemens.com>
References: <20181109091430.24559-1-henning.schild@siemens.com>
 <6bcda9af-aea0-970d-59f2-ed7a49222fe2@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: xenomai@xenomai.org, Philippe Gerum <rpm@xenomai.org>

Am Fri, 16 Nov 2018 07:23:47 +0100
schrieb Jan Kiszka <jan.kiszka@siemens.com>:

> On 09.11.18 10:14, Henning Schild via Xenomai wrote:
> > The test often asserted. This patch gives the thread a priority,
> > introduces a 25us margin and prints the value in case we still fail.
> > 
> > Signed-off-by: Henning Schild <henning.schild@siemens.com>
> > ---
> >   testsuite/smokey/posix-clock/posix-clock.c | 15 ++++++++++++++-
> >   1 file changed, 14 insertions(+), 1 deletion(-)
> > 
> > diff --git a/testsuite/smokey/posix-clock/posix-clock.c
> > b/testsuite/smokey/posix-clock/posix-clock.c index
> > f672a9d52..36e0f5dea 100644 ---
> > a/testsuite/smokey/posix-clock/posix-clock.c +++
> > b/testsuite/smokey/posix-clock/posix-clock.c @@ -417,8 +417,10 @@
> > static int clock_decrease_after_periodic_timer_first_tick(void) 
> >   	diff = now.tv_sec * 1000000000ULL + now.tv_nsec -
> >   		(timer.it_value.tv_sec * 1000000000ULL +
> > timer.it_value.tv_nsec);
> > -	if (!smokey_assert(diff < 1000000000))
> > +	if (!smokey_assert(diff < 1000000000ULL + 25000ULL)) {  
> 
> Philippe, is this margin also reasonable from your perspective? Or
> are we risking to miss a problem this way? I'm currently lacking a
> feeling.

Good question. That is an estimate suitable for x86. While it should
not defeat the test, the test failing 60% of the time renders it not
too useful.

Henning

> Thanks,
> Jan
> 
> > +		fprintf(stderr, "diff = %llu\n", diff);
> >   		return -EINVAL;
> > +	}
> >   	
> >   	ret = smokey_check_errno(read(t, &ticks, sizeof(ticks)));
> >   	if (ret < 0)
> > @@ -430,10 +432,21 @@ static int
> > clock_decrease_after_periodic_timer_first_tick(void) return
> > smokey_check_errno(close(t)); }
> >   
> > +static int init_posix_clock(void)
> > +{
> > +	struct sched_param params = {.sched_priority = 1};
> > +
> > +	return pthread_setschedparam(pthread_self(), SCHED_FIFO,
> > &params); +}
> > +
> >   static int run_posix_clock(struct smokey_test *t, int argc, char
> > *const argv[]) {
> >   	int ret;
> >   
> > +	ret = init_posix_clock();
> > +	if (ret)
> > +		return ret;
> > +
> >   	ret = clock_increase_before_oneshot_timer_first_tick();
> >   	if (ret)
> >   		return ret;
> >   
> 


