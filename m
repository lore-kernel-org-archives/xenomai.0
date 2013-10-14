MIME-Version: 1.0
In-Reply-To: <525A85FA.9060001@xenomai.org>
References: <CAKKWdtfW+p1twc63Z1t3AXQscNtCGMO0j0NUc9uqq4gXaCgfoA@mail.gmail.com>
	<3b559e148cf71d636e41b420b7476428.squirrel@127.0.0.1>
	<CAKKWdtctE64WA0v74-s6DgtBjVW14TJxjeTZtb66Sj5UKkw=Qw@mail.gmail.com>
	<525A85FA.9060001@xenomai.org>
Date: Mon, 14 Oct 2013 12:53:06 +0330
Message-ID: <CAKKWdtcJ1bkLTcBtY1NTf3war3d_tnwfNfbpTJyY_rG43ruHaQ@mail.gmail.com>
From: ali hagigat <hagigatali@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Xenomai] Watchdog timer does not function correctly
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

if i use Linux syscalls , do i have to use real-time syscalls to return to
the primary mode?


On Sun, Oct 13, 2013 at 3:07 PM, Gilles Chanteperdrix <
gilles.chanteperdrix@xenomai.org> wrote:

> On 10/12/2013 05:30 PM, ali hagigat wrote:
> >     printf("expiration = %.1llu, expiries = %.1lu, name = %s\n",
> > info1.expiration, info1.expiries, info1.name <http://info1.name> );
> > }
> >
> > while(1);
> >
> > }
>
> So, the last syscall used before the infinite loop is a Linux syscall,
> and the thread is currently running in secondary mode. Hence, no
> watchdog. So, if you have not touched
> /proc/sys/kernel/sched_rt_runtime_us or
> /proc/sys/kernel/sched_rt_period_us, this is harmless, you can simply
> press ctrl-C to stop the program.
>
>
> --
>                                                                 Gilles.
>
