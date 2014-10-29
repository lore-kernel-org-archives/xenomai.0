Date: Wed, 29 Oct 2014 10:29:16 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20141029092916.GA5258@sisyphus.hd.free.fr>
References: <CABaOOZ2YOda_cUS-tskNxDZ6sNekMqnPnbu6p8Qp4kvjRzDMyA@mail.gmail.com>
 <543E9BAE.2010808@xenomai.org> <543E9CF5.6080400@xenomai.org>
 <CABaOOZ1Hb5YYBXt2jtyTZWVnA03EGohaVChzEJ0X9=od2=SeNw@mail.gmail.com>
 <543F8974.4070400@xenomai.org>
 <CABaOOZ0aEf8F3EzW=w4R1OgK0SGzE9VnDAJHV+swmSc3EF9O-w@mail.gmail.com>
 <543F900D.3050500@xenomai.org>
 <CABaOOZ0gmn2XnoF+pzPVWEU0Fh7WfafJduk5qUnknp5pk8V2bQ@mail.gmail.com>
 <20141028153440.GA11779@sisyphus.hd.free.fr>
 <CABaOOZ2osGiOCjErFgg0cq0mz4MP-e7d+32ayQmxJn0fONvaew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABaOOZ2osGiOCjErFgg0cq0mz4MP-e7d+32ayQmxJn0fONvaew@mail.gmail.com>
Subject: Re: [Xenomai] Manual context switch from userspace
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Stratiyenko Roman <picoworm@gmail.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Wed, Oct 29, 2014 at 10:51:18AM +0200, Stratiyenko Roman wrote:
> Thanks a lot, I already found simple solution at:
> 
> http://www.1024cores.net/home/lock-free-algorithms/tricks/fibers
> 
> So as I guess, compiler knows what registers are in use now, CPU, FPU etc,
> so compiler stores the registers into local memory, only then it switch
> Program Counter and Stack Pointer register,
> 
> I think this way is most fastest way to switch between tasks, compiler save
> only those registers that are used in this moment.

Indeed, I downloaded the last version of glibc (which is where the
setjmp function is implemented) and it is true that it does not save all
registers, only the callee saved ones (since setjmp is a function
call, it does not have to save the caller saved registers, since the
compiler expects them to be clobbered anyway). Since the FPU
registers are not callee saved, this is not an issue, and the
compiler will save them by itself before the call to setjmp/longjmp.

Something to be careful about though: setjmp seems to save the
signal mask, and use sigprocmask, which could result in a switch to
secondary mode, so it is probably better to use sigsetjmp and pass 0
as second argument.

-- 
					    Gilles.

