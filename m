Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C6ABFE.8D0C7E91"
Date: Thu, 20 Jul 2006 15:14:21 +0200
Message-ID: <FDBBB5CC70676540B3EF7CFE83FD94E04F5518@domain.hid>
From: "ROSSIER Daniel" <Daniel.Rossier@domain.hid>
Subject: [Xenomai-help] Priority inversion
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C6ABFE.8D0C7E91
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable



Hi all,

Attached, another tricky piece of code.

We actually try to exhibit a priority inversion by using the semaphore =
(which does not implement the priority inheritance protocol).

We have the three following tasks:

- meteoDataAcquisition: acquiring the mutex, spinning 10ms, releasing =
the mutex / priority 1 / delayed at 18ms, and then activated with a =
frequency of 1000 ms from its first activation (so normally, more or =
less activated at 1018, 2018, 3018, etc.)

- busManagement: acquiring the mutex, spinning 5 ms, releasing the mutex =
/ priority 10 / period of 20 ms.
- comHandling: just spinning 10ms, period of 20 ms.

So, the worst case would be when the meteoDataAcquisition acquired the =
mutex right before the busManagement, so we can say that the highest =
priority task will be delayed of 10ms at the worst; we put an alarm of =
30ms, then no alarm will raise up; and indeed, it works like that.

Doing the same stuff with the semaphore - just change WITH_MUTEX to 0 - =
should theoretically lead to an alarm since the comHandling will take =
the hand, delaying the busManagement over 30ms. Here comes the problem: =
if we leave the alarm at 30ms, the alarm raises up, as expected. But, if =
we change the alarm to 31ms, there is no alarm anymore... and we do not =
understand why? Normally we should see some alarms for some values from =
31 to 35ms, since comHandling spins during 10ms. Mytery...

