Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2125.outbound.protection.outlook.com [40.107.22.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30336A3B
	for <xenomai@lists.linux.dev>; Tue, 23 Aug 2022 06:32:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JoPXMCfKoBS4ZMYwNBivP51GA39iMlpav8wnBypiM/b/POJC8G4lOhnTBaSPKDpbtxG/XYI208S2h3ZZZ7tNK+Fmlaa4K43fb2eHrd0HNnb5nlt3WywCgL5pl/qaCDyaWJWojlLMMysQCAXsprjDtNMXgNZwI40OCV9ZdoDTT+/IKUO1vukN7Ul08UudUSByqg+eUrwT/QV9XRP9EYppfom/vSmbEe9Ao76j07NXCxsoNLEPBsZf0DORepvikT7z1XkSVykpGoWnNj5fGjjF863CZS0DyGelquzt4d7iGVTnr8GfOSRKkJl+RymYVsWcSJ1Bzjo6EUkZ77JVEw/idg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fvgB0tPcKaIDs7Sea9N+khL2w0CFQiRBwDpKUfCsynU=;
 b=MbKfRQhlGnEyL8Y0/Xn1Q6+LAGqiARW7AmKDqoaNG68kvKnlOMskRrYBPMG48CyxUZ1cAQOymnRqN0AjJTZqatIge8Z94r4nLZQcOi5OCbbUcYcMYsfoXgeRLmYcPeaCIimc5Am+ilairVYzw30qn9+R+FmWyPKUgr4rWuXUxGy9PQiU6l+ymZR/QUh4KX+YFHlMQhd7pS8ZwRyA+dIO+2B/s3fApqbStQC6UVNfoDQ+ztDOcNKK9umO/9Tp0749JW3e8ykn7bW2l/REfXuDcmAfmLzE0INZ9lMUQ4epE8lTHjOPlxu1j2NuOrWt3gho9cP7VKskOZAclsKHVd97kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sigmatek.at; dmarc=pass action=none header.from=sigmatek.at;
 dkim=pass header.d=sigmatek.at; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sigmatek.at;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fvgB0tPcKaIDs7Sea9N+khL2w0CFQiRBwDpKUfCsynU=;
 b=DLekFiOat338k9mcsIQuaGC4ZDzSY5CJOck/kxAd9QYGIAhBdacVAmuRn3PI9/h9cszDNS1zIxHL66GoCnssshJmW0ZpjDXzZBgRnwJO0wb79KQcErWmm56TH7+yxccOjLBHF8mBshv6DY3Pg9jlfRD/k2rTuizVoeMZhjlNdes=
Received: from VE1PR08MB4909.eurprd08.prod.outlook.com (2603:10a6:802:a8::22)
 by AM0PR08MB4482.eurprd08.prod.outlook.com (2603:10a6:208:140::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.19; Tue, 23 Aug
 2022 06:32:29 +0000
Received: from VE1PR08MB4909.eurprd08.prod.outlook.com
 ([fe80::1a8:818d:b100:95a4]) by VE1PR08MB4909.eurprd08.prod.outlook.com
 ([fe80::1a8:818d:b100:95a4%7]) with mapi id 15.20.5546.024; Tue, 23 Aug 2022
 06:32:28 +0000
From: Johannes Kirchmair <johannes.kirchmair@sigmatek.at>
To: Philippe Gerum <rpm@xenomai.org>
CC: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: RE: [PATCH 0/3] prove of concept
Thread-Topic: [PATCH 0/3] prove of concept
Thread-Index: AQHYkgnbkB/UFS5bDU2Bm0KbKVBupq10wDoAgEYICuA=
Date: Tue, 23 Aug 2022 06:32:28 +0000
Message-ID:
 <VE1PR08MB490917EE71941F086968A9F192709@VE1PR08MB4909.eurprd08.prod.outlook.com>
References: <20220707135952.5171-1-johannes.kirchmair@sigmatek.at>
 <875yk7mqdn.fsf@xenomai.org>
In-Reply-To: <875yk7mqdn.fsf@xenomai.org>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sigmatek.at;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cd97fae3-be7d-488d-b887-08da84d1403a
x-ms-traffictypediagnostic: AM0PR08MB4482:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 UYml0kDYKCzMYi1ojZjHr1/MPmLTMblnFKACSK6hDTfXIzLsrmT7d+wdt1KuFMsGL2zJ9s2SNh5Cp3+YRI2OfmQc1/MBsImUAJoTWuiPqOyh3PngqKsFMK0QZgOeUwcd3CMVowqh0+K3OPK6ADDx/+QQW8SVPz5+s3YzHE3Bng8piWXnKwbtqtbOFL75HHVvNVMCub6nmv3RhsssyIEljJd1+og/gS8si8q8uhBPIfQg2GEHz7Iv4NCqOunIj6B7VHg8LhgfB3rBX6wrtwarhhtn8m3BgECG2tfBv0J9Ag3Z/WUwZrw8xZAoOFso8uK7jxldSpav6kTCm0dF4OZtN/WreuwYLcwWaWWZi9M+Mn6cqKqAtELjFl5C56MzWQqU0FR7foUOO5aw5Mhj13lhW2gKj2o1sIZidqZF3Kln7kjy+sOMDCb0ve6m1Em/Zzz26kSIL4t4G3A4MI36I7wRY5E1VyJBvIdpC2CpjmR/gjtLfNS33Kx1KEzGhNR9M2+2SHam4Zvzh+ZF/UHtBgE/JSlZt4U2l1gnep/CaF8Rxvc82AcLAVYV7DFQ6pkkqs0pp4n/E8K+I+VrR2uTdybZOWUwdmTuMPY4u7jcVSOW0/+Y9s6uxr9Yfd/1R7n7U+TllmcYGqjRXG3ZJrHtdhH5kSQfOecskS4I7IkPRtDGu5RZyPVkzj43139ZTJPoLLws4UFDyg0S9WxQC3TAWqp87WoxQHz89Z1YmWrntd1IABX0dRVP063JHjRkCn1dEuAREwEUpQofXGAyEaT0IY8mNw==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4909.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(136003)(366004)(346002)(39850400004)(396003)(83380400001)(38070700005)(66446008)(38100700002)(122000001)(76116006)(6916009)(4326008)(66946007)(66476007)(66556008)(8676002)(64756008)(316002)(55016003)(44832011)(2906002)(8936002)(5660300002)(26005)(7696005)(6506007)(53546011)(9686003)(33656002)(186003)(71200400001)(478600001)(41300700001)(86362001)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?uNXNDsALKzdtfHAzJHAwat/pjAf4EKvAnEc71Ax1h7T84dON8BuI3E4M1xb+?=
 =?us-ascii?Q?zHm6uJ7A8IeqbOPsUkNlu21skyMQfqLPJetgOOJ8clYOXeosUFQJadyinzk8?=
 =?us-ascii?Q?d1mfurbOeHEO+U9+Z/jST/z4CBZ8gvyknJegxU7Cn6iVoh9wJDHah2yQ4BzY?=
 =?us-ascii?Q?RiOTBkEW5srLgNhAw1820diOs9YJp9jENgcCy9+okGfPsgOfkjXiZ5jltB8Y?=
 =?us-ascii?Q?IdjjZ9d9KJ2XiwrEeSI3nNe1QdGuSalpD741Zu/Cx/aBtDGqq4OD637e0mmj?=
 =?us-ascii?Q?v/VbTKz+zqKClA3loi29AtdF7IkKeI/P8WZZnlbBK5VIDCuICwwXHFbOy4vG?=
 =?us-ascii?Q?H7fOmmZQwhhoUbMGVa0lAjnpi+JW1TC9DuQ/4qY1s8+16nc6JJDQDrHPPXx3?=
 =?us-ascii?Q?tUoUJZCyuzOPRI/itA2ysnfTaPmtNdK/T/3zlnWgDGNOVAMLgFKen5Mjablj?=
 =?us-ascii?Q?nUzSOYQ7+krI10aim33a6Ra638lf900xlve110O7/ScfXrwsR7JflqN7QreO?=
 =?us-ascii?Q?2Ia9slaGGrh+U5E0n11BMXrRQvuxyQw4gvxtJ7k8VROSh7MKF7uN6zUcUz2F?=
 =?us-ascii?Q?7PGNOKmXAE2+RdGP7DHNAZqt5+wGMuz89qxJ1qISobdNoAHpP4WZ3AhvSSRh?=
 =?us-ascii?Q?mhewcHHagLrbDSKlwCm24CnjlOoyrwLJGw1oDEeuYv2zEM1iaaUvvhy9CXNw?=
 =?us-ascii?Q?jAVfnpYTWGiTLdjo8pdMcI/q4IBZ9oFiTxNPKOdODpsJQUkLJknzVU9ZCYgQ?=
 =?us-ascii?Q?AoGvH/Bl23jPkjzEyW7dAndl4garKkT5eJ3FR8z4EIYUQf+ZCf29Xnw/TyCL?=
 =?us-ascii?Q?Oq+vkrEe9ThVZxY4vgW7G5EeR5f92A8wSJ0oVDcY+F6sXtm+aaWELW9ZvNFW?=
 =?us-ascii?Q?lN8BnzBxCa2fQj5YcTdYldU83omqHj44QD/Zh5rd/6LErTHjOj/PGIGviAJF?=
 =?us-ascii?Q?fL6teUpkCxYoGxttKxR8zhgHrqF9S6acHi5eN7KHYZxqtLXsR7OjLvvZX2rY?=
 =?us-ascii?Q?GaxsGvENzFKazuGS614PjpUldJAE6wdHqcM+5sv5gQjVTj+GTzbRiRV6PC2a?=
 =?us-ascii?Q?cCZIQyVvwfbsQwhtc6xuSdUCQO46E5StfqjleyMmVwvwUS3PpY3zrWNH8P1G?=
 =?us-ascii?Q?eeQ3TBs+bbyZPd8S4jnUdvR9CwT0+lwUPx/BiY7rGO0igV2XWo+ftM0LoYSt?=
 =?us-ascii?Q?eOAqY68M95N+ewualDSvHMwUdk9Z+8PbaofAvemRL/3c3HgC8B4+u15vcjnB?=
 =?us-ascii?Q?Vwto6utAfGbKyxOeXjLlBaCeZBWnksbc/p7bb/u1x080dC8+Op/SZo+vAgSf?=
 =?us-ascii?Q?hHajfK+zVR+g3hnkzOrzPe4v43RbfEAc1T3yW9JrNBvqXvYEd90QGF4FXjCS?=
 =?us-ascii?Q?26dwMWjZek1sNQ+zF9ZK+LH6Euvdq4oyTNOGwuM8Yp8i6stHR1whM2i//ltw?=
 =?us-ascii?Q?LMWxIHD/wmQ3OrlAUVygY/n7eJ3mI7qf//AfWLMj/9WIIv0WW6hrPcxyRGKt?=
 =?us-ascii?Q?JxE+zZ73VFbqkYWgVGPMTZ+53JEi1RClDHb/F547s0tWp2s9qpnFYhCS3B2L?=
 =?us-ascii?Q?S5q4imXduJO2wdeA4GptHAEfNB9rthbZtqMlR04UwCvbMallJz/0rTqWCQ4w?=
 =?us-ascii?Q?oQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: sigmatek.at
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4909.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd97fae3-be7d-488d-b887-08da84d1403a
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2022 06:32:28.6342
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bcb1d87a-d2bc-486e-a62b-9ac9c746bc1b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S/A4k2LZ1ZFL6LF/6NwZcYb90QsEvdumFQHORLOyucE6dN22gjvT8S2ez+ZWfwjRZzu5GrM3BP3JFmGMirncPxYD6/x6KIP1isndhBudb3k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB4482

Hello Philippe,

I am sorry for the very late response.
After my vacation some other topics not directly linked to Xenomai hit me.

> -----Original Message-----
> From: Philippe Gerum <rpm@xenomai.org>
> Sent: Freitag, 8. Juli 2022 19:43
> To: Johannes Kirchmair <johannes.kirchmair@sigmatek.at>
> Cc: xenomai@lists.linux.dev
> Subject: Re: [PATCH 0/3] prove of concept
>=20
>=20
> Johannes Kirchmair <johannes.kirchmair@sigmatek.at> writes:
>=20
> > This is a prove of concept implementation of exception handling in Xeno=
mai
> real
> > time.
> >
> > It implements an interface similar to the posix signals but with a much=
 smaller
> > feature set.
> >
> > For now, this feature can be used for handling floating point exception=
 (fpe)
> > and illegal opcode exception in user space without losing real time.
> >
> > The fpe exception handling can be used for fixing division by zero erro=
rs in
> > user space code without dropping out of the real time domain.
> >
> > The illegal opcode exceptions can be used for implementing breakpoints.=
 This
> > can be done by replacing the breakpoints original instruction by an ill=
egal
> > opcode. At the time a task tries to execute the instruction an illegal =
opcode
> > exception will be triggered. The thread can be  suspended in the signal=
 handler
> > in user space. There are two main advantages of having it done in real =
time.
> >
> > The first is if a task does some time critical IO or has to meet some w=
atchdog
> > constrains, the signal handler can be used to bring the IO into a sane =
state
> > before the task is stopped. Same for the watchdog, it can be stopped be=
fore it
> > sends the whole process into an error state.
> >
> > The second advantage is for processes that have several real time tasks=
. For
> > example consider a process with rt tasks task1 and task2, where task1 i=
s of a
> > higher priority than task2. If task1 triggers an exception and is relax=
ed to
> > the Linux domain, task2 of a lesser priority would take over and could =
block
> > the handling of the maybe more imported work/exception handling in task=
1.
> >
> > Disclaimer:
> > This implementation is far from being ready to merge. It is mainly inte=
nded to
> > be a starting point for discussions about rather we (the community) wan=
t some
> > kind of exception handling interface in Xenomai and what a maintainable
> > interface for this could look like.
> >
>=20
> Thanks for taking a close look to this. Since the proposal is about
> handling CPU traps in user-space, I have a couple of observations
> regarding the kernel side of things, and some questions regarding the
> intended use cases application-wise.
>=20
> With respect to x86, the traps roughly fall into these categories:
>=20
> - #NM, #XF, #XM, #MF, #DB, #PF, #AC and #BP may need some kernel fixup
>   to be applied when taken from non-privileged mode, we cannot just
>   return from the oob handler and be done with it in every possible
>   case.
>=20
> - #DF, #MC, #SS and #TS do not involve user-space activity, so let's
>   ignore these, along with any trap involved in virtualization
>   management, there is no point in routing them to a user-space handler
>   anyway.
>=20
> - #GP, #DE, #OF, #BR and #UD either do not need further kernel fixup, or
>   at least such fixup can be done transparently on the oob stage with no
>   impact on the worst-case latency. Routing them to a rt signal handler
>   in user-space could be done.
>=20
> The first set looks problematic though:
>=20
> * duplicating the original fixup code in the real-time core
>   (e.g. Cobalt, EVL) would be a bad idea (obsolescence, portability
>   issues, prone to hidden regressions). We have been there with the
>   I-pipe and FPU management offloaded to Cobalt already. This is the
>   reason why Dovetail provides built-in scheduling and FPU management in
>   oob mode, offloading such tasks to the real-time core can only end up
>   in some interstellar mess.
>=20
> * however, reusing the existing kernel fixup code may require to
>   re-enter the regular inband execution context. In most cases, the
>   portion of that code which handles user-originated traps cannot
>   support out-of-band traversal (e.g. takes regular spinlocks we
>   certainly do not want to convert to hard locks). Dovetail already
>   tries hard not to notify the core about any fault which can be fixed
>   up without switching in-band first, IOW: we leave oob mode only when
>   we really have to, not systematically upon trap.
>=20
> Because of this, generalizing the ability for the core to bypass the
> kernel fixups for any kind of trap does not look right.
>=20
> This does not impede us from looking for a way to catch the events from
> the 3rd set which could be handled safely from user-space in oob mode
> though. You mentioned so far the following use cases:


Thank you for you detailed write-up of the different groups of exceptions a=
nd their handling in the kernel.
Actually I so far did not entertain the fact that the kernel does some comp=
lex fixups for some exceptions.=20
And I agree on the point that we probably should not handle those in oob-co=
de.

My main concern was with #UD and #DE as we have use cases for just those. A=
t least at this moment.

> - unchecked maths: #DE handling
>=20
> - I/O stall detection: watchdog disabling, hw cleanup then
>   self-suspension on #UD (used as a way to force a breakpoint)
>=20
> What a handler would do looks obvious with respect to receiving a
> forced #UD, the user code may even be allowed to resume normally
> from the suspension point at some point later.
>=20
> However, it is unclear to me what a handler might do upon other traps,
> such as #DE, #GP, #OF and so on: the faulty thread could not be allowed
> to resume execution from the code location which caused the exception,
> as I don't see how the original issue could be fixed reliably from the
> rt signal handler.
>=20
> I see two options for this handler:
>=20
> - it does a siglongjmp() to some recovery point in the call stack:
>   fairly ugly and basically unreliable for any state machine above
>   trivial.
>=20
> - it notifies some health monitoring agent to take over, in order to run
>   some recovery steps, then self-suspends the current thread. We would
>   not need POSIX signal semantics to implement this.
>

To add some context, we do automatization hardware and have a runtime engin=
e that allows our customers to run their own applications on our hardware. =
They are able to run some stuff in real time tasks and also the runtime eng=
ine use real time tasks for interacting with hardware that needs a certain =
timing for the interaction with it.

If we don't have a way to fix the problems that caused the exception we do =
the following.=20
We tell the runtime engine to stop the application running. Than in fact us=
e siglongjmp to go to a certain point, where we most of the time do some cl=
eanup for the task and  then terminate it.

> In other words, is a generic async signal API the best - and required -
> way to address the issue(s) at hand?

I prefer  a solution with a signal like approach because it runs the except=
ion handling in the same task context so we don't have to think that much a=
bout tasks priorities. As the task that triggers an exception has a certain=
 priority we should probably handle the error in the same priority. If we r=
un the fixup in a monitoring task it will probably have a higher priority t=
han the task having the issue. This could lead to indirect blocking of high=
 priority tasks by a low priority task.

Anyways, I did not find a lot of time to think of an alternative approach f=
or the problem at hand because the solution with signals
where already in use before I started at the my company.
I will think about if signals are the only way and talk to some of the seni=
or developers here, to get a better understanding.
 =20
But for sure thank you for your input and concerns regarding the topic.

Best regards
Johannes


>=20
> --
> Philippe.
