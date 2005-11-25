Message-ID: <001401c5f1a5$872f2980$06000100@domain.hid>
From: "Marco Cavallini" <rtai@domain.hid>
Date: Fri, 25 Nov 2005 10:47:49 +0100
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="Windows-1252";
	reply-type=original
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] fusion and its stack limit
Reply-To: Marco Cavallini <rtai@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Xenomai-core@domain.hid

Hi,
with fusion-0.9.1 and VxWorks skin
I am testing the creation of 255 different tasks each with a different 
priority
level from 0 to 254.
I am facing to a problem creating more than 12 tasks with taskSpawn
after creating 12 tasks the program fails into thread.c
in function xnthread_init()
at call xnarch_alloc_stack()
returning -ENOMEM.

Can I increase the stack for fusion (and how) ?
TIA

Marco Cavallini
Koan s.a.s. - Bergamo - ITALIA
Embedded and Real-Time Software Engineering
www.koansoftware.com    |    www.klinux.org


