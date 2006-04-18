Message-ID: <444510DB.6030704@domain.hid>
Date: Tue, 18 Apr 2006 12:16:27 -0400
From: Jim Cromie <jim.cromie@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] /proc/cpuinfo missing sep - closure
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

just to follow up:

I built a xeno-kernel for my laptop, the sep flag was on,
so it was Fedora specific.  I asked on fedora-list,
got this answer:


 > This is pretty obscure, and I havent seen any problems because of it,
 > but it is a bit odd.
 > 
 > Can someone(s)
 > - confirm its absence on  2.6.16-1.2069_FC4 or other
 > - check their FC-5 /proc/cpuinfo, and report back.
 > - explain why this is a good thing, or how it might have happened 
 > accidentally ?

SEP is incompatible with segment-based NX emulation provided
by exec-shield in the Fedora kernel.

The reason for this is that a SYSRET resets the segment limits.




I presume this distinction is well hidden inside glibc etc..


