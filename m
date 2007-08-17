Message-ID: <2ff1a98a0708170504o37658a03y8ec1b084b4d26489@domain.hid>
Date: Fri, 17 Aug 2007 14:04:43 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <46C57FBF.9050108@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <18116.37871.209453.702969@domain.hid>
	<46C57FBF.9050108@domain.hid>
Subject: Re: [Xenomai-help] Time for rt_mutex_acquire
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Dirk Eibach <eibach@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

On 8/17/07, Dirk Eibach <eibach@domain.hid> wrote:
> gilles.chanteperdrix@xenomai.org wrote:
> > Dirk Eibach wrote:
> >  > Hello,
> >  >
> >  > I'm wondering how long a rt_mutex_acquire is supposed to take on a PPC405
> >  > platform. I'm getting times about 50 usec here, which is too much for my
> >  > application. Is anything wrong in my kernel/xenomai configuration or is
> >  > this time to expected?
> >
> > How do you measure this ? Are you sure the mutex is free when you try to
> > acquire it ?
> >
>
> I prepared a small testcase. It shows about 8.300 ticks, which is about 30
> usec on my platform (266MHz).

Did you try to call ppc_getcounter twice in a raw to measure the
overhead of this function ?


-- 
                                               Gilles Chanteperdrix

