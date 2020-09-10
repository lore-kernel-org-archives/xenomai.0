Subject: Re: RTnet plan to support qdisc, zero copy, XDP?
References: <SG2PR04MB3253490EE02C550FC8CE8C9BA4280@SG2PR04MB3253.apcprd04.prod.outlook.com>
 <8eeca6c3-2378-f4a8-ac22-dc63014d7e85@siemens.com>
 <SG2PR04MB325373993B097ED04B72B88AA4270@SG2PR04MB3253.apcprd04.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <f1ca269d-f911-65cb-2bca-b5c208c01276@siemens.com>
Date: Thu, 10 Sep 2020 08:42:38 +0200
MIME-Version: 1.0
In-Reply-To: <SG2PR04MB325373993B097ED04B72B88AA4270@SG2PR04MB3253.apcprd04.prod.outlook.com>
Content-Type: text/plain; charset="windows-1252"
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
To: Peter Wong <tsnuser@outlook.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 10.09.20 08:34, Peter Wong wrote:
> The plan is to have new xenomai socket API for send RT traffic to
> xenomai core network stack -> then to linux driver?=A0
>=20
> There is switching overhead between cobalt and linux ?=20

No, the plan is not using the Linux drivers for the dataplane as that
would defeat the purpose of having a separate scheduling domain with cobalt.

If we used Linux, that would be for setup, background clock
synchronization etc. Dataplane will either require own drivers again, or
we may reuse DPDK.

Jan

> ------------------------------------------------------------------------
> *From:* Jan Kiszka <jan.kiszka@siemens.com>
> *Sent:* Wednesday, September 9, 2020 4:05 PM
> *To:* Peter Wong <tsnuser@outlook.com>; xenomai@xenomai.org
> <xenomai@xenomai.org>
> *Subject:* Re: RTnet plan to support qdisc, zero copy, XDP?
> =A0
> On 07.09.20 03:45, Peter Wong via Xenomai wrote:
>> Is there any plan for support qdisc, zero copy, XDP in RTnet?
>>=20
>=20
> Plans aren't concrete yet, but renovation (or replacement) of RTnet is
> needed, specifically to support TSN. Ideally, we do that with maximum
> reuse of kernel infrastructure, "just" adding the fast-path access from
> an RT application. Or we look into reusing DPDK which is gaining TSN
> support as well and has a Linux-free data path already.
>=20
> Jan
>=20
> --=20
> Siemens AG, Corporate Technology, CT RDA IOT SES-DE
> Corporate Competence Center Embedded Linux

