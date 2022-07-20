Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB52B6AA0
	for <xenomai@lists.linux.dev>; Wed, 20 Jul 2022 17:41:02 +0000 (UTC)
Received: (Authenticated sender: philippe.gerum@sourcetrek.com)
	by mail.gandi.net (Postfix) with ESMTPSA id 1A0DDE0008;
	Wed, 20 Jul 2022 17:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1658338855;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=25JpQGC3GHqoLGRglGRd+rXo3trw14vcgjkFnkvRut4=;
	b=AzxO7v6lA7fTKSG7M6e6Z9oUs+6f8UgCGerUOs2yZkXLAUKeGyN1qm9Y9SdgGik7cupx1v
	kmAE65xy00SHw+65jgfmLKXsD6eIUBNK5YVCPSPsxoGYJJG9bK/fOqTleIU6/vkBkFLeK5
	rRrzOaeOthGBdgON/eVZQOftVpySHhf1Jbb8BWDmFQLHfIGft3N0HOKxLY6+RbPzdVq2Ye
	FdWivkm+oswOv1xNRtjW+w/zKM8CFmU5CCgAUXPK0xN/oLAtft9kgwXfwy+gtiINML779d
	asBgP1yQ6YnLo5RnUd5VSivL3DDyxLQDkUZbcWant9T+AK0zBu6PRCNyj4iKrg==
References: <PH1P110MB1050C461687F096F74A6B1FBE28E9@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
User-agent: mu4e 1.6.6; emacs 27.2
From: Philippe Gerum <rpm@xenomai.org>
To: Russell Johnson <russell.johnson@kratosdefense.com>
Cc: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: Re: Weird debugger behavior with events
Date: Wed, 20 Jul 2022 19:33:29 +0200
In-reply-to: <PH1P110MB1050C461687F096F74A6B1FBE28E9@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
Message-ID: <87fsivlm1l.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


Russell Johnson <russell.johnson@kratosdefense.com> writes:

> [[S/MIME Signed Part:Undecided]]
> Hello,
>
>=20=20
>
> I have a simple test app with two EVL threads (basics shown below). When =
I run the app outside of a debugger, both threads run as expected with no i=
n-band switches or errors from the EVL core. However, when I run in the deb=
ugger, I am seeing evl_timedwait_event returns -1 when the app is started a=
nd then eventually it finally returns -110 (ETIMEDOUT). It makes it very ha=
rd to debug. I would expect it to run like it does outside of the
> debugger =E2=80=93 thread 1 should just keep re-calling timedwait as it s=
hould keep timing out. The other weird thing is that if I run thread 1 in t=
he debugger without thread 2 running, then it will work fine. Any ideas?
>
>

I could not reproduce this with the provided test case so far. Receiving
-1 from evl_timedwait_event() would mean that the caller is not an evl
thread (i.e. not attached via evl_attach_thread/self()). I ran the test
after setting a breakpoint on the evl_timedwait_event() statement;
single-stepping and continuing from a break state from that line works
ok here. There must be something different in the way I'm testing this
compared to yours.

Could you provide me with the full test case, e.g. the one that includes
the attachment to the evl core, and also details about the user
interaction with gdb? For instance, do you set breakpoints and see
issues from the break state and on, or do you observe the weird behavior
as soon as you run the app over gdb, even without any interaction,
breakpoint, single-stepping etc?

--=20
Philippe.
