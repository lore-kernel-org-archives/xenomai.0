Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 611F4101F2
	for <xenomai@lists.linux.dev>; Tue,  2 Jan 2024 14:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id F3C41626FAE9;
	Tue,  2 Jan 2024 15:07:51 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id fO67GcdIohVM; Tue,  2 Jan 2024 15:07:51 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 6121B626FAED;
	Tue,  2 Jan 2024 15:07:51 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id du6cm73d_N8G; Tue,  2 Jan 2024 15:07:51 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id 3CADE626FAE9;
	Tue,  2 Jan 2024 15:07:51 +0100 (CET)
Date: Tue, 2 Jan 2024 15:07:51 +0100 (CET)
From: Richard Weinberger <richard@nod.at>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: xenomai <xenomai@lists.linux.dev>
Message-ID: <806798081.189858.1704204471017.JavaMail.zimbra@nod.at>
In-Reply-To: <983ceb09-c9f3-4b15-9aa1-78fb3d371df4@siemens.com>
References: <20231220194855.8684-1-richard@nod.at> <983ceb09-c9f3-4b15-9aa1-78fb3d371df4@siemens.com>
Subject: Re: [PATCH] [RFC] xnthread_set_periodic: Improve period adjusting
 support
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: xnthread_set_periodic: Improve period adjusting support
Thread-Index: HnuFlCSHFn4a3nZK91UP5vFEHhFi/A==

----- Urspr=C3=BCngliche Mail -----
> Von: "Jan Kiszka" <jan.kiszka@siemens.com>
> If I scan our code base correctly, this only affects RTDM tasks, at
> least in-tree. Is that your use case as well?

Exactly. I didn't implement for userspace tasks so far because my use case =
is
purely RTDM.

>> Alternatively, callers of xnthread_set_periodic() could access
>> task->ptimer directly and pass an adjusted start time to
>> xnthread_set_periodic().
>>=20
>> Signed-off-by: Richard Weinberger <richard@nod.at>
>> ---
>>  kernel/cobalt/thread.c | 15 ++++++++++++---
>>  1 file changed, 12 insertions(+), 3 deletions(-)
>>=20
>> diff --git a/kernel/cobalt/thread.c b/kernel/cobalt/thread.c
>> index ff12f288a..a5304cc8a 100644
>> --- a/kernel/cobalt/thread.c
>> +++ b/kernel/cobalt/thread.c
>> @@ -1335,9 +1335,18 @@ int xnthread_set_periodic(struct xnthread *thread=
,
>> xnticks_t idate,
>> =20
>>  =09xntimer_set_affinity(&thread->ptimer, thread->sched);
>> =20
>> -=09if (idate =3D=3D XN_INFINITE)
>> -=09=09xntimer_start(&thread->ptimer, period, period, XN_RELATIVE);
>> -=09else {
>> +=09if (idate =3D=3D XN_INFINITE) {
>> +=09=09xnticks_t start =3D period;
>> +
>> +=09=09if (xntimer_running_p(&thread->ptimer)) {
>> +=09=09=09xnticks_t elapsed =3D xntimer_interval(&thread->ptimer) -
>> +=09=09=09=09=09=09__xntimer_get_timeout(&thread->ptimer);
>> +=09=09=09if (elapsed < period)
>> +=09=09=09=09start =3D period - elapsed;
>> +=09=09}
>> +
>> +=09=09xntimer_start(&thread->ptimer, start, period, XN_RELATIVE);
>> +=09} else {
>>  =09=09if (timeout_mode =3D=3D XN_REALTIME)
>>  =09=09=09idate -=3D xnclock_get_offset(xntimer_clock(&thread->ptimer));
>>  =09=09else if (timeout_mode !=3D XN_ABSOLUTE) {
>=20
> If we changed the behavior of xnthread_set_period, we would also need to
> update its documentation - which so far states that "now" is the start
> time when calling this service with idate =3D=3D XN_INFINITE.

Sure. This patch is just an RFC.

> But why not using idate for this use case instead? Is the pattern too
> common to push it to the user?

While this is doable, I found it a bit hacky to access task->ptimer directl=
y.
IMHO ->ptimer is private and should not directly accessed.
At least my other prototype uses xntimer_interval() and __xntimer_get_timeo=
ut()
to get all information need from the periodic timer to change the period
while it runs.
=20
> And if changing the current logic, I would wonder why not saying that
> idate =3D=3D XN_INFINITE means that the change will only take affect for =
the
> next period, not the current one. Would avoid losing one shot like in
> your proposal above.

I need to think about this but as far I understand your idea this requires
an extra variable in the timer or task struct.

Thanks,
//richard
