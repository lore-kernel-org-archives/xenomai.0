Date: Wed, 15 Apr 2009 20:20:33 -0700 (PDT)
From: Martin Shepherd <mcs@domain.hid>
In-Reply-To: <49E23FB1.5030505@domain.hid>
Message-ID: <Pine.LNX.4.64.0904151951500.9694@domain.hid>
References: <Pine.LNX.4.64.0904081243120.22300@domain.hid>
	<Pine.LNX.4.64.0904081659110.22300@domain.hid>
	<Pine.LNX.4.64.0904101250540.4820@domain.hid>
	<Pine.LNX.4.64.0904101708030.4820@domain.hid>
	<6C68EA7C-72E4-482D-917A-24C7C6DA31C9@domain.hid>
	<Pine.LNX.4.64.0904101729031.4820@domain.hid>
	<49E08F6F.8000604@domain.hid>
	<Pine.LNX.4.64.0904111233180.32647@domain.hid>
	<49E0F887.40805@domain.hid>
	<Pine.LNX.4.64.0904111820330.6444@domain.hid>
	<49E1B05A.4040705@domain.hid>
	<Pine.LNX.4.64.0904121206040.23562@domain.hid>
	<49E23FB1.5030505@domain.hid>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Subject: Re: [Xenomai-help] Running xeno-test
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


On Sun, 12 Apr 2009, Gilles Chanteperdrix wrote:
> Martin Shepherd wrote:
>> On Sun, 12 Apr 2009, Gilles Chanteperdrix wrote:
>>> ...
>>> Could you tell us the versions of Linux and Xenomai you are using and
>>> post your .config ?
>>
>> I am using Xenomai 2.4.7, with Linux kernel 2.6.28.7, under Ubuntu 8.10.
>>
>> The following are the contents of the linux-2.6.28.7/.config file:
>
> Ok. You seem to have avoided the usual pitfalls, however you really have
> a lot of options enabled.

Yes, I started from the config that came with Ubuntu, which has lots
of things turned on. However most of them are modules for drivers that
will never be loaded.

> The symptoms of your problem really look like
> a bug which I had and turned out to be a NO_HZ problem. So, maybe you
> could try and disable CONFIG_NO_HZ ? You can also try to enable
> Xenomai's NMI watchdog, which will fire if a timer overrun occur.

Correct me if I am wrong, but turning on the NMI watchdog appears to
be contingent on having local APIC, which the processor that I am
using (an ancient AMD Athlon), doesn't seem to have.

I have tried disabling CONFIG_NO_HZ (by disabling Tickless System in
"make menuconfig"), but this didn't change the symptoms.

It turns out that just running "dd if=/dev/zero of=/dev/null" on its
own, without running xeno-test, hangs the computer after a random
interval of a few seconds to a minute or so. At that point, the only
thing that wakes it up for a few more seconds, is to hit a key on the
keyboard of the computer, or move the mouse, and after a few times of
doing this, the computer locks up hard and has to be rebooted. I have
verified that this doesn't happen if I boot into Ubuntu with the
2.6.27-11 kernel that came with it.

Martin

