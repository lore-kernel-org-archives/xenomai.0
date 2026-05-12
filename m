Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A352478851
	for <xenomai@lists.linux.dev>; Tue, 12 May 2026 09:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778577407; cv=pass; b=dyKCWrq+pcK8SWnza1k4nuRCHNFpWsFwTdWk6rjaZlp3P3J8lZX1nrTcauJX788C18g6yWnULGScbSq3HgCOmzLsP0YNLgjmn8a+vwaadBJnMLuRWera2yQ5KPJ231Opnc2KsJMnzbHQrypGQpJk8iAdEcdfWxLpouktBlCcSV0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778577407; c=relaxed/simple;
	bh=TnWfOsxONotd/TuGfVzunppOoCFNozToSPtLYpAxwlo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GLjGAo+iGiHeo6CNENQEO22RWsInwOJ4HUyOAg/6xxbnNInLFMJBpT4yWeyXtbB9YXBAfynZ5OZ2/2HKz0KXQku4M4UdTduOHCU57wSInqyujck5ohzlMDm8r6NEaB51+EzvIg0zFgTFh2nWpxnRRYDUXR3pMaBhvtaeg9WWySc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VsvjaQaJ; arc=pass smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VsvjaQaJ"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-368977e33b1so948110a91.1
        for <xenomai@lists.linux.dev>; Tue, 12 May 2026 02:16:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778577402; cv=none;
        d=google.com; s=arc-20240605;
        b=g9y/w9nDuxwCg0/kMcyC0zsghM3GlyacJJSp2RT7m/7AFIFsuFeaFDPQyatFpm3MWE
         G1P7FM2HqzgzCa38omLmyg4KNDYqsgW6rZc1xydRbgqD3C5+jVWC7uFyX5cVbW6ueLH+
         +zxwso823sD1cNSdQLBiyZh58QL9gCqYu6wsG9XkjlwRbQ7x/QZlHarV1kJBSWtZBxCP
         SKGbRHRfCuuQ571cHzPp9AtipnxQOTedcH4DwjafWHVS+m/OLF1Cvj1DQ1ht2TAyr969
         1z0F16KM1M9iHx+qQurkj+MY9hCBg/YDEUJKGdYwruv5oIwlyVGblFnNS/+CErFJMJV+
         zK1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TnWfOsxONotd/TuGfVzunppOoCFNozToSPtLYpAxwlo=;
        fh=Gbokv2cqjXipI/isbuuM2AkWdnz5ZRsDr4BAyqPfOQ0=;
        b=dUrXuycQR+nBmuR6T5CtyX5lQGExwu1RqVZGLVFjW3CxGQagY7sRQOc/pquQIldmlL
         ZRkguhdq94zRlkTPDZ43Y0IG1dIQtkFsomcr43QQEqQ3QpKu2PXd83Y+sKm8hxgGxF8X
         /GD5ifsEvoOutEZBfLQVM7ddIoQK50twm9VxW/rs48us4VNiGU0cBteMeMoGRUYsySOG
         jirPMTwuI49Yo5VvrYAivbfn+cwy3mCNGZrs1UlT+HDUCQDYow0SB3b7Pcxvn5EyCyFr
         UQw2muL3j0wzihibMtsL0p+6Y0myxdwe42V8IXFsbSPYosGFJ5ZzS9BiVAgnYVFpH01R
         /VGg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778577402; x=1779182202; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TnWfOsxONotd/TuGfVzunppOoCFNozToSPtLYpAxwlo=;
        b=VsvjaQaJhkgzmerMvLARRyJvbKA9+bBe3FBVb7LvCaalZRZRaX18tybHmw9kVrvEmK
         gLEnHtTjzmIuq6lqgG05ogVbeLe0po67mQXBtqKLyLL0KGoO7tXuGAfaPJph0g8Vlldc
         E9DEev2mBnBlgxGDWaH1qHYf085w0hoQJyYNRLCjhrrlpRhORQiGyE4vok1mt0v0bKRR
         9RHx51+Pt447PRnb3mzZDcRrBobaG5ePVTtHQZoB67GM4CMh9B4Eaxs6/Q+fU0K9nTEP
         mhJEcDYrZIBBEyGQO3VEIgJy+lnqv8Timirk13mST7rxud/1rXiP0MqNzPF/YkD6JElY
         CCQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778577402; x=1779182202;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TnWfOsxONotd/TuGfVzunppOoCFNozToSPtLYpAxwlo=;
        b=jYapuSw93ycUmHCN6StUzfqN744Tahfmh3NZomQN/VBKcAKYr14OPC12LLsJkxu0Ci
         30dUwu55qJyB0EUx4g0Y11izLIlSK4atSdaBSE2kibbgxkWbrg0RcR0kCT5dN2NRV/RO
         uVJ6Sr3H9VfdsxAqE9Jcvtv7eahn5Dz+rm8iQGyZPBWEkeXTma5FaNRVbAWom8vXUXF8
         V4srNrsDsLFaGgbYaiJewU7oiyy9C1kjqXlzxVR5BVF4jIGKkeN0lIqieGHQqrOC2Tx2
         P1w4AQKcRLcTCfztDFbJ+9/VWcB0VTgMXYqpyUgUw7+v2RAndMF5oPlZ/bBS/JLbwnnb
         /ofw==
