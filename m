MIME-Version: 1.0
In-Reply-To: <50E1CE62.9010806@xenomai.org>
References: <50e1cc2fb40c67.12589971@wp.pl>
	<50E1CE62.9010806@xenomai.org>
Date: Mon, 31 Dec 2012 18:52:59 +0100
Message-ID: <CAMYDobURJ8z9JMVD=kwzHfQKQrLSeEP=bXP4cAouOGPM8C9uBg@mail.gmail.com>
From: Peter Soetens <peter@thesourceworks.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] SIGXCPU with rt_mutex_release
Reply-To: peter@thesourceworks.com
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

Hi all,

Thanks for the analysis. I'd propose to move this to bugs.orocos.org where
we can try to reproduce and track this bug in orocos.

We've been testing in our buildfarm against xenomai 2.5, so this might be
something we did not notice until now...

Peter

Op maandag 31 december 2012 schreef Gilles Chanteperdrix (
gilles.chanteperdrix@xenomai.org) het volgende:

> On 12/31/2012 06:32 PM, Mariusz Janiak wrote:
>
> > Hi,
> >
> > I have met problem when I run OROCOS helloWord example. Xenomai
> > generate SIGXCPU signal when rt_mutex_release(...) is called. I have
> > installed signal handler for each realtime thread created by OROCOS
> > and I get following result
> >
> > SIGDEBUG received, reason 4: affected by priority inversion
>
>
> There is a problem in your application, namely a mutex owned by a thread
> running with the SCHED_OTHER scheduling policy, released while Xenomai
> did not notice that the same thread had taken the mutex. This could
> happen if for instance you change the scheduling policy while holding a
> mutex.
>
> Please try reducing the error to a simple testcase which will allow us
> to investigate this issue.
>
> > There is much bigger mess during exiting from application. I am not
> > pretty sure this is a Xenomai problem, if not sorry for bothering. I
> > haven check it with previous Xenomai release yet.
>
>
> We need facts to start working, again, please write a simple test case
> to help investigating the issue.
>
> --
>                                                                 Gilles.
>
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org <javascript:;>
> http://www.xenomai.org/mailman/listinfo/xenomai
>
