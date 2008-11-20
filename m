Message-ID: <c671e46ede47f2d2326c99835d3c0c3b.squirrel@domain.hid>
In-Reply-To: <2BF3BEC899094F50A4B492D9E924A4FA@PromessInc.local>
References: <42B0FA09DE79461986CBEE046DEF3B87@domain.hid>
	<492429F8.2090309@domain.hid>
	<90cf07d8d7a97433c26e9b773ae87423.squirrel@domain.hid>
	<2BF3BEC899094F50A4B492D9E924A4FA@PromessInc.local>
Date: Thu, 20 Nov 2008 18:12:42 +0100 (CET)
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai-help] Does Valgrind work with Xenomai?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rob@domain.hid
Cc: xenomai@xenomai.org


Robert McCullough wrote:
>
>
>   --> -----Original Message-----
>   --> From: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org]
>   --> Sent: Thursday, November 20, 2008 8:25 AM
>   --> To: rpm@xenomai.org
>   --> Cc: rob@domain.hid; xenomai@xenomai.org
>   --> Subject: Re: [Xenomai-help] Does Valgrind work with Xenomai?
>   -->
>   -->
>   --> Philippe Gerum wrote:
>   --> > Robert McCullough wrote:
>   --> >> Hi,
>   --> >>
>   --> >>
>   --> >>
>   --> >> I currently have a C++ application that is using 5 RTDM drivers,
> 2
>   --> >> Xenomai real-time user-space threads and several non-real-time
>   --> Linux
>   --> >> threads.
>   --> >>
>   --> >> This application seems to have a memory leak because after
> running
>   --> for
>   --> >> several hours the OOM-Killer kills this application.
>   --> >>
>   --> >> I am looking for a memory leak detection tool to help find the
>   --> leak.
>   --> >>
>   --> >>
>   --> >>
>   --> >> Two years ago in the following mail it was mentioned that making
>   --> >> Valgrind aware of Xenomai syscalls was on the todo list.
>   --> >>
>   --> >> http://article.gmane.org/gmane.linux.real-time.xenomai.users/1805
>   --> >>
>   --> >>
>   --> >>
>   --> >> Has this been done?
>   --> >>
>   --> >
>   --> > No news.
>   --> >
>   --> >> Does Valgrind work with Xenomai?
>   --> >>
>   --> >
>   --> > Nope.
>   -->
>   --> Another way around, at least if you are using the posix skin, is to
>   --> compile your application for Linux without Xenomai. If you are using
> a
>   --> legacy API, you can do this with Xenomai/SOLO. If you are using the
>   --> native
>   --> API, then maybe you can ask gently Philippe to write a native skin
> for
>   --> Xenomai/SOLO.
>   -->
>   --> Now, about valgrind, I spent some time thinking about it. A first
>   --> modification of valgrind, is to allow dynamic syscall tables, such
> as
>   --> what
>   --> Xenomai use. This should be an easy task.
>   -->
>   --> The next task is to rewrite all xenomai syscalls in valgrind
> language
>   --> (that is mainly to identify memory reads and writes), this is not a
>   --> hard
>   --> task, but a rather long one. So, my idea (which remains an idea for
>   --> now)
>   --> was to write the interface of the syscalls in IDL, and to generate
>   --> automatically the code for valgrind.
>   -->
>   --> --
>   -->                     Gilles.
>
> [Robert McCullough]
>
> Thanks Gilles for your advice and information.
> My application uses the native skin but not to much so it might not take
> too
> much to convert to the posix skin.  I will look into doing this.  As far
> as
> the 5 RTDM drivers go, they will not run under Linux without Xenomai,
> correct?  So, I will have to replace them with non-real-time drivers or
> simulate them in my application.

There is an experimental branch of RTDM which allows to run RTDM drivers
over plain Linux. I do not remember where it is. Maybe someone can give us
more details?

>
> I am new to valgrind and have just started to try it.  So, at this time I
> would not be very much help in the modification to work with Xenomai.
>
> I am currently using the Linux "top" utility to monitor the memory usage
> of
> my application.  Is this the best utility for this job?
>
> Also, is there a way to monitor the memory usage of my Xenomai tasks and
> RTDM drivers?

No, not yet.

-- 
                    Gilles.


