References: <6309036.vrZ57LHtHK@wirbelwind> <9606009.fESfxUr9Qo@wirbelwind>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <566458D1.7020308@xenomai.org>
Date: Sun, 6 Dec 2015 16:48:33 +0100
MIME-Version: 1.0
In-Reply-To: <9606009.fESfxUr9Qo@wirbelwind>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] powerpc 440 userspace latency test does nothing
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: steven.seeger@nasa.gov, xenomai@xenomai.org

On 12/05/2015 07:53 PM, Steven Seeger wrote:
> More info on this.
> 
> timer_gettime() on latency's timerfd returns 0 seconds and 1 nanosecond, 
> indicating the timer has not expired.

This value usually indicates an expired but not yet handled timer shot;
that would match your description of an elapsed timer that did not
trigger the associated action.

-- 
Philippe.

