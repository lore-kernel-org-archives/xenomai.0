From: Wolfgang Denk <wd@domain.hid>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 8bit
Date: Fri, 21 Mar 2008 00:11:19 +0100
Sender: wd@domain.hid
Message-Id: <20080320231119.631D924A87@domain.hid>
Subject: [Xenomai-core] Xenomai/SOLO - RTOS emulation for standard Linux
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: ag-automation@domain.hid, xenomai@xenomai.org
Cc: OSADL Members <members@domain.hid>

Hello all,

DENX Software Engineering is proud to announce Xenomai/SOLO, the new
RTOS emulator that runs as a normal user-space application on a
standard Linux kernel. Of course, when timing requirements have to be
met, a real-time capable Linux kernel with the PREEMPT_RT support
enabled should be used.

Philippe Gerum, the author of the code, writes:

    Some weeks ago, I started laying the groundwork for porting the
    Xenomai emulators natively over the PREEMPT_RT kernel. Unlike the
    co-kernel based Xenomai version, SOLO does not require any kernel
    support from additional modules or patches. It is fully based on
    the standard POSIX library, and runs as a regular process
    controlled by a single image Linux kernel.

    As a first step, a VxWorks emulator has just been rebuilt over
    this new framework.

    This framework is not another window-dressing of the existing
    Xenomai 2.x core, but really something 100% redesigned and
    rewritten for running on a native real-time Linux implementation,
    while keeping the opportunity to adapt it back to a co-kernel
    system. At some point, I'd like to make both the native and
    co-kernel Xenomai incarnations converge on the basis of this new
    core interface for Xenomai 3, so that we would be able to share
    the APIs between them. In short, SOLO is a necessary intermediate
    step on the road to Xenomai 3.

This work has been co-sponsored by the OSADL (http://www.osadl.org)
and DENX Software Engineering (http://www.denx.de).

For details, please see the README at
http://www.denx.de/cgi-bin/gitweb.cgi?p=xenomai-solo.git;a=blob;f=README

You can pull the whole code from
git://www.denx.de/git/xenomai-solo.git  resp.
http://www.denx.de/git/xenomai-solo.git  or browse it at
http://www.denx.de/cgi-bin/gitweb.cgi?p=xenomai-solo.git;a=summary


Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@domain.hid
Quote from the Boss... "I didn't say it was your fault.  I said I was
going to blame it on you."

