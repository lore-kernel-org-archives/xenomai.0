Resent-To: xenomai-core <xenomai@xenomai.org>
Resent-Message-Id: <48F8B484.8080803@domain.hid>
Message-Id: <20081017154559.420723261@domain.hid>
Date: Fri, 17 Oct 2008 17:45:59 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
Subject: [Xenomai-core] [PATCH 00/13] Generic fast xnsynch support & more
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

Hopefully the last round, addressing remarks brought up on the last
posting. The changes are:

[Patches 7-9]
 - define xnsynch_owner_check as xnsynch-implementation-independent way
   to check provided and current synch owner match (reduces #ifdefs)

[Patches 6 and 9]
 - push lockcnt changes to native mutexes into separate patch (patch

[Patch 2]
 - switch creation of xeno_current_key etc. from pthread_once to a
   constructor
 - translate pthread_getspecific == NULL into XN_NO_HANDLE
   (funnily, this shrinks the code on x86-64)

[Patch 13]
 - detect SMP feature inconsistency between kernel and userland
   (but keep SMP off by default for now)

Note that this series (as well as the latter) depends on the VRTX fix of
Philippe which is not yet merged into SVN trunk.

Jan

PS: Hope this series is compatible with more mail clients /wrt
commenting on the inlined patches.

--
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux


