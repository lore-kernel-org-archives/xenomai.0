Date: Mon, 27 Dec 2010 15:44:17 +0100 (CET)
From: Kolja Waschk <xenoka09@domain.hid>
In-Reply-To: <alpine.DEB.1.10.1012221012270.10955@domain.hid>
Message-ID: <alpine.DEB.1.10.1012271521010.20479@domain.hid>
References: <alpine.DEB.1.10.1012211818430.9596@domain.hid>
	<4D110810.1090504@domain.hid>
	<alpine.DEB.1.10.1012221012270.10955@domain.hid>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED;
	BOUNDARY="-1463809534-1070373248-1293461057=:20479"
Sender: "Kolja Waschk,,," <xenoka09@domain.hid>
Subject: [Xenomai-help] gdb/gdbserver and pthread_cond_wait (was:
	gdb/gdbserver hangs...)
Reply-To: Kolja Waschk <xenoka09@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Xenomai GNA <xenomai@xenomai.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463809534-1070373248-1293461057=:20479
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed

Hi,

I've made up a small test program for my issue with pthread_cond_wait and gdb.
Sorry for posting code again, I've made it as compact as possible.

The behaviour of the attached program depends on whether it is run via
gdbserver or without.


When run via gdbserver, the pthread_cond_wait sometimes returns EPERM:

> Remote debugging from host 10.0.10.10
> T0: pthread_cond_wait: 1
> ... repeats for T0 and T1 ...
> T1: pthread_cond_wait: 1
> T1: pthread_cond_wait: 1
> T0: pthread_cond_wait: 1
> T2: pthread_cond_wait: 0
> Child exited with retcode = 0


Started directly, it prints what I would expect:

> T0: pthread_cond_wait: 0
> T1: pthread_cond_wait: 0
> T2: pthread_cond_wait: 0


Am I missing something when configuring the threads, cond variable etc.?

About my environment:

  - Xenomai 2.5.5.2, unmodified
  - blackfin FDPIC toolchain 2010R1-RC4 (gcc 4.3.5, gdb 6.6, gdbserver 6.5)
  - blackfin-linux-dist 2010R1-RC5 (kernel 2.6.34 with I-pipe upgraded to 1.15-01)


I compile "try.c" with the following command line:

bfin-linux-uclibc-gcc \
   -I/opt/uClinux/blackfin-linux-dist/staging/usr/include \
   -L/opt/uClinux/blackfin-linux-dist/staging/usr/lib \
   -Wl,@/opt/uClinux/blackfin-linux-dist/staging/usr/lib/posix.wrappers \
   -g -fPIC -fmessage-length=0 -mfast-fp -D_GNU_SOURCE -D_REENTRANT -D__XENO__ \
   -o try try.c -lxenomai -lpthread_rt


The gdb script contains only a few commands:

set verbose on
set solib-absolute-prefix notexistent
set solib-search-path /opt/uClinux/blackfin-linux-dist/staging/usr/lib:/opt/uClinux/bfin-linux-uclibc/bfin-linux-uclibc/runtime/lib
file try 
target remote 10.0.10.9:2222
break main
cont
cont


The pthread_cond_wait, returning EPERM immediately, causes a lockup in a
program that I'm trying to debug (see old thread about gdb/gdbserver hanging).
I currently know no measure against this behaviour other than to sleep for a
while in that case...

Thanks for any hints!
Kolja

---1463809534-1070373248-1293461057=:20479
Content-Type: TEXT/x-csrc; name=try.c
Content-Transfer-Encoding: BASE64
Content-ID: <alpine.DEB.1.10.1012271544150.20479@domain.hid>
Content-Description: 
Content-Disposition: attachment; filename=try.c

