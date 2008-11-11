Message-ID: <4919D652.1090901@domain.hid>
Date: Tue, 11 Nov 2008 20:00:34 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Xenomai v2.4.6.1
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
To: xenomai-core <xenomai@xenomai.org>
Cc: xenomai-help <xenomai@xenomai.org>


As a card-carrying all time member of the brown-paper-bag cohort, I released a
terminally messed up I-pipe patch for 2.6.27/x86 (2.1-01), as part of Xenomai
2.4.6. This  bug affects most uniprocessor configurations, both for x86_32 and
64bit archs.

Xenomai 2.4.6 can be fixed using the following drop in replacement for the
bugous I-pipe patch:
http://download.gna.org/adeos/patches/v2.6/x86/adeos-ipipe-2.6.27-x86-2.1-02.patch

Otherwise, you may just want to download Xenomai 2.4.6.1 instead, which does
include the fixed I-pipe patch.
http://download.gna.org/xenomai/stable/xenomai-2.4.6.1.tar.bz2

-- 
Philippe.

