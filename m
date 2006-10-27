Message-ID: <54823def0610261823n4c24b6bal31afd74f3e0d962e@domain.hid>
Date: Fri, 27 Oct 2006 11:23:30 +1000
From: "Andrew Dennison" <andrewd.lists@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_40368_5954836.1161912210122"
Subject: [Xenomai-core] [PATCH] prepare-kernel.sh breaks linux-2.4
	drivers/Makefile
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

------=_Part_40368_5954836.1161912210122
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Running prepare-kernel on the denx 2.4 kernel adds the following line

mod-subdirs := xenomai

This prevents all other mod-subdirs under drivers from building.

Patch is against r1273 but still seems to apply (and be required) on head.

Andrew

------=_Part_40368_5954836.1161912210122
Content-Type: text/x-diff; name=linux_2.4_driver_modules.patch; 
	charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_etrw8md1
Content-Disposition: attachment; filename="linux_2.4_driver_modules.patch"

ZGlmZiAtLWdpdCBhL3NjcmlwdHMvcHJlcGFyZS1rZXJuZWwuc2ggYi9zY3JpcHRzL3ByZXBhcmUt
a2VybmVsLnNoCmluZGV4IGZiYzkxY2UuLmNhODdlN2YgMTAwNzU1Ci0tLSBhL3NjcmlwdHMvcHJl
cGFyZS1rZXJuZWwuc2gKKysrIGIvc2NyaXB0cy9wcmVwYXJlLWtlcm5lbC5zaApAQCAtNDU1LDcg
KzQ1NSw3IEBAIEVPRgogCXBhdGNoX2VkIGRyaXZlcnMvTWFrZWZpbGUgPDxFT0YKIC9pbmNsdWRl
IFwkKFRPUERJUilcL1J1bGVzLm1ha2UKIGkKLW1vZC1zdWJkaXJzIDo9IHhlbm9tYWkKK21vZC1z
dWJkaXJzICs9IHhlbm9tYWkKIHN1YmRpci1cJChDT05GSUdfWEVOT01BSSkgKz0geGVub21haQog
CiAuCg==
------=_Part_40368_5954836.1161912210122--

