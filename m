Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [Xenomai-core] RTDM cannot open device
Date: Fri, 6 Apr 2007 11:26:40 +0200
Message-ID: <899865CA54E4444DAF2E3639C04C5F4805EC6A@trillian.at.omicron.at>
In-Reply-To: <46160F89.405@domain.hid>
From: "Richard Cochran" <richard.cochran@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

> From: Gilles Chanteperdrix
> > What am I doing wrong?
>=20
> Maybe you only defined the open_rt callback for your driver and are
> trying to open the driver from a non realt-time thread ?

Thanks, that was it.

Richard

