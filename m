Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E7E24679C
	for <xenomai@lists.linux.dev>; Tue, 18 Aug 2026 15:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787067974; cv=pass; b=AzXta+YhiZEM7EA4OJ+JPjgf0b7+bl0iRDGyyUOqwi/1IVNy90UkN0ZeHSc0zuWXgpcE8ccZXxU9GDFfkoCC2y7nPL+wHFt+z2DC67WcD4ETt9KOa9nn9/E6d9CBVgvpg1aFfpUzMO3XCyeCT+I/Mx/Nxu+SEZ9gCKWTnwceslU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787067974; c=relaxed/simple;
	bh=ajyLutiJd7glu2JqHKqy/fj0k6jy48qLCi7vidS2dMs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MYkI6PVKUh7SZpFaJFlCrKcRi/Dpw069MPMlQIwa+YI4HCVbgYiHLTF31BjAJcp1lxhu9uZso1ZmimJZULvd5wZAzirgLcmqoVQJK5z1Q4P5Ml0GtOV38Uvu1V+mqvH+JthAGHX22pknPuiGWlHZrQqZjlfLz8C0DDYRLOLnkUE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lmi3d.com; spf=pass smtp.mailfrom=lmitechnologies.com; dkim=pass (1024-bit key) header.d=lmi3d.com header.i=@lmi3d.com header.b=UFec3Bya; arc=pass smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lmi3d.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lmitechnologies.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lmi3d.com header.i=@lmi3d.com header.b="UFec3Bya"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6a17cb94b26so8021321a12.3
        for <xenomai@lists.linux.dev>; Tue, 18 Aug 2026 08:46:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787067970; cv=none;
        d=google.com; s=arc-20260327;
        b=fpf4TfxPGaOmuE5etu5SkwvbCfJjfcf+jAx+1DGEXyLFcpdnN+xkWT7ao8IUguFwk2
         0cF69Sh3HU4TL5XL2GHE8OG4BzYizRcOntQgCiBbiLHjahuUR5nidD0xTzth8rh60+sy
         tQBo78G78yktCHd9Amk8xsB/8kOntyv75F9lFClpxKBc52bfxTfsLCJNxUt5ux8C9Mp9
         VlJVijV+GS+bPsFsuqh7m6rTy62u0k1Y/C9k+WKvx6ma2g59rD2YmMhS4WrKQHjE0xPD
         +tgrea5eR85P5BYPSvJbVKg0fBOdZHvDuAVVYnPZAwPBNBcrNAWs+bdtDYHcrTFn++7R
         vwfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=60ob/MsNuOxwc5TiWKBt2dn2KKUschd6DYGQNE4bd7k=;
        fh=2l+TGLFeE1ahyGX0NFWl+YHufE08RrvpgGAU/fiYC4s=;
        b=Il24hT3+qeFozODAveyz4fYaIoXKsKe76gxSSohXktBHuUfui/DmPedQ4ryDf1vGwb
         +/WYMy+YaKZR1OMXyilA08k/WJ9rrNsnRxlu2DS2QmnNbIA+LFc0DWd4YE2FyhHa5gev
         PIkYyODb1vFajQROettmSZ5e3AxsCkD4MLwkJc6Alw6DEvvyplqYj3xtMzstrv9CssWw
         TD+xZ34Dr/444G0BEybK4DvpTLs0Ein8QWf/eYbC3rHWFTirHJPzMcrGM0atPhzMhCDT
         n05soSUoDG0cX0KWTn/qUCWgUFh8YYxEAszm/tk/JxCF15mSIlnG4/44a0pg7OX6HT+n
         hnFA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lmi3d.com; s=google; t=1787067970; x=1787672770; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=60ob/MsNuOxwc5TiWKBt2dn2KKUschd6DYGQNE4bd7k=;
        b=UFec3ByaIxnzLIrhd7WPjtaDyFmdpE3n9yhy1a09vVJv7HuRIr8zTxIgCTyCTEXe8H
         4vAyrIsIqvdTxnfbqP7AnGWeToMzzFzXySlVjoBN5kmAOV7lrpjqEq2fmdqLudWbSmwS
         bTSxU5Qy4jXpoBbHnnN51YUJSqLd3a4pgtoOQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787067970; x=1787672770;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=60ob/MsNuOxwc5TiWKBt2dn2KKUschd6DYGQNE4bd7k=;
        b=XBdjv50LdF5Z1QHUtyONrfKYPHwsa985er81zOiXhJWSLvPMIULAR5acMwP+dRQApO
         Mna2CyT7Xl/pP2ALjHzQm3ABChzQkxb7PeQZcb3wtegWQf2LATEN0klTemtY8gKt3S8t
         6pZju7Ywu2CWA45tITLFWge8+zH1t1JOJKonlc7hgORwLVtAWQ2OJLtGy5Obvm4Qhkxd
         gXZ7rr1ICi6BKCf1Wx4lKMkIgL6E3XGNWvSbmgDvNHV2pQuBVaHsB43Za6IvsIIHHhDl
         FyqEJL3sGHnwBidfuowbZJxWn5XMCuOxjgzW2MkIDAFIlX7y2Ntw9Gh9icz8siWhAbSf
         R7dQ==
