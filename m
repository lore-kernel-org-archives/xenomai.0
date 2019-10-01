In-Reply-To: <4e3b24df-a9ce-f860-081c-f4fc29ea16db@siemens.com>
From: =?utf-8?q?Fran=C3=A7ois_Legal?= <devel@thom.fr.eu.org>
Date: Tue, 01 Oct 2019 15:26:57 +0200
MIME-Version: 1.0
Message-ID: <b7f-5d935400-4b-344a2840@235460703>
Subject: =?utf-8?q?Re=3A?= Kernel crash at startup when enabling RTNet + RTIPv4
Content-Type: text/plain; charset=utf-8
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
Cc: xenomai@xenomai.org

Hello,

Could you please clarify what "upstream" is ? RTNet project ? There doe=
s not seem to be activity there since 2012 ?
I'll be happy to contribute on this. You mention "glue scripting", coul=
d you be more precise to let me try to fix that part too.

Shall I send the patch to this list ?

Thanks

Fran=C3=A7ois

Le Mardi, Octobre 01, 2019 15:10 CEST, Jan Kiszka <jan.kiszka@siemens.c=
om> a =C3=A9crit:
=C2=A0On 01.10.19 15:04, Fran=C3=A7ois Legal via Xenomai wrote:
>
> Hello list,
>
> I've been struggling to get the RTNet + RTIPv4 part to work on a Zynq=
 7000 board. Using source code from stable Xenomai 3.0.9 tarball, and p=
atching a vanilla 4.4.189 linux.
> I consistently had the kernel crash (0 pointer dereference error) at =
startup when enabling either RTIPv4, RTCFG or RTMAC.
>
> I finally found that there "might" be a problem with the Makefile in=C2=
=A0kernel/drivers/net/stack.
> It turns out that (on my system at least), the order in which the pro=
tocol stacks appear in the Makefile is wrong because (I running a kerne=
l with everything builtin, no modules) the protocols are loaded in that=
 order, and thus, (in my case) RTIPv4 gets initialized before stack=5Fm=
gr does which cause it to fail while registering (calling=C2=A0=5F=5Frt=
dev=5Fadd=5Fpack with a not initialized=C2=A0rt=5Fpackets array).
>
> When I reorder the protocols in the Makefile, everything works flawle=
ssly.
>
> I can provide a patch if this needs to be fixed.
>

Upstream does not support built-in RTnet. I suspect we need to sort thi=
s and
more issues out systematically in order to permit that. Also, the glue =
scripting
will need adjustments because of assumptions that RTnet comes in module=
s.

That said, contributions in that directions are welcome!

Jan

--
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux


=C2=A0
