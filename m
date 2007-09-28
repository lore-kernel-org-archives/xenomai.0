From: Sebastian Smolorz <ssm@domain.hid>
Date: Fri, 28 Sep 2007 18:47:52 +0200
References: <899865CA54E4444DAF2E3639C04C5F4805ED1F@trillian.at.omicron.at>
In-Reply-To: <899865CA54E4444DAF2E3639C04C5F4805ED1F@trillian.at.omicron.at>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <E1IbJ04-0001K5-3D@mailer.emlix.com>
Subject: Re: [Xenomai-core] [RFC] Fast Context Switch Extension for ARM Linux
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Richard Cochran <richard.cochran@domain.hid>
Cc: xenomai@xenomai.org

Richard Cochran wrote:
> > -----Original Message----- From: Sebastian Smolorz
> > Sent: Wednesday, September 26, 2007 11:28 AM
> >
> > We consider to set up a git repository so that you and all
> > interested people will be able to clone from it. If anyone feels
> > prepared to contribute code to this project we either can provide
> > write access to the repository or do it the Linus' way (i.e. we
> > would pull from others' repositories), whichever is preferred.
>
> For now, can you post a diff against a known vanilla kernel version?
>
> Perhaps later we can set up a public project.

Nevertheless, here comes our git repository:
http://git.opensource.emlix.com

Note that this patch is far less than finished. It is hackish, it does not=
=20
work, but you asked for it. ;-)

The current status is: Sometimes the kernel boots properly and I get a shel=
l=20
prompt. Then a 'ls' is possible, sometimes two but then the systems freezes.

Still a lot of work to do but we are ready to do it and are confident of=20
getting this beast running.

If anyone is interested: Don't hesitate to help.


Regards,

Sebastian

=2D-=20
Dipl.-Ing. Sebastian Smolorz, emlix GmbH, http://www.emlix.com
=46on +49 551 30664-0, Fax -11, Bahnhofsallee 1b, 37081 G=F6ttingen, Germany
Gesch=E4ftsf=FChrung: Dr. Uwe Kracke, Dr. Cord Seele, Ust-IdNr.: DE 205 198=
 055
Sitz der Gesellschaft: G=F6ttingen, Amtsgericht G=F6ttingen HR B 3160

emlix - your embedded linux partner

