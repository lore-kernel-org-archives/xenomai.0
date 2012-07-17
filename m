From: "Jorge Ramirez Ortiz,  HCL Europe" <Jorge.Ramirez-Ortiz@hcl.com>
Date: Tue, 17 Jul 2012 16:16:45 +0100
Message-ID: <4F534D1A615F544D95E57BFD8460658301CBE3D2@GEO-HCLT-UKEVS1.GEO.CORP.HCL.IN>
References: <4F534D1A615F544D95E57BFD8460658301CBE3D1@GEO-HCLT-UKEVS1.GEO.CORP.HCL.IN>
	<50057E14.3080904@grandegger.com>,<50057E9C.8080508@siemens.com>
In-Reply-To: <50057E9C.8080508@siemens.com>
Content-Language: en-GB
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Edge interrupts on PCI drivers
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>, Wolfgang Grandegger <wg@grandegger.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

sure  all PCI interrupts are level  (I wasnt referring to PCIe).

I think in the case of these PCI multidevice boards, the only way to handle=
 the edge interrupt sources  is to disable the particular edge interrupt in=
 the ISR and re-enable it only after the condition is cleared. IF the condi=
tion is not cleared or the interrupt is not attended, even if it is an edge=
 interrupt,. the CPU thinks the PCI device it is trying to interrupt again. =


Sorry this wasnt Xenomai specific...just talking to myself...

[also apologies about the top posting. maybe I should copy/paste my comment=
s at the bottom of the thread...]

________________________________________
From: Jan Kiszka [jan.kiszka@siemens.com]
Sent: 17 July 2012 16:02
To: Wolfgang Grandegger; Jorge Ramirez Ortiz,  HCL Europe
Cc: xenomai@xenomai.org
Subject: Re: [Xenomai] Edge interrupts on PCI drivers

On 2012-07-17 17:00, Wolfgang Grandegger wrote:
> On 07/17/2012 04:57 PM, Jorge Ramirez Ortiz, HCL Europe wrote:
>> Typical PCI devices have many sources of interrupts (some level, some ed=
ge triggered) normally all routed through PIN A.
>
> AFAIC, PCI interrupts are *always* level sensitive.

More precisely, legacy INTx are level triggered, MSI/MSI-X interrupts
are edge. About which type are we talking here?

Jan

--
Siemens AG, Corporate Technology, CT RTC ITP SDP-DE
Corporate Competence Center Embedded Linux




::DISCLAIMER::
---------------------------------------------------------------------------=
-------------------------------------------------------------------------

The contents of this e-mail and any attachment(s) are confidential and inte=
nded for the named recipient(s) only.
E-mail transmission is not guaranteed to be secure or error-free as informa=
tion could be intercepted, corrupted,
lost, destroyed, arrive late or incomplete, or may contain viruses in trans=
mission. The e mail and its contents
(with or without referred errors) shall therefore not attach any liability =
on the originator or HCL or its affiliates.
Views or opinions, if any, presented in this email are solely those of the =
author and may not necessarily reflect the
views or opinions of HCL or its affiliates. Any form of reproduction, disse=
mination, copying, disclosure, modification,
distribution and / or publication of this message without the prior written=
 consent of authorized representative of
HCL is strictly prohibited. If you have received this email in error please=
 delete it and notify the sender immediately.
Before opening any email and/or attachments, please check them for viruses =
and other defects.

---------------------------------------------------------------------------=
-------------------------------------------------------------------------


