From: Paul <paul_c@domain.hid>
Subject: Re: [Xenomai-help] RTCAN and tsc
Date: Fri, 9 Mar 2007 15:38:54 +0000
References: <bc4264770703060706x5dafb942weec4d4c2c5756427@domain.hid>
	<E1HPfGn-0003K5-RF@mailer.emlix.com>
	<bc4264770703090717u2a64c148g6000d0d64a488058@domain.hid>
In-Reply-To: <bc4264770703090717u2a64c148g6000d0d64a488058@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <200703091538.54236.paul_c@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org
Cc: Bernard Dautrevaux <bernard.dautrevaux@domain.hid>


Hi Roland

On Friday 09 March 2007 15:17, roland Tollenaar wrote:
> If it is also not possible to optimize the code further then IMHO =A0we
> are looking at a fundamental hardware constraint.

I think it was Sebastian that said there are 14 reads and one write per=20
interrupt - If this is the case, then looking at the Peak parport dongle=20
driver, I see eight IO instructions per read and six per write. A total of=
=20
118 inb(). outb() calls - Not a particulaly large amount, however, a standa=
rd=20
parallel port takes one to two microseconds to service each call, so 200uSe=
c=20
for the interrupt handler would quite reasonable..

 One way to reduce the time spent servicing IO instructions would be to swi=
tch=20
to a PCI based parport card (not sure if it would be compatable with the=20
driver & dongle).. Or alternatively use a PCI CANbus card.


Regards, Paul.


