Content-Type: text/plain; charset="utf-8"
In-Reply-To: <f15068ac-b798-ebb0-beca-05d6e36e0c1f@siemens.com>
From: =?utf-8?q?Fran=C3=A7ois_Legal?= <devel@thom.fr.eu.org>
Date: Wed, 04 Mar 2020 18:40:55 +0100
MIME-Version: 1.0
Message-ID: <7231-5e5fe800-13-3b6a0580@56070974>
Subject: =?utf-8?q?Re=3A?= GPIO interrupt not working on Zynq7000
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Greg Gallagher <greg@embeddedgreg.com>, =?utf-8?q?Xenomai=40xenomai=2Eorg?= <xenomai@xenomai.org>

Le Mercredi, Mars 04, 2020 18:13 CET, Jan Kiszka <jan.kiszka@siemens.co=
m> a =C3=A9crit: 
 
> On 04.03.20 18:04, Fran=C3=A7ois Legal wrote:
> > So to terminate on that ipipe topic, I checked the legacy ipipe 4.4=
.y / 4.4.y-cip branches, and none fo them seem to handle the zynq-gpio =
correctly. It looks like this has been fixed in 4.9.y branch.
> > 
> > Shall I submit a patch on this ?
> 
> That would be perfect. I already cherry-picked a few ARM patches from=
 
> newer releases that Philippe pointed me to. If those apply, just list=
 
> the commit shas. If not, please send the adjusted ones as backport. I=
 
> would recommend to also check ipipe-4.19 for potential further fixes.=

> 
> Jan
> 
> -- 
> Siemens AG, Corporate Technology, CT RDA IOT SES-DE
> Corporate Competence Center Embedded Linux
 
 I think this "389e3638" is the one

Fran=C3=A7ois


