Date: Wed, 12 Oct 2005 17:48:05 +0200 (MEST)
From: Sebastian Smolorz <Sebastian.Smolorz@domain.hid>
Subject: Re: [Xenomai-core] Wrong RTDM proc entry prevents xeno_rtdm.ko from
	being loaded
In-Reply-To: <434D2C1A.4050102@domain.hid>
Message-ID: <Pine.GSO.4.58.0510121742360.15047@domain.hid>
References: <Pine.GSO.4.58.0510121715430.6772@domain.hid>
	<434D2C1A.4050102@domain.hid>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED;
	BOUNDARY="-559023410-851401618-1129132085=:15047"
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

---559023410-851401618-1129132085=:15047
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Wed, 12 Oct 2005, Philippe Gerum wrote:

> Sebastian Smolorz wrote:
> > Hi,
> >
> > today I discovered a bug after having tried to load the Xenomai RTDM skin.
> > I've attached a patch which should correct the problem.

... and if we want to have a clean removal of the proc entry at module
unload, this next patch is very useful! ;-)

Sebastian
---559023410-851401618-1129132085=:15047
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="rtdm_proc_entry_2.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.GSO.4.58.0510121748050.15047@domain.hid>
Content-Description: 
Content-Disposition: attachment; filename="rtdm_proc_entry_2.patch"

LS0tIHhlbm9tYWkvc2tpbnMvcnRkbS9wcm9jLmMJMjAwNS0xMC0xMiAxNzoz
NTo0Mi4wMDAwMDAwMDAgKzAyMDANCisrKyBwcm9jLmMJMjAwNS0xMC0xMiAx
NzozMTowOS4wMDAwMDAwMDAgKzAyMDANCkBAIC0zMjIsNyArMzIyLDcgQEAg
dm9pZCBydGRtX3Byb2NfY2xlYW51cCh2b2lkKQ0KICAgICByZW1vdmVfcHJv
Y19lbnRyeSgib3Blbl9maWxkZXMiLCBydGRtX3Byb2Nfcm9vdCk7DQogICAg
IHJlbW92ZV9wcm9jX2VudHJ5KCJwcm90b2NvbF9kZXZpY2VzIiwgcnRkbV9w
cm9jX3Jvb3QpOw0KICAgICByZW1vdmVfcHJvY19lbnRyeSgibmFtZWRfZGV2
aWNlcyIsIHJ0ZG1fcHJvY19yb290KTsNCi0gICAgcmVtb3ZlX3Byb2NfZW50
cnkoIlhlbm9tYWkvcnRkbSIsIE5VTEwpOw0KKyAgICByZW1vdmVfcHJvY19l
bnRyeSgieGVub21haS9ydGRtIiwgTlVMTCk7DQogfQ0KIA0KICNlbmRpZiAv
KiBDT05GSUdfUFJPQ19GUyAqLw0K

---559023410-851401618-1129132085=:15047--

