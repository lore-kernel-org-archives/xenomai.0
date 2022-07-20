Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 780697465
	for <xenomai@lists.linux.dev>; Wed, 20 Jul 2022 19:48:50 +0000 (UTC)
Received: from spool.mail.gandi.net (spool5.mail.gandi.net [217.70.178.214])
	by relay.mail.gandi.net (Postfix) with ESMTPS id 3AEBA1C0002
	for <xenomai@lists.linux.dev>; Wed, 20 Jul 2022 19:48:48 +0000 (UTC)
X-Envelope-To: rpm@xenomai.org
X-Envelope-To: xenomai@xenomai.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 2EFEED8023C;
	Wed, 20 Jul 2022 19:48:47 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id c22so3335938wmr.2;
        Wed, 20 Jul 2022 12:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MsODB4bUEEpNJrXz2Bcshu8PxJmIJEzVXEIIQA3rtTE=;
        b=ln/lmiRzItbI3K6h1CTdPduhXLSfabrZM4biG4iXQj0gupL8kTstCkNWaJjakcdLq2
         cu+gURQY5y3otPXmMQlmfizIVDpZtBRzf/5vPH1JZbMNIJvK5pQU5APBcmmEbmspO1n4
         a/nalYP1jfqyMzn65BrPRtQzaQic/E7pHyVcYjxeMBD7qYQjvGj6yiUQP6jpuTPClhL1
         NLOKYGn02lN7SRa9lws2o17Ufruazfb+mTo7VNqHd1IiQccE2sXXlehVd4zE/VFFUNCw
         h5EJURljXp4CHijpAkxzb9a1i5e+KS4UrLW4rm/5A60I9q54B7tf/lELBALBWvR8i7jy
         ip0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MsODB4bUEEpNJrXz2Bcshu8PxJmIJEzVXEIIQA3rtTE=;
        b=dlO6Kugrd1+P91lL0EuHb0moIaeBEo/nXxBEFJ3peSlOqzvl7Kvpk45qWwiMmBFLnE
         pD7wXIiFiPV3KqaSvQGuQNlQU/sOjEUVl6VSOlDIkT//1MwWIkCu/Tn2pFFCm2ec/f8U
         9UA1VZ8rc2BaAWcUZIhZu45C5+SUU2DXkcT1l9G/DoBfa28gxvMiHCJ+yV1XpUeMvYtW
         Tqhe/fV9DkB+a+t21wlRY/AP9HKDlpSLhjneaejTLPaqwN2L7VQkptnJSGnMVgKXjACq
         Mnb15+3Do5oNG/7z+JEFlZ/VeOOOMt671hFjfBAXx5APhg+dqnYgFfcpWzICg0IN4du4
         NcEA==
X-Gm-Message-State: AJIora/Ia6I1N2dBMwFEwRYjbS8NakD7nO9gr3eqf3rI0pVIjjwxk9US
	lW51Lno2LT6254QMQoOGzy5QdZiAX95Y2J4Xt7ARzg2Q
X-Google-Smtp-Source: AGRyM1swI0YD0bknAsEnoWPtHVViBn+7qhiii0cGdMGR3JlqlgTLOyTf/68KvppvishkOX9HbYzSlHDhr8x0f5dlfeg=
X-Received: by 2002:a05:600c:1991:b0:3a1:9fc4:b67d with SMTP id
 t17-20020a05600c199100b003a19fc4b67dmr5374387wmq.49.1658346526688; Wed, 20
 Jul 2022 12:48:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAAm9oxrn5pTSPH_AqrZ_0QakrL1LDsAW2GfA=ckejhnYFPOrFA@mail.gmail.com>
 <87fsj3d827.fsf@xenomai.org> <CAAm9oxq0qzdxx+KnbROMCHgNvp-xEZ99O90omY4zOxXtxsEpsA@mail.gmail.com>
 <CAAm9oxqa0Rp3x3QS_oteS7PX35n4W8TYZu1=7y6U_QC5G-3S=w@mail.gmail.com>
 <87edygmas6.fsf@xenomai.org> <CAAm9oxqx-P9O7cONgeGwud0BvsSWok7itGzqSZdc7NRCmFLdyg@mail.gmail.com>
 <87tu7bk76a.fsf@xenomai.org>
In-Reply-To: <87tu7bk76a.fsf@xenomai.org>
From: Sri Subramanian <sridhar.subramanian@gmail.com>
Date: Wed, 20 Jul 2022 12:48:35 -0700
Message-ID: <CAAm9oxpy2VF6KXJLE8wK_xTCt4ffK9+WpqMo2OmqP=nMxDmaYw@mail.gmail.com>
Subject: Re: Xenomai 4 / oob_sendmsg crashes kernel from tidbits/oob-net-icmp
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass (spool5: domain of gmail.com designates 209.85.128.49 as permitted sender) client-ip=209.85.128.49; envelope-from=sridhar.subramanian@gmail.com; helo=mail-wm1-f49.google.com;
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=gmail.com header.s=20210112 header.b="ln/lmiRz";
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (spool.mail.gandi.net: domain of sridharsubramanian@gmail.com designates 209.85.128.49 as permitted sender) smtp.mailfrom=sridharsubramanian@gmail.com

On Wed, Jul 20, 2022 at 10:47 AM Philippe Gerum <rpm@xenomai.org> wrote:
>
>
> Sri Subramanian <sridhar.subramanian@gmail.com> writes:
>
> > I just re-ran the test and yes, tshark (on the pinging device) sees
> > exactly 10 request+reply packets, and then, only request packets.
> >
>
> Ok, so for some reason, the sender is fine but the ICMP reply on the
> receive side does not make it to the wire, although the ministack there
> says it's all fine.
>
> > Configuration: R-PI4 (pinger) -> CM4+IO (oob-net-icmp) on
> > same switch, version 5.17+patch on both.
> >
>
> To be sure, is your 5.17 tree up to date EVL-wise, with all the patches
> available so far for 5.15.y and 5.19?
>

I updated to the top of the 5.19.evl-rebase branch and built rc7 off it and
I got the same results.
