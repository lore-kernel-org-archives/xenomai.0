From: =?iso-8859-1?Q?H=E4nel-Baas=2C_Alexander?=
 <alexander.haenel-baas@sieb-meyer.de>
Date: Thu, 30 Mar 2017 09:04:51 +0000
Message-ID: <9BA84827B30CBE4996725F98F7DC912365356F03@SMExchange01.siebmeyer.org>
References: <9BA84827B30CBE4996725F98F7DC912365354EB5@SMExchange01.siebmeyer.org>
 <fda60c40-a2c9-556c-b84c-b9de4e59ea46@web.de>
In-Reply-To: <fda60c40-a2c9-556c-b84c-b9de4e59ea46@web.de>
Content-Language: de-DE
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai] _X86_VSYSCALL on arm ?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@web.de>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi Jan,

Thanks for your fast response.

> This had no effect on ARM. It was defined by default in configure[.ac], e=
ven on non-x86, but that was fixed as a side effect of 18493575. You will g=
et this with the next latest stable 3.0.x release.

Nice to hear it. I had already expected that.=20

By=20
Alexander

-----Urspr=FCngliche Nachricht-----
Von: Jan Kiszka [mailto:jan.kiszka@web.de]=20
Gesendet: Donnerstag, 30. M=E4rz 2017 10:42
An: H=E4nel-Baas, Alexander; xenomai@xenomai.org
Betreff: Re: _X86_VSYSCALL on arm ?

On 2017-03-30 09:32, H=E4nel-Baas, Alexander wrote:
> Hi,
>=20
> our xenomai application shows CONFIG_XENO_X86_VSYSCALL=3D1, but is is run=
ning on arm machine.
>=20
> We compile the app on a debian x86 host machine with the=20
> OSELAS.Toolchain-2016.06 (arm-v7a-linux-gnueabi) for running on the arm L=
ayerscape (ls1021a) target.
> To get the proper clfags we ask xeno-config with "--skin=3Dalchemy --cfla=
gs".
>=20
> My issue :
> Is CONFIG_XENO_X86_VSYSCALL=3D1 for an arm binary good?
> Where is the step to configure this flag?=20

This had no effect on ARM. It was defined by default in configure[.ac], eve=
n on non-x86, but that was fixed as a side effect of 18493575. You will get=
 this with the next latest stable 3.0.x release.

Jan


