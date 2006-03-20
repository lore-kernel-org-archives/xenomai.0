Message-ID: <441F1B05.1090505@domain.hid>
Date: Mon, 20 Mar 2006 22:13:41 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] yet another test tool
References: <441DD89A.4000501@domain.hid>	<17438.51347.702261.525919@domain.hid>	<441EDA08.7050900@domain.hid>
	<17438.65058.166546.339686@domain.hid>
In-Reply-To: <17438.65058.166546.339686@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai-core <xenomai@xenomai.org>

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>  > As a first step, I would vote for establishing that generic service to
>  > redirect the userspace return path to some arbitrary handler in hard-RT
>  > context. Then we can think about how to handle signal injection from
>  > Linux vs. injection from Xenomai gracefully.
> 
> Ok, the first idea was a bad idea. Will try the second, or the
> alternative proposed by Philippe.
> 
>  > 
>  > > 
>  > >  > 
>  > >  > What do you think, is it worth including as a POSIX counterpart for
>  > >  > testsuite/latency?
>  > > 
>  > > There are a few details that I do not like about this tool, but we may
>  > > take it, and fix the details later.
>  > 
>  > It's a real hack, isn't it ;)? But what precisely do you mean?
> 
> What I dislike most, is the lack of return values check. This may work
> well with Linux, but not with Xenomai. I would also prefer a clean
> shutdown using pthread_cancel, after all sigwait and *nanosleep are
> cancellation points, so it should work even without resorting to cleanup
> handlers.
> 

The current implementation is one thing (we could fix it), the purpose 
of the tool is another, and actually, this is the latter which seems 
useful to me. By sharing some common tests between native preemption and 
real-time sub-systems like Xeno, we would make performance comparisons 
more relevant. Additionally, I'm convinced that the POSIX skin is an 
underutilized goodie albeit it works damn well and obviously favours a 
close integration within the Linux environment, simply because there is 
a lack of explanation about it. Illustrating how one could leverage it 
is always a good thing.

-- 

Philippe.

