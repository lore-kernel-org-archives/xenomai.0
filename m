Message-ID: <21067.194.114.62.68.1187272557.squirrel@domain.hid>
In-Reply-To: <2ff1a98a0708160639k555fbb48p98a13892e30e5b02@domain.hid>
References: <61839.194.114.62.68.1187258167.squirrel@domain.hid>
	<2ff1a98a0708160300r79a717ebt7541c1d6e3da6687@domain.hid>
	<11886.194.114.62.68.1187258877.squirrel@domain.hid>
	<18116.9932.592597.831501@domain.hid>
	<56493.194.114.62.68.1187265227.squirrel@domain.hid>
	<2ff1a98a0708160639k555fbb48p98a13892e30e5b02@domain.hid>
Date: Thu, 16 Aug 2007 15:55:57 +0200 (CEST)
From: "Nadym Salem" <Kaiman@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] latency problems
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

On Thu, August 16, 2007 15:39, Gilles Chanteperdrix wrote:

>> >  > >> trying to use RTnet and having massive synchronisation problem=
s,
>> a
>> >  > >> problem
>> >  > >> with xenomai latencies came up.
>> >  > >> Our xenomai latency test gives weird values. Attached a
>> xeno-test
>> > log.
>> >  > >> Does anyone have an idea ?
>> >  > > Yes, read the FAQ and try the proposed workarounds.
>> >  > Sorry not to mention it. Of course we used all the settings in th=
e
>> FAQ
>> > and
>> > What does your kernel logs say about SMI workaround, is it working ?
>> It does not say anything about SMI, reading the Torubleshoothing file,
>> it
>> sound like there should be a warning if it is not working.
> But you should get a message "SMI enabled" in the kernel logs. Do you g=
et
> it ?

Nope...there isn't an entry with SMI at all in all /var/log/*

>> >  > Or am I just too blind to find other workarounds there ?
>> > There is also the X-server workaround, and the Legacy USB workaround=
.
>> No HW Acceleration on.
>> Legacy USB Option in Bios is missing (like a lot more... :-/ )
>> > What version of Xenomai are you using ?
>> Xenomai 2.3.2 with Linux Kernel 2.6.20
> In case there is a bug in the newly introduced direct access to tsc
> from posix clock functions, could you re-compile with access to hw tsc
> disabled and re-run cyclictest ?

I could, just being not able to find the option ;)

Greets, Nadym



