Message-ID: <51D95573.4020308@xenomai.org>
Date: Sun, 07 Jul 2013 13:48:03 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1373196748.98256.YahooMailNeo@web172204.mail.ir2.yahoo.com>
In-Reply-To: <1373196748.98256.YahooMailNeo@web172204.mail.ir2.yahoo.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] Problem with shared memory (no entry in /dev/shm)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Franz Engel <franz_lambert_engel@yahoo.de>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Le 07/07/2013 13:32, Franz Engel a écrit :
> Hi,
> 
> Currently I'm upgrading my system to Xenomai 2.6.2.1 and the Linux
> kernel 3.5.7. Everything looks fine. I see the services starting in
> the dmesg and the latency test runs without problems (besides some
> high latencies :-)). But I have a problem with the shared memory.
> When I run my project in the old system, everything works fine and I
> saw an entry in /dev/shm. With my new system I get segmentations
> faults when I try to write to the shared memory I created. Futhermore
> I have no entries in /dev/shm. If I compile the code (in my cmake
> file it is possible to change between "normal" compiling and
> compiling with xenomai) without xenomai everything works good and I
> get an entry in /dev/shm. Does somebody else have the same problems
> with the shared memory in the new xenomai version or is something
> wrong with my code. Here is a small example with the corresponding
> cmake-file (I get no errors):

The difference comes from the kernel configuration: if you have xenomai
posix shared memory enabled in xenomai configuration, these one are
used, and they do not appear in /dev/shm but in /proc/xenomai/heaps.

As for the error with xenomai skin posix shared memory I will run your
sample program to see if I can reproduce it, but would need a bit more
information:
what version of the I-pipe patch do you use?
is running the example you posted sufficient, or do I have to add a call
to mmap and a write to the mmaped area to reproduce the bug?


-- 
Gilles.

