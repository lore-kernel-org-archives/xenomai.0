Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [Xenomai-help] two questions about using rtdm
Date: Mon, 31 Jul 2006 17:33:59 +0300
Message-ID: <02AA386EB831044F8537A696BA785C78A668C8@domain.hid>
In-Reply-To: <44CE11FB.3070309@domain.hid>
From: "Landau, Bracha" <BLandau@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: jan.kiszka@domain.hid
Cc: xenomai@xenomai.org

I don't need deterministic network access, but I was hoping it would impr=
ove performance.

-----Original Message-----
From: jan.kiszka@domain.hid [mailto:jan.kiszka@domain.hid]
Sent: Monday, July 31, 2006 5:22 PM
To: Landau, Bracha
Cc: Wolfgang Grandegger; xenomai@xenomai.org
Subject: Re: [Xenomai-help] two questions about using rtdm


Landau, Bracha wrote:
> I downloaded RTNet and tried to compile it for mpc8260 fcc enet.=20
> I use linux kernel 2.6.14.
> The file drivers/rt_mpc8260_fcc_enet.c did not compile. It's looking fo=
r files named "immap_8260.h" and "immap_cpm2.h", neither of which exists.=

>=20

I think to remember Wolfgang said that 2.6 is not yet supposed to work
with this particular driver. So I better redirect this question for more
details.

But before digging to deep into this: What are you planning to do with
RTnet? My point is if you actually need deterministic network access or
if you may live with relaxed services via normal Linux. It's not that
RTnet is bad :), but it might not be required here.

Jan

*************************************************************************=
**********
This email message and any attachments thereto are intended only for use =
by the addressee(s) named above, and may contain legally privileged and/o=
r confidential information. If the reader of this message is not the inte=
nded recipient, or the employee or agent responsible to deliver it to the=
 intended recipient, you are hereby notified that any dissemination, dist=
ribution or copying of this communication is strictly prohibited. If you =
have received this communication in error, please immediately notify the =
postmaster@domain.hid and destroy the original message.
*************************************************************************=
**********

