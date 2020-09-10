From: Peter Wong <tsnuser@outlook.com>
Subject: Re: RTnet plan to support qdisc, zero copy, XDP?
Date: Thu, 10 Sep 2020 07:44:43 +0000
Message-ID: <SG2PR04MB3253A2BB447D5B9CD5D3697DA4270@SG2PR04MB3253.apcprd04.prod.outlook.com>
References: <SG2PR04MB3253490EE02C550FC8CE8C9BA4280@SG2PR04MB3253.apcprd04.prod.outlook.com>
 <8eeca6c3-2378-f4a8-ac22-dc63014d7e85@siemens.com>
 <SG2PR04MB325373993B097ED04B72B88AA4270@SG2PR04MB3253.apcprd04.prod.outlook.com>,
 <f1ca269d-f911-65cb-2bca-b5c208c01276@siemens.com>
In-Reply-To: <f1ca269d-f911-65cb-2bca-b5c208c01276@siemens.com>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

We can use one NIC on linux(time sync) and cobalt/DPDK(fast data path) in p=
arallel?

________________________________
From: Jan Kiszka <jan.kiszka@siemens.com>
Sent: Thursday, September 10, 2020 2:42 PM
To: Peter Wong <tsnuser@outlook.com>; xenomai@xenomai.org <xenomai@xenomai.=
org>
Subject: Re: RTnet plan to support qdisc, zero copy, XDP?

On 10.09.20 08:34, Peter Wong wrote:
> The plan is to have new xenomai socket API for send RT traffic to
> xenomai core network stack -> then to linux driver?
>
> There is switching overhead between cobalt and linux ?

No, the plan is not using the Linux drivers for the dataplane as that
would defeat the purpose of having a separate scheduling domain with cobalt=
.

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
>
> On 07.09.20 03:45, Peter Wong via Xenomai wrote:
>> Is there any plan for support qdisc, zero copy, XDP in RTnet?
>>
>
> Plans aren't concrete yet, but renovation (or replacement) of RTnet is
> needed, specifically to support TSN. Ideally, we do that with maximum
> reuse of kernel infrastructure, "just" adding the fast-path access from
> an RT application. Or we look into reusing DPDK which is gaining TSN
> support as well and has a Linux-free data path already.
>
> Jan
>
> --
> Siemens AG, Corporate Technology, CT RDA IOT SES-DE
> Corporate Competence Center Embedded Linux
