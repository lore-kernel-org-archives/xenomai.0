From: "PRADHAN, MAKARAND (RC-CA)" <makarand.pradhan@siemens.com>
Date: Wed, 7 Oct 2015 19:27:15 +0000
Message-ID: <B89CCBE86D4F62448EE4F6367C6D3C89221ECA2A@USMLVA0EM24MSX.ww017.siemens.net>
References: <B89CCBE86D4F62448EE4F6367C6D3C89221E32ED@USMLVA0EM24MSX.ww017.siemens.net>
 <560AB34B.5020300@xenomai.org>
 <B89CCBE86D4F62448EE4F6367C6D3C89221E4342@USMLVA0EM24MSX.ww017.siemens.net>
 <560AB938.8090905@xenomai.org>
 <B89CCBE86D4F62448EE4F6367C6D3C89221E435B@USMLVA0EM24MSX.ww017.siemens.net>
 <B89CCBE86D4F62448EE4F6367C6D3C89221E4474@USMLVA0EM24MSX.ww017.siemens.net>
 <B89CCBE86D4F62448EE4F6367C6D3C89221E4503@USMLVA0EM24MSX.ww017.siemens.net>
 <B89CCBE86D4F62448EE4F6367C6D3C89221EA9F2@USMLVA0EM24MSX.ww017.siemens.net>
 <561568AE.30109@xenomai.org> <56156AB4.2080705@xenomai.org>
In-Reply-To: <56156AB4.2080705@xenomai.org>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai] Interrupt latency close to 1ms on powerpc Xenomai
 2.6.4
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, "Xenomai@xenomai.org" <xenomai@xenomai.org>

Thanks Philippe.

I understand the rationale and will have to do some more reading to grasp i=
t entirely.

A quick question though. We have been using Xenomai for quite some time, an=
d only in 2.6.4 did we notice excessive delays in our int handling. Was thi=
s behavior enabled in 2.6.4 or was it like this all the time?

Rgds,
Mak.

-----Original Message-----
From: Philippe Gerum [mailto:rpm@xenomai.org]
Sent: Wednesday, October 07, 2015 2:56 PM
To: PRADHAN, MAKARAND (RC-CA); Xenomai@xenomai.org
Subject: Re: [Xenomai] Interrupt latency close to 1ms on powerpc Xenomai 2.=
6.4

On 10/07/2015 08:47 PM, Philippe Gerum wrote:
> On 10/07/2015 04:25 PM, PRADHAN, MAKARAND (RC-CA) wrote:
>> Hi All,
>>
>> On further experimentation, I still feel that rt_intr_enable may be caus=
ing my user space int handler to jump into secondary domain.
>>
>
> rt_intr_enable() is a secondary domain call, it cannot execute over
> the primary domain simply because the infrastructure shared with the
> regular kernel that might be involved to enable/disable IRQs requires
> this. The nucleus forcibly relaxes the calling thread for this reason.
> So the behavior you observe is not a bug, it is actually the intent
> and requirement for carrying out such request. Check
> ksrc/native/syscall.c:4152, this call is tagged as "lostage", meaning
> that it shall run from the lowest pipeline domain stage, i.e. linux.
>
> This is the reason why handling interrupt top-halves in userland is a
> bad idea, and also the reason why the RT_INTR support has completely
> disappeared from 3.x's Alchemy API (formerly know as 2.x's "native"
> API), in favor of a UIO-like model called UDD, standing for
> "user-space device driver". There, top-halves must live in kernel
> space, and bottom-halves may live in userland, which is the only sane
> and safe way to handle interrupts from the latter.
>
> The rationale for this change is stated here:
> http://xenomai.org/migrating-from-xenomai-2-x-to-3-x/#irqhandling
>

Which also translates as: enabling/disabling an IRQ line is changing the pe=
rmanent state of that line, compared to mask+ack/unmask when serving a part=
icular occurrence which changes its transient state.

Enabling/disabling IRQ lines normally happens during the init/cleanup phase=
, where running from a mere linux context won't be an issue.
Conversely, mask+ack/unmask upon IRQ may happen over the rt domain (obvious=
ly), but those ops may be called from a kernel context exclusively for sani=
ty reasons.

Therefore, using rt_intr_enable() to emulate the unmask-after-IRQ-service o=
p from userland won't work.

--
Philippe.

This message and any attachments are solely for the use of intended recipie=
nts. The information contained herein may include trade secrets, protected =
health or personal information, privileged or otherwise confidential inform=
ation. Unauthorized review, forwarding, printing, copying, distributing, or=
 using such information is strictly prohibited and may be unlawful. If you =
are not an intended recipient, you are hereby notified that you received th=
is email in error, and that any review, dissemination, distribution or copy=
ing of this email and any attachment is strictly prohibited. If you have re=
ceived this email in error, please contact the sender and delete the messag=
e and any attachment from your system. Thank you for your cooperation

