Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF232D9EF3
	for <xenomai@lists.linux.dev>; Mon, 19 Jan 2026 07:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768808988; cv=none; b=X6ZYbL0hBrBPfvv5HGaeV6RERm48pYKbtQKLiWYajGWx96G5Mef22OuTYILq/FaSiNq5WOl3tVerS/5q+bAwlTMgQMu6mwAyJsjYzKYYy0jjd1ycDLmmIhwSH9O0je9prBQr2MQVYn6ljFU6DbXO86575JtJuoePxzcH8dk9RSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768808988; c=relaxed/simple;
	bh=B6vktHflwSWu5OMyr/Vn9EI3AfLujx6uZhdJtMzCxtY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=Cbksi1B6XFmaz5I3ZBMdy2dlJgRO9Hst6nv5CgkRab52M+239niWl9KkLYTCfG7YPwbFay8i/4XYwAsr6fYKs+mDT/K/Htm/Lhpc6oArWmYwhevTuMyrHrbTrK8FifTti5SOnTnmO4KSUiONXcrxQabqh2Qbg4Tqp5sQ5WQF7p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smile.fr; spf=pass smtp.mailfrom=smile.fr; dkim=pass (1024-bit key) header.d=smile.fr header.i=@smile.fr header.b=DMSTEZOd; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smile.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smile.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=smile.fr header.i=@smile.fr header.b="DMSTEZOd"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-431048c4068so2271418f8f.1
        for <xenomai@lists.linux.dev>; Sun, 18 Jan 2026 23:49:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1768808985; x=1769413785; darn=lists.linux.dev;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=apQHOGzatmHtjygee+5HkprC2/oNr85ur1sZckPoOt0=;
        b=DMSTEZOd11gCJvDbAm4aO+lgWIT2LhHEOdHIFZp4GMrYVcZWzkfvJ8Aij/h84AQU/D
         frHspeC432t7fCm0OQ3VZfgxU/CblcoJdQIS2C4L3T6fjr4AH5I/MejiTSrdFpMRL9Uw
         W3e8Nd3rp0RY7qMTPWpg2/M/KMthYl02WVH84=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768808985; x=1769413785;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=apQHOGzatmHtjygee+5HkprC2/oNr85ur1sZckPoOt0=;
        b=JXBFFeqrGvMxeKU+4NFjaKhXZup7NKL8lN7dOhUWKaE/PprQG+P16fEF9vw7xlkT+E
         o/Nql+i+y2Wij3yvcgs+45JWjBrceJC0svn4Mk41o+qrHtZy5HrW2uueCmSHhabyw3xw
         lJcwE2DkRMhPQT5GUE9sE52beZJ0FXzch387IuCkMDEEqUjgAnsXuXJ+m1rWTOVVEmzJ
         5CR/0J2Pr8n/tbInDXrpW/G479ScuODU0u+saL5lcTJ97qj2YG+mkeY3UDJWwHaNYXLG
         o73FZzI4yS9gXIk0iZTyQx5fYxEXwgksXL8Xok3TL4OOItHQ/n48VlBXsPhwNWbZFiFu
         xC7g==
X-Gm-Message-State: AOJu0Yx5Pd3ZTPCG5kasWErdkj+I1kUt1jLy12ObHomH27ccLOd0yJJ7
	g37PTyeJXpQOFBeEXeTHJZjwG5E0jKlsQHt9BZEnwN6FKTRQA+Z1r8hOvdIl0AmRyDY9YLLNgzT
	JABW+zGGwN2hxOtUsRaaW6yXNluylvWND3nnsjYlYDCKuS0oVUxZMVsd5uw==
