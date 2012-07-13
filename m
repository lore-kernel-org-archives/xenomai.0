From: "Jorge Ramirez Ortiz,  HCL Europe" <Jorge.Ramirez-Ortiz@hcl.com>
Date: Fri, 13 Jul 2012 17:27:49 +0100
Message-ID: <4F534D1A615F544D95E57BFD8460658302FEC034@GEO-HCLT-UKEVS1.GEO.CORP.HCL.IN>
References: <4F534D1A615F544D95E57BFD8460658301CBE3B9@GEO-HCLT-UKEVS1.GEO.CORP.HCL.IN>,
	<4FFE189C.7060504@xenomai.org>
	<4F534D1A615F544D95E57BFD8460658301CBE3BD@GEO-HCLT-UKEVS1.GEO.CORP.HCL.IN>,
	<4FFE8B7C.60506@xenomai.org>
	<4F534D1A615F544D95E57BFD8460658301CBE3C2@GEO-HCLT-UKEVS1.GEO.CORP.HCL.IN>
	<4FFFEB98.7060106@xenomai.org>
	<4F534D1A615F544D95E57BFD8460658302FEBCEB@GEO-HCLT-UKEVS1.GEO.CORP.HCL.IN>
	<500001AC.5040706@xenomai.org>
	<4F534D1A615F544D95E57BFD8460658302FEBD85@GEO-HCLT-UKEVS1.GEO.CORP.HCL.IN>
	<50000D7C.2010809@siemens.com>
In-Reply-To: <50000D7C.2010809@siemens.com>
Content-Language: es-ES
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] BUG: Unhandled exception over domain Xenomai -
 switching to ROOT
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Please can we go back and reframe the discussion?

But first I'll reiterate: do ignore the marginal issue I had with the frame=
work (I ported and went over 44,785 lines of ANSI-C(kernel/user) and 1995 l=
ines of C++ code  in just a few days -this one was a big pci driver-....I a=
m not really losing my sleep over it) . Besides It is not really relevant t=
o the point I am trying to make and the reason why I am posting here. =


My point is: yes, absolutely, I would expect the framework to allow wakeup =
calls to linux services from interrupt context. =

Why not? Why is this the wrong expectation to have?
When the client calls the RTDM driver from the wrong context (a non-realtim=
e context in the real-time world), the framework doesn't complain. It handl=
es it and gives the driver the option to chose how it wants to handle it wh=
ich makes perfect sense to me. =


And anyhow, failing that, I would have expected the real-time driver model =
to give the user the option to chose the back door context he wants to regi=
ster to (which is my whole point and what  PREEMPT_RT actually does in the =
linux domain). And I would expect an rtdm interface for that. So I think my=
 point stands with respect to consistency on the interfaces: either give th=
e client a rtdm_request_irq context flag to request different IRQ contexts =
or handle wake_up events. =


With respect to your comment about PREEMPT_RT I think it actually helps wit=
h what I am trying to articulate here. So I think we are looking at it from=
 different angles.

Anyway I really don't have much more to contribute/say on this matter but a=
s a user, I thought it would be right to spend some time sharing my views s=
ince I benefited from this project so many times.

-----Mensaje original-----
De: Jan Kiszka [mailto:jan.kiszka@siemens.com] =

Enviado el: 13 July 2012 12:59
Para: Jorge Ramirez Ortiz, HCL Europe
CC: Philippe Gerum; xenomai@xenomai.org
Asunto: Re: [Xenomai] BUG: Unhandled exception over domain Xenomai - switch=
ing to ROOT

[please don't top-post]

On 2012-07-13 13:24, Jorge Ramirez Ortiz, HCL Europe wrote:
> Yes it does: the caller ignores upfront whether the call will be handled =
in realtime or non-realtime context by the driver.
> The client (of course!) can/should (it doesn't really matter for the sake=
 of the argument) take the adequate measures to make sure it will get into =
the adequate path.
> But the _interface_ does not guarantee which path it will take. This is a=
 fact that you can't disagree with.
> =

> But please allow me to re-frame the discussion: I am not discussing here =
about realtime design practises or about how to use the framework properly.
> I am merely commenting on  the _interfaces_ to the realtime framework and=
 their consistency.

As far as I understood, you were using interfaces outside of the scope
of the RTDM framework. Sorry, we can change the Linux kernel to
gracefully handle all types of improper RT designs. We already have
quite some infrastructure to detect such scenarios, and if there are
holes, we are happy for suggestions (bug reports, patches etc.) to plug
them. But, e.g., failing a call like wake_up from wrong contexts is
impractical (there are too many spots to patch). Or what is your
expectation?

BTW, if you call wake_up under PREEMPT-RT from a hard IRQ handler, you
will get similar results: at best lockdep will bark at you, at worst
your box locks up hard. Different architecture, similar problem.

Jan

-- =

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


