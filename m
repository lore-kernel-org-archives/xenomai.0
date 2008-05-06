Date: Tue, 6 May 2008 09:37:03 +0200 (CEST)
From: Klaas Gadeyne <klaas.gadeyne@domain.hid>
Message-ID: <Pine.LNX.4.64.0805060930140.26449@domain.hid>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-1304785219-1210059423=:26449"
Subject: [Xenomai-core] [PATCH] -ETIMEDOUT return value not described in
 rt_cond_wait API documentation?
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1304785219-1210059423=:26449
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed

Hi,

it seems -ETIMEDOUT is not mentioned as a possible return value of
rt_cond_wait() in the API docs [1], although it *is* returned in case
of the timeout having expired [2]?

Attached patch tries to solve this against the 2.4 branch.

regards,

Klaas

ps.  This seems to apply to 2.3, 2.4 and trunk.

[1]
<http://www.xenomai.org/documentation/trunk/html/api/group__cond.html#g3aa51073817be2ffb2a880a7393502e8>
[2] 
<http://www.rts.uni-hannover.de/xenomai/lxr/source/ksrc/skins/native/cond.c#493>
--8323329-1304785219-1210059423=:26449
Content-Type: TEXT/x-diff; charset=US-ASCII; name=cond_c.patch
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.64.0805060937030.26449@domain.hid>
Content-Description: 
Content-Disposition: attachment; filename=cond_c.patch

SW5kZXg6IGNvbmQuYw0KPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQ0KLS0tIGNv
bmQuYwkocmV2aXNpb24gMzcxNykNCisrKyBjb25kLmMJKHdvcmtpbmcgY29w
eSkNCkBAIC00MTYsNiArNDE2LDkgQEANCiAgKiBkZXNjcmlwdG9yLCBpbmNs
dWRpbmcgaWYgdGhlIGRlbGV0aW9uIG9jY3VycmVkIHdoaWxlIHRoZSBjYWxs
ZXIgd2FzDQogICogc2xlZXBpbmcgb24gdGhlIHZhcmlhYmxlLg0KICAqDQor
ICogLSAtRVRJTUVET1VUIGlzIHJldHVybmVkIGlmIEBhIHRpbWVvdXQgZXhw
aXJlZCBiZWZvcmUgdGhlIGNvbmRpdGlvbg0KKyAqIHZhcmlhYmxlIGhhcyBi
ZWVuIHNpZ25hbGVkLg0KKyAqDQogICogLSAtRUlOVFIgaXMgcmV0dXJuZWQg
aWYgcnRfdGFza191bmJsb2NrKCkgaGFzIGJlZW4gY2FsbGVkIGZvciB0aGUN
CiAgKiB3YWl0aW5nIHRhc2sgYmVmb3JlIHRoZSBjb25kaXRpb24gdmFyaWFi
bGUgaGFzIGJlZW4gc2lnbmFsZWQuDQogICoNCg==

--8323329-1304785219-1210059423=:26449--

