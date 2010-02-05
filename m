Date: Fri, 5 Feb 2010 11:37:44 +0100
From: Tschaeche IT-Services <services@domain.hid>
Message-ID: <20100205103744.GA12904@domain.hid>
References: <20100204105700.GB20669@domain.hid>
	<4B6ADA01.2080803@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <4B6ADA01.2080803@domain.hid>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] Force switch back to primary domain
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

Hi,

On Thu, Feb 04, 2010 at 03:30:25PM +0100, Gilles Chanteperdrix wrote:
> It would be nice if you could try Xenomai 2.5.1, the latest stable
> release, to see if you are not having a problem that we already fixed.

it seems as we (Henri and me) have problems with the mutex implementation
(FAST_SYNC) in 2.5.1. we'll try and give you feedback when we have time
to debug this issue.

> > which returns without error. but, when calling rt_dev_ioctl()
> > again, the non realtime version function of the driver ioctl_nrt
> > is called (where i can't use rtdm_event_wait()).
>=20
> in ioctl_nrt, return -ENOSYS, Xenomai will switch back your task to
> primary mode, and call the rt ioctl.

great - that's what a was looking for!

Thank you,

	Olli

--=20
Tschaeche IT-Services       Tel.:  +49/9134/9089850
Dr.-Ing. Oliver Tsch=E4che    Mobil: +49/176/20435601
Welluckenweg 4              Email: services@domain.hid
91077 Neunkirchen

