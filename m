Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5FE6AD4
	for <xenomai@lists.linux.dev>; Fri, 22 Jul 2022 19:30:17 +0000 (UTC)
Received: from spool.mail.gandi.net (spool4.mail.gandi.net [217.70.178.213])
	by relay.mail.gandi.net (Postfix) with ESMTPS id EDB2160005
	for <xenomai@lists.linux.dev>; Fri, 22 Jul 2022 19:30:15 +0000 (UTC)
X-Envelope-To: rpm@xenomai.org
X-Envelope-To: xenomai@xenomai.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 0874378001C;
	Fri, 22 Jul 2022 19:30:15 +0000 (UTC)
Received: by mail-wr1-f53.google.com with SMTP id m17so7503860wrw.7;
        Fri, 22 Jul 2022 12:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cqnM4t2RfUPX8CyyMgp8/+m+ifpF3arYU9BypXxb+U0=;
        b=YnfrhV2b2GNv4KcUlGX/JJLHlcLa2tUxbOvxQ0f7rpcFRguaDvxg6C4a85M9xuIQND
         dL6d6l6wWz9414nYO9zsKLdybZJDFqm3AukyymKePC0SYORLBlRBf6qZdalwdtmojGiE
         rfYNFr6a5oALlnvA55K3D6r+6pNZ8GnLPAyTpBrdhkjDTMcXprEcxtpYV9evBzzg1Ds9
         vNSTlYwSRwWooudY6pLlKp7rODXwIKNvdXKrZ71uYV5xbJLAAvcHJ4ZCY8AjMOwPWVU8
         7XcIHDX40z2yV/NE/ay4uVIhWWaYO+VfIFR4SnI1EGuHdE5ehRMuxaHBMz+gJzK96I9j
         gyqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cqnM4t2RfUPX8CyyMgp8/+m+ifpF3arYU9BypXxb+U0=;
        b=5sGA9J1fsDFmQ2miA0lx6e2xbylou7LSTZ8HMHnG9WQGPEG/axwSKwxAisJfWMmHj6
         D1LLK4pMVGDtxBWCjCS+QEW3PwgZR3x8+amhyg9+5a54Kn4Y6eXbKdeFLMkWG7s5BCyL
         LFzSnbQ5LnGeGgbJdXpgFSip7wqLca9dK7aLcmYr9ePQ40R6nmPjKdCKsxytbvcRlp/e
         HiT3uT8OeR0enaofDw0/ITfhYpiDWrj/6w8iAn98I1yZqPcMolL5afmsTqF+2kvBLL81
         5McBFjO1du1yWjffROeBRvzVpdiKrb+0TIKV9UeppPJntO0XjXzAwjpJ6brS21r00+YQ
         w5og==
X-Gm-Message-State: AJIora9Ud7YSwNmYHCqjFgw727aKa9v5Nr7RUEbNdBsx1ArGscCcr3o1
	+FfifDtYGl2bNQcfcMeH/ZJEhkAc5bPEREsZaApNaxCe
X-Google-Smtp-Source: AGRyM1uo1vwCkIuZEnoD46988xkvcq4usZvzyKzO0Kb/KBZo2sEQrD7bRMDzbYA7SNXxcfsFiZyLL2E2Me9sMi6w14I=
X-Received: by 2002:a05:6000:188b:b0:21d:b277:d492 with SMTP id
 a11-20020a056000188b00b0021db277d492mr918380wri.311.1658518214335; Fri, 22
 Jul 2022 12:30:14 -0700 (PDT)
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
 <87tu7bk76a.fsf@xenomai.org> <CAAm9oxpbtX2qXHPxOGCQre14_7T7jZtDuN=b5U2sA2B_su6ARQ@mail.gmail.com>
 <87a692ewlf.fsf@xenomai.org> <8735euee6p.fsf@xenomai.org> <87czdxyt1x.fsf@xenomai.org>
In-Reply-To: <87czdxyt1x.fsf@xenomai.org>
From: Sri Subramanian <sridhar.subramanian@gmail.com>
Date: Fri, 22 Jul 2022 12:30:03 -0700
Message-ID: <CAAm9oxrYfzdbKi0yAcN2e98P_Oz6ippi_2-7bC9z=6fa1P6bAQ@mail.gmail.com>
Subject: Re: Xenomai 4 / oob_sendmsg crashes kernel from tidbits/oob-net-icmp
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass (spool4: domain of gmail.com designates 209.85.221.53 as permitted sender) client-ip=209.85.221.53; envelope-from=sridhar.subramanian@gmail.com; helo=mail-wr1-f53.google.com;
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=gmail.com header.s=20210112 header.b=YnfrhV2b;
	spf=pass (spool.mail.gandi.net: domain of sridharsubramanian@gmail.com designates 209.85.221.53 as permitted sender) smtp.mailfrom=sridharsubramanian@gmail.com;
	dmarc=pass (policy=none) header.from=gmail.com

On Fri, Jul 22, 2022 at 10:07 AM Philippe Gerum <rpm@xenomai.org> wrote:
>
> > Confirmed, I can observe the exact same behavior with any board pinging
> > the pi4 here. 10 packets with proper ICMP reply, then the responder goes
> > south.
>
> This issue should be gone with the latest (5) commits from this branch:
> https://source.denx.de/Xenomai/xenomai4/linux-evl/-/commits/v5.19-evl-rebase/
>
> I'll backport them to 5.15 and 5.10 as well.
>

Thanks for your promptness and dedication! I've tested it and the fix works!

Sri
