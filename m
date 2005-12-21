Date: Wed, 21 Dec 2005 15:10:12 -0500
From: Kent Borg <kentborg@domain.hid>
Message-ID: <20051221151012.W16178@domain.hid>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Xenomai-help] Shared Memory, check. Fifos...
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Thanks to help from the list, I now know how to use shared memory
between a realtime userland process and a regular userland process.
Way cool!

Next, how do I do a fifo that gets written from RT userland and read
from regular userland?  Just a regular Linux mkfifo, opens, writes,
etc?  (Any special locking issues?  How do I control and deal with
buffer limits?)


Thanks,

-kb, the Kent who is getting the hang of it.

