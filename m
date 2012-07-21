From: "Jorge Ramirez Ortiz,  HCL Europe" <Jorge.Ramirez-Ortiz@hcl.com>
Date: Sun, 22 Jul 2012 00:01:09 +0100
Message-ID: <4F534D1A615F544D95E57BFD8460658301CBE3E0@GEO-HCLT-UKEVS1.GEO.CORP.HCL.IN>
References: <4F534D1A615F544D95E57BFD8460658301CBE3DF@GEO-HCLT-UKEVS1.GEO.CORP.HCL.IN>,
	<500B2F9F.8020602@xenomai.org>
In-Reply-To: <500B2F9F.8020602@xenomai.org>
Content-Language: en-GB
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] switching domains at will
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

a user task example: a Xenomai thread calls into an RTDM ioctl_rt which it =
is better handled in non-rt since it needs to use some linux services. So a=
t the RTDM ioctl I can issue -ENOSYS. =

When the call returns to userland, the task is in secondary mode - but now =
I need to issue now an ioctl_rt. pthread_setschedparam seems to do the tric=
k but I'd like to make sure that this is a reliable way of doing it.

yes I remember that one :). I am just doing a code clean up and adding some=
 consistency..



________________________________________
From: Gilles Chanteperdrix [gilles.chanteperdrix@xenomai.org]
Sent: 21 July 2012 23:39
To: Jorge Ramirez Ortiz,  HCL Europe
Cc: xenomai@xenomai.org
Subject: Re: [Xenomai] switching domains at will

On 07/21/2012 10:59 PM, Jorge Ramirez Ortiz, HCL Europe wrote:
>
> Is there an API to switch domains  from a user RT task

For what purpose do you need to do that?

> and  a kernel based task?

kernel based task can not switch domain: they are always running in
xenomai domain, and any call to Linux services will cause mysterious
crashes such as the one you got when calling wake_up from an interrupt
handler (also happening in xenomai domain).



> ::DISCLAIMER::
> -------------------------------------------------------------------------=
---------------------------------------------------------------------------
>
> (...) Any form of reproduction, dissemination, copying,
> disclosure, modification, distribution and / or publication of this
> message without the prior written consent of authorized
> representative of HCL is strictly prohibited. (...)

The only easy way to comply to this part of your disclaimer is to
unsubscribe you from the xenomai mailing list, we are not going to
moderate you and ask HCL representatives if we can publish each of your
posts. If this is not what you want, I suggest you manage to send mails
to the mailing list without the disclaimer.

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


