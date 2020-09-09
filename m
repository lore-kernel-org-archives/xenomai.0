Subject: Re: RTnet plan to support qdisc, zero copy, XDP?
References: <SG2PR04MB3253490EE02C550FC8CE8C9BA4280@SG2PR04MB3253.apcprd04.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <8eeca6c3-2378-f4a8-ac22-dc63014d7e85@siemens.com>
Date: Wed, 9 Sep 2020 10:05:36 +0200
MIME-Version: 1.0
In-Reply-To: <SG2PR04MB3253490EE02C550FC8CE8C9BA4280@SG2PR04MB3253.apcprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Peter Wong <tsnuser@outlook.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 07.09.20 03:45, Peter Wong via Xenomai wrote:
> Is there any plan for support qdisc, zero copy, XDP in RTnet?
> 

Plans aren't concrete yet, but renovation (or replacement) of RTnet is
needed, specifically to support TSN. Ideally, we do that with maximum
reuse of kernel infrastructure, "just" adding the fast-path access from
an RT application. Or we look into reusing DPDK which is gaining TSN
support as well and has a Linux-free data path already.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

