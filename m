Resent-To: xenomai-core <xenomai@xenomai.org>
Resent-Message-Id: <49513798.90507@domain.hid>
From: Jan Kiszka <jan.kiszka@domain.hid>
Date: Tue, 23 Dec 2008 20:06:49 +0100
Message-ID: <20081223190649.26094.61372.stgit@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [PATCH v2 0/5] NMI watchdog fixes / enhancements
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

Changes since last round:
 - Fix build breakage of trunk against 2.6.27
 - Make rthal_nmi_release more robust (additional patch)
 - Fix issue of last patch on 32 bit (untested last-minute changes...)

All patches are also available at
git://git.kiszka.org/xenomai.git nmi-wd-queue

Jan

