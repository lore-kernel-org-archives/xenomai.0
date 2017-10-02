References: <DB6PR0701MB24567885F171F1129C2FCE61B57D0@DB6PR0701MB2456.eurprd07.prod.outlook.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <b7c66b27-ccc4-d1d0-56ed-1925514868b0@xenomai.org>
Date: Mon, 2 Oct 2017 16:18:15 +0200
MIME-Version: 1.0
In-Reply-To: <DB6PR0701MB24567885F171F1129C2FCE61B57D0@DB6PR0701MB2456.eurprd07.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] The task calling pthread_cond_signal() has to own the
 lock
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Giulio Moro <g.moro@qmul.ac.uk>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 10/02/2017 04:08 PM, Giulio Moro wrote:
> I am using condition variables with the Posix skin on Xenomai 3.0.5
> I find that if the thread calling pthread_cond_signal() has not acquired the lock associated with the condition variable, the waiting thread is not resumed. Is this expected behaviour? As
> According to the Posix specifications (referenced by the Xenomai docs):
> "The pthread_cond_broadcast() or pthread_cond_signal() functions may be called by a thread whether or not it currently owns the mutex that threads calling pthread_cond_wait() or pthread_cond_timedwait() "
> therefore, I think that what I observe is unexpected behaviour.
> Note: I am happy for my use case to accept the non-deterministic behaviour caused by the signalling thread not acquiring the lock.
> 

libcobalt enforces the requirement to hold the lock so that optimizing
the wake up process is possible - under the assumption that the caller
owns the lock. There is no hack around this.

-- 
Philippe.

