Date: Mon, 4 Dec 2006 16:37:17 +0300
Message-ID: <20061204133717.GA20186@domain.hid>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
From: Anthony Sharobaiko <anthony@domain.hid>
Subject: [Xenomai-help] Xenomai install problems
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Hi!

I try to get Xenomai running on arm (PXA board). Currently everything compiles perfectly, but testsuite examples simply segfault:
=== cut here ===
root@domain.hid# ./run 
*
*
* Type ^C to stop this application.
*
*
/usr/xenomai/bin/xeno-load: line 247:  1139 Segmentation fault
$suflag $* $cmdargs
=== cut here ===

I use 2.6.16.29 kernel with ipipe-2.6.15-1.5-03. Some hunks were applied by hand, 
but I'm sure that IPIPE works (I've used: http://www.mail-archive.com/adeos-main@gna.org to check).

Also, Xenomai (built into kernel) successfully registers domain:
=== cut here ===
root@domain.hid# cat Xenomai 
Invariant head, Id=0x58454e4f
irq0-25: passed
irq26: wired
irq27-191: passed
irq192-193: passed, virtual
irq194: wired, virtual
=== cut here ===

Where should I dig to get a working testsuite? =)

-- 
	WBR, Anthony Sharobaiko.


