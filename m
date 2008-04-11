Date: Fri, 11 Apr 2008 18:09:09 +0200 (CEST)
From: Klaas Gadeyne <klaas.gadeyne@domain.hid>
Message-ID: <Pine.LNX.4.64.0804111759280.5433@domain.hid>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-1277286215-1207930149=:5433"
Subject: [Xenomai-help] rt_task_sleep_until question
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1277286215-1207930149=:5433
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed

Hi,

I've noticed that threads which, in my ignorant opinion, are supposed
to be sleeping, get woken up much earlier than I expect them to be.

Please find attached a modified version of the trivial-periodic.c
application, which creates a RT_TASK that should sleep as long as
possible (i.e. until unblocked by a signal handler).  However, the
task gets woken up much earlier (and many times) _before_ that time it
seems.

  head /tmp/app.txt
current_time = 1207928393295939429
sleep until 18446744073709551615
[TIMERLOOP] Total errors = 1, return code = -110
current_time = 1207928393296000379
sleep until 18446744073709551615
[TIMERLOOP] Total errors = 2, return code = -110
current_time = 1207928393296005409
sleep until 18446744073709551615
[TIMERLOOP] Total errors = 3, return code = -110
current_time = 1207928393296009604

What did I overlook here?

Thx,

Klaas
--8323329-1277286215-1207930149=:5433
Content-Type: TEXT/x-csrc; charset=US-ASCII; name=rt_task_sleep_until.c
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.64.0804111809090.5433@domain.hid>
Content-Description: 
Content-Disposition: attachment; filename=rt_task_sleep_until.c

I2luY2x1ZGUgPHN0ZGlvLmg+DQojaW5jbHVkZSA8c2lnbmFsLmg+DQojaW5j
bHVkZSA8dW5pc3RkLmg+DQojaW5jbHVkZSA8c3lzL21tYW4uaD4NCg0KI2lu
Y2x1ZGUgPG5hdGl2ZS90YXNrLmg+DQojaW5jbHVkZSA8bmF0aXZlL3RpbWVy
Lmg+DQoNClJUX1RBU0sgZGVtb190YXNrOw0KY2hhciBzdG9wX3RpbWVyPTA7
DQojZGVmaW5lIFRJTUVWQUxfTUFYIH4oUlRJTUUpMA0KDQp2b2lkIGRlbW8o
dm9pZCAqYXJnKQ0Kew0KICBpbnQgcmV0OyANCiAgaW50IGVycm9ycyA9IDA7
DQogIGRvew0KICAgIGRvew0KICAgICAgcHJpbnRmKCJjdXJyZW50X3RpbWUg
PSAlbGx1XG4iLHJ0X3RpbWVyX3JlYWQoKSk7DQogICAgICBwcmludGYoInNs
ZWVwIHVudGlsICVsbHVcbiIsIFRJTUVWQUxfTUFYKTsNCiAgICB9d2hpbGUg
KChyZXQgPSBydF90YXNrX3NsZWVwX3VudGlsKFRJTUVWQUxfTUFYKSkgPT0g
MCk7DQogICAgLy8JCWlmIChyZXQgPT0gLUVUSU1FRE9VVCl7DQogICAgcHJp
bnRmKCJbVElNRVJMT09QXSBUb3RhbCBlcnJvcnMgPSAlZCwgcmV0dXJuIGNv
ZGUgPSAlZFxuIiwrK2Vycm9ycyxyZXQpOw0KICAgIC8vIH0NCiAgfXdoaWxl
ICghKHN0b3BfdGltZXIgJiYgcmV0ID09IC1FSU5UUikpOw0KICBwcmludGYo
IkVuZCBvZiBUaW1lckxvb3AsIGNvZGUgJWQsIFRvdGFsIGVycm9ycyA9ICVk
XG4iLHJldCxlcnJvcnMpOw0KfQ0KDQp2b2lkIGNhdGNoX3NpZ25hbChpbnQg
c2lnKQ0Kew0KICBzdG9wX3RpbWVyID0gMTsNCiAgcnRfdGFza191bmJsb2Nr
KCZkZW1vX3Rhc2spOw0KfQ0KDQppbnQgbWFpbihpbnQgYXJnYywgY2hhciog
YXJndltdKQ0Kew0KICBzaWduYWwoU0lHVEVSTSwgY2F0Y2hfc2lnbmFsKTsN
CiAgc2lnbmFsKFNJR0lOVCwgY2F0Y2hfc2lnbmFsKTsNCg0KICAvKiBBdm9p
ZHMgbWVtb3J5IHN3YXBwaW5nIGZvciB0aGlzIHByb2dyYW0gKi8NCiAgbWxv
Y2thbGwoTUNMX0NVUlJFTlR8TUNMX0ZVVFVSRSk7DQoNCiAgLyoNCiAgICog
QXJndW1lbnRzOiAmdGFzaywNCiAgICogICAgICAgICAgICBuYW1lLA0KICAg
KiAgICAgICAgICAgIHN0YWNrIHNpemUgKDA9ZGVmYXVsdCksDQogICAqICAg
ICAgICAgICAgcHJpb3JpdHksDQogICAqICAgICAgICAgICAgbW9kZSAoRlBV
LCBzdGFydCBzdXNwZW5kZWQsIC4uLikNCiAgICovDQogIHJ0X3Rhc2tfY3Jl
YXRlKCZkZW1vX3Rhc2ssICJzbGVlcGluZyBmb3JldmVyIiwgMCwgNTAsIDAp
Ow0KDQogIC8qDQogICAqIEFyZ3VtZW50czogJnRhc2ssDQogICAqICAgICAg
ICAgICAgdGFzayBmdW5jdGlvbiwNCiAgICogICAgICAgICAgICBmdW5jdGlv
biBhcmd1bWVudA0KICAgKi8NCiAgcnRfdGFza19zdGFydCgmZGVtb190YXNr
LCAmZGVtbywgTlVMTCk7DQoNCiAgcGF1c2UoKTsNCg0KICBydF90YXNrX2Rl
bGV0ZSgmZGVtb190YXNrKTsNCn0NCg==

--8323329-1277286215-1207930149=:5433--

