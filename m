Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 180087B
	for <xenomai@lists.linux.dev>; Thu, 30 Jun 2022 10:51:30 +0000 (UTC)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-317710edb9dso175400017b3.0
        for <xenomai@lists.linux.dev>; Thu, 30 Jun 2022 03:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0MLRxTvRjPeFgAaOC5IMUhxF2jehLm/328NgqUIYQXo=;
        b=cmArNJDgGnWBvjkG/vOD7gsAvalII5bYgpe/u4jhUFj4k3qKUbDU2UhP3haYEexkev
         ymiVejLc2WZ0H8jW/8mJ4fDID9dRYkPKO1TExVS8CS83HtISbbjDclVMBk+TbdpN+r+1
         YcXtQ0YcnwS1J7Ha2d7RdJBsbqdTWdnf3AfwOHXx75RptffhqPY1dmATig6nzWDC/Gyi
         AxKQ7TahUBzxWxcSPbc1qEFF/gYq6ZppzSjjOhnPWCthsywcme5Z41dieP3pQjEwIT/+
         9XopQuzQeMW3DU8aPfxSAg8twJn5plvQA54RzbL3v75Wk1ppZQbX+/HdAKLhlLvqLlps
         30cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0MLRxTvRjPeFgAaOC5IMUhxF2jehLm/328NgqUIYQXo=;
        b=Z36wjbbLsTPxRLRgMeVOQyxENBBdrT93mY6gBVjmk9MhsdZ311uou0Fve/4JuHGQIx
         PpPWKuL32UVejPy455jBSY1ZI/rtM4OTL7ufTxV9H/ocPfXguqH2hpHdYwr1FaJHRfkF
         erMk6OdQNa9Lkcbcz5TDfFSeIlPkorVyPPx2+XBDtmO0GrZWp66jlyLkardOiNO0lEag
         dbPxfjPtZwC0cwTA4tT0wyUltvEVklYaK5JlP449Hc9J0WoJ7D6CXfUMepeq5iK7WOZ7
         0I2HLCrWJf9DEx8wzZjOIOSUsGakbJJM5TzTYNaEzM4s/zLAjfIQOOVp5akMuQ+UpIHV
         sxUg==
X-Gm-Message-State: AJIora+ig+fEC4gGoviVxoJ+bA9s25Py2nzVsyL6YMEXVwhLGjv8yl1r
	OVH/a8mCxX2D/ezPmr43WAKG0JYIZeZnghIS5qw=
X-Google-Smtp-Source: AGRyM1uZW2mKoxxzrtMDiSH6W8aDnPW/ZfOZ6CB20pBDm3velGv+qekHG6NYasOI2SYA2Ulw1ZMtqT2q3Nz/RAHR+VE=
X-Received: by 2002:a05:690c:113:b0:2ef:260b:3801 with SMTP id
 bd19-20020a05690c011300b002ef260b3801mr9747656ywb.49.1656586289890; Thu, 30
 Jun 2022 03:51:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <87ilojv6ts.fsf@xenomai.org> <344cd21f1804f3a383f25a5e3bea56be956c5649.camel@siemens.com>
In-Reply-To: <344cd21f1804f3a383f25a5e3bea56be956c5649.camel@siemens.com>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Thu, 30 Jun 2022 12:51:18 +0200
Message-ID: <CAFLxGvxjUwGZzqAR3N-JYZ1tr0XAfjXmzuD+7o1gFaLGeaKGXQ@mail.gmail.com>
Subject: Re: Mailing list archive rehosting
To: "Bezdeka, Florian" <florian.bezdeka@siemens.com>
Cc: "rpm@xenomai.org" <rpm@xenomai.org>, "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>, 
	"jan.kiszka@siemens.com" <jan.kiszka@siemens.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, Jun 30, 2022 at 11:17 AM Bezdeka, Florian
<florian.bezdeka@siemens.com> wrote:
> > [1] https://lore.kernel.org/xenomai/
>
> Thanks for taking care and bringing back the history.

Yeah, thanks for doing so!

> As the migration is now done, is someone already working on getting a
> patchwork integration as well?

Also consider using b4 (and other cool features of lore).

Konstantin gave a nice talk on the topic:
https://lpc.events/event/11/contributions/983/attachments/759/1421/Doing%20more%20with%20lore%20and%20b4.pdf

-- 
Thanks,
//richard
