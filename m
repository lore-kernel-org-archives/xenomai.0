References: <1522245644.2732.13.camel@sprinte.eu>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <4daad8ee-cdbd-b67b-bc71-ce141e4a60dc@xenomai.org>
Date: Wed, 28 Mar 2018 16:16:34 +0200
MIME-Version: 1.0
In-Reply-To: <1522245644.2732.13.camel@sprinte.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Canonical way to differentiate between NPTL / Cobalt
 threads
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Julien Blanc <julien.blanc@sprinte.eu>, "Xenomai@xenomai.org" <xenomai@xenomai.org>

On 03/28/2018 04:00 PM, Julien Blanc wrote:
> We're using a mix of regular NPTL posix threads and RT cobalt threads
> in our application, using XDDP communication between them.
> 
> In a few places, we need to identify the calling context, ie, whether
> we're being called from a cobalt RT thread or from a regular NPTL
> thread, and act accordingly.
> 
> My understanding is that calling pthread_getschedparam and checking
> that the returned policy is SCHED_FIFO does the job.
> 
> * is it correct ? Or are they some corner cases not covered by this
> test ?

A regular pthread undergoing the SCHED_FIFO policy would also match this
test, so this would work as long as SCHED_FIFO is exclusively used for
Cobalt threads.

> * is it the canonical way, or is there another one ? (maybe cheaper -
> since this call will do two calls in case of a posix thread, there must
> be a cheaper way to detect the running context).
> 
cobalt_thread_pid(pthread_t) from the internal support library would do
the job. A successful call would denote a cobalt thread, -ESRCH would
denote a regular (or invalid) pthread.

-- 
Philippe.

