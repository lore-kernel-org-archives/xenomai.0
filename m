Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7090F18E1F
	for <xenomai@lists.linux.dev>; Wed, 19 Nov 2025 02:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763518460; cv=none; b=sr1SRi0wPa2AMoJ++MRucNSUGH9PwHFBUmwBylHZ3VPJN17ulFIPquh6g5CEwIkZQL3Y0X2351dIrfPJXGjuLc4n42ZI1vE4b+9lgRiKI6sjIH1n0FwXG0ddh9ZLBf16nFXH92tIGbtl+bVNgaNxmYNV+UITGVS9KRDLEm0I3wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763518460; c=relaxed/simple;
	bh=9wCmcM638suFTwOp2EmBzan+83RFif6/LVcAyMS0EZQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=ppBQoV7Tn2c8rnlFEOzdPNEL6eATQGH5uCzDT7xyKf4gq8L97zQ8kRGvetbvL6p/PjisOeH9+E5dmnjLOnfUd9E2Ft1qrVWuPuYmlxjumOMuO0Wnx/27hEffF8aAvcsaD1uKU6q5D/iHZ1q2N9AQ8LapuGVuegV8GZgOXHyHcBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L9XXRQK9; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L9XXRQK9"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6417313bddaso9892752a12.3
        for <xenomai@lists.linux.dev>; Tue, 18 Nov 2025 18:14:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763518456; x=1764123256; darn=lists.linux.dev;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pzhu0+63K7NZ/iBpf9cn4N/gZpzBO5/Klbf5zi0UE6E=;
        b=L9XXRQK9AtBJKGT7TI+IqMfPKLhJm3EXoj0qAHHbEo2VDqqM3sNJS8IsLw7PHotfHP
         aXILKHr/6iMsmhHvoqdXLrLyw2OA7Kcl1bufLLwWglLFk8dClg2X4YoRgcqh0WBnZVkL
         uAm5MN7SUOHgaLgBgipbdA+Akj7gLfULVxjE8RkYzKMvN4X/tv/OQ5Xz4+20TwFyY27V
         J5Cp3JE1VMXa+vxuR0EAwSiMvJSIDVYiIUtc6icQKZ5C91wZ410kTJY9R1X0Q65m6BFw
         2AfL9hSkUm3mcF+2t5mVE8pHNBHh5KlDHElu48bOKGbSL05adj2MSLVig6oSdBN+LYeX
         U3nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763518456; x=1764123256;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Pzhu0+63K7NZ/iBpf9cn4N/gZpzBO5/Klbf5zi0UE6E=;
        b=TIBxrsc9o+C6IFCCf+eYV58wlLWBhZBvNjldg707EnYJtPpr5D7h7hN+nMZi7vQG5R
         QkEii/Icv8ilrspmuco5ufV8N0so0tujtVcRQeTZXNACYVn6NUk4MU3pRihUyoBOrAO5
         IzAPC8NIZ91KzIg9NCJGMiMs6hpcNAb39dOrRzK6x0EEZmCImQHEpfJXviBmgokzbPK3
         yqQ0LvuMQ50SloceeHUABR5YnhOoHrtpQe4SWrZQCqKqx5ckajR9s13E+HP9LRMlmBqY
         BmCf6hnaJE66ZiWUMzLfgirHHToh8SxirZDyWS1NnXA3unE1z93m2o9D2yRuAGgS442q
         LYjA==
X-Gm-Message-State: AOJu0YztKJ7MbAAOZMCTeeoAXXDtiYNwEHyAuLiSePzjqBFiHna3ZIbu
	PcJRpM/rK6HuCw2mLkLlSRG2GTeENDxz6WMA3GUtHaqftp+ybFof0LyyTq1QO2trk9G3CWZLTD3
	k4/765kFvVMQg8osfsDqmULkz1jSBvVgmPiM8
X-Gm-Gg: ASbGnct51+IedEVweM5bYyYAEz3ug9CH2pdR3g33pLlynsrcKUSIo4Ct8pKvkrQUZTJ
	ec1Pec8URuM0DSSrjX2rIqxChKkpwiIdhOqHq8nPtKBQc4eCtucpzst+PeZtTV8R//BdnCO0i1B
	xpeNklRzFlbCaAY43BhGz2Uag2KspcTJ1E7NM+QDXHv88pF90cZeBc8m+K+u1aN958+37lQB9F7
	eo9frbbnNV/71Lw7noaeTb0XwQBgYlaixKzPP1lQ6BNfLlydm6iTmRNg5WSGF1yjFDSH2dtuA==
X-Google-Smtp-Source: AGHT+IEhnvhZg1Q7R8JAE1eDR33CBdoccXjdRchtzX/qvyVCG4q4mZ9ShbZ0+/5UKNdbVLBVGFPdBmiZOVAmdsYurnA=
X-Received: by 2002:a05:6402:270e:b0:63b:feb1:3288 with SMTP id
 4fb4d7f45d1cf-64350e9e82bmr17278417a12.25.1763518456361; Tue, 18 Nov 2025
 18:14:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CA+K1mPEs3K7ymrnTMa2vmM4NWrdL-n-G41zxEYTJYBxq4F233w@mail.gmail.com>
