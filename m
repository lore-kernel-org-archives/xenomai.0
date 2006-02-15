Date: Wed, 15 Feb 2006 07:20:11 -0800
From: Steven Seeger <steve@domain.hid>
Message-ID: <C01886AB.23C1%steve@domain.hid>
Mime-version: 1.0
Content-type: text/plain;
	charset="US-ASCII"
Content-transfer-encoding: 7bit
Subject: [Xenomai-help] atomic_t in userspace
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

I just upgraded to the latest SVN after a few months of hiatus, and my
userspace app that used atomic_t through nucleus/asm/atomic.h no longer
works. It says it can't find atomic_t, and it seems that all the atomic
operations have been put inside a kernel only #if. Is there another way to
use atomics in my shadowed threads from userspace? Is there any equivalent?

Steven