X-Forwarded-Encrypted: i=1; AHgh+RrL6fjwI58UJ5V0tNj4mIOpJRC9eHI7ypE6s20bp0q7S0jkW4g0bOzB4U8gzKptJWLZ4kAMc4YI@lists.linux.dev
X-Gm-Message-State: AOJu0YzXPJwbhJJ/xVtzayJBS6JaoDvb4s71K3vhm/8pl1OoYkSD/j8V
	hOi7z2BSiRVvuXekta+XtsejdrUY5/Caik8jladKT8X7ecukI7iJB+AQ+8tnpENDypAcd4c6x+9
	AEL2Lc+Bj3+urppiBoufYz1tr+c93QS1icyZyk904t6viC5tjQ8BfRb8PLesZCvK6jKt8zQFAU4
	vK8/GtVf3A3t929cpiT+tkrpV3pfZTJ+rQtvmK89Kr7Wg7rzT7RbtoHOJN/goLWwX5pweTKoLq0
	Eu5gFd2v7jvpSs+aWFaXv4A5ht5FRE=
X-Gm-Gg: AR+sD13OE4lFh/dOdHd/PMwPS/Hp146Z+8qJgrXkToHYOxOR0wiP035PZNVhywhR0mN
	B7cMa9JrUFNF2TRtpXa9v2QyAQKU+V4aMwE52xl4VPrTJFKnIZMp9MIFYM518CupWrGrXtNA5+m
	BBNa65A396vYT1eRLCFasBOSmyIRplKy8aeSmSIi2gz69VlAxtgKCtYqewO7BF6JnISHbiKe5fx
	Eh/jph0AN224qL+/rmh/IyCo5x927we0NY9FXkXCbU7Yc8oyrTlI06MhD9jx7uZxDFm4ONUZ2Id
	YxEwb2M5joBYxwvXQMWD21lBfm5JaNQr3D4Dct9BqsovDXRlIr/VJ5NEgbC8kW8Vyif2ctwcI5B
	Ub3rRcaoG13Sn23Yer1QK0SDQjgGykHQxPhTTIJcytLNynUPgLZGJtU3l4g4z++4=
X-Received: by 2002:a05:6402:913:b0:6a1:44c8:edc4 with SMTP id
 4fb4d7f45d1cf-6a38a95be16mr17505808a12.12.1787067970436; Tue, 18 Aug 2026
 08:46:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAKndYJGo5Yu7Ak694tX=cqRjtJneXs22DPjz=UDVkUcNJMWyOA@mail.gmail.com>
 <87v799kt2q.fsf@xenomai.org> <CAKndYJFhN5MfybdumExs7b5gTqW_CHa_i=cOL7R6xgjad1ytDQ@mail.gmail.com>
 <b7d8d1e3-0353-49dd-b626-5aaae76f7526@siemens.com> <CAKndYJFsiha4BZ1VmyM4-XADyNJ0RusC+TPJAm9k2q99=khLLA@mail.gmail.com>
 <87bjb0lqob.fsf@xenomai.org> <CAKndYJGm0Ne6_fMkrNmQoE92LZmSghyH23CYmht0Ogs-obRH1A@mail.gmail.com>
 <87ecfv31rb.fsf@xenomai.org>
In-Reply-To: <87ecfv31rb.fsf@xenomai.org>
From: Gerte Hoogewerf <ghoogewerf@lmi3d.com>
Date: Tue, 18 Aug 2026 17:50:54 +0200
X-Gm-Features: AcwNN1UfWc-gHJWz7ZzPxDewYO02xEAYpt4uffeXj3b2xmfOjz1icSlBC40z7Cw
Message-ID: <CAKndYJH5PjEnOz9Y1e_uDTHf7Lupt5d2W=hhc11jVpGjN0HcQQ@mail.gmail.com>
Subject: Re: The state of Xenomai 4 on Xilinx Zynq-7000 (or ARM32 in general)
To: Philippe Gerum <rpm@xenomai.org>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Philippe/Jan,

On Tue, Aug 18, 2026 at 5:08=E2=80=AFPM Philippe Gerum <rpm@xenomai.org> wr=
ote:
> Could you try this patch, without the dts fixup, and let us know of the
> outcome?
> [..]
> diff --git a/kernel/time/tick-proxy.c b/kernel/time/tick-proxy.c
> index 5a877987a84e4..6d2b7a860d230 100644
> --- a/kernel/time/tick-proxy.c
> +++ b/kernel/time/tick-proxy.c
> @@ -229,13 +229,16 @@ int tick_setup_proxy(struct clock_proxy_device *dev=
)
> [..]

I tried this on the original baseline where it hung.  After applying
the fix, it worked like a charm.

Very nice.

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
