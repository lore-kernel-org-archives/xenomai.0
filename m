Subject: Re: Xenomai: native skin or CONFIG_XENO_OPT_PERVASIVE disabled.
References: <BB5C4F5E3633C64999D0577F81995AE70286E71C@XMAIL.tecom.nnov.ru>
 <55438112-789f-da93-99ed-0320b6486fa3@siemens.com>
 <DM6PR09MB340211DA1BFC00EF331BE9F3853C0@DM6PR09MB3402.namprd09.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <b17fb997-30c7-f271-56a3-8933b1924098@siemens.com>
Date: Wed, 24 Apr 2019 08:18:00 +0200
MIME-Version: 1.0
In-Reply-To: <DM6PR09MB340211DA1BFC00EF331BE9F3853C0@DM6PR09MB3402.namprd09.prod.outlook.com>
Content-Type: text/plain; charset="windows-1252"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Seeger, Steven D. (GSFC-582.0)[Embedded Flight Systems, Inc]" <steven.seeger@nasa.gov>, Alexander Sharabanov <sharabanov.a@tecomgroup.ru>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 24.04.19 08:11, Seeger, Steven D. (GSFC-582.0)[Embedded Flight Systems, =
Inc]=20
wrote:
> Sorry, but what is CI build?
>=20

https://gitlab.denx.de/Xenomai/xenomai/blob/master/.travis.yml
https://travis-ci.com/xenomai-ci/xenomai/

Jan

> Steven
> -------------------------------------------------------------------------=
-------
> *From:* Jan Kiszka <jan.kiszka@siemens.com>
> *Sent:* Wednesday, April 24, 2019 1:46 AM
> *To:* Alexander Sharabanov; xenomai@xenomai.org; Seeger, Steven D.=20
> (GSFC-582.0)[Embedded Flight Systems, Inc]
> *Subject:* Re: Xenomai: native skin or CONFIG_XENO_OPT_PERVASIVE disabled.
> On 22.04.19 15:36, Alexander Sharabanov via Xenomai wrote:
>> Hi All,
>>=20
>> I am upgrading the linux kernel from linix kernel v2.6.30 to linux 3.16.=
61 (long tern support). Also I have upgraded the Xenomai and ipipe. I upgra=
ded the xenomai to stable /v3.0.x (instead the Xenomai-2.4.10 that I used i=
n old kernel), and ipipe-core-3.16-powerpc-1.patch.  I have got the next er=
ror:=A0 Xenomai: native skin or CONFIG_XENO_OPT_PERVASIVE=20
> disabled. (modprobe xeno_native?). I do not see this options in new Xenom=
ai.=20
> Could you please help me to resolve that.
>=20
> The primary error seems that your userspace is still on 2.5 while the ker=
nel
> part is now on 3.0.
>=20
> Regarding the kernel and ppc: 3.16 will be dead soon as well (early next =
year),
> and we do not test against such old kernels anymore. We do not have an of=
ficial
> ppc ipipe release newer than 4.4.71 or 4.9.51. The 4.9 kernel is no longer
> regularly updated, but 4.4 is - specifically via the STLS CIP kernel - an=
d will
> continue to be.
>=20
> However, ppc is not tested by me, not even build-tested anymore. If you v=
alidate
> ipipe-4.4.y[-cip] from=20
> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__gitlab.denx.de_Xen=
omai_ipipe_branches&d=3DDwICaQ&c=3DApwzowJNAKKw3xye91w7BE1XMRKi2LN9kiMk5Csz=
9Zk&r=3Dr63S9M7Jhsu-Ginn_ewiQeYiA39ideOTJunKLVvbEVs&m=3D2HxaHR_Z81H2hWU2fVH=
4D7v_N6tFRXgEfKqqJID9-HA&s=3DqZatnoFMBt8oA7MdrLnOFzrcfiJp9Q6-hpCfYusFmq8&e=
=3D,=20
> I can do
> the tagging also for ppc (like I'm doing for arm if users report it works=
).
>=20
> Steven, are you planning to refresh the kernel patches beyond that? How a=
bout
> adding CI build for ppc? We would need support on that topic. Otherwise, =
it's
> likely time to bury that arch, like it's happening all around.
>=20
> Jan
>=20
> --=20
> Siemens AG, Corporate Technology, CT RDA IOT SES-DE
> Corporate Competence Center Embedded Linux

