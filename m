Message-ID: <4B8D55AD.9090901@domain.hid>
Date: Tue, 02 Mar 2010 19:15:09 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Posix mutex unit test fails on git head
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

Gilles,

can you (or someone else) confirm this:

# mutex-torture-posix
simple_wait
simple mutex_lock 1: 1 (Operation not permitted)

I'm on a x86_64 target (2.6.32.8 with latest I-pipe), Xenomai is
unpatched git head.

[ But I'm currently facing general stability issues with 2.6.32 again.
And sigtest is failing loudly here, typically hard lockups. Ugh. ]

Jan

-- 
Siemens AG, Corporate Technology, CT T DE IT 1
Corporate Competence Center Embedded Linux