In-Reply-To: <CA+K1mPEs3K7ymrnTMa2vmM4NWrdL-n-G41zxEYTJYBxq4F233w@mail.gmail.com>
From: C Smith <csmithquestions@gmail.com>
Date: Tue, 18 Nov 2025 18:14:04 -0800
X-Gm-Features: AWmQ_bl80vhJMJfBvaxk_ZSNz4akUWS7eTNBmDb9-UMlChlWoKomogn2iJupUas
Message-ID: <CA+K1mPHMdS+vh-5SJBYQy79D8fK-MK+Z7Yv_CdmYBf3d1oL+gQ@mail.gmail.com>
Subject: Re: multicast fails with rt_igb driver
To: Xenomai <xenomai@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 17, 2025 at 5:31=E2=80=AFPM C Smith <csmithquestions@gmail.com>=
 wrote:
>
> I am having a problem using multicast with rtnet, specifically the
> rt_igb driver.
>
> xeno-config info:
> Cobalt Core Version:  3.1.2
> Kernel Version: 4.19.229 x86_64
> I-pipe release: #21 detected
>
> My NIC is an Intel I210AT using rt_igb. The rt_igb driver works well in
> general, it can receive Unicast UDP packets sent into the real-time port =
OK.
>
> When trying to set up a real-time UDP socket capable of receiving Multica=
st
> data, things fail. Here is how I am configuring:
>
>    modprobe rtnet rtipv4
>    echo "0000:03:00.0" > /sys/bus/pci/devices/0000\:03\:00.0/driver/unbin=
d
>    echo "0000:03:00.0" > /sys/bus/pci/drivers/rt_igb/bind
>    modprobe rtudp rtpacket rtcap rtcfg rtmac tdma
>    rtifconfig rteth0 up 192.168.0.240 netmask 255.255.255.0 promisc
>    ifconfig rteth0 up
>    rtifconfig:
>    rteth0    Medium: Ethernet  Hardware address: 6C:B3:11:52:A8:5A
>           IP address: 192.168.0.240  Broadcast address: 192.168.0.255
>     ...
>
> My code:
>   struct ifreq ifr;
>   struct sockaddr_in addr;
>   struct ip_mreq mreq;
>
>    ret =3D socket(AF_INET, SOCK_DGRAM, 0);
>    if (ret =3D=3D -1)
>       return -1;
>    else
>       udp_multicast_socket =3D ret;
>
>    strcpy(ifr.ifr_name, "rteth0");
>    ret =3D ioctl(udp_multicast_socket, SIOCGIFINDEX, &ifr);
>    if (ret < 0) {
>       write_log("IOCTL SIOCGIFINDEX returned: %s", strerror(errno));
>       return -1;  //Failure
>    }
>
>    memset(&addr, 0, sizeof(addr));
>    addr.sin_family =3D AF_INET;
>    addr.sin_port =3D htons(port);
>    addr.sin_addr.s_addr =3D INADDR_ANY;
>
>    ret =3D bind(udp_multicast_socket, (struct
> sockaddr*)&addr, sizeof(struct sockaddr));
>    if(ret < 0) {
>     return ERROR;  // Failure
>    }
>
>    // Join the multicast group
>    mreq.imr_multiaddr.s_addr =3D inet_addr("239.249.5.5");
>    mreq.imr_interface.s_addr =3D INADDR_ANY;
>    ret =3D setsockopt(udp_multicast_socket, IPPROTO_IP,
> IP_ADD_MEMBERSHIP, &mreq, sizeof(struct ip_mreq));
>    if (ret =3D=3D -1 {
>       return ERROR;  // Failure
>    }
> ```
>
> Its the setsockopt() above which returns -1, with errno equal to ENODEV.
>
> Am I doing something wrong in this code? I do see multicast mentioned
> in the rt_igb sources - is it known to work?
>
> thanks,
> C Smith

I put some printk()s into the rt_igb driver code and I have figured
out what two of my problems are. Firstly, I neglected to say I am
accessing the rt_igb driver from a RT Xeno application compiled -m32.
I confirmed that the addressing of the setsockopt() does not have "32
bit compat" code.
When I hacked the addressing in net/stack/ipv4/ip_sock.c, int
rt_ip_ioctl(struct rtdm_fd *fd, int request, void __user *arg), I
actually got the i setsockopt() to execute OK.

This code should support 32 bit compat mode:
int rt_ip_ioctl(struct rtdm_fd *fd, int request, void __user *arg)

So that the following 32-bit call succeeds:
ret =3D setsockopt(sys_p->udp_multicast_socket, IPPROTO_IP,
IP_ADD_MEMBERSHIP, &mreq, sizeof(struct ip_mreq));

No, I don't have final compat code from which to make a patch at this
point. But that is contingent upon the second problem:
When registering for the multicast group via setsockopt(), I get
errno: "Protocol not available".

So the rt_igb driver apparently does not support the reception of
multicast traffic at all. Is there a plan or a known patch to do so?

-C Smith
