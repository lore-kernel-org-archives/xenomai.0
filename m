Date: Tue, 25 May 2010 13:44:44 +0200
From: Tschaeche IT-Services <services@domain.hid>
Message-ID: <20100525114444.GA30677@domain.hid>
References: <20100520142614.GA23058@domain.hid>
	<1274434121.2444.9.camel@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <1274434121.2444.9.camel@domain.hid>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] Monitoring Xenomai scheduler switches
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
Cc: xenomai@xenomai.org

On Fri, May 21, 2010 at 11:28:41AM +0200, Philippe Gerum wrote:
> > ...
> > It seems, that our code is not called when Xenomai switches to the RO=
OT task.
> >=20
> > We already had this issue with Xenomai 2.4.10
> > and solved it by applying the attached patch.
> >=20
> > How can we catch these Xenomai scheduler events in 2.5.3?
> >=20
> > What is the reason for filtering them out?
>=20
> No valid one. Patch queued in my tree, thanks.
=20
Just tested your queued patch for 2.5.3 in our build.
Looks great now: we are able to trace all context switches now :-)

Thanks,

   Olli

--=20
Tschaeche IT-Services       Tel.:  +49/9134/9089850
Dr.-Ing. Oliver Tsch=E4che    Mobil: +49/176/20435601
Welluckenweg 4              Email: services@domain.hid
91077 Neunkirchen

