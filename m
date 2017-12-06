References: <99BAB48E90E86D42AD41F0BCE3225AEB018DE4C73A@GRZSMS582.andritz.com>
From: =?UTF-8?Q?St=c3=a9phane_Ancelot?= <sancelot@numalliance.com>
Message-ID: <10f50ca3-aade-c465-ce99-8d379984ecf7@numalliance.com>
Date: Wed, 6 Dec 2017 09:15:08 +0100
MIME-Version: 1.0
In-Reply-To: <99BAB48E90E86D42AD41F0BCE3225AEB018DE4C73A@GRZSMS582.andritz.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] RTDM/RTNet - proposal to support sending/receiving
 multiple packets with one systemcall
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Lange Norbert <norbert.lange@andritz.com>, "Xenomai (xenomai@xenomai.org)" <xenomai@xenomai.org>
Cc: "jan.kiszka@siemens.com" <jan.kiszka@siemens.com>

Hi,

I have done an application that does this thing.

the application manages a stack of frames with priorities. high=20
priorities frame are sent at synchronised time (each ms, synchronised by=20
external clock) and then if there is enough remaining time, low priority=20
frames. (ethercat bus application)

The job is not done in driver, but in realtime application process.

I have=C2=A0 2 stacks =3D> Input / ouput packets

I managed to link this task with an internal software switch that=20
permits to embed ethernet packets in ethercat (EoE)

 From my viewpoint, I don't understand the added value doing this on=20
driver side ?

Regards,

S.Ancelot


Le 05/12/2017 =C3=A0 15:38, Lange Norbert a =C3=A9crit=C2=A0:
> Hello,
>
> I would like to involve the RTDM Maintainers for discussing an addition=
 to the RTDM drivermodel.
> This work would be done by Phillipe Gerum as part of a contract, he is =
also better suited to outline the necessary changes,
> should nothing stand against the proposal itself.
>
> - Problem description
>
> To be compatible with existing software, Ethernet packets will be polle=
d at synchronized events.
> The application ideally would give the kernel/rtnet stack the responsib=
ility and freedom to do this in an efficient manner,
> and be able to directly express the intend to poll all currently availa=
ble packets.
>
> Similarly, but less time-critical thus important, sending multiple pack=
ets in a burst would be a requirement.
>
> Lastly Linux has this functionality in form of recvmmsg and sendmmsg,
> which would be a good fit in terms of existing interface, atleast if us=
ed in non-blocking mode.
>
> - Hypothetical Proposal
>
> Adding the necessary interfaces to RTDM and RTNet
> to allow non-blocking bulk receive/send, and offering functions not unl=
ike the mentioned recvmmsg and sendmmsg.
>
> - Potential issues
>
> Copying of multiple packets would be done in RTDM context, potentially =
blocking resources for each packet or the whole duration.
> For our usecase it would for example not matter if the involved etherne=
t driver instance is not able to handle IRQs during this time,
> but it should not significantly affect worst-case task switch times in =
general, or block reception on other physical interfaces (Ethernet or oth=
erwise).
>
> recvmmsg and timeouts (blocking) are likely to be problematic, but bloc=
king mode is not required or wanted.
>
> - Open questions to the RTDM maintainers
>
> What would be the requirements of adding similar functionality to recvm=
msg to RTNet / RTDM,
> and would there be any caveats that would prohibit addition from side o=
f the RTDM maintainers?
>
> Other than that, a mmap based approach is also an option, but that's a =
somewhat more involved solution for both kernel and userspace as far as I=
 understood.
>
> Kind regards
>
> Norbert Lange
>
>
> #######################################################################=
##############
> This message and any attachments are solely for the use of the intended=
 recipients. They may contain privileged and/or confidential information =
or other information protected from disclosure. If you are not an intende=
d recipient, you are hereby notified that you received this email in erro=
r and that any review, dissemination, distribution or copying of this ema=
il and any attachment is strictly prohibited. If you have received this e=
mail in error, please contact the sender and delete the message and any a=
ttachment from your system.
> Thank You.
>    ANDRITZ HYDRO GmbH
>    Rechtsform/ Legal form: Gesellschaft mit beschr?nkter Haftung / Corp=
oration
>    Firmensitz/ Registered seat: Wien
>    Firmenbuchgericht/ Court of registry: Handelsgericht Wien
>    Firmenbuchnummer/ Company registration: FN 61833 g
>    DVR: 0605077
>    UID-Nr.: ATU14756806
> #######################################################################=
##############
>
>
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> https://xenomai.org/mailman/listinfo/xenomai


