Message-ID: <4739E07B.1000608@domain.hid>
Date: Tue, 13 Nov 2007 18:35:55 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: [Xenomai-core] Xenomai v2.4-rc6
Reply-To: rpm@xenomai.org
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>, xenomai-help <xenomai@xenomai.org>


Here is the sixth candidate release for the v2.4.x branch.

	[nucleus]

	* LTT support overhaul.
	* Fix select() breakage with message pipes.
	* Return EOF condition to the real-time side when the Linux
          peer closes the message pipe.

	[i386, x86_64 => x86]

	* Merge i386 and x86_64 arch-dep support as x86.
 	* Update Adeos/i386 support for 2.6.20, 2.6.22 and 2.6.23.

	[posix]

	* Fix pthread_cond_*wait() handling of signal receipt.

	[native]

	* Fix API for requesting I/O regions; add support for IOMEM
          space. See API.CHANGES for more.
	* Allow rt_task_inquire() to only probe for the existence of a
          task.
	
	[psos]

	* Provide tm_getc() service to get the count of elapsed
          ticks for the pSOS timebase.

	[rtai]

	* Set up default CPU affinity for tasks.
	* Fix shared memory allocation for small heap sizes.

http://download.gna.org/xenomai/testing/xenomai-2.4-rc6.tar.bz2

-- 
Philippe.

