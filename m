Message-ID: <4DE4D2F1.20305@domain.hid>
Date: Tue, 31 May 2011 13:37:21 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Fragile lock usage tracking for auto-relax
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai core <Xenomai-core@domain.hid>

Hi Philippe,

enabling XENO_OPT_DEBUG_NUCLEUS reveals some shortcomings of the
in-kernel lock usage tracking via xnthread_t::hrescnt. This BUGON in
xnsynch_release triggers for RT threads:

	XENO_BUGON(NUCLEUS, xnthread_get_rescnt(lastowner) < 0);

RT threads do not balance their lock and unlock syscalls, so their
counter goes wild quite quickly.

But just limiting the bug check to XNOTHER threads is neither a
solution. How to deal with the counter on scheduling policy changes?

So my suggestion is to convert the auto-relax feature into a service,
user space can request based on a counter that user space maintains
independently. I.e. we should create another shared word that user space
increments and decrements on lock acquisitions/releases on its own. The
nucleus just tests it when deciding about the relax on return to user space.

But before hacking into that direction, I'd like to hear if it makes
sense to you.

Jan

-- 
Siemens AG, Corporate Technology, CT T DE IT 1
Corporate Competence Center Embedded Linux