X-Gm-Gg: AY/fxX4PEXFTH5LzaXMV3U4nopKIR4R1SsasZJ32dXHpOkMDoFndN18L3iGl4+VdGJ4
	3iZ1h1tOuMq5nWB5DbfcxFMIpFtpEKeyIg7Th287d2YFiVTQgSt+w8Gdp/lif9liIZiPDZ9H+CX
	K8+TuHuralXSAPlTDtiNQC4CoJOtsYFa0PBfLIcXE4Ti3wchIPUxKtpIInDjFikDB/Np48UYEMC
	SWkHctIV4+JV6TByn0v7a65Q88CRmP3pS1Afh0kKP8cXYQLEIPygioGdrP/U3iWSiUq/KGwlR3X
	rDY/LvuTpt8qo+5U/pueR4DaOovH1NP2pGbBkaS1S0chE/pgZJBKz9rUnrXN626Nq+pg6kORRj2
	8l8wi8i7qvonKUT2aRbkQ4RVf7A==
X-Received: by 2002:a05:6000:2089:b0:429:b8c7:1848 with SMTP id
 ffacd0b85a97d-4356955f32bmr13007759f8f.19.1768808984825; Sun, 18 Jan 2026
 23:49:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Pierre FICHEUX <pierre.ficheux@smile.fr>
Date: Mon, 19 Jan 2026 08:49:33 +0100
X-Gm-Features: AZwV_QhHRCKivJ3LlBrnYVkOE-c4ZbsPV7anq0Ez2gPRnAwY9c02DcE3-xeVwUM
Message-ID: <CAFc1U0utp_YgpET_EgBb=Q6e3orJfisB5_sSLq53APX73eWyJg@mail.gmail.com>
Subject: xenomai-image problem
To: Xenomai <xenomai@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi all,

I try to use the current version of xenomai-image and I get an error
at the beginning of the build (Xenomai 3 with several targets).

$ ./kas-container menu
2026-01-19 08:41:30 - INFO     - kas 5.1 started on Debian GNU/Linux 12
2026-01-19 08:42:02 - INFO     - Saving configuration as /work/.config.yaml
2026-01-19 08:42:02 - INFO     - Using /repo as root for repository xenomai
2026-01-19 08:42:02 - INFO     - Repository isar already contains
9792d18e9334b3cec72e2ade6a1065084c0c24d6 as commit
2026-01-19 08:42:02 - INFO     - Repository isar checked out to
9792d18e9334b3cec72e2ade6a1065084c0c24d6
2026-01-19 08:42:02 - INFO     - /work/build$
/work/isar/bitbake/bin/bitbake -c build demo-image
Loading cache: 100% |
     | ETA:  --:--:--
Loaded 0 entries from dependency cache.
Parsing recipes: 100%
|######################################################| Time: 0:00:02
Parsing of 52 .bb files complete (0 cached, 52 parsed). 107 targets, 0
skipped, 0 masked, 0 errors.
NOTE: Resolving any missing task queue dependencies
Sstate summary: Wanted 12 Local 0 Mirrors 0 Missed 12 Current 1 (0%
match, 7% complete)00:00
Initialising tasks: 100%
|###################################################| Time: 0:00:00
NOTE: Executing Tasks
ERROR: isar-mmdebstrap-target-1.0-r0 do_bootstrap:
ExecutionError('/work/build/tmp/work/xenomai-demo-armhf/isar-mmdebstrap-tar=
get/1.0-r0/temp/run.do_bootstrap.296',
25, None, None)
ERROR: Logfile of failure stored in:
/work/build/tmp/work/xenomai-demo-armhf/isar-mmdebstrap-target/1.0-r0/temp/=
log.do_bootstrap.296
...

The error seems to be the result of a missing dpkg command.

| I: installing essential packages...
| chroot: failed to run command =E2=80=98dpkg=E2=80=99: No such file or dir=
ectory

I've used it some months ago without any problem, do I need to update
anything else ?

Thx by advance

--=20

Pierre FICHEUX -/- CTO Smile ECS, France -\- pierre.ficheux@smile.fr
                             http://www.smile.fr
                             https://smile.eu/fr/offres/embarque-iot
I would love to change the world, but they won't give me the source code
