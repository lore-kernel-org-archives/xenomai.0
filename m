From: Krzysztof =?UTF-8?Q?B=C5=82aszkowski?= <kb@domain.hid>
In-Reply-To: <1282056067.1730.245.camel@domain.hid>
References: <1282047938.5255.89.camel@domain.hid>
	<1282056067.1730.245.camel@domain.hid>
Content-Type: text/plain; charset="utf-8"
Date: Tue, 17 Aug 2010 18:09:25 +0200
Message-Id: <1282061365.5255.205.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai-core] xenomai 2.5.3/native, kernel 2.6.31.8 and fork()
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

Hi Philippe,

On Tue, 2010-08-17 at 16:41 +0200, Philippe Gerum wrote:
> On Tue, 2010-08-17 at 14:25 +0200, Krzysztof Błaszkowski wrote:
> > Hello,
> > 
> > I found recently that large application uses to segfault before fork()
> > leaves its glibc wrapper.
> > 
> > I included here a test suite which can be easily used to verify what
> > goes wrong. It may be necessary to adjust makefile to compile the code.
> > So, the console is missing output from line #89. We can see instead a
> > message that getpid couldn't be linked which is 1st sign of memory
> > corruption.
> > 
> > i used to think that this issue could be related to not unbinding heap
> > before fork() but it turned out that it is enough to link userspace with
> > xenomai libraries.
> > 
> > I wonder if this is known issue and if there is any fix, does 2.5.4 work
> > same ? or maybe there is something wrong with the kernel i use (or adeos
> > patch)
> > 
> > Another question is why rt_task_create() is marked deprecated in native
> > skin.
> 
> rt_task_create() as defined by the kernel-side API is marked as
> deprecated. The user-space version of rt_task_create() is not.
> 
> >  Does it mean that native skin is going to be removed from source
> > tree ?
> > 
> 
> No. It means that starting with the next major evolution of Xenomai
> (i.e. 3.x), skins will no more export any kernel-based API (except
> RTDM). In short, if your application is running in user-space, nothing
> will change for you. OTOH, applications currently running in kernel
> space over the native API should consider moving to user-space at some
> point, because we won't support the former programming model
> indefinitely. The rationale for this decision is explained here:
> http://www.xenomai.org/index.php/Xenomai:Roadmap#What_Will_Change_With_Xenomai_3
> 
> The keyword here is "application", obviously not drivers, which are by
> essence better supported in kernel space in the Linux environment, and
> Xenomai 3.x will keep on providing what is required to develop them
> there over RTDM.


Thank you for explanation. it means to me lots of work in the future if
i wanted to be up-to-date with mainstream development.
I am glad to see that Xeonami II is going to be maintained for long
time.

Regards,

> 
> > Regards,
> > 
> > _______________________________________________
> > Xenomai-core mailing list
> > Xenomai-core@domain.hid
> > https://mail.gna.org/listinfo/xenomai-core
> 


-- 
Krzysztof Blaszkowski


