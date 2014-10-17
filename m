MIME-Version: 1.0
In-Reply-To: <543F900D.3050500@xenomai.org>
References: <CABaOOZ2YOda_cUS-tskNxDZ6sNekMqnPnbu6p8Qp4kvjRzDMyA@mail.gmail.com>
 <543E9BAE.2010808@xenomai.org> <543E9CF5.6080400@xenomai.org>
 <CABaOOZ1Hb5YYBXt2jtyTZWVnA03EGohaVChzEJ0X9=od2=SeNw@mail.gmail.com>
 <543F8974.4070400@xenomai.org>
 <CABaOOZ0aEf8F3EzW=w4R1OgK0SGzE9VnDAJHV+swmSc3EF9O-w@mail.gmail.com>
 <543F900D.3050500@xenomai.org>
Date: Fri, 17 Oct 2014 12:04:35 +0300
Message-ID: <CABaOOZ0gmn2XnoF+pzPVWEU0Fh7WfafJduk5qUnknp5pk8V2bQ@mail.gmail.com>
From: Stratiyenko Roman <picoworm@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] Manual context switch from userspace
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Thank you for helping. I replaced swapcontext with longjmp. All works good.
No switch to secondary mode.

As about using threads, I do not fully understand how scheduler works.
Maybe after I will get more experience in multithreading, I will do as you
recommend.



2014-10-16 12:29 GMT+03:00 Gilles Chanteperdrix <
gilles.chanteperdrix@xenomai.org>:

> On 10/16/2014 11:21 AM, Stratiyenko Roman wrote:
> > Preamptive threads is very hard to write. I need synchronize many blocks
> to
> > garanty data integrity.
> > My program is an automation with many parallel processes that are using
> > data of each other.
> > So for me the best solution is remove any preemption.
>
> The thing is, with an RTOS, as long as you are not using timers, the
> preemption points are those made explicitly by the application.
>
> You could even implement a sort of makecontext/setcontext system with
> pthreads where makecontext would make a pthread_create and initialize a
> per thread semaphore, and setcontext woult post the destination thread
> semaphore and pend on the current thread semaphore. In fact, you can
> explicitly switch between threads by using per-thread semaphores.
>
> (please keep the list posted, do not send me private mails).
>
> --
>                                                                 Gilles.
>
