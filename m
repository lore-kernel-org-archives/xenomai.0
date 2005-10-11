Date: Tue, 11 Oct 2005 07:10:02 -0700
From: Steven Seeger <steve@domain.hid>
Message-ID: <BF7115CA.17CC%steve@domain.hid>
Mime-version: 1.0
Content-type: text/plain;
	charset="US-ASCII"
Content-transfer-encoding: 7bit
Subject: [Xenomai-core] rt_timer_ticks2ns
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

In periodic mode, rt_timer_ticks2ns should convert ticks to periodic
jiffies. However, it always seems to return 0.


