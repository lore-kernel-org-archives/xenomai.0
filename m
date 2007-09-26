From: Sebastian Smolorz <ssm@domain.hid>
Date: Wed, 26 Sep 2007 11:27:33 +0200
References: <899865CA54E4444DAF2E3639C04C5F4805ED13@domain.hid>
In-Reply-To: <899865CA54E4444DAF2E3639C04C5F4805ED13@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <E1IaTAr-000759-Lj@domain.hid>
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
> I know that this is a bit off topic, yet perhaps some on this list
> have interest or knowledge in this area. I am also posting this idea
> to the linux-arm-kernel list.
>
> I would like to implement the ARM FCSE under Linux, using the Intel
> IXP425 board. Before I start, I would like to ask:
>
> 1. Has any work already been done in this area?

Yes, we at emlix evaluate the feasibility of porting the FASS patch to a=20
modern 2.6 kernel in the context of a customer project. It is far more work=
=20
than expected because central MM implementations both ARM-specific and=20
Linux-general have changed since the 2.4 days. What we have done is to take=
=20
the FASS patch and tried to make it work with the 2.6 line rather than=20
implementing the concepts from scratch. So far, we are able to compile a=20
=46ASS-patched 2.6.21 kernel but it fails when trying to start init. We exp=
ect=20
a huge amount of bugs hiding inside the code yet. No wonder, we are still i=
n=20
the middle of the work. I would call the code far from being releasable but=
=20
before you also begin to do the work we have already performed it is=20
reasonable to post our current status.

We consider to set up a git repository so that you and all interested peopl=
e=20
will be able to clone from it. If anyone feels prepared to contribute code =
to=20
this project we either can provide write access to the repository or do it=
=20
the Linus' way (i.e. we would pull from others' repositories), whichever is=
=20
preferred.


Regards,

Sebastian

=2D-=20
Dipl.-Ing. Sebastian Smolorz, emlix GmbH, http://www.emlix.com
=46on +49 551 30664-0, Fax -11, Bahnhofsallee 1b, 37081 G=F6ttingen, Germany
Gesch=E4ftsf=FChrung: Dr. Uwe Kracke, Dr. Cord Seele, Ust-IdNr.: DE 205 198=
 055
Sitz der Gesellschaft: G=F6ttingen, Amtsgericht G=F6ttingen HR B 3160

emlix - your embedded linux partner