X-Gm-Message-State: AOJu0YwmtNmc0vFB2/WoCMw7aixb0rJNgy1U1B10E9yzwGMc1IPuqYNN
	INMeTSj/NfymHstkPFwdNQ7EU7x+f5vtjSg+Do/a4pg8Te0ZyeQOEOhT2muQuZMLRfw0jlQhYxK
	yCkSHXzDLGIJVeOkfi2MwCN8S0bzFJmI=
X-Gm-Gg: Acq92OH3xsSgV5CyqbnJgKS3v0XiRG4YDgNYEGhwZyow8mnTcZ5qTfq5fgH82FILNY3
	6xVaz0JZ8iBGtAdlxs8NCyz+7lmCIcJKwx90ffqe3I697hhOl+KrSC7gwnksIfy3U7FX1a8mO35
	CwDI9OYwoqF7riK1xj+yDBlu6mDix+In0nxGVfp6cQJzc0GbVEjvxwbhD01QDTs1X/UlQttFtdC
	DjXfRrn+RYRoGOrCRXwgtPSu/aJY9ppkYWpc2XsFgb6dyCCbhwCP32quNh00j6v0pUl9jRDV3Jf
	8O/i1A==
X-Received: by 2002:a17:90b:4ac6:b0:368:6998:b4a9 with SMTP id
 98e67ed59e1d1-368b24d485amr2563888a91.11.1778577402358; Tue, 12 May 2026
 02:16:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAFLxGvw_cRpJbBKg2YG9_oi5Bv_DU39OB41nPyJcq7hv7hK6YQ@mail.gmail.com>
 <411e79a0-cabf-4d86-bed0-12e0b9546c1f@siemens.com> <CAFLxGvyUZWXEYdvKynRhJEkJGnEKomCmKYvZg3+Z7DJUM+SUPQ@mail.gmail.com>
 <94e64297-32e5-4818-867b-a8fa27d0c630@siemens.com>
In-Reply-To: <94e64297-32e5-4818-867b-a8fa27d0c630@siemens.com>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Tue, 12 May 2026 11:16:29 +0200
X-Gm-Features: AVHnY4Jx2mfSte_YS2xViGEiiclDuW05OP5Dq2AfmkiNU1IWrqmqPgQ1BXbDumo
Message-ID: <CAFLxGvxA5q++HKe9AREfP6qmiNObWTch8E2Gh_ZiUaUyUENVVQ@mail.gmail.com>
Subject: Re: Spurious task resume due to SIGSHADOW
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 12, 2026 at 10:50=E2=80=AFAM Jan Kiszka <jan.kiszka@siemens.com=
> wrote:
>
> On 12.05.26 09:19, Richard Weinberger wrote:
> > On Tue, May 12, 2026 at 7:50=E2=80=AFAM Jan Kiszka <jan.kiszka@siemens.=
com> wrote:
> >>
> >> On 11.05.26 23:49, Richard Weinberger wrote:
> >>> I'm currently debugging an issue on a very old Xenomai system, while
> >>> reading the source I noticed that the very same issue could also exis=
t
> >>> on recent Xenomai releases.
> >>>
> >>> What I see is the following:
> >>> - A task gets suspended and unblocked using rt_task_suspend() and
> >>> rt_task_unblock()
> >>
> >> This is intentionally rt_task_unblock instead of rt_task_resume?
> >
> > From what I can tell, yes.
> >
> >> Because:
> >>
> >> "A nesting count is maintained so that rt_task_suspend() and
> >> rt_task_resume() must be used in pairs."
> >
> > The application has non-trivial thread management, from what I can
> > tell, it's fine.
> >
>
> Unlikely, because it will completely confuse tcb->suspends, preventing
> future suspends for the task that was not properly resumed.

Well, the application does rt_task_suspend(), followed by rt_task_unblock()=
.
But unblock does not resume a task. That's why the application later
uses rt_task_resume().
So, it should be paired.
Please keep in mind, this is unrelated to the SIGSHADOW race.

--=20
Thanks,
//richard
