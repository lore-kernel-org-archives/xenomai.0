Date: Fri, 21 Jan 2011 15:16:08 +0100 (CET)
From: Kolja Waschk <xenoka09@domain.hid>
In-Reply-To: <1295618431.1828.52.camel@domain.hid>
Message-ID: <alpine.DEB.1.10.1101211510130.4003@domain.hid>
References: <OF1911EB62.67FE0A4E-ONC125781E.0029C740-C125781E.002C4F5B@LocalDomain>
	<alpine.DEB.1.10.1101200922440.1211@domain.hid>
	<4D384CC9.2040303@domain.hid>
	<alpine.DEB.1.10.1101201702340.1990@domain.hid>
	<4D386922.5080807@domain.hid> 
	<alpine.DEB.1.10.1101201811090.1990@domain.hid>
	<4D38809E.3080906@domain.hid> <4D388975.80606@domain.hid>
	<alpine.DEB.1.10.1101211225490.3495@domain.hid>
	<1295618431.1828.52.camel@domain.hid>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Sender: "Kolja Waschk,,," <xenoka09@domain.hid>
Subject: Re: [Xenomai-help] debug posix skin - pthread_cond_wait return EPERM
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
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

Hi,

> primary mode loop. In that case, the gdb stub which is part of the
> regular kernel just can't receive the remote "break" command packet sent
> from your host, simply because the remote linux  kernel is not given any
> CPU time.

Thanks for the clarification. I suspected so but the FAQ entry gave me some
hope that I might have been wrong ;) Are there any gdb macros that might help
to gather helpful information about tasks etc. with a debugger on a host
attached to the target via JTAG?

Kolja



