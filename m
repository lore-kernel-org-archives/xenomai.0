Message-ID: <517956F9.3010404@web.de>
Date: Thu, 25 Apr 2013 18:16:57 +0200
From: Jan Kiszka <jan.kiszka@web.de>
MIME-Version: 1.0
References: <51757858.6040604@bollue.de> <51767C09.3070502@siemens.com>
	<51769250.7050504@bollue.de> <5176950F.3040702@siemens.com>
	<5176AB28.7000305@bollue.de> <5176AC37.1040405@siemens.com>
	<5176C108.5050102@bollue.de> <5176C24B.3000300@siemens.com>
	<5176E0D2.2080101@bollue.de> <51778E9A.7090206@siemens.com>
	<5177D2EA.7060306@bollue.de>
In-Reply-To: <5177D2EA.7060306@bollue.de>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Sporadic freeze using RTnet
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Kai Bollue <mlist1@bollue.de>
Cc: Xenomai <xenomai@xenomai.org>

On 2013-04-24 14:41, Kai Bollue wrote:
> On 24.04.2013 09:49, Jan Kiszka wrote:
>> Yep, that's it, thank you very much.
>>
>> Does the rt_8139too driver support pre-mapping?
>> Nope, only the two I mentioned (simply because they are more common on
>> platforms that have >4G and/or an IOMMU). But - wait - the 8139too has a
>> fixed DMA window (due to some older chips) and therefore does copying
>> to/from a pre-allocated bounce buffer on its own. That makes it work
>> with IOMMUs as well.
> =

> OK, this means that cards using the RTL 8139 are currently the only
> non-Intel cards that work correctly with RTnet and > 4 GB of RAM, right?
> Maybe this information should be put somewhere googleable, as modern
> systems tend to have much RAM - and often still PCI slots.

True. There is an RTnet-related section on the Xenomai Wiki, and I'm
always open for patches against the in-tree doc of RTnet.

Jan


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 263 bytes
Desc: OpenPGP digital signature
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20130425/a61ed1a=
5/attachment.pgp>
