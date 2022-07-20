Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B9F1FB9
	for <xenomai@lists.linux.dev>; Wed, 20 Jul 2022 16:35:25 +0000 (UTC)
Received: from spool.mail.gandi.net (spool4.mail.gandi.net [217.70.178.213])
	by relay.mail.gandi.net (Postfix) with ESMTPS id C073B1C0003
	for <xenomai@lists.linux.dev>; Wed, 20 Jul 2022 16:35:17 +0000 (UTC)
X-Envelope-To: rpm@xenomai.org
X-Envelope-To: xenomai@xenomai.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	by spool.mail.gandi.net (Postfix) with ESMTPS id D784B7803EC;
	Wed, 20 Jul 2022 16:35:16 +0000 (UTC)
Received: by mail-wr1-f42.google.com with SMTP id bk26so26894008wrb.11;
        Wed, 20 Jul 2022 09:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AMbO/rWji+1tG+kpnbHzF7GLb/eS+/Ulwpu9W3TULJ0=;
        b=IY1bqKhofbBBig3+M7dvyw416UtnzS3D54P8zuEzR/aFYIhm4vHWIfWM4haCxYQxAR
         knDPrQO3tZOd5uhiXwrx9yrzFTGSDrd2PHoa6Jh3lgOgxu9zANwiOcSDwd+yUC/eFV5D
         eoODY2Yx8MkjvJuehTx0rIUgCBkDPhkJ/xwAp9u2pHF9xNnskq+Y2H0iw0EFzoeKfCw4
         bLknAv61ZfipjPVlFMjFhc07vAYRJrpJhFi1KpKpNOeJz1OOFNUxl3zWlk9At2X033Z4
         sJlDRqNz4rERy+bxShSuwSQfNIDm34WeSNkdi1so0HQtXeqddFBfxdT1TeHNVQzog/es
         zAFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AMbO/rWji+1tG+kpnbHzF7GLb/eS+/Ulwpu9W3TULJ0=;
        b=z3bFt2kidwwpcpbglyvkqNNT+5vAywNSAdtrYHahwrFwn285NNo8nfrByLXQ/EUdG6
         qqcf4XP3d/ZwpOq8vxIijP1bEZrdS64z6MpWxLoomsvmPfiNzLw560x8P5HcVejL4FID
         mZzc22D74UKALC9azHNn9ky26HUCF3maSM3V7YuVYzd/LREOmAHE34yJdNjWGCT7rICq
         hPf+aZQ4KCv6Axa79o+ApeBM2ZkhpbjDzi1kmnYjsoNu1nC/ui5ilNr+cDlqmbvIdhjr
         XUO7K13aZinjPGRl5h9lVLHuwF0SYgxTLGB7MPoWI6FT+7uIZ6a2E81JTFpLlQtEI8VU
         995Q==
X-Gm-Message-State: AJIora+ThFlAC64EtICqv6sg5Ofa8oBe45m0BnVJlJWbdnhPpYXKuu1o
	Ogi7VU2sP/qJFgio5/xbSmdpJ6zADMtmcRPRo7ftTVUm
X-Google-Smtp-Source: AGRyM1sdc47WGqXSfSJ6ylAvFUqoTbFh0xN9iRMejOvJi4flb28n6LAX9P0sUkQ/xvO4miepmC821DFa4OWP0jGaLdA=
X-Received: by 2002:a05:6000:1882:b0:21d:9f46:aadb with SMTP id
 a2-20020a056000188200b0021d9f46aadbmr30382396wri.64.1658334916338; Wed, 20
 Jul 2022 09:35:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAAm9oxrn5pTSPH_AqrZ_0QakrL1LDsAW2GfA=ckejhnYFPOrFA@mail.gmail.com>
 <87fsj3d827.fsf@xenomai.org> <CAAm9oxq0qzdxx+KnbROMCHgNvp-xEZ99O90omY4zOxXtxsEpsA@mail.gmail.com>
 <CAAm9oxqa0Rp3x3QS_oteS7PX35n4W8TYZu1=7y6U_QC5G-3S=w@mail.gmail.com> <87edygmas6.fsf@xenomai.org>
In-Reply-To: <87edygmas6.fsf@xenomai.org>
From: Sri Subramanian <sridhar.subramanian@gmail.com>
Date: Wed, 20 Jul 2022 09:35:05 -0700
Message-ID: <CAAm9oxqx-P9O7cONgeGwud0BvsSWok7itGzqSZdc7NRCmFLdyg@mail.gmail.com>
Subject: Re: Xenomai 4 / oob_sendmsg crashes kernel from tidbits/oob-net-icmp
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass (spool4: domain of gmail.com designates 209.85.221.42 as permitted sender) client-ip=209.85.221.42; envelope-from=sridhar.subramanian@gmail.com; helo=mail-wr1-f42.google.com;
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=gmail.com header.s=20210112 header.b=IY1bqKho;
	spf=pass (spool.mail.gandi.net: domain of sridharsubramanian@gmail.com designates 209.85.221.42 as permitted sender) smtp.mailfrom=sridharsubramanian@gmail.com;
	dmarc=pass (policy=none) header.from=gmail.com

I just re-ran the test and yes, tshark (on the pinging device) sees
exactly 10 request+reply packets, and then, only request packets.

Configuration: R-PI4 (pinger) -> CM4+IO (oob-net-icmp) on
same switch, version 5.17+patch on both.

I'll try to scrounge around for a 32-bit ARM board I can test with
to see if that's the differentiator.

Sri

On Wed, Jul 20, 2022 at 1:46 AM Philippe Gerum <rpm@xenomai.org> wrote:
>
>
> Sri Subramanian <sridhar.subramanian@gmail.com> writes:
>
> > On Thu, Jul 14, 2022 at 5:59 PM Sri Subramanian
> > <sridhar.subramanian@gmail.com> wrote:
> >>
> >> On Thu, Jul 14, 2022 at 8:32 AM Philippe Gerum <rpm@xenomai.org> wrote:
> >> >
> > <snip>
> >> >
> >> > This patch may help:
> >> > https://source.denx.de/Xenomai/xenomai4/linux-evl/-/commit/2ad6b2207f9f1669f64f6816428a20e1bbd6357c
> >> >
> >> > Feedback on this fix welcome, so that we may assume the issue is closed.
> >> >
> >>
> >
> > Hello Philippe,
> >
> > As noted below, the fix doesn't crash the kernel.
> >
> > However, I observe this strange behavior with oob_sendmsg:
> >
> > 1. With oob-net-icmp, sending back ICMP echo responses, the pinging device
> > only receives exactly 10 responses, then stops. oob-net-icmp continues to
> > print on the console that it is sending responses.
> >
> > 2. If I just use oob_sendmsg to send a packet every second to the network and
> > then run tshark on the receiving device, I see the same behavior -- 10 packets
> > received and then nothing while the client continues to indicate it
> > has successfully
> > sent the packets.
> >
> > 3. Once you get into this condition of "non-sent-packets", the only
> > way to get out
> > is to turn off eth0.42, reset the values to oob_port and
> > control_vlans, then turn on
> > eth0.42. It is, weirdly, as if the oob links are restricted to only
> > send 10 packets.
> >
> > Again, the environment is Raspberry PI/CM4 and I've tested with both
> > 5.15 and 5.17.
> >
>
> I cannot reproduce such behavior (x86 <-> i.MX6q on the same switch),
> the overnight test was still ok both sides after 14hrs. Does tshark see
> the packets going out when observing from the sending device?
>
> --
> Philippe.
