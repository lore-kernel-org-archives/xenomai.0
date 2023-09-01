Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE7ADBE4D
	for <xenomai@lists.linux.dev>; Fri,  1 Sep 2023 13:28:32 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3B3D960002;
	Fri,  1 Sep 2023 13:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1693574904;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y5qz6svRrwOJW0y0gQudXJaG+hLDdyAn5Q/G771kzKk=;
	b=MDNRl6hwgSVRmLKl9uAka+k3l8Ccgz8eF/8Pp9DcbISZgEzq7gXTmZv5R3YD7ZKsyIl1r7
	jl0vNi4DqTexNkiy3M76TQdVyknj3Y5iVGl+DIt/39Ycb6efb4GP7DDlR3h58dBYvH/Jx1
	PPBGPWqCS1Fl59i469DnNExKeJi3Y1PF9PyvbgOVI2Pk9twhTOjal/xBhz0J8Tn+8M83ge
	9Ee4G3RnGYcsfwDcovGrBFspQD+2GUK/sjg3eH7E1T29v+y/57BRVhhYTPRMoEwJFOMjW2
	Dhw+x9ouPPt2aP8pQK645padDhHcd3SfyN6R6gFeyjTn0fkfF7UOGPitnT5Rpg==
References: <DB8PR10MB3706C1F288ABC9A40F6E7E3AF9E5A@DB8PR10MB3706.EURPRD10.PROD.OUTLOOK.COM>
User-agent: mu4e 1.8.11; emacs 28.2
From: Philippe Gerum <rpm@xenomai.org>
To: Jesus Villena <j.villena@ecler.com>
Cc: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: Re: [EVL] GPIO driver error
Date: Fri, 01 Sep 2023 15:11:59 +0200
In-reply-to: <DB8PR10MB3706C1F288ABC9A40F6E7E3AF9E5A@DB8PR10MB3706.EURPRD10.PROD.OUTLOOK.COM>
Message-ID: <87il8uuio8.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: rpm@xenomai.org


Jesus Villena <j.villena@ecler.com> writes:

> Hello,
>
> I have found and error on drivers/gpio/gpiolib-cdev.c: the function linee=
vent_create doesn't call to init_waitqueue_head(&le->wait), which leads to =
a critical kernel error plus rebooting when trying to use GPIOs under an EV=
L enabled kernel.
>
> On branch v5.10.y-evl-rebase the fix would be on line 2026:
>
> 2025 =C2=A0=C2=A0=C2=A0INIT_KFIFO(le->events);
> 2026 + init_waitqueue_head(&le->wait);
>
> I have seen that this error is present also on the other branches.
>

Merged, thanks. You have been credited via the Reported-by tag in the
corresponding commits, please do not hesitate to send 'formal' patches
with your sign-off to submit them for inclusion.

--=20
Philippe.
