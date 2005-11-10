Date: Thu, 10 Nov 2005 17:07:16 +0100 (MET)
From: Sebastian Smolorz <Sebastian.Smolorz@domain.hid>
Message-ID: <Pine.GSO.4.58.0511101656220.6569@domain.hid>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-959030623-1131638836=:6569"
Subject: [Xenomai-core] Patch for RTDM recvmsg bug
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

---559023410-959030623-1131638836=:6569
Content-Type: TEXT/PLAIN; charset=US-ASCII

Hi,

here's a patch for a bug in skins/rtdm/syscall.c. The msghdr was not
copied to user space upon completion of a recvmsg() call if the return
value was not equal to zero. But recvmsg shall return the length of the
message in bytes (according to IEEE Std 1003.1).

I have the permission from Jan to patch his code. ;-)


Sebastian
---559023410-959030623-1131638836=:6569
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="rtdm_syscall_recvmsg.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.GSO.4.58.0511101707160.6569@domain.hid>
Content-Description: 
Content-Disposition: attachment; filename="rtdm_syscall_recvmsg.patch"

LS0tIHhlbm9tYWkvc2tpbnMvcnRkbS9zeXNjYWxsLmMJMjAwNS0xMS0xMCAx
Njo0NToyNC4wMDAwMDAwMDAgKzAxMDANCisrKyBzeXNjYWxsLmMJMjAwNS0x
MS0xMCAxNjoyNzowOC4wMDAwMDAwMDAgKzAxMDANCkBAIC05OSw3ICs5OSw3
IEBAIHN0YXRpYyBpbnQgc3lzX3J0ZG1fcmVjdm1zZyhzdHJ1Y3QgdGFza18N
CiANCiAgICAgcmV0ID0gX3J0ZG1fcmVjdm1zZyhjdXJyLCBfX3huX3JlZ19h
cmcxKHJlZ3MpLCAma3JubF9tc2csDQogICAgICAgICAgICAgICAgICAgICAg
ICAgX194bl9yZWdfYXJnMyhyZWdzKSk7DQotICAgIGlmICghcmV0KQ0KKyAg
ICBpZiAocmV0ID49IDApDQogICAgICAgICBfX3huX2NvcHlfdG9fdXNlcihj
dXJyLCAodm9pZCBfX3VzZXIgKilfX3huX3JlZ19hcmcyKHJlZ3MpLCAma3Ju
bF9tc2csDQogICAgICAgICAgICAgICAgICAgICAgICAgICBzaXplb2Yoa3Ju
bF9tc2cpKTsNCiANCg==

---559023410-959030623-1131638836=:6569--

