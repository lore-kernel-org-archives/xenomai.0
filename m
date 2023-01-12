Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F4F290F
	for <xenomai@lists.linux.dev>; Thu, 12 Jan 2023 11:45:21 +0000 (UTC)
Received: by mail-lf1-f45.google.com with SMTP id v25so27987274lfe.12
        for <xenomai@lists.linux.dev>; Thu, 12 Jan 2023 03:45:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oSIkjDc2t1msCpE4EmA2Fz2iKOiAS3xEwyIpZSZvi+E=;
        b=SVqXriAxvy+KRZtnz3533gQQBbUhOZiUNBFVYeDDw1e2PlQq1FVjRHxma3qk8YJmrj
         YzklDErRcfGjns7nYoWlyxigkd7vIuWTQjDp/ggqq8t2L67t8rJVKDgKc5AXqpXWa1iI
         buf7eMBEFobY10ci3whY4tje91HBwPj4ivlcPt4G9oemMmwLpcVe/woXZAeAnVYy+5f0
         UdBcLWYy+fUCzO27GEXR/BV1VEBA7PIUJH1IkRnbdKFcwrDq2Zo375ufqzDXoZBHBWAK
         76qA7xXnlJnGvav7ZdRR1zzLGfnWSrYQccn/5dTjG4Osq/plYwho7Hxco4LDbgU9Q+Bj
         jIEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oSIkjDc2t1msCpE4EmA2Fz2iKOiAS3xEwyIpZSZvi+E=;
        b=dbTSPQS9KVfjJOoPu3YWx+ibPv6d+I1LIF6HhYLtwo70I92KzffO8CihXDbKqNJac3
         sXksqhmq6+gh/IGuEM/edKFb/vbkKLp/2IYBjZwynA6CsQUGsc4aMYRQbvGpNrU1Zowe
         liW0a6qu5Xqf+4kbBwt63jN+3xVepKPkTSN3Pea9rvBtmTjdb5VEaE8pjGHvuoGt8eSA
         FeVxHssyAYlxx3/nlYWDC4z2MlHP0vdw3f7ZBFMYOFWxkT/n7mqvQMe6047pgs2yt6Jt
         xkqhE4o2nrEotVPaA2UXnCaW0MctSHAnQ2B+wFAtlsL3cooz33uiBk7+1VnLfJt8R8k5
         VakQ==
X-Gm-Message-State: AFqh2kr7eX0KAjl7+l2eylNB/9UXYSRLEYYYB7UsUK7PAxd+ascoUobu
	fCpNoLEw7QnDpWbIH4IrDnwk4mlmGsi6dEjIDe8=
X-Google-Smtp-Source: AMrXdXvCiuaIdM9kfuw7vPGcUP43VFHBsWTxVWyUYqph66ZGlNH38CWgTkKVjzjflGOM53/9QOuoZ9LeAPBFImJ6x4A=
X-Received: by 2002:a05:6512:398d:b0:4cc:93e6:5ebb with SMTP id
 j13-20020a056512398d00b004cc93e65ebbmr533149lfu.585.1673523919715; Thu, 12
 Jan 2023 03:45:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <MN2PR11MB4285900B48A09E859AD39964F2FC9@MN2PR11MB4285.namprd11.prod.outlook.com>
In-Reply-To: <MN2PR11MB4285900B48A09E859AD39964F2FC9@MN2PR11MB4285.namprd11.prod.outlook.com>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Thu, 12 Jan 2023 12:45:07 +0100
Message-ID: <CAFLxGvz3eC7HZpAFnjRzFARV9+PxLm3iBiS8agGdvqitP=0YBg@mail.gmail.com>
Subject: Re: Xenomai Community Call Minutes - Jan 11, 2023
To: "Chen, Hongzhan" <hongzhan.chen@intel.com>
Cc: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 11, 2023 at 12:47 PM Chen, Hongzhan <hongzhan.chen@intel.com> w=
rote:
>
> Attendees: Jan Kiszka, Rick Wang, Florian Bezdeka, Richard Weinberger,  H=
ao Li,  Qiang Zhang, Hongzhan Chen
>
> *Community update:
>               Fixed ipipe issues while updating the CI toolchain (Debian =
11 -> 12)
>               Fixed exception bypassing issue
>               Bring up RSIC-V support on Xenomai:
>                             Please contact Jan to get RISC-V board if any=
one want to join bringing-up RISC-V
>
> Open discussion:
>               Enable dpdk on Xenomai =E2=80=93 porting dpdk l2fwd as firs=
t step.

Thanks a lot for the meeting notes!
Maybe it is worth noting that there will be no call in two weeks due
to Chinese New Year.

--=20
Thanks,
//richard
