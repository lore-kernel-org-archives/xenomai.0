Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957BA15B0F2
	for <xenomai@lists.linux.dev>; Wed, 10 Apr 2024 11:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712750355; cv=none; b=Zd0c99TcciFrLrvxQKmd1YnOkLonQekj2K99ExKsXXBWISR0PhnhUuq7jypSKzB3aKth4Z2g92v1wraLnGznU4MxQqLqOJbhlOlV7ExVxV8K4uqBY7Fs65HzPQr4acaiDqf4EuFuHaoE+duIiEZoZOZiqN7DAfqnJ12DvInKwYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712750355; c=relaxed/simple;
	bh=pZNZlryFPf2ABrQNRmt7xS3fgm8WHHuHmMyIuPhE9R8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XKovjm0KEDypu7AuBBPddmLB6H53+XI8ygftkkjmEEEx+mbLBoNQUJfSK5h6Zw21G1BR+14CMnQ9vAPZCo5M1WGvjTAWbbozqYZUomPWDf4vyzuJ5oLZK43AeZuVvvu/NRqfigEmrGB/WAhYBZA2QJc6LYxvMlQQ8AJqS596hyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=ZHLD1481; arc=none smtp.client-ip=185.136.64.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="ZHLD1481"
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20240410115902181d1d211713c3ff98
        for <xenomai@lists.linux.dev>;
        Wed, 10 Apr 2024 13:59:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=xppKY/Yj++mNraDnEi9ZPHeehGnJhAmhHHXoKObpxX8=;
 b=ZHLD14814tcpM6SdEjbBLCvp5VwGL/prnBxlWuIuqkEz1M2ZN2ty2O34d+k4b850mICJFS
 Tuc/vb5M92OYBwg+J1DRAm58tp1+Wdv19SxUJzARM0Fue6Duc+1v546HHZqehowOnfENusDl
 zsIvbgYPygcYj8vfunW5lKSm3XMmM=;
Message-ID: <0c9e4bbe6a68452f2ab6c5526609de514ebb2b3a.camel@siemens.com>
Subject: Re: Problem with rt_task_set_affinity() in combination with
 xenomai.supported_cpus
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@lists.linux.dev
Cc: Clara Kowalsky <clara.kowalsky@siemens.com>
Date: Wed, 10 Apr 2024 13:59:00 +0200
In-Reply-To: <555d1fbec426cb00fb8bc23412802df51f60bb83.camel@siemens.com>
References: <2fc736948068580213268be9548154799b5c8633.camel@siemens.com>
	 <aab40d57-cd36-419d-ad04-5700cbef9d94@siemens.com>
	 <2315a45d9328c17bd9d7be36c0755bcb4f297744.camel@siemens.com>
	 <2a1c8a5a-5ebb-4195-b986-7ac1ed849a9b@siemens.com>
	 <555d1fbec426cb00fb8bc23412802df51f60bb83.camel@siemens.com>
