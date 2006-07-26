Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C6B07A.C690ECF7"
Subject: RE: [Xenomai-help] Xenomai task (beginner)
Date: Wed, 26 Jul 2006 08:14:39 +0200
Message-ID: <1299EF3181B10F479D85C3280132852422DABD@THEZE.intra.cea.fr>
In-Reply-To: <17606.21420.165431.429261@domain.hid>
From: "GUARDIOLA-FALCO Sebastien 204282" <Sebastien.GUARDIOLA-FALCO@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C6B07A.C690ECF7
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

GUARDIOLA-FALCO Sebastien 204282 wrote:
 >> Hello,
 >>=20
 >> I'm waiting for Xenomai to be included in the ElinOS Linux package, =
so I can't try it before next week.=20
 >> My question is simple : how to port a linux program to Xenomai so =
this program is recognized as a Xenomai task? (and has low latencies?). =
Is it done when launching the program? like "prio 255 myprogram" in =
LynxOS? or are there lines of code to include?
 >> My linux task doesn't have any system call, except mmap(). Next I'm =
using the pointer I get from mmap() and that's it.
 >>=20

Gilles Chanteperdrix wrote:
>If you are talking about latencies, then your task has to suspend,
>waiting for some event using some other system call than mmap. I assume
>here that you are using the POSIX interface for that purpose.=20

Actually my program (see attached file) doesn't wait, it's a "polling" =
task (on a VME bus) that reads a pointer.
And if data read shows that we missed an event/data (means that data =
refresh is too fast, 500 microseconds for Linux for example), then I =
save/display the error.
So there's no blocking call here, only polling.

>To have a Linux program "recognized" by Xenomai, you have to compile it
>with special compilation flags, provided by the xeno-config script. The
>advantage of this approach is that the regular Linux services remain
>accessible by prefixing their names with the __real_ prefix. For =
example
>Linux regular mmap remain accessible but is called __real_mmap.

Interesting. About the compilation, does it means that when I launch =
such a task the Xenomai scheduler will do all the job? only because I =
include this 'xeno-config' option?
If it's the case, I'm wondering if that scheduler will increase =
performance for my polling thing... not sure.
What is certain is that task priority handling must be greater in =
Xenomai than Linux/premmptive.
About that, does my "sched_get_priority_max(SCHED_FIFO)" of my code will =
have any effect on Xenomai? a Xenomai equivalent for this call?

Thanks,
S=E9bastien.

------_=_NextPart_001_01C6B07A.C690ECF7
Content-Type: application/octet-stream;
	name="polling.c"
Content-Transfer-Encoding: base64
Content-Description: polling.c
Content-Disposition: attachment;
	filename="polling.c"