Normally, the task meteoDataAcquisition is aperiodic, and activated on =
the basis of an IRQ. In order to simulate that, we put the task with a =
delay of 18ms (yes, that's the reason of 18 ;-)), activated each second =
(therefore causing the priority inversion systematically). But nothing =
happens! the system runs, but no alarm raises up with=20

Many many thanks for your great help!

Daniel


------_=_NextPart_001_01C6ABFE.8D0C7E91
Content-Type: application/octet-stream;
	name="mytry.c"
Content-Transfer-Encoding: base64
Content-Description: mytry.c
Content-Disposition: attachment;
	filename="mytry.c"

DQoNCiNpbmNsdWRlIDxsaW51eC9tb2R1bGUuaD4NCiNpbmNsdWRlIDxuYXRpdmUvdGFzay5oPg0K
I2luY2x1ZGUgPG5hdGl2ZS9zZW0uaD4NCiNpbmNsdWRlIDxuYXRpdmUvbXV0ZXguaD4NCiNpbmNs
dWRlIDxuYXRpdmUvYWxhcm0uaD4NCg0KI2RlZmluZSBTVEFDS19TSVpFIDgxOTINCiNkZWZpbmUg
TVMgMTAwMDAwMCANCg0KI2RlZmluZSBXSVRIX01VVEVYICAwICAvKiBzZW1hcGhvcmUvbXV0ZXgg
c2VsZWN0aW9uICovDQoNClJUX1RBU0sgYnVzTWFuYWdlbWVudFRhc2s7DQpSVF9UQVNLIG1ldGVv
RGF0YUFjcXVpc2l0aW9uVGFzazsNClJUX1RBU0sgY29tSGFuZGxpbmdUYXNrOw0KDQpSVF9TRU0g
c2VtYTsNClJUX01VVEVYIG11dGV4Ow0KUlRfQUxBUk0gYWxhcm1CdXM7DQoNCmludCBlcnI7DQoN
CnZvaWQgbWV0ZW9EYXRhQWNxdWlzaXRpb24odm9pZCAqY29va2llKSB7DQoNCiAgcnRfdGFza19z
ZXRfcGVyaW9kaWMoJm1ldGVvRGF0YUFjcXVpc2l0aW9uVGFzaywgVE1fTk9XLCAxMDApOw0KDQog
IHdoaWxlKDEpIHsNCg0KICAgIGlmIChXSVRIX01VVEVYKQ0KICAgICAgcnRfbXV0ZXhfbG9jaygm
bXV0ZXgsIFRNX0lORklOSVRFKTsNCiAgICBlbHNlDQogICAgICBydF9zZW1fcCgmc2VtYSwgVE1f
SU5GSU5JVEUpOw0KDQogICAgcnRfdGltZXJfc3BpbigxMCpNUyk7DQoNCiAgICBpZiAoV0lUSF9N
VVRFWCkNCiAgICAgIHJ0X211dGV4X3VubG9jaygmbXV0ZXgpOw0KICAgIGVsc2UNCiAgICAgIHJ0
X3NlbV92KCZzZW1hKTsNCg0KICAgIHJ0X3Rhc2tfd2FpdF9wZXJpb2QoTlVMTCk7DQogIH0NCg0K
fQ0KDQp2b2lkIGJ1c01hbmFnZW1lbnQodm9pZCAqY29va2llKSB7DQoNCiAgd2hpbGUoMSkgew0K
DQogICAgaWYgKFdJVEhfTVVURVgpDQogICAgICBydF9tdXRleF9sb2NrKCZtdXRleCwgVE1fSU5G
SU5JVEUpOw0KICAgIGVsc2UNCiAgICAgIHJ0X3NlbV9wKCZzZW1hLCBUTV9JTkZJTklURSk7DQoN
CiAgICBydF90aW1lcl9zcGluKDUqTVMpOw0KDQogICAgaWYgKFdJVEhfTVVURVgpDQogICAgICBy
dF9tdXRleF91bmxvY2soJm11dGV4KTsNCiAgICBlbHNlDQogICAgICBydF9zZW1fdigmc2VtYSk7
DQoNCiAgICBydF9hbGFybV9zdGFydCgmYWxhcm1CdXMsIDMxLCBUTV9JTkZJTklURSk7DQogICAg
cnRfdGFza193YWl0X3BlcmlvZChOVUxMKTsNCiAgfQ0KfQ0KDQp2b2lkIGNvbUhhbmRsaW5nKHZv
aWQgKmNvb2tpZSkgew0KDQogIHdoaWxlICgxKSB7DQoNCiAgICBydF90aW1lcl9zcGluKDEwKk1T
KTsNCg0KICAgIHJ0X3Rhc2tfd2FpdF9wZXJpb2QoTlVMTCk7DQogIH0NCg0KfQ0KDQp2b2lkIGFs
YXJtSGFuZGxlcihSVF9BTEFSTSAqYWxhcm1EZXNjLCB2b2lkICpjb29raWUpIHsNCiAgcHJpbnRr
KCIjQUxFUlQ6XG4iKTsNCn0NCg0Kdm9pZCBfX2V4aXQgY2xlYW51cF9tb2R1bGUgKHZvaWQpIHsN
Cg0KICBwcmludGsoIiNjbGVhbnVwXG4iKTsNCg0KICBydF90YXNrX2RlbGV0ZSgmbWV0ZW9EYXRh
QWNxdWlzaXRpb25UYXNrKTsNCiAgcnRfdGFza19kZWxldGUoJmJ1c01hbmFnZW1lbnRUYXNrKTsN
CiAgcnRfdGFza19kZWxldGUoJmNvbUhhbmRsaW5nVGFzayk7DQoNCiAgcnRfYWxhcm1fZGVsZXRl
KCZhbGFybUJ1cyk7DQoNCiAgcnRfbXV0ZXhfZGVsZXRlKCZtdXRleCk7DQogIHJ0X3NlbV9kZWxl
dGUoJnNlbWEpOw0KDQoNCiAgcHJpbnRrKCJCeWUgYnllIVxuIik7DQp9DQoNCmludCBfX2luaXQg
aW5pdF9tb2R1bGUgKHZvaWQpIHsNCg0KICBwcmludGsoIiNzdGFydGluZy4uLlxuIik7DQoNCiAg
ZXJyID0gcnRfdGltZXJfc2V0X21vZGUoTVMpOw0KICBpZiAoZXJyICE9IDApIHsNCiAgICBwcmlu
dGsoIkVycm9yIHRpbWVyOiAlZFxuIiwgZXJyKTsNCiAgICByZXR1cm4gLTE7DQogIH0NCg0KICBl
cnIgPSBydF9zZW1fY3JlYXRlKCZzZW1hLCAiU0VNQVBIT1JFX0JVUyIsIDEsIFNfUFJJTyk7DQog
IGlmIChlcnIgIT0gMCkgew0KICAgIHByaW50aygic2VtYXBob3JlIGNyZWF0aW9uIGZhaWxlZDog
JWRcbiIsIGVycik7DQogICAgcmV0dXJuIC0xOw0KICB9IA0KDQogIGVyciA9IHJ0X211dGV4X2Ny
ZWF0ZSgmbXV0ZXgsICJNVVRFWF9CVVMiKTsNCiAgaWYgKGVyciAhPSAwKSB7DQogICAgcHJpbnRr
KCJtdXRleCBjcmVhdGlvbiBmYWlsZWQ6ICVkXG4iLCBlcnIpOw0KICAgIHJldHVybiAtMTsNCiAg
fQ0KDQogIGVyciA9IHJ0X2FsYXJtX2NyZWF0ZSgmYWxhcm1CdXMsICJBTEFSTV9CVVMiLCBhbGFy
bUhhbmRsZXIsIE5VTEwpOw0KICBpZiAoZXJyICE9IDApIHsNCiAgICBwcmludGsoImFsYXJtIGNy
ZWF0aW9uIGZhaWxlZDogJWRcbiIsIGVycik7DQogICAgcmV0dXJuIC0xOw0KICB9DQoNCiAgZXJy
ID0gcnRfdGFza19jcmVhdGUoJmJ1c01hbmFnZW1lbnRUYXNrLCAiYnVzTWFuYWdlbWVudCIsIFNU
QUNLX1NJWkUsIDEwLCAwKTsNCiAgaWYgKGVyciAhPSAwKSB7DQogICAgcHJpbnRrKCJ0YXNrIGNy
ZWF0aW9uIGZhaWxlZDogJWRcbiIsIGVycik7DQogICAgcmV0dXJuIC0xOw0KICB9DQoNCiAgZXJy
ID0gcnRfdGFza19jcmVhdGUoJm1ldGVvRGF0YUFjcXVpc2l0aW9uVGFzaywgIm1ldGVvRGF0YUFj
cXVpc2l0aW9uIiwgU1RBQ0tfU0laRSwgMSwgMCk7DQogIGlmIChlcnIgIT0gMCkgew0KICAgIHBy
aW50aygidGFzayBjcmVhdGlvbiBmYWlsZWQ6ICVkXG4iLCBlcnIpOw0KICAgIHJldHVybiAtMTsN
CiAgfQ0KDQogIGVyciA9IHJ0X3Rhc2tfY3JlYXRlKCZjb21IYW5kbGluZ1Rhc2ssICJjb21IYW5k
bGluZyIsIFNUQUNLX1NJWkUsIDUgLCAwKTsNCiAgaWYgKGVyciAhPSAwKSB7DQogICAgcHJpbnRr
KCJ0YXNrIGNyZWF0aW9uIGZhaWxlZDogJWRcbiIsIGVycik7DQogICAgcmV0dXJuIC0xOw0KICB9
DQoNCiAgcnRfdGFza19zZXRfcGVyaW9kaWMoJmJ1c01hbmFnZW1lbnRUYXNrLCBUTV9OT1csIDIw
KTsNCiAgcnRfdGFza19zZXRfcGVyaW9kaWMoJmNvbUhhbmRsaW5nVGFzaywgVE1fTk9XLCAyMCk7
DQogIHJ0X3Rhc2tfc2V0X3BlcmlvZGljKCZtZXRlb0RhdGFBY3F1aXNpdGlvblRhc2ssIHJ0X3Rp
bWVyX3JlYWQoKSArIDE4LCAxMDAwKTsgLyogRGVsYXkgdGhpcyB0YXNrIGluIG9yZGVyIHRvIGZv
cmNlIHByaW9yaXR5IGludmVyc2lvbiAqLw0KDQogIHJ0X3Rhc2tfc3RhcnQoJmNvbUhhbmRsaW5n
VGFzaywgY29tSGFuZGxpbmcsIE5VTEwpOw0KICBydF90YXNrX3N0YXJ0KCZidXNNYW5hZ2VtZW50
VGFzaywgYnVzTWFuYWdlbWVudCwgTlVMTCk7DQogIHJ0X3Rhc2tfc3RhcnQoJm1ldGVvRGF0YUFj
cXVpc2l0aW9uVGFzaywgbWV0ZW9EYXRhQWNxdWlzaXRpb24sIE5VTEwpOw0KDQogIHJldHVybiAw
Ow0KfQ0KDQpNT0RVTEVfTElDRU5TRSgiR1BMIik7DQo=

------_=_NextPart_001_01C6ABFE.8D0C7E91--

