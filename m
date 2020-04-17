From: =?utf-8?B?5aSP5L6v6YeP?= <xia.h.l@lynuc.cn>
References: <002c01d6149b$b2460cf0$16d226d0$@lynuc.cn>
 <d23bccc4-479b-b64e-b1fd-550cf2ab609a@siemens.com>
In-Reply-To: <d23bccc4-479b-b64e-b1fd-550cf2ab609a@siemens.com>
Subject: =?utf-8?Q?=E7=AD=94=E5=A4=8D:_linux4.14+xenomai3.1_real-ti?=
 =?utf-8?Q?me?=
Date: Fri, 17 Apr 2020 18:23:55 +0800
Message-ID: <000001d614a2$4c72fcb0$e558f610$@lynuc.cn>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Language: zh-cn
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: 'Jan Kiszka' <jan.kiszka@siemens.com>, xenomai@xenomai.org
Cc: huang.c.h@lynuc.cn

ok=EF=BC=8Cthanks.

-----=E9=82=AE=E4=BB=B6=E5=8E=9F=E4=BB=B6-----
=E5=8F=91=E4=BB=B6=E4=BA=BA: Jan Kiszka [mailto:jan.kiszka@siemens.com]=20
=E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: 2020=E5=B9=B44=E6=9C=8817=E6=97=A5 =
17:50
=E6=94=B6=E4=BB=B6=E4=BA=BA: =E5=A4=8F=E4=BE=AF=E9=87=8F; =
xenomai@xenomai.org
=E6=8A=84=E9=80=81: huang.c.h@lynuc.cn
=E4=B8=BB=E9=A2=98: Re: linux4.14+xenomai3.1 real-time

Hi Xiahou Liang,

On 17.04.20 11:36, =E5=A4=8F=E4=BE=AF=E9=87=8F via Xenomai wrote:
> dear Xenomai Team:
>=20
> When we tested on the Intel(r) Celeron(r) processor 1047ue (third
> generation) motherboard (using kernel version: 4.1.18, xenomai =
version: 2.6.
> 5, patch: ipipe-core-4.1.18-x86-3. ), The real-time test results meet=20
> the requirements.But the 4.1.18 version of the kernel (xenomai version =

> 2.6.5) running on the Intel(r) Celeron(r) processor 3955U (sixth=20
> generation) motherboard can not guarantee real-time performance
>=20
> And on Intel(r) Celeron(r) processor 3955U (sixth generation)=20
> motherboard (kernel version: 4.14.134, xenomai version: 3.1, patch:
> ipipe-core-4.14.134-x86-2. Patch ), We have done many configuration=20
> modification tests. However, the maximum jitter is 25u under 1ms, the

IOW, the maximum jitter was 975 =C2=B5s? That would be indeed completely =
off.

> real-time test results cannot meet our requirements. Our goal is a=20
> maximum jitter of around 10u.

How did  you measure the latency? Via the Xenomai testsuite (latency) or =
via your own application? If the latter, can you reproduce such =
excessive latencies also with Xenomai tests?

>=20
> We would like to ask what relevant content needs to be modified.
>=20

First of all, don't use 4.14 anymore when starting a new project. It's =
unmaintained Xenomai-wise. Please try with latest 4.19 patch =
(ipipe-core-4.19.114-cip24-x86-12).

Then we would need your kernel .config for that setup if you can still =
reproduce that high latency.

Jan

--
Siemens AG, Corporate Technology, CT RDA IOT SES-DE Corporate Competence =
Center Embedded Linux


