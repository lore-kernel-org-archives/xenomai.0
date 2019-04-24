From: "Seeger, Steven D. (GSFC-582.0)[Embedded Flight Systems, Inc]"
 <steven.seeger@nasa.gov>
Subject: Re: Xenomai: native skin or CONFIG_XENO_OPT_PERVASIVE disabled.
Date: Wed, 24 Apr 2019 06:10:14 +0000
Message-ID: <DM6PR09MB3402364C4B51AF4E5095788D853C0@DM6PR09MB3402.namprd09.prod.outlook.com>
References: <BB5C4F5E3633C64999D0577F81995AE70286E71C@XMAIL.tecom.nnov.ru>,
 <55438112-789f-da93-99ed-0320b6486fa3@siemens.com>
In-Reply-To: <55438112-789f-da93-99ed-0320b6486fa3@siemens.com>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>, Alexander Sharabanov <sharabanov.a@tecomgroup.ru>, "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi guys.

I released a 4.14.36 ipipe patch last June. I used the tags mechanism that =
Philippe did. The latest tag is ipipe-core-4.14.36-ppc32-1.1.

You can find this stuff at: https://gitlab.denx.de/Xenomai/ipipe-ppc32 or h=
ttps://xenomai.org/downloads/ipipe/v4.x/ppc32/ for a quick download link.

We made ipipe-ppc32. The ppc64 arch is now removed as there was an RFC and =
nobody spoke up. I have no hardware to test on it.

We are moving forward with xenomai/ppc32 at NASA and our arinc653 implement=
ation. The current thinking is while it may not fly, it can at least be a v=
iable (and free) development platform for arinc-653 applications that can t=
hen be moved to commercial proprietary platforms with certification if need=
-be.

Steven

________________________________
From: Jan Kiszka <jan.kiszka@siemens.com>
Sent: Wednesday, April 24, 2019 1:46 AM
To: Alexander Sharabanov; xenomai@xenomai.org; Seeger, Steven D. (GSFC-582.=
0)[Embedded Flight Systems, Inc]
Subject: Re: Xenomai: native skin or CONFIG_XENO_OPT_PERVASIVE disabled.

On 22.04.19 15:36, Alexander Sharabanov via Xenomai wrote:
> Hi All,
>
> I am upgrading the linux kernel from linix kernel v2.6.30 to linux 3.16.6=
1 (long tern support). Also I have upgraded the Xenomai and ipipe. I upgrad=
ed the xenomai to stable /v3.0.x (instead the Xenomai-2.4.10 that I used in=
 old kernel), and ipipe-core-3.16-powerpc-1.patch. I have got the next erro=
r:  Xenomai: native skin or CONFIG_XENO_OPT_PERVASIVE disabled. (modprobe x=
eno_native?). I do not see this options in new Xenomai. Could you please he=
lp me to resolve that.

The primary error seems that your userspace is still on 2.5 while the kerne=
l
part is now on 3.0.

Regarding the kernel and ppc: 3.16 will be dead soon as well (early next ye=
ar),
and we do not test against such old kernels anymore. We do not have an offi=
cial
ppc ipipe release newer than 4.4.71 or 4.9.51. The 4.9 kernel is no longer
regularly updated, but 4.4 is - specifically via the STLS CIP kernel - and =
will
continue to be.

However, ppc is not tested by me, not even build-tested anymore. If you val=
idate
ipipe-4.4.y[-cip] from https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3=
A__gitlab.denx.de_Xenomai_ipipe_branches&d=3DDwICaQ&c=3DApwzowJNAKKw3xye91w=
7BE1XMRKi2LN9kiMk5Csz9Zk&r=3Dr63S9M7Jhsu-Ginn_ewiQeYiA39ideOTJunKLVvbEVs&m=
=3D2HxaHR_Z81H2hWU2fVH4D7v_N6tFRXgEfKqqJID9-HA&s=3DqZatnoFMBt8oA7MdrLnOFzrc=
fiJp9Q6-hpCfYusFmq8&e=3D, I can do
the tagging also for ppc (like I'm doing for arm if users report it works).

Steven, are you planning to refresh the kernel patches beyond that? How abo=
ut
adding CI build for ppc? We would need support on that topic. Otherwise, it=
's
likely time to bury that arch, like it's happening all around.

Jan

--
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux
