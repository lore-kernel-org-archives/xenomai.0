Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00DCA1E489
	for <xenomai@lists.linux.dev>; Mon,  8 Apr 2024 19:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712604909; cv=none; b=Vt5y8ItBiZy5MU/HXEb91ERyby/KhZCrjZyEvz2znZDZtegAe3xLOoEgPxCwr7JAaDcYZh//t85sQu1RuuBV0OM/K4u6wz9j3vkRHTOz6YAEpMxXbFBejyyMHM+Obu0LLrZY3HIbqm9Yct4bs2hQx+sSz39R9oE/ux2w6QR5cUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712604909; c=relaxed/simple;
	bh=J4Gtyo2k2Ck48vfF96PDow6ovE72SrhGt7HjBJFxGBI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=poh7aIoG3bWyGKoVkjo3hifcofU9LrsNpsUgBgXJqDY8J7KqshjCL76ls9peS400qW7GmSQNN80iI17M8iVQpCndqGMNiE9HXZ4LEmop0nSZN4Wnt5k0/sd8qidUD3r+6lyN5G6ObGJN9NovH2TyeDloZnjaMBCKX3l8+Tzd9S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zuw7A1KG; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zuw7A1KG"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1e2178b2cf2so43965455ad.0
        for <xenomai@lists.linux.dev>; Mon, 08 Apr 2024 12:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712604907; x=1713209707; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rRKKPbQjyL+rgs9neDacvPwEqdanDZ4yH+QrR13r3F8=;
        b=Zuw7A1KGYcmk7iXOsJ3VaIOBwvdBi1XZo8HgcJcBE1qWEdxdF4OhUxXy5tkLd3Io3q
         sn1fXrcdQtQhqdpp/6zhnx4Hj28HGJgGRGU5bqR6iULBiWWElt0gJMIDg1twkXPbFHAC
         94/YZnRa5ainAS8viKaZHaWGQu5AyFUzYlrEK0BgZIxGlB8Z9pDMrcG61bFyI/dhTAhb
         nbq9n7LWvLW/2srPVoyKtew0UmHNV2Jcet4AjEo6z+JPqfoOkkFcvXUyLQDtS1T0lCEV
         H8HNMpaR99gPuErb3WknUcvaTm6N6l90n7JM5zBAFSinHOcujco+iJpcy6bERoJQdWZW
         x45A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712604907; x=1713209707;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rRKKPbQjyL+rgs9neDacvPwEqdanDZ4yH+QrR13r3F8=;
        b=AphfUMCz5pAedwTWWN9yfErfHsADeVNklX9ABjJKfXqhOHkpzxY72IkHWsIWTHmacs
         Y0A59S1kb4s8N1dvGFFAwWt4tMjU17BHWVB5sjrn7nwbGAWWwq4jZJQz/OtNggBUModx
         /rJI2wND5TLt+vwVeREmv0+LzyMsIxQdBikg3TN06Ahv966mFYaoksLvVx7EytKjw7Xv
         RteEbZeJTZ8h9pDzz7YdFnMTXtC93AxNIqLV128KMOPvy27RA/jXV2I/dmhbDlFfAGfm
         Pmx95rRDTm/1N8K6mqnQOTUvHUQ8cw42UZQZ1uZIVlQ388qPng192x17UAnJ+lemnkpq
         BISw==
X-Forwarded-Encrypted: i=1; AJvYcCVYZaAi/1X+gyQh2r+okY90Hirw7JYdzkgDm/r/dazbP2jP5yYoz9iIx96wL9PGA9byUTMHibK3PLbj/x0nPkXUiQZlLWFSRA==
X-Gm-Message-State: AOJu0YwWb0avSS5r0lptc0YTCzpDNVQ0zvBis9dELr4XLvf5C4AiHWRp
	CrkbrkvSJXFgHU23vk3RDn8MmEuIwIoyYArWKMTMsZ+rH3GvuoWctt8cvRymds0L6zcfQVkM6R2
	mY9SB65wYll7YmXCpgAQ5Try/xhE=
