From: Josh Karch <JKarch@domain.hid>
Date: Wed, 9 Dec 2009 10:04:59 -0800
Message-ID: <843773D242212C4882D4EDFFBF665F7F0155A93AA7@domain.hid>
References: <843773D242212C4882D4EDFFBF665F7F0155A93A9D@FW-SBS.fw.local>,
	<4B1FE230.8070702@domain.hid>
In-Reply-To: <4B1FE230.8070702@domain.hid>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Xenomai scheduling while atomic bug--debugging
 parameters
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Gilles,

sounds good-- for now I'm recompiling the kernel with all debug options dis=
abled to see if my program will run stable, but I can make another compilin=
g with all options enabled for kernel debugging, ipipe debugging, and xenom=
ai debugging, run it, send a config.  I have a couple of questions:
1) is it possible to disable all of these debugging parameters in the kerne=
l boot parameter or do I have to recompile
2) What is the best way to collect a trace?  Right now I have copied from k=
ern.log, messages, and syslog (in /var/log), although they are all similar.
3) Is there a quick way to recompile the kernel with these options without =
having to rebuild all the kernel modules or do I need to do a clean and reb=
uild?

Thank you,

Joshua Karch
________________________________________
From: Gilles Chanteperdrix [gilles.chanteperdrix@xenomai.org]
Sent: Wednesday, December 09, 2009 9:45 AM
To: Josh Karch
Cc:=20
Subject: Re: [Xenomai-help] Xenomai scheduling while atomic bug--debugging =
parameters

Josh Karch wrote:
> parameters and see if that resolves the problem:  Any ideas on
> whether that issue was addressed in 2.4.10?

Looking a the thread you show us, the user which had the original
problem seem not to have sent any further data, so chances are that the
issue was not addressed.

The data we are interested in are:
- better stack traces (frame pointer are possibly disabled in your
kernel, it would probably be better if you enabled them)
- kernel configuration
- a run with all xenomai and I-pipe debug options enabled

TIA.

--
                                          Gilles


