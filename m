Date: Wed, 23 Dec 2015 19:43:41 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20151223184341.GB3877@hermes.click-hack.org>
References: <2558065.W1DNnPs8ZD@wirbelwind>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2558065.W1DNnPs8ZD@wirbelwind>
Subject: Re: [Xenomai] userspace absolute timer value
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Steven Seeger <steven.seeger@nasa.gov>
Cc: xenomai@xenomai.org

On Wed, Dec 23, 2015 at 01:05:00PM -0500, Steven Seeger wrote:
> All,
> 
> The issue that I had with userspace absolute time to start a timer (what 
> latency test does) was due to a quirk on my board where the powerpc timebase 
> was coming up as 0xdXXXXXXXXXXXXXXX which was causing the 32-bit userland to 
> lose precision when getting the monotonic clock value. The latency test gets 
> the time, adds a millisecond, and uses this time to start the process. However 
> on my machine the time was way off due to the loss of precision. (there were 
> more than 2^32 seconds, but time_t is only 32-bit) On my board adding some 
> code to set the timebase to 0 in head_44x.S and that cleared up all the 
> issues. Everything is working for me now. This appears to be a problem with 
> how cobalt deals with 64-bit ns counters and 32-bit userspace clocks, however 
> I could be missing something.

If I understand correctly, your problem is that struct timespec
tv_sec member has 32 bits. Well, I am afraid there is not much we
can do about that (I heard mainline has a plan to switch to a new
timespec with a 64 bits tv_sec, but I do not know how much of that
plan has been implemented).

Can you not call clock_settime to set a wallclock offset which will
at least allow CLOCK_REALTIME to behave as expected ?

Regards.

-- 
					    Gilles.
https://click-hack.org

