References: <0184EA26B2509940AA629AE1405DD7F201D0EFC5@dggema523-mbx.china.huawei.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <1722eb75-f2e5-3263-5246-61260ab99d4e@siemens.com>
Date: Wed, 27 Jun 2018 18:03:49 +0200
MIME-Version: 1.0
In-Reply-To: <0184EA26B2509940AA629AE1405DD7F201D0EFC5@dggema523-mbx.china.huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] with/without RTmac to the RTnet
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: gengdongjiu <gengdongjiu@huawei.com>, Greg Gallagher <greg@embeddedgreg.com>, Pintu Kumar <pintu.ping@gmail.com>, Philippe Gerum <rpm@xenomai.org>, "Xenomai@xenomai.org" <xenomai@xenomai.org>
Cc: "Ouyangzhaowei (Charles)" <ouyangzhaowei@huawei.com>, yangchuanlong <yangchuanlong@huawei.com>, "zhangjianwei (D)" <zhangjianwei8@huawei.com>, "liupeifeng (A)" <liupeifeng3@huawei.com>

On 2018-06-27 17:32, gengdongjiu wrote:
> Hi,
> 
> Sorry to disturb you, I want to consult with you two questions:
> 
> 1.       For the RTnet,  do you usually using the witout-RTmac mode or
> with-RTmac mode?  From the spec and code, it seems the RTmac is very
>  complex and reduce the real-time.

RTmac was primarily designed for colliding networks, i.e. hub-based
infrastructure. If you know your network load and all your applications
on the network behave (no transmission bursts), you do not need RTmac
(+TDMA).

> 
> 2.       Does the default Xenomai driver supports intel  I210 network
> <?keyword=network> card <?keyword=card>?
> 

That should be the rt_igb IIRC, or rt_e1000e. Give it a try (or compare
PCI IDs in advance).

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

