MIME-Version: 1.0
Date: Mon, 4 Apr 2011 15:22:50 -0400
Message-ID: <BANLkTi=QSd8qm6jwQKB3mZLwTsmp1t7phw@domain.hid>
From: Eric Eric <ericrebates@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Xenomai-help] commercial users of xenomai, commercial support, JTAG
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Hello, in the course of evaluating migration from Integrity to
Xenomai, a few questions have come up that I am having a hard time
finding info on:

- Are there any examples of commercial projects that use Xenomai?  I'm
specifically looking for propaganda like this RTEMS flier:
http://www.rtems.com/sites/default/files/RTEMS-Users-V2.pdf

- Are there any companies offering commercial support services for
Xenomai, such as FSMLabs does for RTLinux or OAR does for RTEMS?

- Can Xenomai kernel-level tasks be debugged via JTAG?  Although we
would do most of our work in user-tasks, there is a non-trivial part
that is highly latency sensitive and will need to go in the kernel
(bearing in mind GPL compliance of course).  There is concern that
this could be problematic to debug.  We sometimes use a Blackhawk JTAG
with TI CodeComposer to debug Linux drivers.

I think it was asked before, but we are using ARM.

Thanks.

- Eric

