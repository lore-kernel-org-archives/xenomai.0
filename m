Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DED930F921
	for <xenomai@lists.linux.dev>; Wed, 29 Oct 2025 07:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761722244; cv=none; b=VDwPQc4Z9lbjqdmavAomrJuCry9EGwacrr1dEiHxQrvVrhflYlpNlYCIsHjrSkIIgh0AHEaWcasoi1hNHiA9JkubXx4Ekz9PinsxssYpaB4VGwL7c93usuvxZg/tBZH+lQrx4kC1ipbtqvRKNTvrRbG3/a6O7OkZtLRRdsPy9EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761722244; c=relaxed/simple;
	bh=5zEpK4hJj1yPYcx+Muq7BlIWTs4L9ViGQj++PPeCxQI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=USU0haB+qSNBLTWTel8hRh2UaindRfmUfwVmimQdEYAAw2pg5HHzD+ANd/HMjKB7LebEs6Kkt1igUhEHvvrCZ5LaKABjr6fYisCy3uQwPEcupE1O+WOA4oVBb8Jlfr/8hv6GIWPFVdlLyRPMyL8VcoF9fXC6vRklW6jYx4etfQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NxrzdjZw; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NxrzdjZw"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b6cdba2663dso4982851a12.2
        for <xenomai@lists.linux.dev>; Wed, 29 Oct 2025 00:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761722241; x=1762327041; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5zEpK4hJj1yPYcx+Muq7BlIWTs4L9ViGQj++PPeCxQI=;
        b=NxrzdjZwsWp70/XbBd9BHUzMy2D/V4dkEYaoToX0hnGawYwk/K9UFF3qJEkPJjZR55
         mc78zN/9xkC40O4xZ7R8EhctfWH7ibYmhTjBH7ROWfU9jl46Pq0qLepePi3m8VMOHHYI
         TaahdxL00PTrVAV4CAR9qB1Z3gXOx8DW7tqe03HNVYxR1lzonx2vQIBFYXpQ6rGLx0Ka
         aO8Vkbb/oYXOc7pzeRIUGtK6RXmFFvUUC4tmOQ6Rf4tIJM90z/mP1T/R9q6xdApaqiWF
         /inN09jaHZGMYN3jZj4bPGswKRvBia9AAC0s643pamF9tpniKuMA8GdpnaEnpSarGNqN
         xdUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761722241; x=1762327041;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5zEpK4hJj1yPYcx+Muq7BlIWTs4L9ViGQj++PPeCxQI=;
        b=BoAHleXuNexJRSR3F68riAfOMgzLzRUwww/pobSLAElGV2o9WILshNZUHCR9sffThf
         FkEsdGmtbz94x6vRRU2GeMSxv+cATd58P3djjWtr1R3rj81MOYeO0rfxylRSVR9o0F6o
         gSy0jxmlmtOllc+x/pzuhy+JdeJod8xFuaRwq02hIWjrlgbr6qzDak3bllyZmf0RP8Bk
         TKFAF+J+j8C9FfIE9Y4hdJwQQAyykPAkLH1pWvFtff5o+KFdVC58twWqyzpQYY74GWUK
         pzzAZYFm1o+jGOvWAv18rxPqTzZUjs2G9+Z06BhQ6KmhF1t63Q+akPBtIhLlm34YNuxr
         ErCQ==
X-Gm-Message-State: AOJu0Yz68bM/qWA850tQp/92hFE6lBQtIkVM3xatagcMKgqhhKVzLFau
	w+FRmlhY689gBIDH9rON4XnZ94/2ikWxxU3Lhm8FuD2oxL6UTg0XuHKB72Nv/nEf8o4IbwpvbJZ
	EN9KhBCrbADnAzy3jddDz1liPPFBX6WLgkg==
X-Gm-Gg: ASbGnctPjtQ98KgxJDyskRPcEfFBAhiewM8EajqJCxNQWdqgmJkLKvxQeiKVqJqyRCH
	3S90HbPt/EhBrO7vWygvegyWebo1ML+xDFS1XUY6xnyxde9mumeUPcOrmYqBhhtXizAXIKF8DY2
	IxqXc2y503I57CJ1lcaihcgaDF7t7tVMLXZ9vF8sSSTY/eaPnB28z2mSURGG/WAdMjVsXGREZXq
	RZdUksyOqVY5csty9V8puCL+FM/T9KQghAzZLgKQUXGBE4vq29fCHhlImlr
X-Google-Smtp-Source: AGHT+IHtDBHU4dYOxSWJJVj7zAnKvO+c3BLrl+9nJvZDkU899FBBc2Zwk2lk3x7jX4M2gPwiKwkGN1d/5v39yTH+/JA=
X-Received: by 2002:a17:903:15c8:b0:28d:1815:6382 with SMTP id
 d9443c01a7336-294deed68e1mr24986045ad.46.1761722240787; Wed, 29 Oct 2025
 00:17:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <5a0c551c-3aad-41b0-a07b-eddaf8837faf@siemens.com>
In-Reply-To: <5a0c551c-3aad-41b0-a07b-eddaf8837faf@siemens.com>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Wed, 29 Oct 2025 08:17:07 +0100
X-Gm-Features: AWmQ_bmgt-5kPgQ8e0ouSbH3PDwxmKD4q8wcQlzmnSM9G4mybsux7hGHc61WLks
Message-ID: <CAFLxGvxB9DaOeMMeEtohddyt3vD2NA9Attv_GrckkJ-hB9CJ4A@mail.gmail.com>
Subject: Re: Xenomai community call on Wednesday, October 15, 2025, UTC 7:30 AM
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 15, 2025 at 7:39=E2=80=AFAM Jan Kiszka <jan.kiszka@siemens.com>=
 wrote:
>
> Topics may include but are not limited to upstream/downstream project
> plans, status updates, and technical discussions. It's an open online
> meeting that anyone can join and ask questions (you may have to wait for
> the organizer to let you in).
>
> Time:
> Wednesday, October 15, 2025, UTC 7:30 AM
> Paris, France CEST 9:30 AM
> China CST 3:30 PM

Do we have a call today?
