From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Date: Wed, 30 May 2012 13:59:13 -0400
Message-ID: <20120530175913.GM32727@csclub.uwaterloo.ca>
References: <CAKKWdtc6Py7A9YuJ1nNzwmq0SiEcrP_D8pztoo_eNWsp9EAsFg@mail.gmail.com>
	<4FC637EB.90908@xenomai.org> <4FC63C53.3020805@xenomai.org>
	<20120530155743.GK32727@csclub.uwaterloo.ca>
	<623784B6C75D274389918D358E89E8BB0B7FE2DD@OPTELIAN5.optelian.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <623784B6C75D274389918D358E89E8BB0B7FE2DD@OPTELIAN5.optelian.local>
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

On Wed, May 30, 2012 at 05:32:48PM +0000, Chris Stone wrote:
> Rest assured there are many users of Adeos/Xenomai that believe it is a much more elegant/reliable/efficient/simple 
> choice for real time in Linux. The linux scheduler is a mammoth beast that takes far too long to run. One of 
> the finest advantages of Adeos/Xenomai is that you get to preempt the mammoth beast with a simple and fast 
> real time scheduler. PREEMPT-RT is an interesting solution, but is not a particularly well thought out one. 
> PREEMPT-RT is unstable and slow, which is why it STILL isn't fully accepted into the native kernel yet, after at 
> least 8 years of trying to get it in. In another five years, PREEMPT_RT will make Xenomai better by reducing 
> worst case latency when an application switches to secondary mode, but it will never replace Adeos/Xenomai. 

Hmm, that's too bad.  Well maybe we will end up having to stick with
ipipe then.

-- 
Len Sorensen

