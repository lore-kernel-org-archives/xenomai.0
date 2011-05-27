Message-ID: <4DDFB30F.8000003@domain.hid>
Date: Fri, 27 May 2011 16:19:59 +0200
From: Jonas Witt <jonas.witt@domain.hid>
MIME-Version: 1.0
References: <4DDE8DC9.2020905@domain.hid> <4DDF475A.5080504@domain.hid>
In-Reply-To: <4DDF475A.5080504@domain.hid>
Content-Type: multipart/mixed; boundary="------------030806030203000604070501"
Subject: Re: [Xenomai-help] Huge clock drift
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

This is a multi-part message in MIME format.
--------------030806030203000604070501
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Am 27.05.2011 08:40, schrieb Gilles Chanteperdrix:
> On 05/26/2011 07:28 PM, Jonas Witt wrote:
>> Hi all,
>>
>> i am having a problem concerning the clock drift under load:
>>
>> # /usr/xenomai/bin/clocktest
>> == Tested clock: 0 (CLOCK_REALTIME)
>> CPU      ToD offset [us] ToD drift [us/s]      warps max delta [us]
>> --- -------------------- ---------------- ---------- --------------
>>     0          775571614.0       166776.858          0            0.0
>>
>>
>> It remains in the hundreds of MILLIseconds, changing constantly. My
>> setup consists of an embedded Intel Atom board (1.6GHz Z530 processor)
>> with a 2.6.32.7 kernel and Xenomai 2.5.2.
> Hi Jonas,
>
> Could you try and see if 2.5.6 with latest I-pipe patches has the same
> behaviour?
>
>> Latencies under load are
>> reasonable. Mean latency<  10us. Maximum latency<  40us.
>>
>> Without load the ToD offset is approximately constant over time with a
>> ToD drift in the range of 10 microseconds (strangely after a while this
>> settles in a range of 2 microseconds). Does anyone have an idea how this
>> can be caused?
> First, I am not sure clocktest is meant to be use under load. Second,
> does your system uses ntp?
>
>> As a workaround I currently use rt_timer_read() in all
>> relevant programs (also the non-realtime ones), since I need consistent
>> timestamps between realtime and non-realtime tasks.
> In order to solve this particular issue, we have a solution, but not yet
> in stable released versions.
>
>> One other (maybe unrelated) strange behavior is occasional secondary
>> mode switches when calling rt_queue_read(...).
> For this error, we need more details, such as a simple test case
> allowing to reproduce the issue, and again, you need to be sure to
> reproduce the issue on latest stable release with latest I-pipe patches.
>
> Regards.

Hi Gilles,

thanks for your input. I will try Xenomai 2.5.6 soon. In the meantime I 
wrote a simple load simulator to reproduce the issue with my more 
complex program. The clock drift only occurs with a load of more than 
30%. Below that the clock is fine. So you may have to adjust the 
attached code (e.g. change the 2000 value in the for-loop to something 
larger) to stress your system to that level where the processing time is 
more than 2000 microseconds.

Cheers,
Jonas

--------------030806030203000604070501
Content-Type: text/plain;
 name="CMakeLists.txt"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="CMakeLists.txt"

Y21ha2VfbWluaW11bV9yZXF1aXJlZChWRVJTSU9OIDIuNikNCg0KcHJvamVjdChYZW5vTG9h
ZFNpbXVsYXRvcikNCg0KbGlua19kaXJlY3RvcmllcygvdXNyL3hlbm9tYWkvbGliKQ0KaW5j
bHVkZV9kaXJlY3RvcmllcygvdXNyL3hlbm9tYWkvaW5jbHVkZSkNCg0KYWRkX2V4ZWN1dGFi
bGUoJHtQUk9KRUNUX05BTUV9IG1haW4uY3BwKQ0KdGFyZ2V0X2xpbmtfbGlicmFyaWVzKCR7
UFJPSkVDVF9OQU1FfSAgeGVub21haSBydGRtIG5hdGl2ZSkNCg==
--------------030806030203000604070501
Content-Type: text/plain;
 name="main.cpp"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="main.cpp"

