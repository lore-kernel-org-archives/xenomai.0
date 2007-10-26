Message-ID: <47226EB5.5070604@domain.hid>
Date: Sat, 27 Oct 2007 00:48:21 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: [Xenomai-core] I-pipe/i386 fix for oldish IO-APICs
Reply-To: rpm@xenomai.org
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>, xenomai@xenomai.org


If you happen to use Xenomai on fairly old x86 hardware with the IO-APIC
support enabled, you may want to upgrade your I-pipe version to one of
those listed below.

Symptom: random lockup, more likely under high interrupt load
Cause: mishandling of some hardware erratum affecting some IO-APIC 	
versions (notably v17).

http://download.gna.org/adeos/patches/v2.6/i386/adeos-ipipe-2.6.23-i386-1.10-11.patch
http://download.gna.org/adeos/patches/v2.6/i386/older/adeos-ipipe-2.6.22-i386-1.10-11.patch
http://download.gna.org/adeos/patches/v2.6/i386/older/adeos-ipipe-2.6.20-i386-1.10-10.patch

-- 
Philippe.

