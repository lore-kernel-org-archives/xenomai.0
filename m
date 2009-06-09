From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <1244554081.7890.99.camel@domain.hid>
References: <5D63919D95F87E4D9D34FF7748CE2C2A01A4598F@ARVMAIL1.mra.roland-man.biz>
	<1244554081.7890.99.camel@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 09 Jun 2009 15:38:23 +0200
Message-Id: <1244554703.7890.102.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] Some problems with shared memory
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: roderik.wildenburg@domain.hid
Cc: xenomai@xenomai.org

On Tue, 2009-06-09 at 15:28 +0200, Philippe Gerum wrote:
> On Mon, 2009-06-08 at 10:25 +0200, roderik.wildenburg@domain.hid
> > Yes and no: The restriction of a page aligned SHM-size seems to be ab=
olished (I didn=C2=B4t get the error message "No such device or address" =
any more).
> > But my target still stalls, when I kill my test applications in the w=
rong order.
> > For your convenience I appended the test again (start "killtest -c &"=
 then "killtest &" and then kill the last one before the first).
> >=20
>=20
> By "stalls", do you mean a lockup, or does your shell hang upon ^C whil=
e
> the rest of the system keeps running fine?
>=20

In case you still do have access to your system while the killtest
application stalled, then I would be interested by the combined output
of /proc/xenomai/irq, taken 3 times in a row. TIA,

--=20
Philippe.



