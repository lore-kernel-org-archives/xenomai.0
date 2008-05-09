Message-ID: <2ff1a98a0805090253y4e9b2ee3od2d5a7430ba7472c@domain.hid>
Date: Fri, 9 May 2008 11:53:22 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <48241CF1.8020708@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_2295_17261951.1210326802300"
References: <4824197E.90709@domain.hid> <48241CF1.8020708@domain.hid>
Subject: Re: [Xenomai-core] [PATCH] Unfreeze timers when debugged target
	exits
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: rpm@xenomai.org
Cc: Jan Kiszka <jan.kiszka@domain.hid>, Xenomai-core@domain.hid

------=_Part_2295_17261951.1210326802300
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Fri, May 9, 2008 at 11:44 AM, Philippe Gerum <rpm@xenomai.org> wrote:
> Jan Kiszka wrote:
>> I expressed my skepticism about this global timer freeze before :->, and
>
> Just try debugging periodic code without it...
>
> We should have an opt-out mechanism to hide timers from the auto-freeze feature,
>  that is the real issue yet to be fixed.

Here is a patch I use at work.

-- 
 Gilles

------=_Part_2295_17261951.1210326802300
Content-Type: application/octet-stream; name=xeno-timer-nolock.diff
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fg0lb40c0
Content-Disposition: attachment; filename=xeno-timer-nolock.diff

SW5kZXg6IGluY2x1ZGUvbnVjbGV1cy90aW1lci5oCj09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KLS0tIGluY2x1ZGUvbnVj
bGV1cy90aW1lci5oCShyw6l2aXNpb24gNjYwOCkKKysrIGluY2x1ZGUvbnVjbGV1cy90aW1lci5o
CShyw6l2aXNpb24gNjYwOSkKQEAgLTMzLDYgKzMzLDcgQEAKIAogI2RlZmluZSBYTlRJTUVSX0RF
UVVFVUVEICAweDAwMDAwMDAxCiAjZGVmaW5lIFhOVElNRVJfS0lMTEVEICAgIDB4MDAwMDAwMDIK
KyNkZWZpbmUgWE5USU1FUl9OT0xPQ0sgICAgMHgwMDAwMDAwNAogCiAvKiBUaGVzZSBmbGFncyBh
cmUgYXZhaWxhYmxlIHRvIHRoZSByZWFsLXRpbWUgaW50ZXJmYWNlcyAqLwogI2RlZmluZSBYTlRJ
TUVSX1NQQVJFMCAgMHgwMTAwMDAwMApJbmRleDoga3NyYy9udWNsZXVzL3RpbWVyLmMKPT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PQotLS0ga3NyYy9udWNsZXVzL3RpbWVyLmMJKHLDqXZpc2lvbiA2NjA4KQorKysga3NyYy9u
dWNsZXVzL3RpbWVyLmMJKHLDqXZpc2lvbiA2NjA5KQpAQCAtMjEwLDcgKzIxMCw4IEBAIHN0YXRp
YyB2b2lkIHhudGltZXJfZG9fdGlja19hcGVyaW9kaWModm8KIAkJeG50aW1lcl9kZXF1ZXVlX2Fw
ZXJpb2RpYyh0aW1lcik7CiAKIAkJaWYgKHRpbWVyICE9ICZua3BvZC0+aHRpbWVyKSB7Ci0JCQlp
ZiAoIXRlc3RiaXRzKG5rcG9kLT5zdGF0dXMsIFhOVExPQ0spKSB7CisJCQlpZiAoIXRlc3RiaXRz
KG5rcG9kLT5zdGF0dXMsIFhOVExPQ0spCisJCQkgICAgfHwgdGVzdGJpdHModGltZXItPnN0YXR1
cywgWE5USU1FUl9OT0xPQ0spKSB7CiAJCQkJdGltZXItPmhhbmRsZXIodGltZXIpOwogCiAJCQkJ
aWYgKHRpbWVyLT5pbnRlcnZhbCA9PSBYTl9JTkZJTklURSB8fAo=
------=_Part_2295_17261951.1210326802300--

