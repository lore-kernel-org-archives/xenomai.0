Message-ID: <43C8D3E8.10702@domain.hid>
Date: Sat, 14 Jan 2006 11:35:20 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Xenomai v2.0.3
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


This is a maintenance release for the stable branch, which incorporates a few but
significant upgrades and fixes backported from the v2.1 testing branch. Mainly,

- A major bug fix regarding the hybrid scheduling feature, i.e. the ability to
make transitions between kernel-based and user-space Xenomai threads. Basically
all archs are concerned by this fix, but x86 which had no problem regarding this
issue.

- Support for 2.6.15/x86. Other archs will follow.

- Upgrade to the most recent I-pipe series for all archs.

- Fix for the ppc64 FPU preemption bug.

- A few fixes in RTDM and the native skin.

See the ChangeLog for details as usual.

http://download.gna.org/xenomai/stable/xenomai-2.0.3.tar.bz2

-- 

Philippe.


