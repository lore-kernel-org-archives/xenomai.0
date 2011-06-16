Date: Thu, 16 Jun 2011 10:52:21 +0200
From: Pavel Machek <pma@domain.hid>
Message-ID: <20110616085221.GA31375@domain.hid>
References: <4DF5EA11.5010006@domain.hid> <4DF64C3A.6080407@domain.hid>
	<4DF65FC8.1000703@domain.hid> <4DF6F87E.7000500@domain.hid>
	<4DF7436D.6040706@domain.hid> <4DF74640.5070802@domain.hid>
	<4DF8DC11.9000102@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4DF8DC11.9000102@domain.hid>
Subject: Re: [Xenomai-help] Xenomai on i7-870
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jakub Nowacki <j.s.nowacki@domain.hid>
Cc: Jan Kiszka <jan.kiszka@domain.hid>, Xenomai help <xenomai@xenomai.org>


> that. I have SMI workaround switched on. On the other hand I have
> MSI enabled (because I cannot disable them in *config) and Legacy
> USB in BIOS, because, for some reason, my USB keyboard doesn't work
> in grub without it (I cannot select anything in grub but it works
> later in the system correctly).

This may be well it.

GRUB tries to access keyboard controller (it does not have a USB
support), thus you need "Legacy USB" in BIOS. Linux can handle USB and
does not need it.

Get PS/2 keyboard for an experiment...
								Pavel

