Date: Thu, 23 Jul 2009 17:17:34 +0200 (CEST)
From: Kolja Waschk <xenoka09@domain.hid>
Message-ID: <Pine.LNX.4.62.0907231644270.9450@domain.hid>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED;
	BOUNDARY="-1463809534-955321501-1248362254=:9450"
Sender: "Kolja Waschk,,," <xenoka09@domain.hid>
Subject: [Xenomai-help] POSIX skin, simple example with mutex not working...
Reply-To: xenoka09@domain.hid
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

---1463809534-955321501-1248362254=:9450
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed

Hi,

As a newcomer to Xenomai, I was until now successfully experimenting
with the native skin. Now that it comes to run an existing application
that is written for POSIX threads, a few problems show up. The
pthread_mutex_lock() _always_ returns 1 (EPERM) to me, although there
are no forks involved and policy should have been to SCHED_FIFO.

If that's of interest, I'm developing for a Blackfin uClinux (NOMMU)
target with newest uClinux-dist snapshot (Kernel
2.6.30.2-ADI-2010R1-pre, Xenomai 2.4.91, Nucleus v2.5-rc2) with FDPIC
userland. For building,  I simply used

> bfin-linux-uclibc-gcc `/usr/xenomai/bin/xeno-config --posix-cflags`
>   `/usr/xenomai/bin/xeno-config --posix-ldflags`  try.c -o try

Writing an explicit command line including the -Wl,@(wrapper) etc.
doesn't change anything.  The output of the attached code, compiled,
shows the return value from mutex_lock, first called from the NRT
main(), then from a thread that IMHO should run as a realtime thread:

> main:lock:1
> main:unlock:1
> thread:lock:1
> thread:unlock:1

Possibly I just missed some include file, compiler flag, .... or basic concept?

Thanks for any advice
Kolja

---1463809534-955321501-1248362254=:9450
Content-Type: TEXT/x-csrc; charset=US-ASCII; name=try.c
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.62.0907231717340.9450@domain.hid>
Content-Description: 
Content-Disposition: attachment; filename=try.c

I2luY2x1ZGUgPHN0ZGlvLmg+DQojaW5jbHVkZSA8c3lzL21tYW4uaD4NCiNp
bmNsdWRlIDxwdGhyZWFkLmg+DQojaW5jbHVkZSA8cG9zaXgvcG9zaXguaD4N
Cg0Kc3RhdGljIHB0aHJlYWRfdCB0YXNrOw0KDQppbnQgdHJ5X211dGV4KGNv
bnN0IGNoYXIgKndoZXJlKTsNCg0Kdm9pZCAqYm9keSAodm9pZCAqdW51c2Vk
KQ0Kew0KICAgIHRyeV9tdXRleCgidGhyZWFkIik7DQoNCiAgICBwdGhyZWFk
X2V4aXQoMCk7DQp9DQoNCmludCBtYWluIChpbnQgYXJnYywgY2hhciAqYXJn
dltdKQ0Kew0KICAgIGludCByOw0KICAgIHB0aHJlYWRfYXR0cl90IGF0dHI7
DQogICAgc3RydWN0IHNjaGVkX3BhcmFtIHBhcm07DQoNCiAgICBtbG9ja2Fs
bChNQ0xfQ1VSUkVOVHxNQ0xfRlVUVVJFKTsNCg0KICAgIHRyeV9tdXRleCgi
bWFpbiIpOw0KDQogICAgcGFybS5zY2hlZF9wcmlvcml0eSA9IDE7DQogICAg
cHRocmVhZF9hdHRyX2luaXQoJmF0dHIpOw0KICAgIHB0aHJlYWRfYXR0cl9z
ZXRpbmhlcml0c2NoZWQoJmF0dHIsIDEpOw0KICAgIHB0aHJlYWRfYXR0cl9z
ZXRzdGFja3NpemUoJmF0dHIsIDE2Mzg0KTsNCiAgICBwdGhyZWFkX2F0dHJf
c2V0c2NoZWRwYXJhbSgmYXR0ciwgJnBhcm0pOw0KICAgIHB0aHJlYWRfYXR0
cl9zZXRzY2hlZHBvbGljeSgmYXR0ciwgU0NIRURfRklGTyk7DQoNCiAgICBy
ID0gcHRocmVhZF9jcmVhdGUoJnRhc2ssICZhdHRyLCAmYm9keSwgTlVMTCk7
DQogICAgaWYgKHIpIHByaW50ZigibWFpbjpjcmVhdGU6JWRcbiIsIHIpOw0K
DQogICAgciA9IHB0aHJlYWRfam9pbih0YXNrLCAwKTsNCiAgICBpZiAocikg
cHJpbnRmKCJtYWluOmpvaW46JWRcbiIsIHIpOw0KDQogICAgcHRocmVhZF9h
dHRyX2Rlc3Ryb3koJmF0dHIpOw0KDQogICAgcmV0dXJuIDA7DQp9DQoNCmlu
dCB0cnlfbXV0ZXgoY29uc3QgY2hhciAqd2hlcmUpDQp7DQogICAgaW50IHI7
DQogICAgcHRocmVhZF9tdXRleF90IG14Ow0KICAgIHB0aHJlYWRfbXV0ZXhh
dHRyX3QgYXR0cjsNCiAgICBwdGhyZWFkX211dGV4YXR0cl9pbml0KCZhdHRy
KTsNCg0KICAgIHIgPSBwdGhyZWFkX211dGV4X2luaXQoJm14LCAmYXR0cik7
DQogICAgaWYgKHIpIHByaW50ZigiJXM6aW5pdDolZFxuIiwgd2hlcmUsIHIp
Ow0KDQogICAgciA9IHB0aHJlYWRfbXV0ZXhfbG9jaygmbXgpOw0KICAgIGlm
IChyKSBwcmludGYoIiVzOmxvY2s6JWRcbiIsIHdoZXJlLCByKTsNCg0KICAg
IHIgPSBwdGhyZWFkX211dGV4X3VubG9jaygmbXgpOw0KICAgIGlmIChyKSBw
cmludGYoIiVzOnVubG9jazolZFxuIiwgd2hlcmUsIHIpOw0KDQogICAgcHRo
cmVhZF9tdXRleGF0dHJfZGVzdHJveSgmYXR0cik7DQogICAgcHRocmVhZF9t
dXRleF9kZXN0cm95KCZteCk7DQp9DQoNCg0KDQo=

---1463809534-955321501-1248362254=:9450--

