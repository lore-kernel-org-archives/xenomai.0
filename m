Message-ID: <OFE7CBFD2B.465864F1-ONC125727B.00390D6E@uk.marconicomms.com>
From: "Markus Osterried" <Markus.Osterried@domain.hid>
Date: Wed, 7 Feb 2007 11:36:28 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Subject: [Xenomai-core] Found bug in pSOS ev_receive()
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

Hello,

in pSOS skin function ev_receive() in file event.c I've found a bug.
When  ev_receive() is called with EV_WAIT and an event is received, the
task is unblocked and everything is okay, then in this case the copy of the
actual received events into *events_r is missing.

Regards
Markus




