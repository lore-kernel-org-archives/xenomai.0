Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD9A1FA5
	for <xenomai@lists.linux.dev>; Thu, 21 Jul 2022 00:38:37 +0000 (UTC)
Received: from spool.mail.gandi.net (spool1.mail.gandi.net [217.70.178.210])
	by relay.mail.gandi.net (Postfix) with ESMTPS id 11D1C1C0002
	for <xenomai@lists.linux.dev>; Thu, 21 Jul 2022 00:38:34 +0000 (UTC)
X-Envelope-To: rpm@xenomai.org
X-Envelope-To: xenomai@xenomai.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	by spool.mail.gandi.net (Postfix) with ESMTPS id EB1839401A1;
	Thu, 21 Jul 2022 00:38:33 +0000 (UTC)
Received: by mail-wr1-f46.google.com with SMTP id u5so92976wrm.4;
        Wed, 20 Jul 2022 17:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VV3XFnms/QB2W655OfXtWeJ3QJwMZNA4QqN2QXtV/uI=;
        b=fd0ad5sltSVEjMcEeNewKyKIvFpnxMYpI85FpCYbDiPb9/UG7S+skr1KYva/79zznC
         hPB3qBTWmUpncvh4Cmq/c/+LGPX+8hpby7yjI6CdQ0sFc4bZSclyYUd4a1H/lCyDXlnm
         l6/3GJlC5Vi+V7NJt0+/7ObpQQowgdEbXh8VKWuGtp37yXLAfAdFtlHlCK2E75NEwLKF
         jRDGlIVWdGpsYC882tWDhHM6tLJ7MzEnDZM1nvphgbBLATPRRgPNB3dS14K6EUgLue5G
         wYHgySNSfKJfRYWIrFt8lDNs7R8wmyX8r/L40D7gbRTph2JnRcPmOh0qdtko8hkzSPxJ
         vWlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VV3XFnms/QB2W655OfXtWeJ3QJwMZNA4QqN2QXtV/uI=;
        b=iW6FdiBKYduBC7OTvNuuKkXFMT0H2vog3BbxdBPgMtNjxEWVC6kQKgBYqd3hxgs+ZA
         L49kDAYo7UPaQ2eYaWSt1SmUHCwlaACxaSNamIYJvtgXnkpbnGAFunfkRLfCuu6pnp6m
         fQspKiexnkDfdE8hk1ddyxj0IrTJmgNNq3My07NNz5YjB2+N0xe66+hmg90i5dXznfoA
         oc6BC7MiPpnzCxaDMC9iGFwczNr+6rUIK02qB5BLAA3y2BwZPtEDLjbepL2bsv9LuIDk
         LSOrKGcHI26FFq2syoRl1ty6SjGBBCuEt/rd8bmfAE0/VBchxfEP9p8tLrVloSpvCJJq
         wdLw==
X-Gm-Message-State: AJIora85g6D3dudX2Ja5+lST6qwbTAvg6M+K4wplR6zNHPjUn9gJpvs7
	UInPAJytmBIq+dwaP53KfVGa3nZ52AzVcjAs+6nMOz7+
X-Google-Smtp-Source: AGRyM1vbByQP1+W26iU/iaTDPTTuBwHjEs5BTuAAXzU9wDU61c6MhR9Jup/wUzk3hGPqJ+paKOZ4gmPuD+LDc7n0Z4w=
X-Received: by 2002:a05:6000:188b:b0:21d:b277:d492 with SMTP id
 a11-20020a056000188b00b0021db277d492mr33935987wri.311.1658363913321; Wed, 20
 Jul 2022 17:38:33 -0700 (PDT)
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
Date: Wed, 20 Jul 2022 17:38:22 -0700
Message-ID: <CAAm9oxpbtX2qXHPxOGCQre14_7T7jZtDuN=b5U2sA2B_su6ARQ@mail.gmail.com>
Subject: Re: Xenomai 4 / oob_sendmsg crashes kernel from tidbits/oob-net-icmp
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass (spool1: domain of gmail.com designates 209.85.221.46 as permitted sender) client-ip=209.85.221.46; envelope-from=sridhar.subramanian@gmail.com; helo=mail-wr1-f46.google.com;
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=gmail.com header.s=20210112 header.b=fd0ad5sl;
	spf=pass (spool.mail.gandi.net: domain of sridharsubramanian@gmail.com designates 209.85.221.46 as permitted sender) smtp.mailfrom=sridharsubramanian@gmail.com;
	dmarc=pass (policy=none) header.from=gmail.com

