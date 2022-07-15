Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 798A26648
	for <xenomai@lists.linux.dev>; Fri, 15 Jul 2022 01:07:55 +0000 (UTC)
Received: from relay11.mail.gandi.net (unknown [IPv6:2001:4b98:dc4:8::231])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id 9A9CAC4159
	for <xenomai@lists.linux.dev>; Fri, 15 Jul 2022 00:59:23 +0000 (UTC)
Received: from spool.mail.gandi.net (spool1.mail.gandi.net [217.70.178.210])
	by relay.mail.gandi.net (Postfix) with ESMTPS id 64FB6100002
	for <xenomai@lists.linux.dev>; Fri, 15 Jul 2022 00:59:15 +0000 (UTC)
X-Envelope-To: rpm@xenomai.org
X-Envelope-To: xenomai@xenomai.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 5910E940104;
	Fri, 15 Jul 2022 00:59:14 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id y22-20020a7bcd96000000b003a2e2725e89so2169051wmj.0;
        Thu, 14 Jul 2022 17:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bjEfuMFK6+q3w1IXsYzX8lBKlEIKJBIczvmbO/uKCpI=;
        b=UUrIV+OgTucsJPaowtSMMbEBy8mh5p8kxOI++4yFsXw0yGnqNfoZbDUmgWxdHj0jaw
         YzVsSyby6olFovClbEW6B3kH+ur1hd2yPlT2Ol8mSHWF755J7k4bNwRAUUeCS3TLF+vg
         ubwrBkAJNiDUw13wXqp8/Wr7sHMPPrgmWiO/rRYG8gYsXXHJftT0iYHP4nP9D8tB5tW6
         IydxqPK0kyYNcgPGrItLyyNrHLOfqV8tZRE+zW5RL/xnTLym4xOaficlgZhXZhcd668y
         9XI75zNyP9VjBC56IjV25BESWxi1ZPgFW4+KMEHFNsB1prpx30VHxHYBkfeXMGDAlotT
         mo/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bjEfuMFK6+q3w1IXsYzX8lBKlEIKJBIczvmbO/uKCpI=;
        b=WHryh62NC6YG0jm70wpb3GyRgckREo9YD82ZY+kovqUwU0/1PGeIYS2cpf1B//GT4+
         JnGPLElVfGaE/6ylnsqWknpvuS88BNfQYUf0MjRpl8Rt9Pfh2KnCtY0p8fxhbWe9asUP
         JNJueFjChnHlfhgmLNptfg/Wwcwmoq62J8UaDRVdc8ZyEahgv1NQ9kyE78dUcIA+/0v3
         ujf+4Sf3kfZHzQT6oqQRYVhRHp9ngMhWwFIayfLSD5x1nGl+ykTqfpNh57uQwXn/LnaS
         XxC5tAdPSy5XyXhQvFl3CHxv4t9xtLGbrWpwh7+CkAHuPPfHKAaD7bLH4bqGntevoY62
         2mLg==
X-Gm-Message-State: AJIora+sGu56JZZCTx+B5a/wHzKJtFJ7Qt0iYfTtJT0aRqJ1MZA4bvK1
	Ltb+zx9KbkRGqDr1Wgg+RblxVOv+cAcF3nc1oSnnVVYt
X-Google-Smtp-Source: AGRyM1t5K8tEbrk9y5LOt0MfzGWhPDBHhN3jT24ZyBl99ahpPjL04j95oFlgHQ+phsus57ZCYzRu1K2JaVP/Q8KG1RU=
X-Received: by 2002:a05:600c:1991:b0:3a1:9fc4:b67d with SMTP id
 t17-20020a05600c199100b003a19fc4b67dmr11562313wmq.49.1657846753561; Thu, 14
 Jul 2022 17:59:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAAm9oxrn5pTSPH_AqrZ_0QakrL1LDsAW2GfA=ckejhnYFPOrFA@mail.gmail.com>
 <87fsj3d827.fsf@xenomai.org>
