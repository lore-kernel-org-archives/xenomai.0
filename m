Message-ID: <441E6DDD.7050801@domain.hid>
Date: Mon, 20 Mar 2006 09:54:53 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Xenomai v2.0.4
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


This is the fourth maintenance release of the 2.0 branch. Most of the 
fixes merged since 2.0.3 have been backported from 2.1:

- Generic core fix (domain migration lockup)
- x86 fix (I/O bitmap owner for 2.6.15 and above)
- ia64 fix (signal receipt handling)
- Native API fixes (mutex lock count leakage, event mask update, 
reported heap size).
- Adeos support upgrade for all architectures.

http://download.gna.org/xenomai/stable/xenomai-2.0.4.tar.bz2

-- 

Philippe.