On Wed, Jul 20, 2022 at 10:47 AM Philippe Gerum <rpm@xenomai.org> wrote:
>
>
> Ok. On my end, I'll connect a pi4 with the i.MX6, to add the GENET MAC
> module to the picture.
>

It looks like the GENET MAC driver (or the interface) is the culprit.
For some reason, it
restricts the packets sent to 10 after every netif down/up toggle.

I attached a network adapter card to the PCIe interface and connected
that to the switch.

Both the oob-net-icmp and my packet generator are able to call oob_sendmsg
continuously!

One anomaly I found in my experimentation:

- When I try the USB-ethernet adapter, the packets are not seen by the
EVL mini-stack and
despite the fact that /sys/class/net/eth1.42/oob_port is set to 1 and
control/net_vlans is 42,
the packets are read/responded to by the Linux kernel and oob-net-icmp
is just waiting.

Previously I've used the USB-ethernet adapter for all tcp/ip
communication to the device
and it works just fine.

> >
> > On Wed, Jul 20, 2022 at 1:46 AM Philippe Gerum <rpm@xenomai.org> wrote:
> >>
> >>
> >> Sri Subramanian <sridhar.subramanian@gmail.com> writes:
> >>
> >> > On Thu, Jul 14, 2022 at 5:59 PM Sri Subramanian
> >> > <sridhar.subramanian@gmail.com> wrote:
> >> >>
> >> >> On Thu, Jul 14, 2022 at 8:32 AM Philippe Gerum <rpm@xenomai.org> wrote:
> >> >> >
> >> > <snip>
> >> >> >
> >> >> > This patch may help:
> >> >> > https://source.denx.de/Xenomai/xenomai4/linux-evl/-/commit/2ad6b2207f9f1669f64f6816428a20e1bbd6357c
> >> >> >
> >> >> > Feedback on this fix welcome, so that we may assume the issue is closed.
> >> >> >
> >> >>
> >> >
> >> > Hello Philippe,
> >> >
> >> > As noted below, the fix doesn't crash the kernel.
> >> >
> >> > However, I observe this strange behavior with oob_sendmsg:
> >> >
> >> > 1. With oob-net-icmp, sending back ICMP echo responses, the pinging device
> >> > only receives exactly 10 responses, then stops. oob-net-icmp continues to
> >> > print on the console that it is sending responses.
> >> >
> >> > 2. If I just use oob_sendmsg to send a packet every second to the network and
> >> > then run tshark on the receiving device, I see the same behavior -- 10 packets
> >> > received and then nothing while the client continues to indicate it
> >> > has successfully
> >> > sent the packets.
> >> >
> >> > 3. Once you get into this condition of "non-sent-packets", the only
> >> > way to get out
> >> > is to turn off eth0.42, reset the values to oob_port and
> >> > control_vlans, then turn on
> >> > eth0.42. It is, weirdly, as if the oob links are restricted to only
> >> > send 10 packets.
> >> >
> >> > Again, the environment is Raspberry PI/CM4 and I've tested with both
> >> > 5.15 and 5.17.
> >> >
> >>
> >> I cannot reproduce such behavior (x86 <-> i.MX6q on the same switch),
> >> the overnight test was still ok both sides after 14hrs. Does tshark see
> >> the packets going out when observing from the sending device?
> >>
> >> --
> >> Philippe.
>
>
> --
> Philippe.