DQojaW5jbHVkZSA8c3lzL21tYW4uaD4NCiNpbmNsdWRlIDxjc2lnbmFsPg0KI2luY2x1ZGUg
PG5hdGl2ZS9xdWV1ZS5oPg0KI2luY2x1ZGUgPG5hdGl2ZS90aW1lci5oPg0KI2luY2x1ZGUg
PG5hdGl2ZS90YXNrLmg+DQojaW5jbHVkZSA8Y21hdGg+DQoNCmJvb2wgcnVubmluZyA9IHRy
dWU7DQpSVF9RVUVVRSBxdWV1ZTsNCg0Kdm9pZCBleGl0U2lnbmFsIChpbnQgcGFyYW0pDQp7
DQoJcHJpbnRmICgiRXhpdGluZyBwcm9ncmFtLi4uXG4iKTsNCglydW5uaW5nID0gZmFsc2U7
DQp9DQoNCnZvaWQgbWFpbkxvb3Aodm9pZCogZHVtbXkpDQp7CQ0KCWludCBzdGF0dXM7DQoJ
cHJpbnRmKCJNYWluIGxvb3AuLi5cbiIpOw0KCQkNCglSVElNRSBjdXJyZW50VGltZSwgbGFz
dFRpbWU7DQoJDQoJZG91YmxlIHJlc3VsdCA9IDcuMDsNCglkb3VibGUgYSA9IDEwMDAuOw0K
CWRvdWJsZSBiID0gMzMzLjsNCgl1bnNpZ25lZCBpbnQgY291bnRlciA9IDA7DQoJZmxvYXQg
cGVyaW9kVGltZSA9IDUwMC4wZjsNCglmbG9hdCBwcm9jZXNzaW5nVGltZSA9IDAuMGY7DQoJ
ZG91YmxlIHBvc2l0aW9uWzNdOw0KCQ0KCXdoaWxlKHJ1bm5pbmcpDQoJew0KCQlydF90YXNr
X3dhaXRfcGVyaW9kKE5VTEwpOw0KCQkNCgkJUlRJTUUgc3RhcnRUaW1lID0gcnRfdGltZXJf
cmVhZCgpOw0KCQlmb3IodW5zaWduZWQgbG9uZyBsb25nIGludCBpPTA7IGkgPCAoKHVuc2ln
bmVkIGxvbmcpcmVzdWx0KSAlIDUgKyAzMDAwOyArK2kpDQoJCXsNCgkJCWEgKz0gc2luKChk
b3VibGUpaSAvIDUwMC4pOw0KCQkJYiA9IHNxcnQoYSk7DQoJCQlyZXN1bHQgKz0gKChkb3Vi
bGUpaSAvIDMuMCArIDMuMTQyMykgKiAoZG91YmxlKSBpIC0gYSAqIGI7DQoJCX0NCgkJY3Vy
cmVudFRpbWUgPSBydF90aW1lcl9yZWFkKCk7DQoJCQ0KCQlwcm9jZXNzaW5nVGltZSA9IDAu
OWYgKiBwcm9jZXNzaW5nVGltZSArIDAuMWYgKiAoZmxvYXQpKGN1cnJlbnRUaW1lIC0gc3Rh
cnRUaW1lKSAvIDEwMDAuZjsNCgkJcGVyaW9kVGltZSA9IDAuOWYgKiBwZXJpb2RUaW1lICsg
MC4xZiAqIChmbG9hdCkoY3VycmVudFRpbWUgLSBsYXN0VGltZSkgLyAxMDAwLmY7DQoJCWxh
c3RUaW1lID0gY3VycmVudFRpbWU7DQoJCQ0KCQkvKmlmKHJ0X3F1ZXVlX3JlYWQoJnF1ZXVl
LCAodm9pZCopcG9zaXRpb24sIDMqc2l6ZW9mKGRvdWJsZSksIFRNX05PTkJMT0NLKSA+IDAp
DQoJCXsJDQoJCQlwcmludGYoIlg6ICUuMWYgIFk6ICUuMWYgIFo6ICUuMWZcbiIsIHBvc2l0
aW9uWzBdLCBwb3NpdGlvblsxXSwgcG9zaXRpb25bMl0pOw0KCQl9Ki8NCgkJDQoJCWlmKGNv
dW50ZXIrKyA+IDEwMCkNCgkJew0KCQkJY291bnRlciA9IDA7DQoJCQlwcmludGYoIlBlcmlv
ZCBUaW1lOiAlLjFmdXMgICAgICBSZXN1bHQ6ICUuMWZcbiIsIHBlcmlvZFRpbWUsIHJlc3Vs
dCk7DQoJCQlwcmludGYoIlByb2Nlc3NpbmcgVGltZTogJS4xZnVzXG4iLCBwcm9jZXNzaW5n
VGltZSk7DQoJCX0NCgl9CQ0KfQ0KDQoNCmludCBtYWluIChpbnQgYXJnYyAsIGNoYXIgKiBh
cmd2IFtdKSANCnsNCgltbG9ja2FsbChNQ0xfQ1VSUkVOVCB8IE1DTF9GVVRVUkUpOw0KCQ0K
CXNpZ25hbCAoU0lHSU5ULCBleGl0U2lnbmFsKTsNCglwcmludGYoIkluaXRpYWxpemF0aW9u
Li4uIik7DQoJDQoJaW50IHN0YXR1czsNCgkJCQkJCQkJDQoJLyppZihydF9xdWV1ZV9iaW5k
KCZxdWV1ZSwgImNhbVBvc1F1ZXVlIiwgVE1fTk9OQkxPQ0spICE9IDApDQoJew0KCQlyZXR1
cm4gMDsNCgl9Ki8NCgkNCglydF90aW1lcl9zZXRfbW9kZShUTV9PTkVTSE9UKTsNCgkNCglS
VF9UQVNLIHRhc2s7DQoJaWYocnRfdGFza19jcmVhdGUoJnRhc2ssIE5VTEwsIDAsIDgwLCBU
X0pPSU5BQkxFKSAhPSAwKQ0KCXsNCgkJcHJpbnRmKCJDcmVhdGlvbiBvZiBYZW5vbWFpIFRh
c2sgZmFpbGVkIVxuIik7DQoJCXJldHVybiAwOw0KCX0NCgkNCglydF90YXNrX3NldF9wZXJp
b2RpYyAJKCZ0YXNrLCBUTV9OT1csCTQwMDAwMDApOw0KDQoJcHJpbnRmKCJkb25lIVxuIik7
DQoJDQoJcnRfdGFza19zdGFydCgmdGFzaywgJm1haW5Mb29wLCAodm9pZCopTlVMTCk7DQog
IAkNCgkNCglydF90YXNrX2pvaW4oJnRhc2spOwkNCgkNCgltYWluTG9vcChOVUxMKTsNCgkN
CglwcmludGYoIkNsZWFuVXAuLi4iKTsNCgkNCgkvL3J0X3F1ZXVlX3VuYmluZCgmcXVldWUp
OyANCiAJDQoJcHJpbnRmKCJkb25lIVxuIik7DQoJcmV0dXJuIDA7DQp9DQoNCg==
--------------030806030203000604070501--