In-Reply-To: <87fsj3d827.fsf@xenomai.org>
From: Sri Subramanian <sridhar.subramanian@gmail.com>
Date: Thu, 14 Jul 2022 17:59:02 -0700
Message-ID: <CAAm9oxq0qzdxx+KnbROMCHgNvp-xEZ99O90omY4zOxXtxsEpsA@mail.gmail.com>
Subject: Re: Xenomai 4 / oob_sendmsg crashes kernel from tidbits/oob-net-icmp
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass (spool1: domain of gmail.com designates 209.85.128.43 as permitted sender) client-ip=209.85.128.43; envelope-from=sridhar.subramanian@gmail.com; helo=mail-wm1-f43.google.com;
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=gmail.com header.s=20210112 header.b=UUrIV+Og;
	spf=pass (spool.mail.gandi.net: domain of sridharsubramanian@gmail.com designates 209.85.128.43 as permitted sender) smtp.mailfrom=sridharsubramanian@gmail.com;
	dmarc=pass (policy=none) header.from=gmail.com

On Thu, Jul 14, 2022 at 8:32 AM Philippe Gerum <rpm@xenomai.org> wrote:
>
>
> Sri Subramanian <sridhar.subramanian@gmail.com> writes:
>
> > Hello,
> >
> > I am trying to optimize sending ethernet raw packets (for an Ethercat
> > fieldbus application) on a RaspberryPi/CM4 environment.
> >
>
> No NIC driver currently implements the EVL out-of-band protocol fully
> yet, so at the moment, although the EVL network stack does improve the
> timings, there is still some work on the device side to get a full
> real-time path from the application to the wire.
>
> i.e. today we have:
>
> (app) <---> EVL netstack <--/ non-rt /--> (NIC driver via in-band context)
>
> we aim at a full real-time path next:
>
> (app) <---> EVL netstack <-------> (NIC driver via out-of-band context)
>

Understood! Thanks for the explanation. Our current application
occasionally gets hit with ~100us latency on the linux send() call,
so we're hoping this will be an improvement.

>
> > Before implementing the application, I thought I'd try getting an ICMP
> > echo using the "tidbits" sample program oob-net-icmp.
> >
> > I am using eth0 from a RaspberryPI (used to ping) connected to another
> > PI device (CM4 on an IO board) also on eth0, which is echoing back the
> > pings using oob-net-icmp. I set up vlan 42 as documented in the
> > program, for both the devices. (I verify the network connection is
> > good  prior to this by sending pings and verifying the echo responses,
> > through the standard Linux stack on eth0).
> >
> > I also set up the ping-receiving device so the Xenomai kernel can
> > route the packets up the Xenomai mini stack, setting:
> >
> > echo 1> /sys/class/net/eth0.42/oob_port
> > echo 42 > /sys/class/evl/control/net_vlans
> >
> > On the first ping, the kernel crashes with the stack as below. I've
> > tested on both versions 5.15 and 5.17 (both with CONFIG_NET_OOB=y).
> > Thanks for any help or guidance.
> >
> > -Sri Subramanian
> >
<snip>
>
> This patch may help:
> https://source.denx.de/Xenomai/xenomai4/linux-evl/-/commit/2ad6b2207f9f1669f64f6816428a20e1bbd6357c
>
> Feedback on this fix welcome, so that we may assume the issue is closed.
>

The fix doesn't crash the kernel, thanks for the quick response.

oob-net-icmp successfully sends the response and prints stats on the console.
I am puzzled that the sending ping program doesn't ack the echo responses.
oob_port is not enabled for the sending side, so the echo responses should go
up the Linux network stack and 'ping' should see them.

ifconfig stats on eth0.42 also show that the Rx packets were not received.

I've tried this both on NET_OOB -enabled and -disabled kernels with the same
behavior. I'll try using a hardware sniffer next to make sure.

> PS: EVL is maintained for the latest LTS and SLTS releases, and follows
> the mainline development tip closely too. This means v5.10-stable,
> v5.15-stable and v5.19 at the moment. Other releases published may not
> include all available patches: if you want to use them nevertheless, you
> will need to cherry-pick fixes from maintained trees.
>

Will do. Cheers!
Sri

> Thanks,
>
> --
> Philippe.
