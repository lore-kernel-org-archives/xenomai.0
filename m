Date: Thu, 30 Apr 2009 15:16:50 +0200
From: "Petr Cervenka" <grugh@domain.hid>
MIME-Version: 1.0
Message-ID: <200904301516.696@domain.hid>
References: <200904301508.29432@domain.hid> <200904301509.13094@domain.hid>
	<200904301510.8382@domain.hid> <200904301511.15875@domain.hid>
	<200904301512.9035@domain.hid> <200904301513.12716@domain.hid>
	<200904301514.6099@domain.hid> <200904301515.16182@domain.hid>
In-Reply-To: <200904301515.16182@domain.hid>
Content-Type: multipart/mixed; boundary="-------=_268532AB.1FC963F0"
Subject: [Xenomai-help] rtdm_event_timedwait returns -EINTR
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai-help <xenomai@xenomai.org>

This is a multi-part message in MIME format

---------=_268532AB.1FC963F0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

Hello,
I have a problem with rtdm_event_timedwait() function. It sometimes ends prematurely with -EINTR error code. It depends on special circumstances (CPU load, resizing console window in X, ...).

I tried to create simple example with native skin to reproduce the behaviour. But the rt_event_wait() behaves differently.
It, insted of returning -EINTR, resets the timeout. It's like the function is called ones more after last interruption/unblock (with original timeout).

normal run:
------------------
event: res = -110 (Connection timed out)
time - actual 5.00001 s, wanted 5 s

window resizing
-------------------------
event: res = -110 (Connection timed out)
time - actual 14.9161 s, wanted 5 s

used versions:
----------------------
Linux rtc 2.6.26.3-adeos #1 SMP PREEMPT Tue Apr 14 15:03:35 CEST 2009 x86_64 GNU/Linux
Xenomai 2.4.7
adeos-ipipe-2.6.26-x86-2.0-17.patch

Thank you for any help or advice.

Petr Cervenka


---------=_268532AB.1FC963F0
Content-Type: text/x-c++src; name="main.cpp"
Content-Transfer-Encoding: base64

I2luY2x1ZGUgPHN5cy9tbWFuLmg+CiNpbmNsdWRlIDxuYXRpdmUvdGFzay5oPgojaW5jbHVk
ZSA8bmF0aXZlL2V2ZW50Lmg+CiNpbmNsdWRlIDxuYXRpdmUvdGltZXIuaD4KCiNkZWZpbmUg
TVlfRVZFTlQgICAgMHgwMDAwMDAwMWxsCiNkZWZpbmUgTVlfUFJJT1JJVFkgOTkKCnN0YXRp
YyBSVF9UQVNLIG1haW5UYXNrOwoKaW50IG1haW4oaW50IGFyZ2MsIGNoYXIqKiBhcmd2KSB7
CiAgICBjb25zdCBkb3VibGUgT05FX1NFQyA9IDFlOTsKICAgIGNvbnN0IFJUSU1FIHRpbWVv
dXQgPSAoUlRJTUUpKDUgKiBPTkVfU0VDKTsKICAgIFJUX0VWRU5UIGV2ZW50OwogICAgdW5z
aWduZWQgbG9uZyBtYXNrOwogICAgUlRJTUUgc3RhcnQsIGVuZDsKICAgIGludCByZXM7Cgog
ICAgbWxvY2thbGwoTUNMX0NVUlJFTlQgfCBNQ0xfRlVUVVJFKTsKCiAgICBydF90YXNrX3No
YWRvdygmbWFpblRhc2ssIE5VTEwsIE1ZX1BSSU9SSVRZLCBUX0ZQVSk7CgogICAgcnRfdGFz
a19zZXRfbW9kZSgwLCBUX1BSSU1BUlksIE5VTEwpOwoKICAgIHJ0X2V2ZW50X2NyZWF0ZSgm
ZXZlbnQsIE5VTEwsIDAsIEVWX1BSSU8pOwoKICAgIHN0YXJ0ID0gcnRfdGltZXJfcmVhZCgp
OwogICAgcmVzID0gcnRfZXZlbnRfd2FpdCgmZXZlbnQsIE1ZX0VWRU5ULCAmbWFzaywgRVZf
QUxMLCBydF90aW1lcl9uczJ0aWNrcyh0aW1lb3V0KSk7CiAgICBlbmQgPSBydF90aW1lcl9y
ZWFkKCk7CgogICAgc3dpdGNoIChyZXMpIHsKICAgICAgICBjYXNlIC1FSU5WQUw6CiAgICAg
ICAgY2FzZSAtRUlEUk06CiAgICAgICAgY2FzZSAtRVdPVUxEQkxPQ0s6CiAgICAgICAgY2Fz
ZSAtRUlOVFI6CiAgICAgICAgY2FzZSAtRVRJTUVET1VUOgogICAgICAgIGNhc2UgLUVQRVJN
OgogICAgICAgICAgICBwcmludGYoImV2ZW50OiByZXMgPSAlZCAoJXMpXG4iLCByZXMsIHN0
cmVycm9yKC1yZXMpKTsKICAgICAgICAgICAgYnJlYWs7CiAgICAgICAgZGVmYXVsdDoKICAg
ICAgICAgICAgcHJpbnRmKCJ1bmtub3duIGV2ZW50OiByZXMgPSAlZFxuIiwgcmVzKTsKICAg
IH0KCiAgICBwcmludGYoInRpbWUgLSBhY3R1YWwgJWcgcywgd2FudGVkICVnIHNcbiIsIHJ0
X3RpbWVyX3RpY2tzMm5zKGVuZCAtIHN0YXJ0KS9PTkVfU0VDLCB0aW1lb3V0L09ORV9TRUMp
OwogICAgCiAgICBydF9ldmVudF9kZWxldGUoJmV2ZW50KTsKCiAgICByZXR1cm4gMDsKfQo=

---------=_268532AB.1FC963F0--

