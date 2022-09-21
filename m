Received: from cczrelay01.in2p3.fr (cczrelay01.in2p3.fr [134.158.66.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4E533D4
	for <xenomai@lists.linux.dev>; Wed, 21 Sep 2022 13:36:48 +0000 (UTC)
Received: from [192.168.0.114] (mdb35-1_migr-88-125-107-19.fbx.proxad.net [88.125.107.19] (may be forged))
	(authenticated bits=0)
	by cczrelay01.in2p3.fr (8.14.4/8.14.4) with ESMTP id 28LDadlJ015431
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
	Wed, 21 Sep 2022 15:36:45 +0200
Date: Wed, 21 Sep 2022 15:36:33 +0200
From: Emmanuel Pacaud <emmanuel.pacaud@lapp.in2p3.fr>
Subject: Re: How to debug realtime interrupt latency
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@lists.linux.dev
Message-Id: <X4BKIR.IUOSEN2ZXQGV1@lapp.in2p3.fr>
In-Reply-To: <87y1ud3vzn.fsf@xenomai.org>
References: <4WAGIR.N142QYZSDNER1@lapp.in2p3.fr> <87y1ud3vzn.fsf@xenomai.org>
X-Mailer: geary/40.0
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

Hi Philippe,
Le mer., sept. 21 2022 at 08:51:54 +0200, Philippe Gerum=20
<rpm@xenomai.org> a =E9crit :
>=20
> Emmanuel Pacaud <emmanuel.pacaud@lapp.in2p3.fr> writes:
...
>>  The real time interrupt is installed using
>>  rt_request_irq/rt_assign_irq on RTAI, and=20
>> xnintr_init/xnintr_affinity
>>  on Xenomai.
>>  The interrupt latency is measured using the in-house PCIe board (a
>>  time register is latched when the board emit an interrupt, and a
>>  current time register is read at the beginning of the interrupt
>>  handler).
>>=20
>=20
> Which is the frequency of the timer event in this test case?

The PCIe board send an interrupt at 10kHz.

>>  What would explain the latency distribution on the DELL R630 +=20
>> Xenomai
>>  compared to RTAI on the same machine, or to itself on the other
>>  machine ?
>=20
> Hard to say ATM. 10-15 =B5s could be explained by significantly more=20
> cache
> misses, e.g. after a driver for a graphic adapter has issued wbinvd.=20
> Or
> simply due to more convoluted code paths running the ISR. I understand
> the test environment between RTAI 5.2 and Xenomai 3.1 does not change,
> so cache invalidation from the kernel should bite the same way
> though.

The environnements are the same, as well as the kernel configurations=20
(except for the RTAI and Xenomai specific configuration obviously). So=20
yes, we should have seen the same behaviour using RTAI.

>  Longer IRQ masking is another reason obviously, which is often a
> function of cache behavior during some interrupt-free section.

Do you mean there could be some interrupt masking done from the non=20
real time part of the kernel ?

>>  Does Xenomai perform some other tasks before the real time interrupt
>>  handler is called ?
>=20
> No unrelated housekeeping stuff is performed, only IRQ related work is
> involved upon receipt.

Ok.

>>  Is there a way in Xenomai to measure the interrupt latency from the
>>  moment the kernel is awaken by an interrupt signal and the moment
>>  Xenomai calls the installed interrupt handler ?
>>=20
>=20
> As Hongzhan already mentioned, you may want to get some figures from=20
> the
> 'latency' program [1], specifically using the '-t2' option, which
> measures the IRQ-to-ISR delay in kernel space (excluding any=20
> additional
> latency brought by switching user contexts). This should be equivalent
> to your current test case, barring the event generator and clock=20
> source.
>=20
> The I-pipe has a built-in tracer (CONFIG_IPIPE_TRACE); running=20
> 'latency'
> with the -f option would get you a snapshot of the active code path
> before the worst-case figure was measured.

Thanks for the infos.

> Question: are you stuck with 4.14, or could you upgrade to the 5.x
> kernel series? (4.x is EOL here, we moved away from the legacy I-pipe=20
> to
> Dovetail [2] with Xenomai 3.2).

For the time being it would be better if I could stay with 4.14, as it=20
looks like the 5.X kernel series requires a gcc version more recent=20
that what is provided by our standard base OS (Centos7) . But I will=20
definitely test Xenomai 3 with dovetail.

Thanks again,

	Emmanuel.