Autocrypt: =?US-ASCII?Q?addr=3Dflorian.bezdeka@siemen?=
 =?US-ASCII?Q?s.com;_prefer-encrypt=3Dmutual?=
 =?US-ASCII?Q?;_keydata=3DmQENBFwsf8QBCAC2f4AQWu92LZC4bKyUYRxWIpWqGz790s?=
 =?US-ASCII?Q?pcYkXO7M8kfea4iC8qMxv2hT4HT0LTncRP6WiovVN2PeoOBfN5BSa5z?=
 =?US-ASCII?Q?LIrZGVXh7KmbdKhwhVU+ynoTq9G5uaO2Kos7Vv7nNCuatIq8tSNILuoB?=
 =?US-ASCII?Q?DFTAZnJW3y1V7YOwhDCPl5gbLSYqUY3OE0yksbtCcVI5istT4ED6mjQ?=
 =?US-ASCII?Q?9W+3uH1LrgFeEF0oxTjrEPxO5ZYATz0f/TYC8WiM0sMrV+n0eMDntlzA?=
 =?US-ASCII?Q?63D6lcRi5mNp2jPsJkq3tbWqyCrAe1sKPVJB44ekFwCk0kDIuhR13Q3R?=
 =?US-ASCII?Q?HE4Or/9sznhMUQjYueWXvTZfzH/VsQJHABEBAAG0LUZsb3JpYW4gQmV6?=
 =?US-ASCII?Q?ZGVrYSA8Zmxvcmlhbi5iZXpkZWthQHNpZW1lbnMuY29tPokBVAQTAQg?=
 =?US-ASCII?Q?APhYhBAzL4P3jiTHdthsq4cj0O1fnOEBVBQJcLH/FAhsDBQkB4TOABQs?=
 =?US-ASCII?Q?JCAcCBhUKCQgLAgQWAgMBAh4BAheAAAoJEMj0O1fnOEBVc6YIAJ8oO4x?=
 =?US-ASCII?Q?TjOCpjxaS8XQE6VW50HE9I6ShbQVWUEGhF4qzJaACTQDjdg/aio7qNRa?=
 =?US-ASCII?Q?mnAy83Hy9sAxKVhXs+1R1fstN+JO8zgD3tJspucUkCiXlYu+Qcv2d6C?=
 =?US-ASCII?Q?ostv+h4nv8fkSoeLfsQu3GJt6W0RN7t+8H/9fUMXyuB8GWo4bhaZcti6?=
 =?US-ASCII?Q?78CotGLs6UGZpYEGiAMto8+9zVO/tdY1BkREM6bCVeQ9FnnpTRQy/tU5?=
 =?US-ASCII?Q?xemMWJI64UUP92TUIbQ3TZKAz4iG/Mle+YjiHBGrJM7TxjE3sDg5J2Fa?=
 =?US-ASCII?Q?HX4wmZPKGdB6wANKupf6HMMt2y7gduVmMKzgb8PDMLPZwWBSvjELQqz?=
 =?US-ASCII?Q?hiZAQ0EYLSqZwEIAIR4HMTQC4F4YxatIl6MIDY03zD4M3ZQpgyQ6QFL9?=
 =?US-ASCII?Q?Dq0I+PGc7A6z5rsGl76+D8pDFSN2BBJiLLlQadxKc3ZyTTlRp4bc=09bf?=
 =?US-ASCII?Q?FZRmsAXwVfLtBauXxGo9pkyhk8Vcjb2EJm6XR8PH99buGOXlFfTLsmeA?=
 =?US-ASCII?Q?ji/F4jU3qlUnwZMBvHZwRSFqOGdwKPMvW3FppfmREQ0o4xJ4b/bxGXx?=
 =?US-ASCII?Q?ko21uyR/S5rEJx6X8Ukw95h3JinXHx/g2cjbKHrWBDKoqtX9IZCamDny?=
 =?US-ASCII?Q?R+sfLWQbOKOrLNYLwLAQwOTVlZWTgue10G1q6Zi0r8RQ2T1Uy+ZLYagv?=
 =?US-ASCII?Q?Cbzp/lT7p3mv3ba68llX896c0AEQEAAbQ/QmV6ZGVrYSwgRmxvcmlhbj?=
 =?US-ASCII?Q?sgQmV6ZGVrYSBGbG9yaWFuIDxmbG9yaWFuLmJlemRla2FAc2llbWVuc?=
 =?US-ASCII?Q?y5jb20+iQEcBBABCAAGBQJgtKpnAAoJEEoHyE9rG1dPpJYH+gPnqpu7h?=
 =?US-ASCII?Q?4fsWOxco38e74MsazoUdfndTYP5tgaYTVE51ZhOZBl+4jYaywsmmFm9g?=
 =?US-ASCII?Q?6N4Tw3GiMEDB4YU1X7gQZ60fDKpYL5SnCu5qZirJ4RCV4LDA0789ir+6?=
 =?US-ASCII?Q?8/zfwXBTV5QoMH0+MkXB4BL+Km3f7X/GdN5oRoItAyKDBcEfGJo6afT?=
 =?US-ASCII?Q?PtcUdI9n7ExCSfJwb0SBvvkvUsdNppFDGOOHSioINbEHBs2VUvE43toM?=
 =?US-ASCII?Q?4mPLfhFIAtDcn5Byt80/kotU8v3Iyf86NYCa+0h77xTsKHcCUqe8Rvow?=
 =?US-ASCII?Q?bCIbig9GGbbd54TasfqQQOiAkn/WeGl33+UIVX1Q8zo7eyMJHzLJQ3I=3D?=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

