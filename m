From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <45213A36.3010003@domain.hid>
References: <451AEEED.1050708@domain.hid> <451B0978.5020108@domain.hid>
	<451BD6FC.9080205@domain.hid> <451BDADC.30101@domain.hid>
	<1159454661.4982.20.camel@domain.hid> <451C0171.3020508@domain.hid>
	<1159475242.4982.46.camel@domain.hid> <1159475501.4982.49.camel@domain.hid>
	<451D18B2.3060007@domain.hid> <1159537448.4964.8.camel@domain.hid>
	<45213A36.3010003@domain.hid>
Content-Type: text/plain
Date: Sat, 14 Oct 2006 23:54:03 +0200
Message-Id: <1160862844.5151.18.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Adeos + CONFIG_PCI_MSI issue
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
To: adeos-main@gna.org
Cc: andza@domain.hid, "J.D. Yamokoski" <yamokosk@domain.hid>, xenomai@xenomai.org


People having problems booting recent Adeos-patched kernels, and
particularly with CONFIG_SMP/CONFIG_PCI_MSI enabled, may want to try
this new Adeos release, which fixes an issue in the IO-APIC support:
http://download.gna.org/adeos/patches/v2.6/i386/adeos-ipipe-2.6.17-i386-1.5-00.patch

Feedback welcome.

-- 
Philippe.



