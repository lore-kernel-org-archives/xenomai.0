References: <9BA84827B30CBE4996725F98F7DC912365354EB5@SMExchange01.siebmeyer.org>
From: Jan Kiszka <jan.kiszka@web.de>
Message-ID: <fda60c40-a2c9-556c-b84c-b9de4e59ea46@web.de>
Date: Thu, 30 Mar 2017 10:42:17 +0200
MIME-Version: 1.0
In-Reply-To: <9BA84827B30CBE4996725F98F7DC912365354EB5@SMExchange01.siebmeyer.org>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] _X86_VSYSCALL on arm ?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?UTF-8?Q?H=c3=a4nel-Baas=2c_Alexander?= <alexander.haenel-baas@sieb-meyer.de>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 2017-03-30 09:32, H=E4nel-Baas, Alexander wrote:
> Hi,
> =

> our xenomai application shows CONFIG_XENO_X86_VSYSCALL=3D1, but is is run=
ning on arm machine.
> =

> We compile the app on a debian x86 host machine with the OSELAS.Toolchain=
-2016.06 (arm-v7a-linux-gnueabi) for =

> running on the arm Layerscape (ls1021a) target.
> To get the proper clfags we ask xeno-config with "--skin=3Dalchemy --cfla=
gs".
> =

> My issue :
> Is CONFIG_XENO_X86_VSYSCALL=3D1 for an arm binary good?
> Where is the step to configure this flag? =


This had no effect on ARM. It was defined by default in configure[.ac],
even on non-x86, but that was fixed as a side effect of 18493575. You
will get this with the next latest stable 3.0.x release.

Jan

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: OpenPGP digital signature
URL: <http://xenomai.org/pipermail/xenomai/attachments/20170330/c0ffef2c/at=
tachment.sig>
