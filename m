Date: Wed, 25 Aug 2021 10:30:27 +0800
Subject: Re: Can I use ftrace to analysis cobalt kernel
From: Ivan Jiang <jcgeforce@aliyun.com>
Message-ID: <349738F1-8752-4C1A-883F-10C92585F5E2@aliyun.com>
References: <2EEA4F9C-7739-425E-B57E-1BED69207E6B@aliyun.com>
 <88960bcc-c77b-78a4-dd9c-5d5f7c81e4ce@siemens.com>
 <CALLqZ8REDuHT+CUiFfBeDkC2H8ZBhXU0iP1vDMMo_P8640iEvg@mail.gmail.com>
In-Reply-To: <CALLqZ8REDuHT+CUiFfBeDkC2H8ZBhXU0iP1vDMMo_P8640iEvg@mail.gmail.com>
Mime-version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Greg Gallagher <greg@embeddedgreg.com>, Jan Kiszka <jan.kiszka@siemens.com>
Cc: xenomai@xenomai.org

Hi=EF=BC=8CGerg=EF=BC=9A

=20

=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Already set the stake size to 1408, but still crash after few =
minutes.

=20

Thanks.

=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=20

=20

=20

=20

On Tue, Aug 24, 2021 at 9:22 AM Jan Kiszka via Xenomai <xenomai@xenomai.org=
> wrote:

On 24.08.21 14:48, Ivan Jiang via Xenomai wrote:
> Dear guys:
>=20
> =20
>=20
>        Can I use ftrace to analysis the kernel with patch of ipipe.
>=20
>        I find if use function_graph whe kernel will crash like below:
>=20
>        echo function_graph > current_tracer
>=20
> root@smarc-rzg2l:/sys/kernel/debug/tracing# [  377.392724] Kernel panic -=
 not syncing: kernel stack overflow
>=20
> [  377.399125] CPU: 0 PID: 9 Comm: ksoftirqd/0 Not tainted 4.19.140-cip33=
-g6634f0243a91 #3
>=20
> [  377.407929] Hardware name: RZG2L Evaluation Board Kit (Discrete Power =
System Ver.) (Dual Cortex-A55) (DT)
>=20

That's ARM64 and I-pipe - might not have been tested / fully enabled in
that combination. Try 5.10 with the dovetail patch, there ftrace is
known to work better. Alternatively: the I-pipe tracer should work on
arm64 (though without a nice function graph).

Jan

--=20
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

=20

When you enable ftrace, do you also enable the larger stack size in the ftr=
ace config?

=20

-Greg

=20

