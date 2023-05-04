Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8107AFBF7
	for <xenomai@lists.linux.dev>; Thu,  4 May 2023 15:00:49 +0000 (UTC)
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-547303fccefso397649eaf.3
        for <xenomai@lists.linux.dev>; Thu, 04 May 2023 08:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=embeddedgreg-com.20221208.gappssmtp.com; s=20221208; t=1683212448; x=1685804448;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UdQkc2kaVDZtN9bT+v7mdyvjHon3xpmnF4WKBogM0XE=;
        b=oiXqRA82EPeM9CdOnkRSDC83LAueoh9LF9ytqncCkLoYxYF6h3Mtgq01wZYzMS9WqD
         GLKKafqkhXWUmWr/mTI5gWzHwy4VYFBPZFtNXqcpK2bWlmHUJkuxG09mHXX6ffIh9shX
         NsYXJzsYDRoDB8NUmVVdznvzDMtrPHJLS+qPf7D4ZFVFUgp7cTTLGhAsb/IOed3x8zqM
         645TUzXneUQO9TFaDoxhyYXhztKClL/dYBz6It8nVR01EDbEDZvbPTS5fYf9oc0SPNu/
         f7QoU3YtPQTqsxUnJrEhWA1QsAEUkyj5zPteSL3RDjxcUyro/HbzF37OSZR3YMPlGxMc
         LnWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683212448; x=1685804448;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UdQkc2kaVDZtN9bT+v7mdyvjHon3xpmnF4WKBogM0XE=;
        b=EH7w/8JKTQx30QHTQooCBKrPGuUJ7/n+MkK7WQHEWJBz4VoM/2BOPYUSY65R7rAnsT
         LhUdMsh8CUSvPTbF0lRAZedcYvNKDZeOLhkikIOo9J1+q08m0ylxnx5fkws7kQbE55jU
         suPI22HIB6HeOLj1imF2B4AYQq6Coi4JUc8/n1nQHTgu3xraaxeSIkeMbjDyeXN+ygFH
         IlEeP/tbDit0LY28sWJpBZ7nP1i21IMVtwn6HvIUXpYmsE4MJFDlCv8SQc/x7+HKsGJU
         QMATQKMDW7x9DvmaB8gJcTwn5VTjHdiihv7/h1qodgTYV2wNNimT53ZPN/fXqh6zTvfp
         HNng==
X-Gm-Message-State: AC+VfDzzyHXt6HcWZA1i/+rU9R/ZdFoeP1cJJbjrry2RxIaSSNTtiBCI
	cbpH/8wTpdm4ikQMKEXsP4RcnY0sBfT+7yySHdJkFcRvb+PYOkiwZv0=
X-Google-Smtp-Source: ACHHUZ46D+6v0RXrhZmDZyHK4vbEjv1N/mZ7Dq9pq1XrW/jAc2s0balKtOtoLj46EL7f9KcW/yIPujOe1wyTNP+mUUQ=
X-Received: by 2002:a4a:be10:0:b0:542:5d35:12a0 with SMTP id
 l16-20020a4abe10000000b005425d3512a0mr10694519oop.3.1683212448473; Thu, 04
 May 2023 08:00:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <5a8afa1e-d6d7-df9f-2895-6832ffa9673f@smile.fr>
 <189dee91-923f-131a-ccae-0afcccd06107@siemens.com> <7dfbe0c0-161f-0977-4332-75575f1a17ce@smile.fr>
 <9a48d273-5ebd-f557-7941-8532b7ec4b67@siemens.com> <5523da9b-bb44-a1be-9e54-bcad21867eb6@smile.fr>
In-Reply-To: <5523da9b-bb44-a1be-9e54-bcad21867eb6@smile.fr>
From: Greg Gallagher <greg@embeddedgreg.com>
Date: Thu, 4 May 2023 11:00:37 -0400
Message-ID: <CALLqZ8TeAeeu++UP499YS_XPwVYw05eMEYf-K7HPmyhXHBoACg@mail.gmail.com>
Subject: Re: Question about a freeze under Xenomai 3.2.1
To: Julien Aube <julien.aube@smile.fr>
Cc: xenomai@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 4, 2023 at 10:27=E2=80=AFAM Julien Aube <julien.aube@smile.fr> =
wrote:
>
> > Is there any own driver involved, or can you reproduce the issue withou=
t
> > it as well?
>
> I could not reproduce the issue since for now I'm booting on an NFS
> filesystem, and the hang happens when the GEM driver does the detection
> of the phy (thus maybe the issue is rather in the phy layer rather than
> the ethernet driver).
>
> The crash might happen elsewere but I have not seen it.
>
> I'll try to create a setup were the rootfs is on the storage, disable
> ethernet driver and see what happens. Thanks for the idea.
>
> > I'm furthermore no longer sure if the Zynq 7030 is officially / fully
> > supported by dovetail. Maybe Philippe can comment on that.
>
> It's a dual cortex-a9 , and it was working in xenomai 2 / kernel 3.9 ,
> so if it's not working I hope the issue is a small one.
>
> In the meantime I'll see what I can do with a jtag probe.
>
> Thanks !
>
> Julien
>
>
I think we saw this issue a while ago.  I can't remember if a proper
patch was submitted.  Let me take a look at my setup here.  I test
ipipe on both zynq7000 and Ultrascale boards.  I had a dovetail
environment to test zynq 7000 since there were some small issues
reported in the past. I should have some time to boot something
similar this weekend and see.

-Greg
