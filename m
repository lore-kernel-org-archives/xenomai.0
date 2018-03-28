Message-ID: <1522245644.2732.13.camel@sprinte.eu>
From: Julien Blanc <julien.blanc@sprinte.eu>
Date: Wed, 28 Mar 2018 16:00:44 +0200
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] Canonical way to differentiate between NPTL / Cobalt
	threads
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Xenomai@xenomai.org" <xenomai@xenomai.org>

We're using a mix of regular NPTL posix threads and RT cobalt threads
in our application, using XDDP communication between them.

In a few places, we need to identify the calling context, ie, whether
we're being called from a cobalt RT thread or from a regular NPTL
thread, and act accordingly.

My understanding is that calling pthread_getschedparam and checking
that the returned policy is SCHED_FIFO does the job.

* is it correct ? Or are they some corner cases not covered by this
test ?
* is it the canonical way, or is there another one ? (maybe cheaper -
since this call will do two calls in case of a posix thread, there must
be a cheaper way to detect the running context).

Regards,

Julien



