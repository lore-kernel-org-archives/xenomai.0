From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17889.38390.369037.176076@domain.hid>
Date: Sun, 25 Feb 2007 14:58:14 +0100
Subject: Re: [Xenomai-core] Kernel lockup with lapic on old AMD Athlon
In-Reply-To: <45E1641F.1050009@domain.hid>
References: <45E1641F.1050009@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Wolfgang Grandegger <wg@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Wolfgang Grandegger wrote:
 > Hello,
 > 
 > here is the boot log of an hangup of 2.6.20 with I-pipe 1.7-02 and 
 > Xenomai todays trunk. I already reported this hangup a while ago but now 
 > I get an oops. At that time Gilles said that lapic on old Athlons might 
 > be buggy. Does the attached boot log confirm this assumption? 2.6.20-rt8 
 > is working, BTW.

What I had observed with an old Athlon were some random lockups. I was
trying to setup a samba print server at the time, and the lockup always
occured when some windows machine was trying to use the shared printer
through network. I think the IO-APIC was also enabled. Then, at some
later time, I read somewhere on the internet that the IO-APIC or LAPIC
could be buggy on some Athlons, so I understood what had happened to
me. So, I did not investigate this issue any further.

-- 


					    Gilles Chanteperdrix.

