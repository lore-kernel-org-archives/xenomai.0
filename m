From: NZG <ngustavson@domain.hid>
Date: Fri, 4 May 2007 16:30:39 -0500
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200705041630.40004.ngustavson@domain.hid>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] killing a rt task and closing a rtdm fd
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

I've got a user space app that starts a periodic real time task.
The periodic task opens an rtdm file descriptor and starts writing to it in a 
loop.

At some point, due to user interaction,  the task needs to be killed and the 
file descriptor closed.

What's the easiest way to signal it to do so? Anyone have some example code 
they can point at?

I looked through the native docs and the examples at
http://www.captain.at/xenomai.php
and
http://svn.gna.org/svn/xenomai/trunk/examples/rtdm/driver-api/

but they don't appear to address this.

The captains example uses a global variable, but this doesn't actually seem to 
work.

I suspect the task is operating on a copied set of variables, so some sort of 
message passing is going to be involved, but I don't want to slow down the 
main task to wait for a message.

thank you,
NZG

