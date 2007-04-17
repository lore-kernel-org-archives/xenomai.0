From: Jeff Weber <jweber@domain.hid>
Date: Tue, 17 Apr 2007 15:59:52 -0500
References: <200704161449.27506.jweber@domain.hid>
	<200704170821.10282.jweber@domain.hid>
	<17957.7492.656703.120363@domain.hid>
In-Reply-To: <17957.7492.656703.120363@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200704171559.52298.jweber@domain.hid>
Subject: Re: [Xenomai-help] page faults
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
Cc: Xenomai Help <xenomai@xenomai.org>

On Tuesday 17 April 2007 14:17, Gilles Chanteperdrix wrote:

> Ok. I am afraid you will have to help us a bit. Could you try Xenomai
> 2.3.1 in case the nocow patch magically solves your issue ?
Will do.  That may take a little while due to other considerations on this 
end.  I'll get back to you.
>
> If it does not, could you try sizing down your program to a small
> example that we could run to reproduce the issue ?
I've already been working on this, with no luck so far.
>
> If reducing your program is not possible, the only option left is to
> start debugging this issue. A good starting point would be to put some
> printks in arch/i386/mm/fault.c to see what kind of page fault is
> causing the mode switch.
Let's hope it doesn't come to this.  :-)

	Jeff

