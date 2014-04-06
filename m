Message-ID: <53416E2E.20000@xenomai.org>
Date: Sun, 06 Apr 2014 17:09:34 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1396262085.387.YahooMailNeo@web171601.mail.ir2.yahoo.com>
 <53395104.6050109@xenomai.org> <53396B31.1090903@xenomai.org>
 <5339AACA.4090807@xenomai.org>
 <1396782702.1096.YahooMailNeo@web171605.mail.ir2.yahoo.com>
 <53416D09.7060805@xenomai.org>
In-Reply-To: <53416D09.7060805@xenomai.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] EINTR in notifier.c (mercury)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 04/06/2014 05:04 PM, Philippe Gerum wrote:
> @@ -1093,7 +1093,9 @@ int threadobj_sleep(struct timespec *ts)
>  	 */
>  	current->run_state = __THREAD_S_DELAYED;
>  	threadobj_save_timeout(&current->core, ts);
> -	ret = -__RT(clock_nanosleep(CLOCK_COPPERPLATE, TIMER_ABSTIME, ts, NULL));
> +	do
> +		ret = -__RT(clock_nanosleep(CLOCK_COPPERPLATE, TIMER_ABSTIME, ts, NULL));
> 
> We should definitely pass and use the "remain" field in clock_nanosleep(), not to restart a complete wait each time we get interrupted.
> 

The remain field only makes sense without TIMER_ABSTIME. With
TIMER_ABSTIME, since the wake-up time is absolute, passing it again to
clock_nanosleep should be fine.

-- 
                                                                Gilles.

