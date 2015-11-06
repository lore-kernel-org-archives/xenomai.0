From: BECK Fabrice - Contractor <Fabrice.BECK@external.thalesaleniaspace.com>
Date: Fri, 6 Nov 2015 15:03:34 +0000
Message-ID: <75a98ced-93d1-467e-b9ac-61cd71e067c1@THSUMIDEUMSG04P.deu.umi.grp>
Content-Language: de-DE
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] Issue with rt_pipe after update
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>
Cc: NARBONNE Frederic <Frederic.NARBONNE@thalesaleniaspace.com>

Dear Xenomai support,

After a migration from CentOs 6.4 (linux-3.8.13_xenomai-2.6.3) to RHEL 7.1 =
(linux-3.10.32-xenomai-2.6.4) on a new workstation
and update of Xenomai we have transfer rate problems.

On the old machine we managed to get transfer rates of 260 Mbps with our ap=
plication.
On the new machine we are stuck at 78 Mbps with our application.

With some test tool we are able to send at higher rates, so it seems not to=
 be linked to our Ethernet driver.
Our application is the same on both machines.

After some preliminary investigation, we suspect a problem with the rt_pipe=
s (as the problems we see are part of the SW using them),
yet we don't see anything wrong in the Xenomai configuration.
Do you have an idea how we could track down this problem?

In advance many thanks!


Mit freundlichen Gr=FC=DFen / Best regards

Fabrice Beck
Software-Engineer on mission for:
Thales Alenia Space Deutschland GmbH

Phone: +49 7156 353 23580
Fax:      +49 7156 353 28805
Email: fabrice.beck@external.thalesaleniaspace.com<mailto:fabrice.beck@exte=
rnal.thalesaleniaspace.com>
-------------------------------------------------------------------
Thales Alenia Space Deutschland GmbH
Thalesplatz 1 - 71254 Ditzingen - Germany
-------------------------------------------------------------------
Sitz der Gesellschaft/Domicile of the Company: Stuttgart
Amtsgericht/District Court: Stuttgart HRB 735823
Gesch=E4ftsf=FChrer/Managing Director: Sven Carstensen

