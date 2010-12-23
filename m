Date: Thu, 23 Dec 2010 10:09:07 +0100 (CET)
From: Kolja Waschk <xenoka09@domain.hid>
In-Reply-To: <40767404-D45D-43EF-A547-63278CC78AF7@domain.hid>
Message-ID: <alpine.DEB.1.10.1012231008550.13108@domain.hid>
References: <mailman.13966.1293037981.32598.xenomai@xenomai.org>
	<40767404-D45D-43EF-A547-63278CC78AF7@domain.hid>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED;
	BOUNDARY="-1463809534-241591458-1293095308=:13108"
Content-ID: <alpine.DEB.1.10.1012231008551.13108@domain.hid>
Sender: "Kolja Waschk,,," <xenoka09@domain.hid>
Subject: Re: [Xenomai-help] gdb/gdbserver hangs during rt_task_create
Reply-To: xenoka09@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463809534-241591458-1293095308=:13108
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII; FORMAT=flowed
Content-ID: <alpine.DEB.1.10.1012231008552.13108@domain.hid>

Hi,

> I forgot to describe our problem: Gdb hung at rt_task_start() when trying to 
> step through it. But debugging worked fine if I set a breakpoint in the task

Looks similar, but I observed the problem already with first rt_task_create()
(which, however, causes a call to rt_task_start() for the manager thread(?)).

> body, way after any rt_task_start(). Btw, do you call rt_task_start() from a 
> RT task body?

Yes. To be exact, I call rt_task_create and rt_task_start from my main task,
which is RT after calling rt_task_shadow.

I've attached a small example that allows to examine the behaviour. The following
happens in my setup, i.e. when I start "try" on the Blackfin target with
gdbserver and connect with gdb from the host:

1. gdb set to break at "main" runs to the line with mlockall(...)
2. I can step line by line using "next" to the one with rt_task_create

Regardless now whether I type "next" or set a breakpoint in one of the following
lines up to the rt_task_join line and "cont", gdb just prints the following
lines and seems to freeze. Ctrl-C doesn't do anything. Finally after 8 seconds
the subtask finishes and gdb reports "Program exited normally".


24 if (r == 0) r = rt_task_create(&subtask, "subtask", 0, PRIO, T_FPU|T_JOINABLE);
(gdb)  next
[New Thread 304]
Reading in symbols for ../../../../xenomai-2.5.5.2/src/skins/native/task.c...done.
<freeze>


Kolja


P.S. It's gdbserver 6.5 and gdb 6.6; unmodified Blackfin tools 2010R1-RC4.





---1463809534-241591458-1293095308=:13108
Content-Type: TEXT/X-CSRC; NAME=try.c
Content-Transfer-Encoding: BASE64
Content-ID: <alpine.DEB.1.10.1012231008260.13108@domain.hid>
Content-Description: 
Content-Disposition: ATTACHMENT; FILENAME=try.c

I2luY2x1ZGUgPHN0ZGlvLmg+DQojaW5jbHVkZSA8c3lzL21tYW4uaD4NCiNp
bmNsdWRlIDxuYXRpdmUvdGFzay5oPg0KDQojZGVmaW5lIFBSSU8gNDkNCg0K
dm9pZCBzdWJ0YXNrX2VudHJ5KHZvaWQgKmNvb2tpZSkNCnsNCiAgc2xlZXAo
OCk7DQp9DQoNCmludCBtYWluICgpDQp7DQogIGludCByOw0KICBpbnQgaTsN
CiAgUlRfVEFTSyBtYWludGFzazsNCiAgUlRfVEFTSyBzdWJ0YXNrOw0KDQog
IG1sb2NrYWxsKE1DTF9DVVJSRU5UfE1DTF9GVVRVUkUpOw0KDQogIHIgPSBy
dF90YXNrX3NoYWRvdygmbWFpbnRhc2ssICJtYWludGFzayIsIFBSSU8sIDAp
Ow0KICBpZiAociAhPSAwKSBwcmludGYoIkNvdWxkbid0IHJ0X3Rhc2tfc2hh
ZG93OiAiKTsNCg0KICBpZiAociA9PSAwKSByID0gcnRfdGFza19jcmVhdGUo
JnN1YnRhc2ssICJzdWJ0YXNrIiwgMCwgUFJJTywgVF9GUFV8VF9KT0lOQUJM
RSk7DQogIGlmIChyICE9IDApIHByaW50ZigiQ291bGRuJ3QgcnRfdGFza19j
cmVhdGU6ICIpOw0KDQogIGlmIChyID09IDApIHIgPSBydF90YXNrX3N0YXJ0
KCZzdWJ0YXNrLCBzdWJ0YXNrX2VudHJ5LCBOVUxMKTsNCiAgaWYgKHIgIT0g
MCkgcHJpbnRmKCJDb3VsZG4ndCBydF90YXNrX3N0YXJ0OiAiKTsNCg0KICBp
ZiAociA9PSAwKSBmb3IgKGk9MDsgaTw1OyBpKyspIHsgcHJpbnRmKCJzbGVl
cCAlZFxuIiwgaSk7IHNsZWVwKDEpOyB9DQoNCiAgaWYgKHIgPT0gMCkgciA9
IHJ0X3Rhc2tfam9pbigmc3VidGFzayk7DQogIGlmIChyICE9IDApIHByaW50
ZigiQ291bGRuJ3QgcnRfdGFza19qb2luOiAiKTsNCg0KICBwcmludGYoInI9
JWRcbiIsIHIpOw0KICByZXR1cm4gcjsNCn0NCg==

---1463809534-241591458-1293095308=:13108--

