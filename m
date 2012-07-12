From: "Jorge Ramirez Ortiz,  HCL Europe" <Jorge.Ramirez-Ortiz@hcl.com>
Date: Thu, 12 Jul 2012 22:29:57 +0100
Message-ID: <4F534D1A615F544D95E57BFD8460658301CBE3C2@GEO-HCLT-UKEVS1.GEO.CORP.HCL.IN>
References: <4F534D1A615F544D95E57BFD8460658301CBE3B9@GEO-HCLT-UKEVS1.GEO.CORP.HCL.IN>,
	<4FFE189C.7060504@xenomai.org>
	<4F534D1A615F544D95E57BFD8460658301CBE3BD@GEO-HCLT-UKEVS1.GEO.CORP.HCL.IN>,
	<4FFE8B7C.60506@xenomai.org>
In-Reply-To: <4FFE8B7C.60506@xenomai.org>
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

Hi Gilles

Information and context below.

kernel: 2.6.35.9                                                           =
                                                                           =

xenomai:2.6.0                                                              =
                                                                           =

ipipe:2.8-04                                                               =
                                                                           =

cpu atom z530 1.6HH                                                        =
                                                                           =

                                                                           =
                                                                           =

Error                                                                      =
                                                                           =

>>> [  242.962195] BUG: Unhandled exception over domain Xenomai at 0x892160=
 - switching to ROOT                                                       =

>>> [  242.990052] Pid: 972, comm: InterruptTest Not tainted 2.6.35.9-prot-=
xeno-atom #4                                                               =

>>> [  243.015979] Call Trace:                                             =
                                                                           =

>>> [  243.025121]  [<c041b0b3>] __ipipe_handle_exception+0x203/0x210      =
                                                                           =

>>> [  243.048691]  [<c07ef4fb>] error_code+0x63/0x70                      =
                                                                           =

                                                                           =
                                                                           =

System:                                                                    =
                                                                           =

1. Xenomai thread calling ~9000 PCI writes in a loop. Each of these 9000 IO=
CTLs is processed in the realtime path of the RTDM driver.                =

2. A library has an interrupt notifier on the same RTDM device.            =
                                                                           =

   The interrupt notifier is a wait queue in the non-realtime path of the R=
TDM driver. Events are raised from the RTDM interrupt handler to notify the=
 sleeping threads.
   The interrupt notifier is a timed wait every 100ms. When it times out, t=
he linux application reads (msgrcv) from a queue in a shared memory segment=
 (shmget created).                            =

                                                                           =
                                                                           =

The problem with the design is obvious and the issue above solved by modify=
ing the library.                                                           =
   =

The interrupt notifier should be sleeping in an rtdm_event_t in the realtim=
e path of the device instead of a linux wait queue.                        =

                                                                           =
                                                                           =

However, the other design, even if wrong, shouldnt have caused exceptions. =
                                                                           =

                                                                           =
                                                                           =

Anyhow, I am as impressed as always with this piece of software. This is th=
e toolkit that any embedded developer needs. And RTDM has been a great addi=
tion.

thanks
Jorge
   =

________________________________________
From: Gilles Chanteperdrix [gilles.chanteperdrix@xenomai.org]
Sent: 12 July 2012 09:31
To: Jorge Ramirez Ortiz,  HCL Europe
Cc: xenomai@xenomai.org
Subject: Re: [Xenomai] BUG: Unhandled exception over domain Xenomai - switc=
hing to ROOT

On 07/12/2012 10:16 AM, Jorge Ramirez Ortiz, HCL Europe wrote:
> Thanks Gilles. Yes unfortunately I cant recompile this kernel so I
> was wondering about the system context of this fault within Xenomai.
> BTW how come the stack frame is not printed by default.

Because it may not be safe to use show_stack() from RT context (for
instance, the print_symbol function to print symbol names need to take a
spinlock when a symbol is defined by a kernel module, and this spinlock
is not rt-safe). Anyway, the error message normally prints the PC of the
error.

Could you give us the exact error messsage? The version of Xenomai, the
Linux kernel, the version of the I-pipe patch you use?

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


