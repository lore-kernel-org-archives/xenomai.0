From: Steven Seeger <steven.seeger@nasa.gov>
Date: Sat, 5 Dec 2015 22:46:40 -0500
Message-ID: <8954471.7jTm9DH39K@wirbelwind>
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

Me again. The issue appears to be that there's a discrepancy between the value 
returned by clock_gettime(CLOCK_MONOTONIC... and the cobalt kernel's internal 
notion of time. Changing latency to start with a 100 nanosecond relative time 
(which adds some constant latency to the expected result since both the 
expected and actual are no longer based on the same point in time) allows it 
to run successfully.

It seems if I telnet into the board and generate too much text on the screen 
the board locks up. I don't know if the board has any thermal cutoff (it gets 
very hot) or if something is wrong with the kernel. I manually patched in some 
vendor code from a 3.6 kernel into the 3.18.20 kernel to use the xenomai patch 
so I could be missing something, too.

I'm not sure if this makes a difference, but here is clock_gettime's returned 
tv_sec and tv_nsec (with a space in the middle) and the line after that is an 
immediate read of ticks: from /proc/xenomai/clock/coreclk:

1582347100 704906148
 ticks: 15136959121354131671

You can see there's an extra digit in the coreclk output compared to what 
comes out of clock_gettime.

I went ahead and used the ipipe-core-3.14.39-powerpc-8 patch and built the 
vendor's 3.14.2 kernel against it. I didn't have to do as much work as I did 
with the 3.18.20 patch. I had the same results (both with latency and with 
freezing.)

At this point I've got the answers I need from this exercise, but it would be 
good to understand the problem and possibly fix it. If anyone can point me in 
the right direction maybe I can take a look at it.

Steven

