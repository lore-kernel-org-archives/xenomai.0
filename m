Message-ID: <4FC693D4.1090108@xenomai.org>
Date: Wed, 30 May 2012 23:40:36 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAKKWdtc6Py7A9YuJ1nNzwmq0SiEcrP_D8pztoo_eNWsp9EAsFg@mail.gmail.com>	<4FC637EB.90908@xenomai.org>
	<4FC63C53.3020805@xenomai.org>	<20120530155743.GK32727@csclub.uwaterloo.ca>
	<623784B6C75D274389918D358E89E8BB0B7FE2DD@OPTELIAN5.optelian.local>
In-Reply-To: <623784B6C75D274389918D358E89E8BB0B7FE2DD@OPTELIAN5.optelian.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] a question about ADEOS
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Chris Stone <chris.stone@optelian.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 05/30/2012 07:32 PM, Chris Stone wrote:
> Rest assured there are many users of Adeos/Xenomai that believe it is
> a much more elegant/reliable/efficient/simple choice for real time in
> Linux. The linux scheduler is a mammoth beast that takes far too long
> to run. One of the finest advantages of Adeos/Xenomai is that you get
> to preempt the mammoth beast with a simple and fast real time
> scheduler. PREEMPT-RT is an interesting solution, but is not a
> particularly well thought out one. PREEMPT-RT is unstable and slow,
> which is why it STILL isn't fully accepted into the native kernel
> yet, after at least 8 years of trying to get it in. In another five
> years, PREEMPT_RT will make Xenomai better by reducing worst case
> latency when an application switches to secondary mode, but it will
> never replace Adeos/Xenomai.

Do not get me wrong, I have no issue with preempt_rt being the solution
chosen by the kernel community as the solution for real-time. I would
even tend to be a bit less extreme than you, calling room for
improvement the "mammoth beast" and the slow kernel.

As for the stability, the OSADL published some results:
https://www.osadl.org/Single-View.111+M59e3481cdfe.0.html

which show that the preempt_rt patched kernels are able to run for
sustained period of times under load without crashes, at least on the
tested platforms. This is not so different of the way we validate the
I-pipe patch.

I was merely trying to answer the question "why is not adeos integrated
to the linux kernel?".
-- 
                                                                Gilles.

