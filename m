From: Steven Seeger <steven.seeger@nasa.gov>
Date: Sat, 5 Dec 2015 15:03:54 -0500
Message-ID: <9180795.7oqRbDLesy@wirbelwind>
In-Reply-To: <6309036.vrZ57LHtHK@wirbelwind>
References: <6309036.vrZ57LHtHK@wirbelwind>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Subject: Re: [Xenomai] powerpc 440 userspace latency test does nothing
Reply-To: steven.seeger@nasa.gov
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Another piece of info for you. I changed the latency absolute start time from 
1ms to 10 seconds. I see the correct value in __cobalt_timer_setval() but cat 
/proc/xenomai/timer/coreclk never shows any value for TIMEOUT for the 
timerfd_handler.

It's almost like the timer never really starts.

Steven

