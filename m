Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E5B3845B0
	for <xenomai@lists.linux.dev>; Mon,  7 Sep 2026 06:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788763315; cv=pass; b=oo46m/OX6SGSMtVcCozykmdY6l3LBPvuzRnZyeaLo703gLwzzoe7CsYLwXIPV14GCaYBaENELKsI7iVdLLNXmnEbPb4VhBc/oCNhJZs+cl2jhJrR5ccxSoZucQ1BFiCozja59ra0toM96JeNozr7rek8cvSMeGOJI+VMf2DOuXo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788763315; c=relaxed/simple;
	bh=VFVqjFWK9XgSbZzk3PRTj8ziH5ZyweVXu2dt9ED01nE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XUPRW6Sb8vX6Vd+sU+K9tL9nQAYW+Rmh3ZC68peJtHNUFxE7S8DpPgSrJvypWT29seK05/CW+1UT4ATFRW10moz2pPJ5L2ZPz1iswIV0tlnFTqXQ86T1yyy4AdfLq5RYhrEed6MN7fg9hH0zItk88ffKnePEcZSFTmPlKVUyYVU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lmi3d.com; spf=pass smtp.mailfrom=lmitechnologies.com; dkim=pass (1024-bit key) header.d=lmi3d.com header.i=@lmi3d.com header.b=oDB8wrpP; arc=pass smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lmi3d.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lmitechnologies.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lmi3d.com header.i=@lmi3d.com header.b="oDB8wrpP"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-69fab5a852cso4227006a12.0
        for <xenomai@lists.linux.dev>; Sun, 06 Sep 2026 23:41:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788763311; cv=none;
        d=google.com; s=arc-20260327;
        b=mKioupAAS/gd81905XRgkB68jGKTgbhtYhXH2ji3Wwem8OkwEnHAatSwJKbGmVUpa9
         TUnOkw3vfrKO1IKPL63lPhCAxKd23PmYn+2wUMvuSE5Q6aT2SjQ4ZW+wQAbXcx+obnXq
         cuOh2fcnHYgtPNB5v/o0rTxXooKwqPapglpUxLQYU3IFD034rciXrD0IgVbdgSRMOgop
         ayDzLoimSC5fxgNbZMKl6Fsr/pj7OhdhVfEQBmy6O0teXAhjJV5hc5lElO332rcfgqOp
         UbDVdipopPmcm9bbCnzmtJuTYEy6a6irB4x9ZgynJoeUU2v0+nuKVgiRWgJOAZXHAe6U
         xbsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dDsjeBVmRAbPzHzcR7whnWfE3EZgW4Mojm3KWzV/eCE=;
        fh=UeUlDJDXfjZZWypRHnejXdyeHR8qekCZuYLGMfDwefI=;
        b=G/+z/a0sAZWy7sAW6IR+hgr31HMCVo6w78Qf6V3JtOgGx8s0Lft0kYMnXe8/qxJQpe
         h++8zga9WyqS/cnKC+MZrNR4L55OzaXI0omxFfX/XdfxcaBU0396Kbqi0TMK/93HMhI9
         kAfszNaQHRQ3TcEmurpsz/KK1HBaY+Xl95594G60RIYxyhhFz9uc0D75WcIwS30U2Fhs
         51K+HpT7IEWHt+ae2lV4oDxvdmmaEv5UnqL4pr9Cx5cKb5zW3DJMHwew6wx1tEh5nbw4
         0sg5tFGZMdT7Vjkg1rB0hF3sBXEE9gP1AEOjrU6uUIQ0xoQ7T1BAhM0QHf/xR0olDRaf
         pk0w==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lmi3d.com; s=google; t=1788763311; x=1789368111; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dDsjeBVmRAbPzHzcR7whnWfE3EZgW4Mojm3KWzV/eCE=;
        b=oDB8wrpPzaUETx60bTUAKxfjHQafUBrASpCFgmHNWDH1jTGIkMGosFfbDvT5baaqcF
         wCL6LC+Bff1T4uY/bkES7DIEBILHBtlJ5FQxWfqeUmAXoKHuxlZ3cOA7me5r3tW0XUmk
         K0hpqw1i939oWkvUXVN3CxOM/AFNZ+dQNdKQc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788763311; x=1789368111;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dDsjeBVmRAbPzHzcR7whnWfE3EZgW4Mojm3KWzV/eCE=;
        b=mTB9/et15bKYGT+hixKx1R//gCG8viJobIiPFjapT7UQewr0efHd19zLT5yjWT1GuQ
         QVCnrmnF0CuDpStomIkveckoTLOHNXOWmmpPKnqpHgfikWtjHPUJ7dwwDZ5qbNfiU5uU
         ddUcBz9a86kOYaKmSpTp4iOHEWyFNFSqL/SYoLNs5NQH/Slp+zIgdVaJHl5RbWGgFsiT
         DXCnOmrKjLDlsl2lVwiZai7noDUKg6bx5ENK1NsHJeLOTemNCb+Yzn8uY5lggHrYhqsP
         pNzWQXeerhLJwh8fNdZTaQ/Yzp6ClCxVvK0j2c1QgU8e+EFK7MtELjr2s+ZW0KUBjjg4
         Jkgw==
