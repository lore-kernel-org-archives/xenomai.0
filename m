Date: Fri, 24 Feb 2006 06:00:36 -0800
Subject: Re: [Xenomai-help] no-brainer issue found, but not solved
From: Steven Seeger <steve@domain.hid>
Message-ID: <C0245184.24F9%steve@domain.hid>
In-Reply-To: <43FECB82.6040802@domain.hid>
Mime-version: 1.0
Content-type: text/plain;
	charset="US-ASCII"
Content-transfer-encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

I didn't get Jan's original response to my messages. I haven't seen what he
wrote until Philippe's response.

> 
> To be precise, the Linux kernel as a whole will inherit the RT priority of the
> syslog caller until the latter suspends Linux-wise, which is quite possible
> due to 
> the way syslog works.

Hmm, I thought threads in the secondary domain ran at the same priority as
Linux but I didn't know that Linux was elevated also. This is good to know,
thanks.

Since my program is working correctly on the new board, my boss doesn't want
to bother with the geode for now. Again, something is amiss if this program
that uses 100% of the cpu on the geode uses hardly any on another board.

Steven


