Message-ID: <44DA0227.3050700@domain.hid>
Date: Wed, 09 Aug 2006 17:41:27 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] WG: Xenomai vs. RTAI
References: <5D63919D95F87E4D9D34FF7748CE2C2A46DE23@domain.hid>
In-Reply-To: <5D63919D95F87E4D9D34FF7748CE2C2A46DE23@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigA2A151662E6ED26DB73C6FBE"
Sender: jan.kiszka@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Roderik_Wildenburg@domain.hid
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigA2A151662E6ED26DB73C6FBE
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Roderik_Wildenburg@domain.hid wrote:
> Is there a summary of the advantages of Xenomai vs. RTAI ?
> I asked Google and my mail archive about this question but wasn?t very =
succesful.

Probably, because there hasn't been an open and broader discussion on a
public forum yet.

> As far as I know, very much which is true for Xenomai is true for RTAI =
too (userspace realtime, mixing realtime and linux systemcalls, multiple =
skins).

RTAI used to know skins as well - due to the existence of Xenomai or
RTAI/fusion in earlier versions. Now it only knows its own API in its
various revisions, RTDM (which seems to be in a good shape according to
the feedback of RTnet users), and a POSIX wrapping layer (currently
gains a rework/fixing).

> I did not work very much with RTAI (just with kernelspace applications =
and not with LXRT), so I don?t know the disatvantages/advantages of RTAI =
and its prakticability regarding user space support, mixing systemcalls, =
=2E..
>=20
> Perhaps somebody with background in both worlds (probably most of you ?=
) could give me some arguments why Xenomai is the better choice (especial=
ly practicability of the user space support is interesting for me; with X=
enomai it is very easy to manage is it the same with LXRT ?).

Well, you already know most of my arguments, but I will try to repeat
them for all readers (and Google...). Hope I will stay objective, but
everyone should recall that I'm fairly biased now. :)

 o Code organisation and style:
   You may recall my example of the scheduler cores, but I think
   everyone can repeat it with arbitrary code: pick two files from both
   projects that deal with a similar topic, compare their styles and
   then try to grab roughly what they do (start e.g. with [1] and [2],
   then step down the layers). Ask yourself where you would prefer to
   trace down problems if you ever have to (bugs can be everywhere).

 o Development model:
   RTAI's development is widely, today almost exclusively driven by the
   immediate needs of its maintainer. Xenomai is aiming at a far broader
   usage, including a smooth exploitation of upcoming preempt-rt.

   As long as we used RTAI (2001-2005), we always faced quality issues.
   I think I'm allowed to grumble here as we (University of Hannover)
   actively worked on fixing them over the years. Unfortunately,
   continuous changes on the RTAI core didn't let things converge, so we
   finally migrated our robots to Xenomai. I'm twiddling thumbs since
   then - ok, only virtually... ;)

   And this is also attracting significantly more core contributors to
   Xenomai. "Human resources" are most precious (not only) in this
   domain, and I consider Xenomai in a far better position here (though
   we will likely need additional resources in the future given its good
   growth rate).

 o Architecture support:
   I predict RTAI will stay locked on x86 and maybe x86_64 (once we have
   a recent I-pipe patch for that arch). That tightly relates to the
   points above. No one is in sight to start an update of, e.g., PPC
   over latest RTAI. Recently someone worked on an ARM update, but only
   picked an outdated Adeos patch as platform and still struggled with
   getting things clean on the RTAI side.

   In contrast, Xenomai is in use over PPC[64] for quite a while now,
   some ARM subarchs as well, we have Blackfin that is also officially
   advertised by Analog Devices, and IA64, more should follow. There
   must be some reason.

 o Technical features:
   As far as I can tell, there are two major RTAI features that are to
   some degree advantageous compared to Xenomai: immediate IRQ
   dispatching and direct syscall vectoring. It was claimed that they
   have noticeable latency advantages, specifically on low-end. My last
   comparison of RTAI-3.4 from CVS and Xenomai 2.2 from SVN a few weeks
   ago showed about 10% better worst-case latencies of RTAI under load
   on an oldish Pentium 133 MHz. Given the lost cleanness of design, I'm
   absolutely convinced that gain is not worth its price. E.g., direct
   syscalls seem to be one reason why gdb is not always working with
   LXRT processes. But I'm biased, please do your own tests as well.

   Since the requested major modification of the I-pipe model
   (design-wise, not code-wise) got rejected for good reasons, there was
   no more feedback from RTAI at least on this vital commonly used
   component. We've recently identified an issue of the x86-2.4 I-pipe
   patch. RTAI just solved it on its own instead of informing the Adeos
   group so that it can be fixed for all users. Due to this lacking
   cooperation, RTAI can only try to catch up the pace that is made by
   Adeos/I-pipe today. Future kernels will require evolution of I-pipe
   and its users (e.g. adoption to the GTOD infrastructure). It's
   logical now that Xenomai will continue to be first in adopting this.

   And then there is the flexible skin construction kit under Xenomai.

>=20
> And now something completly different, something more idelogical ;-):
> Wouldn?t a bulletin board or a WIKI be a better form of dicussion respe=
ctively knowledge base than a mail archive. The background for this quest=
ion is, that allways when I start a new stupid question I can?t be sure w=
hether this question hasn?t already been dealt with, as my mail archive i=
sn?t complete and also not very good searchable.

Full ack. I've brought up the topic "wiki" a few times as I think it
would be helpful for several purposes.

Bruno, are you listening? Would it be feasible to set up a wiki on
xenomai.org?

Jan


[1]http://www.rts.uni-hannover.de/xenomai/lxr/source/ksrc/skins/native/se=
m.c#L347
[2]http://www.rts.uni-hannover.de/rtai/lxr/source/base/ipc/sem/sem.c#L562=



--------------enigA2A151662E6ED26DB73C6FBE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFE2gInniDOoMHTA+kRAnpgAJ9QfWDDHFF3715Lk6G+oT4zGudxSQCePYlV
NSE1DzJkEJEf00lZg/2/aMw=
=94jg
-----END PGP SIGNATURE-----

--------------enigA2A151662E6ED26DB73C6FBE--

