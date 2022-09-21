Received: from cczrelay01.in2p3.fr (cczrelay01.in2p3.fr [134.158.66.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5D21876
	for <xenomai@lists.linux.dev>; Wed, 21 Sep 2022 05:30:21 +0000 (UTC)
Received: from [192.168.0.114] (mdb35-1_migr-88-125-107-19.fbx.proxad.net [88.125.107.19] (may be forged))
	(authenticated bits=0)
	by cczrelay01.in2p3.fr (8.14.4/8.14.4) with ESMTP id 28L5TgWm011818
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
	Wed, 21 Sep 2022 07:29:43 +0200
Date: Wed, 21 Sep 2022 07:29:36 +0200
From: Emmanuel Pacaud <emmanuel.pacaud@lapp.in2p3.fr>
Subject: RE: How to debug realtime interrupt latency
To: "Chen, Hongzhan" <hongzhan.chen@intel.com>
Cc: xenomai@lists.linux.dev
Message-Id: <CLOJIR.XNBWNAXO5BVE@lapp.in2p3.fr>
In-Reply-To:
	<MN2PR11MB42854F88BC212E32EA6D6885F24F9@MN2PR11MB4285.namprd11.prod.outlook.com>
References: <4WAGIR.N142QYZSDNER1@lapp.in2p3.fr>
	<MN2PR11MB42854F88BC212E32EA6D6885F24F9@MN2PR11MB4285.namprd11.prod.outlook.com>
X-Mailer: geary/40.0
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

Hi,

Thanks for your answer.

Le mer., sept. 21 2022 at 02:22:52 +0000, "Chen, Hongzhan"=20
<hongzhan.chen@intel.com> a =C3=A9crit :
>> What would explain the latency distribution on the DELL R630 +=20
>> Xenomai
>> compared to RTAI on the same machine, or to itself on the other=20
>> machine
>> ?
>=20
> Is that possible that some interrupts have not been triggered as=20
> expected?

I guess it is something I have to check, but it is very unlikely. We=20
are very confident in the PCIe boards we are using for ten years now.
> You may enable=20
> /sys/kernel/debug/tracing/events/cobalt_core/cobalt_irq_entry
> & cobalt_irq_exit events to debug such issue.

Ok, thanks. I'll give t a try.

>> Does Xenomai perform some other tasks before the real time interrupt
>> handler is called ?
>=20
> I do not think there is other tasks can cause such 10us +delay before=20
> xenomai real time interrupt
> handler on your platform unless other real time interrupt handler=20
> occupy cpu with irq off.

I have only installed one real time interrupt, but my understanding is=20
Xenomai has its own timer related timer interrupts.

```
pacaud on xxx in ~ =E2=9D=AF cat /proc/xenomai/irq
  IRQ         CPU0        CPU1        CPU2        CPU3
   69:           0  6541955561           0           0         tolm
 4352:           0           0           0           0         [sync]
 4353:           0           1           1           1        =20
[reschedule]
 4354:           0           1           1           1        =20
[timer-ipi]
 4355:   616197140     6762902     6915380     6915224         [timer/0]
 4419:           0           0           0           0         [virtual]
```

Are these interrupts supposed to be constant time ?

Cheers,

	Emmanuel.


