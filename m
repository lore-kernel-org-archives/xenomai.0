From: Steven Seeger <steven.seeger@nasa.gov>
Date: Wed, 23 Dec 2015 13:05:00 -0500
Message-ID: <2558065.W1DNnPs8ZD@wirbelwind>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Subject: Re: [Xenomai] userspace absolute timer value
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

All,

The issue that I had with userspace absolute time to start a timer (what 
latency test does) was due to a quirk on my board where the powerpc timebase 
was coming up as 0xdXXXXXXXXXXXXXXX which was causing the 32-bit userland to 
lose precision when getting the monotonic clock value. The latency test gets 
the time, adds a millisecond, and uses this time to start the process. However 
on my machine the time was way off due to the loss of precision. (there were 
more than 2^32 seconds, but time_t is only 32-bit) On my board adding some 
code to set the timebase to 0 in head_44x.S and that cleared up all the 
issues. Everything is working for me now. This appears to be a problem with 
how cobalt deals with 64-bit ns counters and 32-bit userspace clocks, however 
I could be missing something.

Steven


