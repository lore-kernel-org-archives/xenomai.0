Date: Sun, 24 Oct 2010 16:55:28 +0100 (BST)
From: edward.robbins@domain.hid
MIME-Version: 1.0
Content-Type: text/plain;charset=UTF-8
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <4CC35937.8060001@domain.hid>
References: <1287845650.32319352@domain.hid> <4CC30152.6060208@domain.hid>
	<1287850862.74211776@domain.hid> <1287851184.14497074@domain.hid>
	<1287859578.113425004@domain.hid> <4CC35937.8060001@domain.hid>
Message-ID: <1287935728.709625318@domain.hid>
Subject: Re: [Xenomai-help] Very high latencies under stress testing
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

>>=0A>> CRID, disabled memory thermal management, turned off lots of ACPI a=
nd=0A> =0A> Pay attention not to disable ACPI completely, as this enables A=
PM, the=0A> legacy power management, and this one causes high latencies.=0A=
> =0A=0AI'm pretty sure it's still enabled.=0A=0A>>=0A>> I'm at a bit of a =
loss. Next I will try to figure out how to read the=0A>> traces. The latenc=
y consistently jumps from <20us (normally around=0A>> 14/15) to just under =
4500us each time I run the test, so I am=0A>> wondering if it is some speci=
fic thing that takes this long. I will=0A>> also try to read the LTP output=
 to see what it's doing when it fails,=0A>> and see if this is consistent.=
=0A>>=0A>> Gilles, I really appreciate all the help, thank you.=0A> =0A> Yo=
u are welcome, no problem. A few things to try: could you try and use=0A> t=
he latest I-pipe for 2.6.35? Just to rule out anything which would have=0A>=
 been fixed since 2.6.32.=0A> =0A=0AI did wonder if I should do this. I'll =
try that next, though I'm not sure when that will be.=0A=0A> Something else=
, did you try to run your system completely without=0A> framebuffer and X-w=
indow? In good old text mode?=0A> =0A=0AYes, all these tests are with X dis=
abled, I'm not even using framebuffer just straight console mode.=0A=0A> I =
do not know what more to suggest. The traces you sent show=0A> consistently=
 ipipe_check_context at the point where you have the issue,=0A> I do not kn=
ow whether this is a coincidence. Do you get any I-pipe=0A> message in the =
kernel logs after the latency peak happens?=0A> =0AI'm fairly sure the answ=
er is no, but will have to double check next time I'm working on the system=
.


