Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B6C13148B6
	for <xenomai@lists.linux.dev>; Wed, 28 Jan 2026 16:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769618231; cv=none; b=eMDLxfS/km1Cjf5ALsDTttH56Xw9WcovpoyoxocJryeA+UFtknQBi7A3O7t6MNmvME2apuYx5PFgEy1FnpvqDiwOwS1j1LDh/yQM41xhqZXbnYtjQY3x+6wNB/kWD2WOiU5KpsyB6I2jB6UKBpO+qC8ZGUn3b3CL3ufbRDs3N8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769618231; c=relaxed/simple;
	bh=46wGqh8p+oKvXUXm03hG8zMhWgorQOGcU0EOupBFxO0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QKh/YcGgSl+66OI34YEVEZR//Hz53PltxyTdq8cUn2SYku8X17ZBl2yB2iSRe0C3Ou/V3XdNrKVUAYziGeAYONALJyVbYdDv2BhfXh7KTeas9zdy+GrlE76McjLtuw/GSmZAp7taxMUgiW07FBAG8C2HVnBKfi2o9b2K5+ohUHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=e+HRlmli; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="e+HRlmli"
Received: by mail.gandi.net (Postfix) with ESMTPSA id CEC6B433F6;
	Wed, 28 Jan 2026 16:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1769618221;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=46wGqh8p+oKvXUXm03hG8zMhWgorQOGcU0EOupBFxO0=;
	b=e+HRlmli+ID1ANhcDwu1PLo1L/roA+visWchjvxmlEpA0LnEp8knsMWbPmEpwhCBWk5svw
	DMUnvqZQ2ZkwTKpssNX7V/jrbP8QJGvxXG+V6Y9dk1LdmBjW9Rr3zyEK4dsqEA0iIUmFfR
	vTJ/VRW5Z15ZqTcC2UUjPYa53pOmYJHgGZwTeWQSml36Xriz+8q9BVSVvv2qxIT8wPm68c
	zTtz9aj8dz+M6hjZK5E4MlgaqbLY37xbK/xIMggXw/dxwQioGILsj1ELoZRV6d07u23Mdh
	6hl8VTP/37rjzpmj6tyFm2iJ+jD66MC3SgyGGhFFCuEptRO0kuDufLx2Sz+DoQ==
From: Philippe Gerum <rpm@xenomai.org>
To: Richard Weinberger <richard@sigma-star.at>
Cc: Richard Weinberger <richard@nod.at>,  xenomai@lists.linux.dev,
  upstream+xenomai@sigma-star.at
Subject: Re: [PATCH 2/5] Make RTDM tasks behave, part I
In-Reply-To: <2195484.zVbxSjN2mB@nailgun> (Richard Weinberger's message of
	"Wed, 28 Jan 2026 14:54:10 +0100")
References: <20260128112821.1232-1-richard@nod.at>
	<874io5vpkl.fsf@xenomai.org> <6094973.eUyiRONoq7@nailgun>
	<2195484.zVbxSjN2mB@nailgun>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Wed, 28 Jan 2026 17:37:00 +0100
Message-ID: <87y0lhu21f.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: rpm@xenomai.org
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduieefkedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtgfesthhqredttderjeenucfhrhhomheprfhhihhlihhpphgvucfivghruhhmuceorhhpmhesgigvnhhomhgrihdrohhrgheqnecuggftrfgrthhtvghrnheptdeugfdtudeuveekgfffjeevgfekvdelfeehhfeiueetudejjeeggfeuheffffefnecuffhomhgrihhnpehgihhtlhgrsgdrtghomhenucfkphepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfpdhhvghlohepphihrhhopdhmrghilhhfrhhomheprhhpmhesgigvnhhomhgrihdrohhrghdpqhhiugepvefgveeiueegfeefhfeipdhmohguvgepshhmthhpohhuthdpnhgspghrtghpthhtohepgedprhgtphhtthhopehuphhsthhrvggrmhesshhighhmrgdqshhtrghrrdgrthdprhgtphhtthhopeigvghnohhmrghisehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtoheprhhitghhrghrugesnhhougdrr
 ghtpdhrtghpthhtoheprhhitghhrghrugesshhighhmrgdqshhtrghrrdgrth
X-GND-State: clean
X-GND-Score: -100

Richard Weinberger <richard@sigma-star.at> writes:

> On Mittwoch, 28. J=C3=A4nner 2026 14:31 Richard Weinberger wrote:
>> > Using -EINTR is going to be a problem if xnthread_unblock() is called =
to
>> > forcibly wake up a kernel task from a sleep. In this case, you would n=
ot
>> > be able to distinguish a signal receipt from a forcible
>> > unblock. -ERESTARTSYS may be better for that specific purpose in the
>> > RTDM API.
>
> Okay, I think now I got what you meant.
> A blocking RTDM function such as rt_event_wait() should return something =
else
> than EINTR upon signal reception?
>
> Currently, these functions return EINTR when a woken up task has the XNBR=
EAK
> flag. Let me find out where in the signal reception path XNBREAK is gaine=
d.
>

Yes, the fact that -EINTR is returned both for signal_pending() and
unblock is the fundamental issue, and that predates your patch set. This
is the way x3 has always dealt with inband signal receipt for userland
tasks as well, which is a problem.

-ERESTARTSYS should flow up the call stack in case signal_pending() is
detected by a sleeping out-of-band call, so that 1) we don't have to do
the prepare_for_signal() dance on our way back to user mode for
restarting a signal - which is basically about giving every syscall a
fixed "(not-)restartable" property instead of allowing the receiving
code to decide about this at the point of receipt, 2) the caller of the
interrupted call can decide what to do next on -ERESTARTSYS, including
RTDM tasks. Such a change went to x4 recently in order to align on the
regular inband handling of -ERESTARTSYS [1].

Whether an RTDM task receiving -EINTR on unblock should terminate or not
is a decision which should be taken on a case-by-case basis. Granted, we
could also ignore that condition in that particular case, because there
is no "user" to yield control back to anyway. The only requirement is to
cross rtdm_task_should_stop() soon enough to detect any pending
termination request when unblocked.

[1] https://gitlab.com/Xenomai/xenomai4/linux-evl/-/commit/51c312c6e52e2a65=
437a5f983e8c2d973aa8dcc1

--=20
Philippe.
