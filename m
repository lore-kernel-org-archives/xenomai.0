Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D956B2F2E
	for <xenomai@lists.linux.dev>; Tue, 20 May 2025 14:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747751470; cv=none; b=asVtWdzzukXHwI0Ta4Otpfse21EHZBBwXGUUTWDM+IJsibJgqSjIkeN5oRFGpx6oPmOb85sS33PUrXnV/oQC5meW6XmznkkD+R06Sz5BUf1C85fiNfLQ9F2m7h/NtHzqOO6yZRDsd237+dvZxo5A7//sCVNy9QfXMjeclHFdQAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747751470; c=relaxed/simple;
	bh=JCUvqYc5TMmdvD1GgBI5w+eISHjhY1WRI5ogFej+GOk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rb2UBUSuowH1nX57d+LK9cyEpm/0zKQVCNxWRdtbm2lqzwajfTykd0IdEiVB8bRSuW4xi+itseyNlGiw37DTwhB6oIZ8hVImScV1p9m1Tfn1mULX9//UNHsr5WMHa75U04LgUsG8ZTG4OMA68JP+5pOv5grxirFmXdWWHuMpYcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LzpsuPXF; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LzpsuPXF"
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3fcfc85f1f5so1683817b6e.2
        for <xenomai@lists.linux.dev>; Tue, 20 May 2025 07:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747751468; x=1748356268; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ek3lpS6fF8cuRMh5nZrJ5Afk2C9cxhxJZp8OiC/u9rI=;
        b=LzpsuPXFKxk3uYyAo1ByGoWY8iNowU/LmCNF4W7+ulkRpjtPJGWhuzyN6Tqudgjdr0
         aoCg6VK+OAo7oFxmDpnp84blwa0oYiObs5cu46KWfRrTXrK5g0lJjLKp9YMAcLnIxjWM
         6WpUndTLAaxaSa9ocZbcIhf1U1Mq08XBMzwVfnDXZHO5y1vFqv+JrqIbbrqDnSUb7WP9
         TKwOiLSP1G5GgXFG/Ea3m1yHrgR5HUPAk2OXCzXfxeKzZ4gS8ECARJVVfeHywrh/nHI0
         T+Zd3GiYK7xauu0SU/j4wHfuPkTQ2XjS0xX5fqT7Qz+FqjqMMPjRdQPkoTH0ua//qTt7
         Lc1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747751468; x=1748356268;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ek3lpS6fF8cuRMh5nZrJ5Afk2C9cxhxJZp8OiC/u9rI=;
        b=pWEx+CwjEIO2nEeuDz05UlZqDGifd8rjRfAJwy6l5DnacmAIOvL31/EEiCrfMzj1ak
         DY2JNAEGyi5Tr+6fuFrRcs8lM1UNenufFCyOPXLOzQDkGC/ZYSZ92MVvrBTZ9wRtRNbf
         VSQtMk92n8kxicWT0e4YrzQGerCPYuzT3633h45rnANy4qaSnDq+QJNtyfjh2OoZsqf9
         24nYu7zw9680WI5MInnwNUcj+tjGbNZS1h7ZirCLbr45k2N8ZxzMLZDmz7MwxbhhDW0U
         M/FC0znmx0u53/Xe9+Tbairo00OaUuGY3yVeoH546y/TAZ4bYBEbF/aNAkvL4bbU6cY4
         YOcg==
X-Gm-Message-State: AOJu0YwqnUIrKIUJ1I6HRP0t8SNPEwOh4B6cPH6eIGmh24nN7Uz1TWGM
	5WOPxceShDdI8+fY7kZAKaEyFUTuKAFC+20S7sCXxsrpIaHaL1M7QGm6GZgBN8FyZsMhQllA0Zn
	PhkzbbJjiDo4/tvWHI0W+OZqbfLISMr0=
X-Gm-Gg: ASbGncuCdGcPkyd0ZjCgRbk4R1ex3sXEV9oJFBQjTZZzaKMtBBv+DQ/atvHvQ0E4TOZ
	j2FMWJC7IWNCaqFCqkHCTgmqpr76vRT/m+OoGMwEgZZgTZYCBzsnlrB/8KG0TYz0fG0giccpx5E
	3xyaeDRkZu52eryGJ4gjOnk2vlElQLEP/INg==
X-Google-Smtp-Source: AGHT+IEWhE7/4kqCQPYgQNRIeISTthmDdzytWHZzXmhFr6aZghuI/Y1volFnH25R1D43lQpyznpnAWmVWwf5BYCSvKo=
X-Received: by 2002:a05:6808:2f11:b0:403:3973:23c4 with SMTP id
 5614622812f47-404da728d28mr11102485b6e.9.1747751467484; Tue, 20 May 2025
 07:31:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAEzxD05xAJmeUeyFwcfqBDZMOqDfa1sL+iEUDknzmr6XwX5Q5Q@mail.gmail.com>
 <CAFc1U0vhiFvELw7Y0uxiASQspk2ZDkiA4G-1e_qDRZMVH3rf=w@mail.gmail.com>
In-Reply-To: <CAFc1U0vhiFvELw7Y0uxiASQspk2ZDkiA4G-1e_qDRZMVH3rf=w@mail.gmail.com>
From: Tom <t93252352@gmail.com>
Date: Tue, 20 May 2025 10:30:56 -0400
X-Gm-Features: AX0GCFt5vx-EEvmtEniIbFNVLnFsjqTE1wPU5V2T_u3OMTRHeAdlB28yeKi2WvA
Message-ID: <CAEzxD05krv7gruQvkXe+-zpgjtbdrFOdr-ZY490uyp9ezcyDyQ@mail.gmail.com>
Subject: Re: Xenomai Installation Inquiry
To: Pierre FICHEUX <pierre.ficheux@smile.fr>
Cc: xenomai@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks, is there a specific number for the storage space required for
Xenomai, including all the additional libraries and updated kernel?

On Tue, May 20, 2025 at 12:50=E2=80=AFAM Pierre FICHEUX <pierre.ficheux@smi=
le.fr> wrote:
>
> Hi,
>
> The footprint is very small: some additional libraries on the target
> and an updated kernel.
>
> PREEMPT_RT doesn't need libraries but not a great difference compared
> with rootfs footprint.
>
> Regards
>
> Le lun. 19 mai 2025 =C3=A0 20:55, Tom <t93252352@gmail.com> a =C3=A9crit =
:
> >
> > Dear Xenomai Project Team,
> >
> > I am part of a research team currently evaluating Xenomai 3 for hard
> > real-time control on our system. Could you please provide an estimate
> > of the typical storage space required for installing Xenomai 3?
> >
> > Additionally, if the installation has a relatively large footprint,
> > are there any recommended alternatives that offer comparable hard
> > real-time capabilities but with a smaller storage requirement?
> >
> > Thank you for your time and assistance.
> >
>
>
> --
>
> Pierre FICHEUX -/- CTO Smile ECS, France -\- pierre.ficheux@smile.fr
>                              http://www.smile.fr
>                              https://smile.eu/fr/offres/embarque-iot
> I would love to change the world, but they won't give me the source code
