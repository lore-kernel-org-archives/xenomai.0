Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B2A36921A
	for <xenomai@lists.linux.dev>; Tue,  3 Feb 2026 18:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770142893; cv=pass; b=uJZO45Nujm5kviNJwqnEz+7x0AyH7EupGla+vyoBuCHL3/4RUtC9xBarjfALO0P7rxtNNRbb8jyzqWv7lLc1K3Df0uoVcQdOiodotBQ7A8T8kMeLwldAMCQEG04E2LpH2wI2RhIXw9XS8kVhGpVu1cv2PoAIT3W2iN+6Bs4lbFw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770142893; c=relaxed/simple;
	bh=uaBBlCBfbCx8iW8Hx4Ghh1bu3188vYCRulYcvsEezmA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S38XzbIriUdaFB9VzyLXzDj7Rmfcl/GGiYBBEqvZ/oCe6cIa37fQy7NF6Q89Qsc02dACbK3rrCHDDVa0fqEnRIo/67t6OhdjnqDyVsqUPhPbIKkwhfxy51ojAI6mNRbEJ3pay2T+FI4EQ9E+RRDBHSOu37BZt7eWVQ21Sj29QO0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smile.fr; spf=pass smtp.mailfrom=smile.fr; dkim=pass (1024-bit key) header.d=smile.fr header.i=@smile.fr header.b=frJGXaWQ; arc=pass smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smile.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smile.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=smile.fr header.i=@smile.fr header.b="frJGXaWQ"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-42fbc305552so5515327f8f.0
        for <xenomai@lists.linux.dev>; Tue, 03 Feb 2026 10:21:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770142890; cv=none;
        d=google.com; s=arc-20240605;
        b=JWw1KBlHGb0z1WUyINE5axdzr0da988G2g910lMqGfH94mVfTThlQiYNDSVJIYcPFE
         1GRvwZn+phj2HxawoyZqsT5IqcJZu7MhbYL0Y6TBzLu1jd6POPRL8IA9onPxkGDJgZqj
         OU/WUHNvzGAQwF37+B1Qobk7bgwZwUODuSPSyaWgDHUCU08i1gip2AGbZVqkJTFjz/BD
         13bIGQ+G9+yMoXFMkLPokvk6klM9x5SpGZgK67YCS+70zI+A48InXMuLtuJqHEoEQnoi
         bjksaEuaM1tXd07iC4aieKnQqQhXNn2qleXKgYB7b23ZrUwX5+HA1kBnbNu4G5vYQNUL
         mvDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gEHEBKh4Sv4dy6yZ2+yjAQIqVSBcxKlg9uYF1lH14Jg=;
        fh=Gbokv2cqjXipI/isbuuM2AkWdnz5ZRsDr4BAyqPfOQ0=;
        b=dOkh7hFxJMK44qdjks129IJqF77g29Ag9rfEnrCVrVqYNTx6RJljg8g2Hgb8htElrn
         wKmokCYXZLNFEMhCLSnbcOOwv0+/5WvhzarNSw7ZyrVMFnHXMiO7SiOkCZaOAc/JCYct
         1Z5lrGvxCQ7se6a4CS30WqlMI9zEPM4X+NjLFtdHYLlZC4G5g3t8+6OKqSnYxW/poaCe
         aI7izupkteVZPM5uiUhqc7EIp2EssvEH4kOrNMhw3KLtI7J1CF2SIbHYBjIwdtjYN+Qk
         06KNJ9fFIBtCLsALcy2/XBTCfevEt5ZnM+Y/lSYVQ3hKbnl8Q93CCw17J1Yab1NwKb4c
         1yhA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1770142890; x=1770747690; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gEHEBKh4Sv4dy6yZ2+yjAQIqVSBcxKlg9uYF1lH14Jg=;
        b=frJGXaWQV3HGuPBvkvHS+Dz8KVwrhsc46kOzEJLx7XGE3QpBklX78X+Hw8EujKn/gE
         gVgo01e0tODOowiQ4pNwsZcwnTit3b9ZNDABEKvfewEIVajwPyzIyemtoYtQOPSBTXah
         e/tUvmWwQ6G9d9aX0oJoEFQHxyoiwf64II4hY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770142890; x=1770747690;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gEHEBKh4Sv4dy6yZ2+yjAQIqVSBcxKlg9uYF1lH14Jg=;
        b=Pc/Jl4FgdbcmSENQKtoFLUqMVPBe6pt8NhqGhbxSIVnYiah+igo+/UZyaJDT+ycBxL
         XV1UqgB8mcclMaKLS+L7bgnJmE905AV6gPFDU1VehRVpp724tu+jtGSyeaOEZ1TLCL4U
         /h5rE0xWIeK63AFdD82KpjYPDna0lZaZOQKHuCwWePfwaCsX/tEh8L1ujeyb2wyx3CV1
         U+gxN8vZsqKdzIBAOi1PXReqiIY2l+FKQmfqRW3jb+X79HF3oLdJ6+JT997zeFGlWPv/
         qWEiGRblbLFh7veuhb6s31G1YnquWxR6RePys1iQSD9EXMgRR7sHwho/xyRPUR5rZ2hr
         I8Ng==
