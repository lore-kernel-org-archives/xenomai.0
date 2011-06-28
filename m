Message-ID: <4E099E67.6080100@domain.hid>
Date: Tue, 28 Jun 2011 11:27:03 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8bit
Subject: [Xenomai-help] FYI: I-pipe incompatible with
	CONFIG_TRANSPARENT_HUGEPAGE
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: adeos-main <adeos-main@gna.org>
Cc: Xenomai-help@domain.hid

Just a heads up in case someone runs 2.6.38 on archs with support for
huge page table entries (like x86): ipipe_disable_ondemand_mappings so
far lacks support for transparent huge pages. So you should disable that
feature (CONFIG_TRANSPARENT_HUGEPAGE) until we have fixed it. That
shouldn't be difficult, but I'm currently hunting a different bug while
coming across this one.

Jan

-- 
Siemens AG, Corporate Technology, CT T DE IT 1
Corporate Competence Center Embedded Linux