X-Gm-Message-State: AFuF++lNma6b7yr0pPzzvUt4r6+3Lt6bzdZTv7g0jjoWEhPqE4SAmrvQ
	CvOlyc5t9ZRhrr7FRZMZXLFx1bYuwwZSOAq3DgsYy1vyulF1Po8Gr0F7JohQlcKnddQ8Rkgbvtg
	a8RHZZXVRgJx6Eoue2pFFlfMuUEXvbLa82gcrSFPSo+QeoJSlycgftLewR08wAMnJ/utWkqTQri
	ABs0a0+Bn3sLpLRcmTN7DrLTShnbkcbBg25p6+Ouh3hHt/azFNwQFosWN6J7xeDQ4Whbpa/+MaA
	e62LwgISE08qb8hJ8EoGBiWfIjFiRdLrstBPSAVkisBCF8LaA==
X-Gm-Gg: AYBFou0FMlxOj+7m9bMFrylEk+58SfOJPK5g+NhgwFPgFQ1lPMwe01+VdG4mJ71NBoN
	QYr5GVjzFuerm/+6nYL3ewvhEmEKSeGnCDMmTLgq4Nz0LN5gu5b3tXVYvEWSFvjrqbMznhlxP+o
	8F3dXRF90XYxzvguii9MlZSmbnxzLBEcISL/hjcFJT91jsZiMETA5FCLQV1mHkKYGPmD4QNwYDl
	Qa+YAQt7DRm+nKdye/CrRfu9XfCNHUiAPxwDl0mTVP7SCQ3TWoNmCy0Emmd5g5MA/B+kaCED8ey
	StaJJCPWVgt/PrpoMz1O/1h0XJkgm/117BH6vipUHza0SdaMdA5LFxkBAuhA9CaFCl2a5pwqn+z
	jbSGfl91OLm9CUdR74qTJGS0l7rYu8u44HXcsjchDZLB0TxxmmGTKoB5Q/aT4RkM6REzR4X6HzQ
	==
X-Received: by 2002:a05:6402:454d:b0:6a7:ee56:6155 with SMTP id
 4fb4d7f45d1cf-6a7ee566271mr4973900a12.23.1788763310290; Sun, 06 Sep 2026
 23:41:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAKndYJGoGdwKkFV8Kd2O+VkAJuqeqxsmL6OLSxhyca5k5R++ZA@mail.gmail.com>
 <23b48beb746e3c998d704e2e2a1b4f5a5ffea3ca.camel@siemens.com>
In-Reply-To: <23b48beb746e3c998d704e2e2a1b4f5a5ffea3ca.camel@siemens.com>
From: Gerte Hoogewerf <ghoogewerf@lmi3d.com>
Date: Mon, 7 Sep 2026 08:46:52 +0200
X-Gm-Features: AcwNN1U5q_c1678_WyDo8Z0oteYDM-uX8XJ2kvEYIgfYtErBZi_SZu-8gp5Qw5w
Message-ID: <CAKndYJF00RPbfD7U8YCAn_vzxDFdtwz5m9O=JVqhH5fdXHxY9w@mail.gmail.com>
Subject: Re: Idle measurement problem on arm_arch_timer (ARM64)
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: xenomai@lists.linux.dev, Andrew MacPherson <andrew@elk.audio>, 
	Philippe Gerum <rpm@xenomai.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Florian,

On Mon, Sep 7, 2026 at 8:23=E2=80=AFAM Florian Bezdeka
<florian.bezdeka@siemens.com> wrote:
> Most likely the same issue that we discussed in [1] a couple of days ago.
> [..]
> https://lore.kernel.org/xenomai/87bjacoy6l.fsf@xenomai.org/T/

I agree. Sorry for opening a new thread. The older thread contains a
carbon copy of the fix my LLM suggested, even without knowing about
the other thread.  :)

Perhaps my report was still useful.  I hope so ;)

I'll keep an eye on the other thread.

Thanks,

--=20


This
email and any attachment(s) it may contain is confidential and is=20
intended
solely for the use of the individual(s) to whom it is addressed.=20
If you are not
the intended recipient of this email, you must not take=20
action based on the
contents, nor distribute, nor expose any part of the=20
content(s) to entities or
person(s) beyond the original distribution list.=20
Please contact the sender and
delete the email if you have received it in=20
error. Thank you.
