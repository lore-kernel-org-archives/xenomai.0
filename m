From: Philippe Gerum <rpm@xenomai.org>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 01 Jan 2010 12:00:52 +0100
Message-ID: <1262343652.19080.526.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Xenomai v2.5.0
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org


Here is Xenomai 2.5.0.

The most notable change in the Xenomai core since the 2.4.x series, is
the introduction of an extensible scheduler framework. This provides a
common interface for adding new real-time scheduling classes. Aside of
the original FIFO and RR ones, this framework supports two new
classes:

	* a time partitioning policy (TP, typically usable for
	  implementing the arinc653 spec).

	* the POSIX sporadic server policy (PSS).

Performance-wise, 2.5.0 brings three major updates (and a number of
smaller optimizations all over the map too):

	* fast real-time mutexes in user-space. Just like with
	  mainline kernel futexes, mutual exclusion in primary mode
	  can now be obtained without any system call most of the
	  time. The POSIX and native Xenomai APIs use them.

	* tunable unlocked context switching, as a way to
	  significantly reduce interrupt latency when required. By
	  allowing real-time IRQs to preempt both the Linux kernel and
	  the Xenomai core safely while any of them performs a context
	  switch, the interrupt latency is significantly improved for
	  some architectures, like armv4/armv5, as they must bear the
	  VIVT cache affliction.

	* a new set of 64/96 bit arithmetics, optimized
          per-architecture, have been introduced. Because they are
          involved in various time-critical operations, the
          performance gain is noticeable on low end platforms.
	
Most APIs have been extended in a way or another. POSIX, native,
VxWorks, RTDM got new services or features, to better support
developers.

The existing RTDM driver set got its share of updates as well, such as
the CAN layer. 2.5.0 also introduces a real-time IPC driver,
implementing various socket-based protocols, for exchanging data
between Xenomai threads and regular Linux tasks, or within the Xenomai
domain.

The largest piece of work merged in 2.5.0 is without any doubt the
Analogy framework. This is a lively DAQ framework based on RTDM, with
a short migration path offered for rebasing Comedi drivers over a
modern infrastructure. Ultimately, Analogy over RTDM will allow us to
run all of our DAQ drivers over a mainline kernel as well.

And finally, 2.5.0 brings in a nios2 port. This makes Xenomai 2.5.0
available for seven architectures:

     * ARM
     * Blackfin
     * Nios2
     * PowerPC 32/64
     * x86 32/64

One more thing, Gilles is the release maintainer for the 2.5.x series,
and will be in charge of keeping the maintenance cycle alive for this
one. This will allow me to focus on 3.x.

http://download.gna.org/xenomai/stable/xenomai-2.5.0.tar.bz2

Happy new year, btw.

-- 
Philippe.



