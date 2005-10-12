Date: Wed, 12 Oct 2005 17:23:43 +0200 (MEST)
From: Sebastian Smolorz <Sebastian.Smolorz@domain.hid>
Message-ID: <Pine.GSO.4.58.0510121715430.6772@domain.hid>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-851401618-1129130623=:6772"
Subject: [Xenomai-core] Wrong RTDM proc entry prevents xeno_rtdm.ko from
	being loaded
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@domain.hid for more info.

---559023410-851401618-1129130623=:6772
Content-Type: TEXT/PLAIN; charset=US-ASCII

Hi,

today I discovered a bug after having tried to load the Xenomai RTDM skin.
I've attached a patch which should correct the problem.

Sebastian
---559023410-851401618-1129130623=:6772
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="rtdm_proc_entry.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.GSO.4.58.0510121723431.6772@domain.hid>
Content-Description: 
Content-Disposition: attachment; filename="rtdm_proc_entry.patch"

LS0tIHhlbm9tYWkvc2tpbnMvcnRkbS9wcm9jLmMJMjAwNS0xMC0xMiAxNjo1
ODo0OC4wMDAwMDAwMDAgKzAyMDANCisrKyBwcm9jLmMJMjAwNS0xMC0xMiAx
NzowMDo1OS4wMDAwMDAwMDAgKzAyMDANCkBAIC0yODUsNyArMjg1LDcgQEAg
aW50IF9faW5pdCBydGRtX3Byb2NfaW5pdCh2b2lkKQ0KIA0KIA0KICAgICAv
KiBJbml0aWFsaXNlIC9wcm9jIGVudHJpZXMgKi8NCi0gICAgcnRkbV9wcm9j
X3Jvb3QgPSBjcmVhdGVfcHJvY19lbnRyeSgiWGVub21haS9ydGRtIiwgU19J
RkRJUiwgTlVMTCk7DQorICAgIHJ0ZG1fcHJvY19yb290ID0gY3JlYXRlX3By
b2NfZW50cnkoInhlbm9tYWkvcnRkbSIsIFNfSUZESVIsIE5VTEwpOw0KICAg
ICBpZiAoIXJ0ZG1fcHJvY19yb290KQ0KICAgICAgICAgcmV0dXJuIC1FQUdB
SU47DQogDQo=

---559023410-851401618-1129130623=:6772--

