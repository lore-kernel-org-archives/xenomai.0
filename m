From: Lowell Gilbert <kludge@be-well.ilk.org>
Date: Tue, 07 Jan 2014 14:52:54 -0500
Message-ID: <44lhyrmuw9.fsf@be-well.ilk.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Xenomai] Altera Cyclone V
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi. 

I'm starting out trying to get Xenomai running on the ARM cores in the
"golden reference design" for the Cyclone V SOC from Altera. So far, I'm
still working on getting a kernel booting with the ipipe support, and I
could use a hand. If anyone's already worked with this system, or if I
definitely can't get under 10-microsecond latency with core affinity
keeping my second core clear of non-real-time processing, I'd appreciate
a word.

I'm trying to do this on a 3.10 Linux kernel, because going back much
further will give me problems with backporting some of the peripheral
support. I may try 3.8 to see what happens, but I really can't go any
earlier than 3.6 in any case.

This chip contains a Cortex A9 dual-core ARM system. (It's really not
practical to do anything other than having Linux run on both cores; if I
could run bare-metal on one, I would.) I figured it shouldn't be too
different to use the TSC than on other Cortex A9 chips.

What I'm hitting at the moment is that gt_setup() is getting called, 
but twd_timer_setup() hasn't run yet, so the frequency isn't set yet. 
Both functions are in __cpuinit, and the file would be used the same for
other chips containing the Cortex A9, so I'm confused about what might
be wrong.

Any pointers would be appreciated.

Thanks.

Be well.
        Lowell Gilbert

