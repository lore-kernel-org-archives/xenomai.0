From: Tobias Marschall <tmarscha@domain.hid>
Subject: Re: [Xenomai-help] Trap Int3
Date: Thu, 20 Apr 2006 10:02:27 +0200
References: <200604192332.17511.tmarscha@domain.hid>
	<4446B634.1060303@domain.hid>
In-Reply-To: <4446B634.1060303@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604201002.27214.tmarscha@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

Hello,

On Thursday 20 April 2006 00:14, Jan Kiszka wrote:
> > I noticed that in /proc/xenomai/faults the count for TRAP 3 (Int3) is >0.
> > I guess that has something to do with running a buggy application of
> > mine, but I would like to know what kind of bug may cause this. I tried
> > google, but I didn't find anything that helped me, could someone please
> > give me a hint?
>
> Do you use a debugger? Int3 on x86 is the debugging trap, inserted by
> gdb&friends to raise a breakpoint.
Oops. :-) Yes I used gdb to hunt a bug. Thank you for the explanation.

Tobias

PS: Sorry for sending the original message twice, but my first message didn't 
appear on the list for over 8 hours so I suspected it to be lost somehow.