X-Gm-Message-State: AOJu0Yyb2Owi23Rjymk9BbcROroBtPrGSgOJFkh+Xq+On1AqQf2lSlOp
	yaQZDKc/ZzRMXtyCjh2nLmghnGMKzT/7X/kcI0J1G2520KeRu//mfh+uX1urjUFn30fF+wZrLrV
	PE6dSgfLabSjWXA6zqhyHI3EQ2Ssnx8P+KncXF0WjqumoWvptgVg9
X-Gm-Gg: AZuq6aJ8KPduLzCm/zI+p5n2wG3vLOk87ywTOs0DWBBrldCS9HWTWny3r6O4URPsV4D
	GtyxaS9MJM9nS9f8VbAPaZmFxxbIYJpgswmdzo8dqWX6QW4teqUDLEnrCttw2IHOvRgBbAdoOB+
	wBxxrBwB2ejNGgYkUsG7jP9ZDtOprMW56Pv3wWmfqD6DmqpFo2ww0bV85AUCNLnCf/yXqjx7rND
	yq965Gr+JGaaZXQvX4Grt/wtO06e6GIx2Pa5xS6PuDAirX7z3UClHrb2KYogPF/0WQo9tYd5bXe
	SPDwvKzIbbpK8pm5B6vmd0XuzjcJU8y8PPlBwfAz0uO3WK6p0sN1SU+bPhwgDhRz4liiVj9K6hg
	MKOyGwqY2VBXwYqVW2yDQD9oZoz4=
X-Received: by 2002:a05:6000:3110:b0:432:aa5a:3916 with SMTP id
 ffacd0b85a97d-43618056baemr401584f8f.40.1770142890502; Tue, 03 Feb 2026
 10:21:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <074a123c-c6bd-46ab-b0d2-6912ea08c1a8@siemens.com>
In-Reply-To: <074a123c-c6bd-46ab-b0d2-6912ea08c1a8@siemens.com>
From: Pierre FICHEUX <pierre.ficheux@smile.fr>
Date: Tue, 3 Feb 2026 19:21:18 +0100
X-Gm-Features: AZwV_Qj_ONGnkxxCaVsvRp1yfdTAJqZFKyk_qmq4tNPnWGOHobLjHGogqqDUgFI
Message-ID: <CAFc1U0tyFfybsjNHMdJA-KAZ-fY-hWOhhCeMiNxdVBdELWbMyA@mail.gmail.com>
Subject: Re: Xenomai community call on Wednesday, February 4, 2026, UTC 7:30 AM
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I will be there :-)

Le mar. 3 f=C3=A9vr. 2026 =C3=A0 17:38, Jan Kiszka <jan.kiszka@siemens.com>=
 a =C3=A9crit :
>
> Topics may include but are not limited to upstream/downstream project
> plans, status updates, and technical discussions. It's an open online
> meeting that anyone can join and ask questions (you may have to wait for
> the organizer to let you in).
>
> Time:
> Wednesday, February 4, 2026, UTC 7:30 AM
> Paris, France CET 8:30 AM
> China CST 3:30 PM
>
> Join Teams Meeting:
> https://teams.microsoft.com/l/meetup-join/19%3ameeting_NmQ4NjFlZmItZmE1NS=
00MzZjLTk3OWMtNzc3N2Q0N2Y2MzM4%40thread.v2/0?context=3D%7b%22Tid%22%3a%2238=
ae3bcd-9579-4fd4-adda-b42e1495d55a%22%2c%22Oid%22%3a%22058073ef-2de1-450d-b=
434-70a67389dcfa%22%7d
>
> Jan
>
> --
> Siemens AG, Foundational Technologies
> Linux Expert Center
>


--=20

Pierre FICHEUX -/- CTO Smile ECS, France -\- pierre.ficheux@smile.fr
                             http://www.smile.fr
                             https://smile.eu/fr/offres/embarque-iot
I would love to change the world, but they won't give me the source code
