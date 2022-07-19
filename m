Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF983203
	for <xenomai@lists.linux.dev>; Tue, 19 Jul 2022 15:30:13 +0000 (UTC)
Received: from spool.mail.gandi.net (spool3.mail.gandi.net [217.70.178.212])
	by relay.mail.gandi.net (Postfix) with ESMTPS id 0D8821C0007
	for <xenomai@lists.linux.dev>; Tue, 19 Jul 2022 15:30:05 +0000 (UTC)
X-Envelope-To: rpm@xenomai.org
X-Envelope-To: xenomai@xenomai.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 15C38AC179C;
	Tue, 19 Jul 2022 15:30:05 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id v5so446474wmj.0;
        Tue, 19 Jul 2022 08:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O9MKFzvv5/ehfIRGuusRu9ftxm2nQDEMnBvaG3aElck=;
        b=ipvZyiH48fov+fegxYZvqxh3lQyYwbAQeLldHrOUx3UoVAEaQ1w1qjK5xbfPjY1ED4
         W8TxrEh6i3YkV2OHqOAjxbLkLF3f1ysTxJGt1a3QjJCIyFSnSxHCiZMbkxHJJEZpbZNP
         /h71YGP7ayXS7UAulGiv8Z1w9ohHLQsQ5V4Bq/ir6DP4CEeckt6YVSskJ5wjEwZQ93G2
         c86VMqU7BXDBwEoZUEqOpsjjInuK8Y50ej+WI9oX4NZpaBkVhpOliYpUECuOXmB25MVU
         EW9Jd/7UDSeSKCKxEHL5MEej9XdUjSVhzKWt0wvZMeRpJQp/arrfWCMkQFZ7qZ1vwRNY
         oAlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O9MKFzvv5/ehfIRGuusRu9ftxm2nQDEMnBvaG3aElck=;
        b=jslai38GpKRxM3Tc0zJeeczzqHqVxmLPVU6ZnFMLlCXGJ0Mk/KtAS+0tBdlStxr6Ip
         20E59HU3ODdajfq0VCvEb93IYiMmOGnEq/D9eaK5hjoZWM7+mDEl+w2Vz7CfE1+X4hzV
         jXlPBXVqA6nFt3VXPs8dwWSa/nrnVgI25Me5iA+7OlAFPGypqCk0kNTdV+jrlsUZjIbm
         rmTq77HaXuKiHhIVMw3FbCbBNmVrNoQsc8NTfPnF1wqq/ffAFBPHdBDXbOzu+Vz3UC6w
         UHbOgWGXYAClMSafB460B+WhgFR+dxZcLwHuzd4y0C1MTAEeBgipoblSWt+owqJCH9cn
         jujw==
X-Gm-Message-State: AJIora8yOaohKG7/t2QkJNkFwI/7I4WERZAEUGa4E8i/gFDl7vQUHu5o
	NIbFZuevBqjMv0KSa0Dg4ouVuYtfVKa7hVdc45IyyUOo
X-Google-Smtp-Source: AGRyM1sMU/gkNsJzATIJZVOZdZYBviXPsx08Jo6K5aeAZabBWTiCPwJ5nOr4uQiXQufNAbvJ3cESAZzdDvCHUB+y2nQ=
X-Received: by 2002:a05:600c:1991:b0:3a3:274f:21b0 with SMTP id
 t17-20020a05600c199100b003a3274f21b0mr1153850wmq.72.1658244604308; Tue, 19
 Jul 2022 08:30:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAAm9oxrn5pTSPH_AqrZ_0QakrL1LDsAW2GfA=ckejhnYFPOrFA@mail.gmail.com>
 <87fsj3d827.fsf@xenomai.org> <CAAm9oxq0qzdxx+KnbROMCHgNvp-xEZ99O90omY4zOxXtxsEpsA@mail.gmail.com>
In-Reply-To: <CAAm9oxq0qzdxx+KnbROMCHgNvp-xEZ99O90omY4zOxXtxsEpsA@mail.gmail.com>
From: Sri Subramanian <sridhar.subramanian@gmail.com>
Date: Tue, 19 Jul 2022 08:29:53 -0700
Message-ID: <CAAm9oxqa0Rp3x3QS_oteS7PX35n4W8TYZu1=7y6U_QC5G-3S=w@mail.gmail.com>
Subject: Re: Xenomai 4 / oob_sendmsg crashes kernel from tidbits/oob-net-icmp
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass (spool3: domain of gmail.com designates 209.85.128.48 as permitted sender) client-ip=209.85.128.48; envelope-from=sridhar.subramanian@gmail.com; helo=mail-wm1-f48.google.com;
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=gmail.com header.s=20210112 header.b=ipvZyiH4;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (spool.mail.gandi.net: domain of sridharsubramanian@gmail.com designates 209.85.128.48 as permitted sender) smtp.mailfrom=sridharsubramanian@gmail.com

On Thu, Jul 14, 2022 at 5:59 PM Sri Subramanian
<sridhar.subramanian@gmail.com> wrote:
>
> On Thu, Jul 14, 2022 at 8:32 AM Philippe Gerum <rpm@xenomai.org> wrote:
> >
<snip>
> >
> > This patch may help:
> > https://source.denx.de/Xenomai/xenomai4/linux-evl/-/commit/2ad6b2207f9f1669f64f6816428a20e1bbd6357c
> >
> > Feedback on this fix welcome, so that we may assume the issue is closed.
> >
>

Hello Philippe,

As noted below, the fix doesn't crash the kernel.

However, I observe this strange behavior with oob_sendmsg:

1. With oob-net-icmp, sending back ICMP echo responses, the pinging device
only receives exactly 10 responses, then stops. oob-net-icmp continues to
print on the console that it is sending responses.

2. If I just use oob_sendmsg to send a packet every second to the network and
then run tshark on the receiving device, I see the same behavior -- 10 packets
received and then nothing while the client continues to indicate it
has successfully
sent the packets.

3. Once you get into this condition of "non-sent-packets", the only
way to get out
is to turn off eth0.42, reset the values to oob_port and
control_vlans, then turn on
eth0.42. It is, weirdly, as if the oob links are restricted to only
send 10 packets.

Again, the environment is Raspberry PI/CM4 and I've tested with both
5.15 and 5.17.

Thanks for any help!
Sri

> The fix doesn't crash the kernel, thanks for the quick response.
>
> oob-net-icmp successfully sends the response and prints stats on the console.
> I am puzzled that the sending ping program doesn't ack the echo responses.
> oob_port is not enabled for the sending side, so the echo responses should go
> up the Linux network stack and 'ping' should see them.
>
> ifconfig stats on eth0.42 also show that the Rx packets were not received.
>
> I've tried this both on NET_OOB -enabled and -disabled kernels with the same
> behavior. I'll try using a hardware sniffer next to make sure.
>
> > PS: EVL is maintained for the latest LTS and SLTS releases, and follows
> > the mainline development tip closely too. This means v5.10-stable,
> > v5.15-stable and v5.19 at the moment. Other releases published may not
> > include all available patches: if you want to use them nevertheless, you
> > will need to cherry-pick fixes from maintained trees.
> >
>