LyogMjAxMC0xMi0yNyAtIHRlc3QgcHJvZ3JhbSBmb3IgcHRocmVhZF9jb25k
X3dhaXQgKi8NCg0KI2luY2x1ZGUgPHN0ZGlvLmg+DQojaW5jbHVkZSA8c3Ry
aW5nLmg+DQojaW5jbHVkZSA8cHRocmVhZC5oPg0KDQojZGVmaW5lIFBSSU9S
SVRZIDENCiNkZWZpbmUgTlVNX1RIUkVBRFMgMw0KDQp2b2xhdGlsZSBpbnQg
cnVuOw0KcHRocmVhZF9jb25kX3QgY29uZDsNCnB0aHJlYWRfbXV0ZXhfdCBt
dXRleDsNCg0Kdm9pZCogdGVzdF90aHJlYWQodm9pZCAqY29va2llKQ0Kew0K
ICAgIGludCB0bnVtID0gKihpbnQqKWNvb2tpZTsNCg0KICAgIHB0aHJlYWRf
bXV0ZXhfbG9jaygmbXV0ZXgpOw0KICAgIHdoaWxlIChydW4pDQogICAgew0K
ICAgICAgICBpbnQgciA9IHB0aHJlYWRfY29uZF93YWl0KCZjb25kLCAmbXV0
ZXgpOw0KICAgICAgICBwcmludGYoIlQlZDogcHRocmVhZF9jb25kX3dhaXQ6
ICVkXG4iLCB0bnVtLCByKTsNCiAgICB9DQogICAgcHRocmVhZF9tdXRleF91
bmxvY2soJm11dGV4KTsNCg0KICAgIHJldHVybiBOVUxMOw0KfQ0KDQppbnQg
bWFpbiAodm9pZCkNCnsNCiAgICBpbnQgaSwgcjsNCiAgICBpbnQgdG51bVtO
VU1fVEhSRUFEU107DQogICAgcHRocmVhZF90IHRpZFtOVU1fVEhSRUFEU107
DQoNCiAgICBydW4gPSAxOw0KICAgIHIgPSBwdGhyZWFkX2NvbmRfaW5pdCgm
Y29uZCwgTlVMTCk7IGlmIChyIT0wKSBwcmludGYoImNvbmRfaW5pdDogJWRc
biIsIHIpOw0KICAgIHIgPSBwdGhyZWFkX211dGV4X2luaXQoJm11dGV4LCBO
VUxMKTsgaWYgKHIhPTApIHByaW50ZigibXV0ZXhfaW5pdDogJWRcbiIsIHIp
Ow0KDQogICAgZm9yIChpPTA7IGk8TlVNX1RIUkVBRFM7IGkrKykNCiAgICB7
DQogICAgICAgIHRudW1baV0gPSBpOw0KICAgICAgICByID0gcHRocmVhZF9j
cmVhdGUoJih0aWRbaV0pLCBOVUxMLCB0ZXN0X3RocmVhZCwgJih0bnVtW2ld
KSk7DQogICAgICAgIGlmIChyIT0wKSBwcmludGYoImNyZWF0ZSglZCk6ICVk
XG4iLCBpLCByKTsNCiAgICB9DQoNCiAgICBzbGVlcCgxKTsNCiAgICBydW4g
PSAwOw0KICAgIHIgPSBwdGhyZWFkX2NvbmRfYnJvYWRjYXN0KCZjb25kKTsg
aWYgKHIhPTApIHByaW50ZigiY29uZF9icm9hZGNhc3Q6ICVkXG4iLCByKTsN
Cg0KICAgIGZvciAoaT0wOyBpPE5VTV9USFJFQURTOyBpKyspDQogICAgew0K
ICAgICAgICB2b2lkICpycDsNCiAgICAgICAgciA9IHB0aHJlYWRfam9pbih0
aWRbaV0sICZycCk7DQogICAgICAgIGlmIChyIT0wKSBwcmludGYoImpvaW4o
JWQpOiAlZFxuIiwgaSwgcik7DQogICAgfQ0KDQogICAgcmV0dXJuIHI7DQp9
DQo=

---1463809534-1070373248-1293461057=:20479--

