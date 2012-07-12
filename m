From: "Jorge Ramirez Ortiz,  HCL Europe" <Jorge.Ramirez-Ortiz@hcl.com>
Date: Thu, 12 Jul 2012 09:16:18 +0100
Message-ID: <4F534D1A615F544D95E57BFD8460658301CBE3BD@GEO-HCLT-UKEVS1.GEO.CORP.HCL.IN>
References: <4F534D1A615F544D95E57BFD8460658301CBE3B9@GEO-HCLT-UKEVS1.GEO.CORP.HCL.IN>,
	<4FFE189C.7060504@xenomai.org>
In-Reply-To: <4FFE189C.7060504@xenomai.org>
Content-Language: en-GB
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Thanks Gilles. Yes unfortunately I cant recompile this kernel so I was wond=
ering about the system context of this fault within Xenomai.
BTW how come the stack frame is not printed by default. =

________________________________________
From: Gilles Chanteperdrix [gilles.chanteperdrix@xenomai.org]
Sent: 12 July 2012 01:21
To: Jorge Ramirez Ortiz,  HCL Europe
Cc: xenomai@xenomai.org
Subject: Re: [Xenomai] BUG: Unhandled exception over domain Xenomai - switc=
hing to ROOT

On 07/11/2012 08:10 PM, Jorge Ramirez Ortiz, HCL Europe wrote:
> Please could I get some background with respect of the possible causes of=
 this message? I have read it might be related to __copy_to/from user but I=
 have already validated that path in the driver. Must be something else.
> Also, I am OK to assume that the system is not reliable after this event.
> thanks in advance

You can try and add a call to show_stack(NULL, NULL) at the place where
this message is printed.

--
                                                                Gilles.


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


