From: Paul <paul_c@domain.hid>
Date: Wed, 4 Apr 2007 23:34:13 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200704042334.13738.paul_c@domain.hid>
Subject: [Xenomai-core] missing native/ppd.h header
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


Hi Philippe

 Just tried to compile from r2361 in trunk, but `make dist` is failing due to 
include/native/ppd.h not present - Perusing the change logs, I see ppd.h was 
included in several native sources in r2361.. Should the reference be to 
nucleus/ppd.h or was the header missed out during a commit ?


Regards, Paul.