LyoNCioqICAgRklMRSAgIDogcG9vbGluZy5jDQoqKg0KKiogICBBVVRIT1IgOiBT6WJhc3RpZW4g
R1VBUkRJT0xBIEZBTENPDQoqKg0KKiogICBQUk9EVUNUIDogUmVhZGluZyBUZXN0IHByb2dyYW0g
b24gVk1FIGJ1cyAocG9sbGluZyBhbiBhY3F1aXNpdGlvbiBib2FyZCkNCioqDQoqKiAgIFZFUlNJ
T046IDEuMCBMSU5VWA0KKioNCioqICAgQ3JlYXRlZCA6IDAzIEp1aWxsZXQgMjAwNg0KKioNCioq
ICAgQ29tbWVudHMgOg0KKioNCioqICAgDQoqKg0KKi8NCiNpbmNsdWRlIDxzY2hlZC5oPg0KI2lu
Y2x1ZGUgPHN5cy9tbWFuLmg+DQojaW5jbHVkZSA8c3lzL3N0YXQuaD4NCiNpbmNsdWRlICJ2bWVk
cnYuaCINCiNpbmNsdWRlIDxzdGRsaWIuaD4NCiNpbmNsdWRlIDxzdGRkZWYuaD4NCiNpbmNsdWRl
IDxzeXMvbW1hbi5oPg0KI2luY2x1ZGUgPHVuaXN0ZC5oPiANCiNpbmNsdWRlIDxlcnJuby5oPg0K
I2luY2x1ZGUgPHN5cy9maWxlLmg+DQojaW5jbHVkZSA8c3lzL2lvY3RsLmg+DQojaW5jbHVkZSA8
c3lzL3R5cGVzLmg+DQojaW5jbHVkZSA8ZmNudGwuaD4NCiNpbmNsdWRlIDxzdGRpby5oPg0KI2lu
Y2x1ZGUgPHN0cmluZ3MuaD4NCiNpbmNsdWRlIDxzaWduYWwuaD4NCiNpbmNsdWRlICJjaHJvbm8u
aCINCg0Kc3RhdGljIGludCBJVEVSPTE7DQpzdGF0aWMgRklMRSAqb3V0cHV0Ow0Kc3RhdGljIHVu
c2lnbmVkIGxvbmcgdGFiWzFdOw0KDQoNCmludCBtYWluKGludCBhcmdjLCBjaGFyICphcmd2W10p
DQp7DQogICBzdHJ1Y3QgdGltZXZhbCBzdGFydCwgZWxhcHNlZDsNCiAgIGludCBrPTAsZmRPdXQs
bjsNCiAgIGxvbmcgaW50IHRpbWVfZTsNCiAgIHVuc2lnbmVkIGxvbmcgbXNiLGxzYj0wLGRhdGVw
cmVjLGV2dDsNCiAgIGNoYXIgKiBwdHJBMzI7DQogICBjaGFyIGRldm5vZGVbMjBdOw0KICAgc3Ry
dWN0IHNjaGVkX3BhcmFtIG15c2NoZWQ7DQoNCiAgIG91dHB1dCA9IGZvcGVuKCJSZXN1bHRfZmls
ZSIsInciKTsNCg0KLyoqKiBTRVQgVEFTSyBQUklPUklUWSAqKiovDQogICAgbXlzY2hlZC5zY2hl
ZF9wcmlvcml0eSA9IHNjaGVkX2dldF9wcmlvcml0eV9tYXgoU0NIRURfRklGTykgLSAxOw0KICAg
IGlmKCBzY2hlZF9zZXRzY2hlZHVsZXIoIDAsIFNDSEVEX0ZJRk8sICZteXNjaGVkICkgPT0gLTEg
KSB7DQogICAgICBwcmludGYoIkVSUk9SIElOIFNFVFRJTkcgVEhFIFNDSEVEVUxFUiIpOw0KICAg
ICAgcGVycm9yKCJlcnJubyIpOw0KICAgICAgZXhpdCgxKTsNCiAgICB9DQoNCi8qKiogT1BFTiBW
TUUgV0lORE9XICoqKi8NCiAgICBzcHJpbnRmKGRldm5vZGUsICIvZGV2L3ZtZV9tJWQiLCAwKTsN
CiAgICBmZE91dCA9IG9wZW4oZGV2bm9kZSwgT19SRFdSKTsNCiAgICBpZiAoZmRPdXQgPCAwKSB7
DQogCXByaW50ZigiT3V2ZXJ0dXJlIGRlIGxhIGZlbmV0cmUgIyVkIGltcG9zc2libGUuICBFcnJu
byA9ICVkXG4iLCAwLCBlcnJubyk7DQoJX2V4aXQoMSk7DQogICAgfQ0KDQovKioqKioqIE1NQVAg
T0YgVEhBVCBXSU5ET1cgKioqKioqKiovDQogICAgcHRyQTMyID0gbW1hcCgwLDB4MTAwMDAwMDAs
IFBST1RfUkVBRHxQUk9UX1dSSVRFLCBNQVBfU0hBUkVELCBmZE91dCwgKG9mZl90KTB4MDAwMDAw
MDApOw0KICAgIGlmKHB0ckEzMiA9PSBNQVBfRkFJTEVEKQ0KICAgIHsNCglwcmludGYoIkVjaGVj
IGxvcnMgZHUgbW1hcCgpLlxuIik7DQoJcmV0dXJuIC0xOw0KICAgIH0NCg0KLyoqKioqKiBJTklU
IE9GIEFDUVVJU0lUSU9OIEJPQVJEICoqKioqKiovDQogICBjaHJvVm1lSW5pdChwdHJBMzIpOw0K
ICAgY2hyb1ZtZVNldE1vZGUoUFJPRyk7DQogICBjaHJvVm1lU2V0UkFaRGF0ZSgweDIwLEVOUkFa
REFURSxSQVpEQVRFTklWMCw0KTsNCiAgIGNocm9WbWVTZXRDcHQoREFURV9IX01IWik7DQogICBj
aHJvVm1lUkFaQ3B0KENQVF9EQVRFKTsNCiAgIGNocm9WbWVTZXRNb2RlKFVUSUwpOw0KICAgZm9y
KGs9MDtrPElURVI7aysrKQ0KCXRhYltrXT0wOw0KICAgcHJpbnRmKCJpbml0IG9rXG4iKTsNCiAg
IGNocm9WbWVTZXRTZW5zRXZ0RGF0ZSgxLCBOSVYwKTsNCg0KLyoqKiBMT0NLIE1FTU9SWSAqKioq
LyANCiAgIG1sb2NrYWxsKE1DTF9DVVJSRU5UIHwgTUNMX0ZVVFVSRSk7DQoNCi8qKiogU0FWRSBT
VEFSVCBUSU1FICoqKi8NCiAgIGdldHRpbWVvZmRheSgmc3RhcnQsKHN0cnVjdCB0aW1ldmFsKikw
KTsNCiAgIA0KLyoqKiBSRUFEIEVWRU5UIChOT04tQkxPQ0tJTkcpICoqKi8NCiAgIGNocm9WbWVH
ZXRFdnREYXRlKCZldnQpOw0KDQovKioqIFJFQUQgREFUQSBBU1NPQ0lBVEVEIFRPIFRIQVQgRVZF
TlQgKioqLw0KICAgY2hyb1ZtZUdldERhdGVFdnREYXRlKCAxLCAmbXNiLCAmZGF0ZXByZWMpOw0K
DQovKioqIERPIFRISVMgUkVBRCBGT1IgQSBXSElMRS4uLiAqKiovDQogICBmb3Ioaz0wO2s8SVRF
UjspDQogICB7DQogICAgIGNocm9WbWVHZXRFdnREYXRlKCZldnQpOw0KICAgICBpZiAoZXZ0JkVW
REFURTEpDQogICAgIHsNCgkNCiAgICAgIGNocm9WbWVHZXREYXRlRXZ0RGF0ZSggMSwgJm1zYiwg
JmxzYik7DQoNCgkvKioqIFBST0NFU1NJTkcgREFUQSAoRVJST1IgSUYgVEhFIFBST0dSQU0gSVMg
TUlTU0lORyBBTiBFVkVOVCkgKioqLw0KCWlmKChsc2ItZGF0ZXByZWMpPjYwMCkgDQoJew0KCSAg
ICBpZihsc2IhPTApIHsNCgkgICAgICAgIHRhYltrXT1sc2ItZGF0ZXByZWM7DQogICAgICAgICAg
ICAgICAgKytrOw0KCSAgICB9DQoJfQ0KCWRhdGVwcmVjPWxzYjsNCiAgICAgfQ0KIA0KICAgfQ0K
DQoNCiAgIGdldHRpbWVvZmRheSgmZWxhcHNlZCwoc3RydWN0IHRpbWV2YWwqKTApOw0KICAgdGlt
ZV9lPShlbGFwc2VkLnR2X3NlYy1zdGFydC50dl9zZWMpKjEwMDAwMDAgKyAoZWxhcHNlZC50dl91
c2VjLXN0YXJ0LnR2X3VzZWMpOw0KICAgcHJpbnRmKCJFcnJvciBmb3VuZCBpbiAlZCBtaWNyb3Nl
Y29uZHMuXG4iLHRpbWVfZSk7DQoNCi8qKiogV1JJVElORyBSRVNVTFRTICoqKi8NCiAgIGZvcihr
PTA7azxJVEVSO2srKykNCglmcHJpbnRmKG91dHB1dCwiJWRcbiIsdGFiW2tdKTsNCg0KDQogIG11
bm1hcChwdHJBMzIsMHgxMDAwMDAwMCk7DQogIGNsb3NlKGZkT3V0KTsNCiAgZmNsb3NlKG91dHB1
dCk7DQogIHJldHVybiAwOw0KfQ0K

------_=_NextPart_001_01C6B07A.C690ECF7--