X-Google-Smtp-Source: AGHT+IEwCQwCwqpOjRYJC4FJD7j9OnxXFRYhRXE+PPF0Yter+gXCPMnILGWw5r51q1lXEVpTqRaffLjxAwf/HIpNlOM=
X-Received: by 2002:a17:902:d512:b0:1e3:f248:192d with SMTP id
 b18-20020a170902d51200b001e3f248192dmr6786534plg.18.1712604907232; Mon, 08
 Apr 2024 12:35:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240403214811.8979-1-richard@nod.at> <20240403214811.8979-2-richard@nod.at>
 <3f3e21a2-1f44-4737-b530-ae8b62619c05@siemens.com>
In-Reply-To: <3f3e21a2-1f44-4737-b530-ae8b62619c05@siemens.com>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Mon, 8 Apr 2024 21:34:53 +0200
Message-ID: <CAFLxGvxTuEF5sseZz4_tAwA=YLj95rZzFOM+TyYEvK_K1zxn_A@mail.gmail.com>
Subject: Re: [PATCH 2/2] prepare-kernel.sh: Warn when result can be defective
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Richard Weinberger <richard@nod.at>, xenomai@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 8, 2024 at 6:10=E2=80=AFPM Jan Kiszka <jan.kiszka@siemens.com> =
wrote:
>
> On 03.04.24 23:48, Richard Weinberger wrote:
> > If the target Linux source tree contains stale files which
> > are owned by Xenomai, the result can be defective.
> > Detect such situations and warn the user to avoid crazy errors.
> >
> > It happened to me twice that the resulting --outpatch was faulty
> > because my kernel tree contained old Xenomail related files.
> > Hopefully this saves somebody else valuable debug time.
> >
> > Signed-off-by: Richard Weinberger <richard@nod.at>
> > ---
> >  scripts/prepare-kernel.sh | 11 ++++++++---
> >  1 file changed, 8 insertions(+), 3 deletions(-)
> >
> > diff --git a/scripts/prepare-kernel.sh b/scripts/prepare-kernel.sh
> > index ed168773247f..f9cf9933da88 100755
> > --- a/scripts/prepare-kernel.sh
> > +++ b/scripts/prepare-kernel.sh
> > @@ -107,13 +107,18 @@ patch_link() {
> >              d=3D`dirname $f`
> >              if test "x$output_patch" =3D "x"; then
> >                  mkdir -p $linux_tree/$link_dir/$d
> > -                if test x$forcelink =3D x1 -o \
> > -                ! $xenomai_root/$target_dir/$f -ef $linux_tree/$link_d=
ir/$f;
> > -             then
> > +                if ! test $xenomai_root/$target_dir/$f -ef $linux_tree=
/$link_dir/$f; then
> > +                    if test -e $linux_tree/$link_dir/$f -a "x$forcelin=
k" !=3D "x1"; then
> > +                        echo "$me: warning: $link_dir/$f already prese=
nt in Linux kernel tree, resulting source tree might be inconsistent!" >&2
> > +                        continue
>
> Does this actually ever trigger? Aren't we deleting files from the
> target directory before filling in new ones?

It triggers, e.g.
rw@foxxylove:~/xenomai (prepare_cleanup)> echo zonk >
~/linux/kernel/xenomai/lock.c
rw@foxxylove:~/xenomai (prepare_cleanup)> ./scripts/prepare-kernel.sh
--linux=3D/home/rw/linux --arch=3Darm64
prepare-kernel.sh: warning: kernel/xenomai/lock.c already present in
Linux kernel tree, resulting source tree might be inconsistent!

Only when using the --forcelink flag existing files will be overwritten.

> This one makes sense to me, though.

Yeah, that one bit me hard.

Thanks,
//richard
