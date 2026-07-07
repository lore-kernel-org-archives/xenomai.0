Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C1E3DD875
	for <xenomai@lists.linux.dev>; Tue,  7 Jul 2026 14:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783433662; cv=none; b=q2WrSDaPRQNt0Kh9l519CzIH9FMsKYCZPByEfUSO8FjMO/UdzYl8uubDzUEXeRK/zobEwzzuzV9MVf2jjN3InuJINeBH6m4/MnOVk7FOMXjHL8um862FcMxfI9NOtakcuLKv8hKcL/PRjj2GyFkM9hoq984/9UCco2gJhc6cHjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783433662; c=relaxed/simple;
	bh=0hzzaiiDEbo9DZpi9rVW+HgSKk1nfRqSin7D+Creems=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=E17f08mXpVqZJNMJ5SAKIBNHQfvOC2MVclUbAe79rjTKxkzzGIm5WjfaSuu0+wEkFo9GW0dt1IR/vFKBZk/pL7gWNEgQOED6GJvA/AMyR8KLsvOtvP4tBgJHDni9EJBXMWFEvjpOMrAdTanf6mxZBhd9D9HnkukUcspXaffVALY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=ZaJV5zg3; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="ZaJV5zg3"
Received: by mail.gandi.net (Postfix) with ESMTPSA id C9E353EC67;
	Tue,  7 Jul 2026 14:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1783433658;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0hzzaiiDEbo9DZpi9rVW+HgSKk1nfRqSin7D+Creems=;
	b=ZaJV5zg3WYM4grcZyhptlFSd8Wkuya/0vyroJrhIVaP4YttMxciM1CeAHZXmM15sRd5mW+
	uoZEslE6P4SDnXDbJApOxllkz13jXb3jLU0T4DO0BappG+oYN2dazl6/XSTAICOG6tvp0c
	9+emyFv6Bwa98VRhk2gNho8xW+TBvLeBZ3SAVogAEJpeQqKqhskFHnAJn6seb4EESVyzr+
	O1Lx7wOh35rz3lddg1bv94LGkH5LD1HU6KJAj6hMEn+FZgSNgmziWs+He8klsMaQNZnOp+
	zeldxUxP+AGKzWhMn2QAqP+o8qzHC1doI3PLsTWa8WX1rddOqYdhtEinZ9UawQ==
From: Philippe Gerum <rpm@xenomai.org>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>,  Tobias Schaffner
 <tobias.schaffner@siemens.com>,  xenomai@lists.linux.dev
Subject: Re: Dovetail/Evl confusion on my end
In-Reply-To: <a4322e374ac79703bf12de3512510af2773a26d5.camel@siemens.com>
	(Florian Bezdeka's message of "Tue, 07 Jul 2026 15:56:15 +0200")
References: <a4322e374ac79703bf12de3512510af2773a26d5.camel@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Tue, 07 Jul 2026 16:14:17 +0200
Message-ID: <87o6givqdi.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: rpm@xenomai.org
X-GND-Score: -100
X-GND-Cause: dmFkZTGTlEoQpsl5Co0RDYiJfZI58En4aAYTftqW1+Pp9eDpNHxl4hq7cLrbZ8NUreEuUi4yBgATNbmMUa6Nykgo3p8qF83wD7m8SD2cBCZiJee5JKPe8eLH6I1Cp9VMC/OzjvAnXuEXKg93QNFlwkvvUyfQzxcRbINrvvfuceIiRBrLCR7DNU5JQfbiUuJ+UIuOsSzy5hXjq4z9CwqlHq7TORiEGrpn0YwlLB5BLpZqBfAy5yWwti3iiXBQxfvmCB9jflSfY82PTm8INB8j7cSgbLEbCj/24RxS6x1LBhmY9LnR22+mY1e6FEazet0Xi78o8I49RMD6o/9qZzaIXkXvo7JlA4t0ojG/eEVFAAysBjjh4p7m4/bPaln6622YWlN7L59QkPgNlvSoBMUsXcrWYU2lrqg9IGYwO4HFSi+FgzXP94D9pZuEGVlOws8dwIOftyYX8dhcKgMKUc401HEa50eqFgTkaWqnHEY1UAOQqg5OQz3R3g2t4tB8kmcFUyjbVJYSUtO+Sne9Hl3Y68mklr+uoAG3YLFzMvNU9e78/yy0/Ma5e5Jla/2EaC7CBTi/ePxC5uzMB9l0H8IzluopqWLSHobwfggxEHzId/UOJ5iBFAQSwhgZ6pPzDGgLi3knLmRaMKmvNfGLdtfJ2Ivq8yQmZkYp/JJGs3C/F0p9bhb0lg
X-GND-State: clean

Florian Bezdeka <florian.bezdeka@siemens.com> writes:

> Hi Philippe,
>
> I just recognized that you updated the source of my rebase branches
> meanwhile, so v7.0-dovetail-rebase (for dovetail) and next/v7.0-evl-
> rebase for evl.
>
> While syncing the missing pieces I noticed that commit=C2=A0
> ad7e492ff2 ("/dev/{null, zero}: dovetail: drop deprecated .write handler =
")=20
> is part of v7.0-evl-rebase but is not part of v7.0-dovetail-rebase.
>
> Why is that? Any specific reason?
>

I pushed this patch yesterday, and wanted to have some hindsight about
it for a couple of (testing) days of the evl tree. I believe it is
correct, but given the patched area, better safe than sorry. I plan to
merge it last on top of 7.0-dovetail.

--=20
Philippe.
