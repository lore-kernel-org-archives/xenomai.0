Message-ID: <525A85FA.9060001@xenomai.org>
Date: Sun, 13 Oct 2013 13:37:30 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAKKWdtfW+p1twc63Z1t3AXQscNtCGMO0j0NUc9uqq4gXaCgfoA@mail.gmail.com>
	<3b559e148cf71d636e41b420b7476428.squirrel@127.0.0.1>
	<CAKKWdtctE64WA0v74-s6DgtBjVW14TJxjeTZtb66Sj5UKkw=Qw@mail.gmail.com>
In-Reply-To: <CAKKWdtctE64WA0v74-s6DgtBjVW14TJxjeTZtb66Sj5UKkw=Qw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Watchdog timer does not function correctly
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: ali hagigat <hagigatali@gmail.com>
Cc: xenomai@xenomai.org

On 10/12/2013 05:30 PM, ali hagigat wrote:
>     printf("expiration = %.1llu, expiries = %.1lu, name = %s\n",
> info1.expiration, info1.expiries, info1.name <http://info1.name> );
> }
> 
> while(1);
> 
> }

So, the last syscall used before the infinite loop is a Linux syscall,
and the thread is currently running in secondary mode. Hence, no
watchdog. So, if you have not touched
/proc/sys/kernel/sched_rt_runtime_us or
/proc/sys/kernel/sched_rt_period_us, this is harmless, you can simply
press ctrl-C to stop the program.


-- 
                                                                Gilles.

