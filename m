From: Paul <paul_c@domain.hid>
Subject: Re: [Xenomai-help] CAN driver
Date: Fri, 23 Feb 2007 12:31:08 +0000
References: <45DC1D05.1000206@domain.hid> <45DEC91C.7040702@domain.hid>
	<bc4264770702230404w42cc72c2ke9d6f3affe2e7244@domain.hid>
In-Reply-To: <bc4264770702230404w42cc72c2ke9d6f3affe2e7244@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <200702231231.08664.paul_c@domain.hid>
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


Hi Roland

On Friday 23 February 2007 12:04, roland Tollenaar wrote:
> parm: =A0 =A0 =A0 =A0 =A0 irq:The interrupt number (array of byte)
> parm: =A0 =A0 =A0 =A0 =A0 io:The io-port address (array of ushort)
> parm: =A0 =A0 =A0 =A0 =A0 type:The type of interface (sp, epp) (array of =
charp)
>
>
> This is the output. This is probably a beginners question but why irq
> 7 must be supplied and what sp or epp means is not answered by this
> info.

This link should help to answer most of your parallel port questions:=20
http://www.beyondlogic.org/epp/epp.htm

And for kernel calls to control the parallel port, see:=20
http://people.redhat.com/twaugh/parport/html/parportguide.html - The=20
information is relevant to vintage 2.2.x as well as for the latest 2.6.xx=20
kernels.


Regards, Paul.


