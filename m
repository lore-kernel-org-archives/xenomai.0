Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A87EF17581
	for <xenomai@lists.linux.dev>; Tue,  5 Mar 2024 17:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.201.40.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709658888; cv=none; b=XLso68IPrwRax0iCOuS/lBeye3aM8IQGfP1PgUGwsdPWGfEq1+j+nJPPFgY0xd44X1fDRRmAWISnLVKSIqedyoKM4Uh63lAqSu4SCex+khgoipPeEKkjWl63LBpIXstTiOR+pIixtAGckCwn+EcNFyWmMYboxqFP8m8UuRpalro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709658888; c=relaxed/simple;
	bh=QtRDyu+qMtZpgSQ04x5cTeQHiWcsGj5ZWgwANuIB/6M=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=JFR3hPTVubLnEjYFjaqJMUa5McgH8YC/bFnue8H1vCCMFASWbCoF4sA0jVSTVzmd7hR3ETQKh7xbd4hnNTwToJIQfN8N+skWAZrDiGPVLffsVjJwmwmQ7etSZgsmlhG67eVv8FrD+eQcofm20qNvWI73ENYjUaQVNGymW8Gure0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at; spf=fail smtp.mailfrom=nod.at; arc=none smtp.client-ip=195.201.40.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 610EF6410400;
	Tue,  5 Mar 2024 18:14:43 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id 6evqM86vRRYu; Tue,  5 Mar 2024 18:14:43 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id DF48F6410410;
	Tue,  5 Mar 2024 18:14:42 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 3y-I6kRXDX0W; Tue,  5 Mar 2024 18:14:42 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id B97AF6410400;
	Tue,  5 Mar 2024 18:14:42 +0100 (CET)
Date: Tue, 5 Mar 2024 18:14:42 +0100 (CET)
From: Richard Weinberger <richard@nod.at>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Richard Weinberger <richard.weinberger@gmail.com>, 
	xenomai <xenomai@lists.linux.dev>, 
	Florian Bezdeka <florian.bezdeka@siemens.com>, 
	david oberhollenzer <david.oberhollenzer@sigma-star.at>
Message-ID: <330314155.13848.1709658882463.JavaMail.zimbra@nod.at>
In-Reply-To: <8b3ae00d-3d40-4531-b236-ad6bf2a8bfd9@siemens.com>
References: <20230816101842.3377643-1-johannes.kirchmair@sigmatek.at> <CAFLxGvyhP+qEfrZQVvOqrLbLmhq48k2G5aA12b9sowKXZeDtTw@mail.gmail.com> <8b3ae00d-3d40-4531-b236-ad6bf2a8bfd9@siemens.com>
Subject: Re: [PATCH 1/3] [POC] test implementaion of rt-signals
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: test implementaion of rt-signals
Thread-Index: igrikQcpLvFvM432z/osTW1HR4jvsQ==

----- Urspr=C3=BCngliche Mail -----
> Von: "Jan Kiszka" <jan.kiszka@siemens.com>
> An: "Richard Weinberger" <richard.weinberger@gmail.com>, "xenomai" <xenom=
ai@lists.linux.dev>
> CC: "Florian Bezdeka" <florian.bezdeka@siemens.com>, "david oberhollenzer=
" <david.oberhollenzer@sigma-star.at>
> Gesendet: Dienstag, 5. M=C3=A4rz 2024 18:05:08
> Betreff: Re: [PATCH 1/3] [POC] test implementaion of rt-signals

> On 05.03.24 16:54, Richard Weinberger wrote:
>> On Wed, Aug 16, 2023 at 12:19=E2=80=AFPM Johannes Kirchmair
>> <johannes.kirchmair@sigmatek.at> wrote:
>>> diff --git a/kernel/cobalt/dovetail/kevents.c b/kernel/cobalt/dovetail/=
kevents.c
>>> index 4da4f51b7..61417717b 100644
>>> --- a/kernel/cobalt/dovetail/kevents.c
>>> +++ b/kernel/cobalt/dovetail/kevents.c
>>> @@ -57,6 +57,9 @@ void handle_oob_trap_entry(unsigned int trapnr, struc=
t pt_regs
>>> *regs)
>>>                 xnsched_run();
>>>         }
>>>
>>> +       if (xnthread_handle_rt_signals(trapnr, regs) =3D=3D 0)
>>> +               return;
>>> +
>>=20
>=20
> This is not the version I shared. But I assume the issue applies to that
> one as well, right?

Yes, I'm fighting currently on x86 and arm64. :-/

Thanks,
//richard