On Wed, 2024-04-10 at 13:37 +0200, Florian Bezdeka wrote:
> On Wed, 2024-04-10 at 12:49 +0200, Jan Kiszka wrote:
> > On 10.04.24 12:09, Florian Bezdeka wrote:
> > > On Tue, 2024-04-09 at 19:13 +0200, Jan Kiszka wrote:
> > > > On 09.04.24 13:56, Florian Bezdeka wrote:
> > > > > Hi all,
> > > > >=20
> > > > > while looking into recent bug reports we were facing a situation =
where
> > > > > we were seeing completely different behavior of provided test
> > > > > applications / reproducers than the original reporter.
> > > > >=20
> > > > > It turned out that reproducers were assuming that specific CPUs a=
re
> > > > > allowed to run Xenomai applications, which was not the case. The
> > > > > cmdline parameter xenomai.supported_cpus=3D0x3 (=3D allow the fir=
st 2 CPUs
> > > > > to serve RT tasks) was used here to shrink the set of CPUs that a=
re
> > > > > allowed to run RT tasks.
> > > > >=20
> > > > > Example (out of my head), error handling ignored:
> > > > >=20
> > > > > void rt_main(void *arg)
> > > > > {
> > > > > 	// do RT stuff
> > > > > }
> > > > >=20
> > > > > main()
> > > > > {
> > > > > 	RT_TASK demo_task;
> > > > > 	cpu_set_t mask;
> > > > > 	int ret;
> > > > >=20
> > > > > 	CPU_ZERO(&mask);
> > > > > 	CPU_SET(3, &mask); // Assumption: CPU 3 is allowed to run
> > > > > 	                   // RT tasks
> > > > >=20
> > > > > 	rt_task_create(&demo_task, "demo", 0, 50, 0);
> > > > >=20
> > > > > 	rt_task_set_affinity(&demo_task, &mask);
> > > > >=20
> > > > > 	rt_task_start(&demo_task, &rt_main, 0);
> > > > > }
> > > > >=20
> > > > > rt_task_set_affinity() does not report any error in case the supp=
lied
> > > > > CPU mask is "invalid" in terms of "there is no usable CPU availab=
le".
> > > > > If an invalid affinity was set rt_task_start() will block forever=
.
> > > >=20
> > > > But the task was already created, is only waiting for the kick-off =
by
> > > > rt_task_start. What happens to it?
> > >=20
> > > The thread is canceled inside the wakeup path to the primary domain:=
=20
> > >=20
> > > [510675.581142] [Xenomai] thread demo[1570] switched to non-rt CPU3, =
aborted.
> > >=20
> > > The caller of rt_task_create() will block forever:
> > >=20
> > > #0  0xf7fc7579 in __kernel_vsyscall ()
> > > #1  0xf7e544e7 in syscall () from /lib/i386-linux-gnu/libc.so.6
> > > #2  0xf7f74791 in do_sc_cond_wait_prologue (cnd=3D0xf746b82c, mx=3D0x=
f746b758,=20
> > >     err=3D0xffffd9a4, timed=3D0, abstime=3D0x0) at cond.c:243
> > > #3  0xf7f74915 in __cobalt_pthread_cond_wait (cond=3D0xf746b82c,=20
> > >     mutex=3D0xf746b758) at cond.c:329
> > > #4  0xf7f9db5a in threadobj_cond_wait (cond=3D0xf746b82c, lock=3D0xf7=
46b758)
> > >     at ../../include/copperplate/threadobj.h:572
> > > #5  0xf7f9e9a8 in wait_on_barrier (thobj=3D0xf746b750, mask=3D16)
> > >     at threadobj.c:1237
> > > #6  0xf7f9ea92 in threadobj_start (thobj=3D0xf746b750) at threadobj.c=
:1274
> > > #7  0xf7fb2464 in rt_task_start (task=3D0xffffdb60, entry=3D0x5655647=
a <rt_main>,=20
> > >     arg=3D0x0) at task.c:644
> > > #8  0x565565b1 in main ()
> > >=20
> > > >=20
> > > > >=20
> > > > > How should the application know that the affinity is invalid?
> > > > >=20
> > > > > My current understanding is that the there is no hook (provided b=
y
> > > > > dovetail) that would allow intersecting the sched_setaffinity() c=
all
> > > > > that is used at the end.
> > > > >=20
> > > > > Should we implement such a hook? Is there something that I missed=
?
> > > > >=20
> > > >=20
> > > > We could check the mask from userspace in libalchemy. That would re=
main
> > > > racy, though, as the set of supported CPUs could still change after
> > > > set_affinity and before start.
> > > >=20
> > > > Do we only have the problem in libalchemy due to its split create/s=
tart
> > > > pattern?
> > >=20
> > > AFAICT this is a general issue, not limited to the alchemy skin. We
> > > never intercept sched_setaffinity(), so it's basically a pure Linux
> > > API.
> > >=20
> > > I would say - as it is a pure Linux API - that we can not validate
> > > affinities regarding Xenomai supported CPUs. We could implement
> > > something for the alchemy skin, but the POSIX skin would need an
> > > additional wrapper.
> > >=20
> > > We have /proc/xenomai/affinity, that might be useful. Not sure if we
> > > can read that without triggering a Linux migration. IMHO, validation =
on
> > > kernel side would be better. At least it would avoid one more wrapper=
.
> >=20
> > Not an issue: sched_setaffinity & Co. are not intercepted, so those are
> > causing a migration anyway.
>=20
> The remaining open topic would be: How to do that for the POSIX theme,
> we don't have any kind of interception available for
> sched_setaffinity() right now.
>=20
> I see two possibilities:=C2=A0
> a) additional an additional wrapper
> b) validation (by implementing some kind of additional hook into the
> cobalt core) on kernel side
>=20
> Validation in userspace is more racy, but does not require any dovetail
> extension...

a) should have been "add an additional wrapper". Sorry.

>=20
> >=20
> > Jan
> >=20
>=20
>=20

