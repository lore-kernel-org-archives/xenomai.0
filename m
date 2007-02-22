Message-ID: <54823def0702221541l574a6eb9v1bb61dfd68395986@domain.hid>
Date: Fri, 23 Feb 2007 10:41:45 +1100
From: "Andrew Dennison" <andrewd.lists@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_32449_33411013.1172187705764"
Subject: [Xenomai-core] [PATCH] Bogus conversion to ns in
	rt_task_make_periodic() emulation
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Xenomai-core@domain.hid

------=_Part_32449_33411013.1172187705764
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

The RTAI function rt_task_make_periodic() takes absolute ticks as the
start_time argument, however this was being compared to ns in the RTAI
emulation layer.

This patch fixes this, and also removes '+ period' as this seems wrong
with the way xnpod_set_thread_periodic() works.

Patch is against r1717 so it won't apply directly to head, but the
same logical bug seems to exist there?

------=_Part_32449_33411013.1172187705764
Content-Type: text/x-patch; name=rtai_task.c.diff; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_eyhu8su3
Content-Disposition: attachment; filename="rtai_task.c.diff"

ZGlmZiAtLWdpdCBhL2tzcmMvc2tpbnMvcnRhaS90YXNrLmMgYi9rc3JjL3NraW5zL3J0YWkvdGFz
ay5jCmluZGV4IDFmNGNkMmMuLjM0MjZhZWQgMTAwNjQ0Ci0tLSBhL2tzcmMvc2tpbnMvcnRhaS90
YXNrLmMKKysrIGIva3NyYy9za2lucy9ydGFpL3Rhc2suYwpAQCAtMjcyLDcgKzI3Miw3IEBAIGlu
dCBydF90YXNrX21ha2VfcGVyaW9kaWMoUlRfVEFTSyAqdGFzaywgUlRJTUUgc3RhcnRfdGltZSwg
UlRJTUUgcGVyaW9kKQogCQlnb3RvIHVubG9ja19hbmRfZXhpdDsKIAl9CiAKLQlpZiAoc3RhcnRf
dGltZSArIHBlcmlvZCA8PSB4bnBvZF90aWNrczJucyh4bnBvZF9nZXRfdGltZSgpKSkKKwlpZiAo
c3RhcnRfdGltZSA8PSB4bnBvZF9nZXRfdGltZSgpKQogCQlzdGFydF90aW1lID0gWE5fSU5GSU5J
VEU7CiAKIAllcnIgPSB4bnBvZF9zZXRfdGhyZWFkX3BlcmlvZGljKCZ0YXNrLT50aHJlYWRfYmFz
ZSwgc3RhcnRfdGltZSwgcGVyaW9kKTsK
------=_Part_32449_33411013.1172187705764--

