Resent-To: xenomai-core <xenomai@xenomai.org>
Resent-Message-Id: <48BBB22E.2000102@domain.hid>
Message-ID: <48BBA9E6.5070400@domain.hid>
Date: Mon, 01 Sep 2008 10:53:50 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] [PATCH 0/9] Fast mutex rework, native support
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

Here comes our current patch series to fix and enhance fast mutexes for
both the POSIX as well as the native skin. After the long discussion on
this list, it is clear that this is not the last word. However, we are
currently not aware of regressions or still broken corner cases, so this
series may at least serve as a reference for future versions.

Patches 1-4 should already be mergeable. They introduce handle-based
owner tracking for the fast locks and clean up some code.

Patch 5 adds lock stealing support to pthread_mutex_trylock (something
that the glibc does not provide, BTW...). It "misuses"
xnsynch_sleep_on(..., XN_NONBLOCK) for this, but reuses a lot of code
this way. To compensate for the overhead if this path, patch 9 optimizes
xnsynch_sleep_on for XN_NONBLOCK users. Take this as a reference for one
of the three possible approaches. Another one, some dedicated
xnsynch_try_acquire (or so), may later be examined as well so that we
can compare pros and cons. But first the third one, lock stealing via
fast locks, should be analyzed /wrt feasibility.

Patch 6 is an intermediate helper to break out of the lock stealing loop
in xnsynch_sleep_on (XNSYNCH_FWDROB). Patch 7 applies it on the POSIX
skin, overcoming the duplicated sleeper tracking. XNSYNCH_FWROB will be
obsolete once we merge fast lock support into xnsynch.

Patch 8 introduces fast mutexes to the native skin. This approach is
built upon the same mechanisms as the POSIX skin (XNSYNCH_FWROB, trylock
via xnsynch_sleep_on) to compare both implementations. The reason for
differences is mostly the simpler native API. It passes an analogous
test case like Gilles wrote for POSIX (augmented with lock stealing
tests). The testsuite will be posted later after some refactoring work.

Feedback welcome.

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux



