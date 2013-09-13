Message-ID: <52337BA2.4080106@xenomai.org>
Date: Fri, 13 Sep 2013 22:54:58 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <a61ffb56.00001e48.00000008@dmerrill_win764.PERF.PERFORMANCESOFTWARE>
In-Reply-To: <a61ffb56.00001e48.00000008@dmerrill_win764.PERF.PERFORMANCESOFTWARE>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] psos t_delete causing a SIGSEGV in suspended task.
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Daniel Merrill <daniel.merrill@psware.com>
Cc: xenomai@xenomai.org

On 09/13/2013 10:48 PM, Daniel Merrill wrote:
> void main()
> 
> {
> 
>     mlockall(MCL_CURRENT | MCL_FUTURE);
> 
>     u_long TID, TID2;
> 
>     u_long args[4] = {TID, 0, 0, 0};

TID here is an uninitialized value, and this is what you pass to
t_delete. I admit the segmentation does not seem like the best reaction,
but the program looks faulty.

>    (...)
>     t_start(TID2, T_PREEMPT | T_TSLICE, &deleter, args);


-- 
                                                                Gilles.

