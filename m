Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C761B21B9
	for <xenomai@lists.linux.dev>; Fri,  3 Jan 2025 19:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735931517; cv=none; b=Ehqs7rCxXiA0a5iRxHBgnIl8DzKlvVvLr7T07/9hNXE6AgexMy+ty9uatr5WpPgp3A0V16MIgIvK9YAm96QiPHsNhBQldYiU+8Shcknk8vOZG/b6uL4zXHXOAC8PCKDZY+YRWY7fsT6vH6TtgQbfOHZVY2wA8z6LftI1tuJskO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735931517; c=relaxed/simple;
	bh=gy1Nr9kbEtZyP+XB+Z44KOgGn6vQ93EWI+LgQZUIGe0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MFGzxea1O6V5dArpQsgu3viw9HXTIGW5aEu9cU7AF+lhmXHHyoxnEyxxO87roXKWYBbR0qhx1uLFpUg3bpn4cPOiNhwW8obDF1NflzBPks3cVCMtL+E/99uCrRDW+F69OwnXtX3XqDO/eF7tTn08N3szsee3fxI6o452i9y3J3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=jan.kiszka@web.de header.b=YihR83oz; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=jan.kiszka@web.de header.b="YihR83oz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1735931507; x=1736536307; i=jan.kiszka@web.de;
	bh=gy1Nr9kbEtZyP+XB+Z44KOgGn6vQ93EWI+LgQZUIGe0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=YihR83ozI13rBsXLUpT/NDrHBf3PucWy+o9aFMgzOxzTyvguIsYk+DXG2edN4BvZ
	 ue8p+dVdIqPJUpcbHlp1Q5600q4g71EOdQz4MEOflkv6ag+4zsTvmVpsENt1Ck58b
	 WHHmdgdiHFeuRxNh38ke2PF859KS2onDoMgB95nQRaJsR5b5bisOw3QMIX6ecUmQn
	 +Sz762g484LmPuC05DQK3Ud/fuzN4Lk6IB6c9sXVgFaKXZAHL+gGdjfOTYmYVNXh4
	 bsmyenQ++CZEYLQKAAJPfGfYw1cyadTOxosCe4dgfY0ODfIu/YTvF9WxjQ6bqi7a6
	 ddsHZh9pLtiiMsNlfQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.10.10] ([46.128.82.72]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MVrg7-1t4nXa1gyz-00RuLJ; Fri, 03
 Jan 2025 20:11:47 +0100
Message-ID: <268ca8e1-d96a-4454-b8ad-21b5c615326e@web.de>
Date: Fri, 3 Jan 2025 20:11:46 +0100
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: IPIPE Kernel & Xenomai matching version
To: =?UTF-8?B?7J6E7KSA7IiYKEp1bmVzb28gSW0pIOyImOyEnSDrkZDsgrDroZzrs7Tti7E=?=
 =?UTF-8?B?7Iqk?= <junesoo.im@doosan.com>,
 "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Cc: =?UTF-8?B?67CV6rK97ZuIKEt5dW5naG9vbiBQYXJrKSDtjIDsnqUg65GQ7IKw66Gc67O0?=
 =?UTF-8?B?7Yux7Iqk?= <kyunghoon2.park@doosan.com>,
 =?UTF-8?B?7J207ZiV7ISdKEh5dW5nc2VvayBMZWUpIOyImOyEnSDrkZDsgrDroZzrs7Tti7E=?=
 =?UTF-8?B?7Iqk?= <hyungseok3.lee@doosan.com>
References: <SL2P216MB2274C60D2E87BA84D06C3E7EE0142@SL2P216MB2274.KORP216.PROD.OUTLOOK.COM>
From: Jan Kiszka <jan.kiszka@web.de>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@web.de; keydata=
 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
In-Reply-To: <SL2P216MB2274C60D2E87BA84D06C3E7EE0142@SL2P216MB2274.KORP216.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:TDPJv9jx0wtknKZBcIfxpbVf31N0/pWD5mR1LM7w7OL17+R7RIx
 5fsBxbBA4w0YArU243j+d4loxlsVqXCuxiYwAy5IhG9jDaeTn5PPOQsPy8oYUL/8GhGv8fS
 cjHXZfTKCN/ftjctmUhtfFKiFxj+Ie67HookddSn40gfaORcZqZnCpq7xLIqLOGX+1CzXTS
 Ik6DRPaEBv/yL1mn3qQYQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:U+DtXp+aDME=;CSwIZHsrfLQL7uxp3LsTweRDW+p
 o0z2r+U+W3aFKeJypryRobf4f8ShrtYhUNjpypJmcshFs5+aqWQg/dJ8lZ8lYe7l1IwjgCG0L
 lcSyNIl4pca/YO0u9xyG7YbiTlwwYPxoJzCJCqs/hPA5G/c+qRNeX+zrqMZAyqwH1P3l2iSLf
 Q55a7DDAcEkbS2djVDMUd3mXbFpAG+xz872YlVLY+O4sxzhYhxJcvmnFVZ8AHFPGNR41/BNdv
 qFUZ1d4ZdXkuRdEUH6ZzyBkreXqQoez1YYaju/fLZ9bx9jWbbMzVlG6QjH9avB6CWw6Sx5dAE
 SE8RA6uCZPZucoq/uzIFFMjBW3aBSgQwzVf0WERTm49GewdNvndcgee3AeU/P7MVeII53tmWV
 WmDv5isbtXd7vnS/WpNwzsgmy8mcaUK5ISwPpQRNzTQkQdCR3HBw85n41+ooX9/0/bMXvSaFL
 F3twz+gV/yFTU1XNKJIWozKiN4tfiHTwcRwoh5WjEaF3ZwXwNDhq9d9Grg+QTvcO7PYYuXucO
 jLlXdHGlpjeINkTylbyraqa5LI97Pcz2tjOKq6/98UaTOb5Cw/TgeLjfnVdgyRtIS+hvLbmt6
 IbnlM29V6bClht3IRBqeaDDexny1IrraQtEltKm7QKrsMRStzhbtzkt9LCNXuLniqtA48Pcd7
 VpMAaItUfnSHdna3fCiOjesN3HWuoQb2rQzXiJVELq2YZxFBNFpTaiLL+pk62y1QWXGn2vGzZ
 4p8cKb83fMo0LNpuBmfgYZ0dstIBZox+AZqc5gjt45QJOngQORWZH0xHEe1IrN3YBe8c1U0vB
 xUG+Fi5bhxvfmkXVoLH18GL34WkjKlJpncZ65G+RxG4S4BO+nOs+WPnjKYEE16n9srh+0xDLu
 yL9XfroyzQxbj/ZrEw3yVWTwHuguBCp/+kOeBdQYMXmCVxTgO/UrCd3Q19o/QRz6FV6tWvVgj
 g48dHhtAH2wG77W8Au49jzftpZaAMxlFQAOxCm1/yZus8eLpHpgnlpjgAOxohnOjN8A9I76a1
 Oyem2aBwXqpi0bnGs8UkMfVhiOHLOVBQDosVAsqqh28e0tSyiXLuWcoCwFkorNCd0YqGm1kFa
 yEEH4v8iE=

On 02.01.25 03:52, =EC=9E=84=EC=A4=80=EC=88=98(Junesoo Im) =EC=88=98=EC=84=
=9D =EB=91=90=EC=82=B0=EB=A1=9C=EB=B3=B4=ED=8B=B1=EC=8A=A4 wrote:
> Hello, this is Junesoo,Im from Doosan Robotics.
>
> Thank you for your kind answers to many questions so far.
>
>
> Doosan Robotics highly trusts Xenomai's overall functionalities and hope=
s to continue using it.
>
> Doosan Robotics is considering IPIPE first, and second, we are consideri=
ng Dovetail.
>
>
> Therefore, we would like to receive recommendations for "the stable matc=
hing versions" of the Kernel and Xenomai library for both IPIPE and Doveta=
il.
>

We always test the latest versions combinations. If we keep the kernel
or Xenomai fixed on some older stable release, you are even more on your
own and risk to miss a possibly relevant bug fix.

>
> For your reference, Doosan Robotics is currently using IPIPE kernel 5.4.=
255 and Xenomai 3.1.4.
>

I-pipe is still supported by Xenomai 3.2.x. We only removed its support
with the 3.3 release.

I-pipe kernels are not frequently updated anymore, though. Furthermore,
5.4 and 4.19-cip are only maintained for x86 at this stage. Finally,
upstream 5.4 will be end-of-life by the end of this year, only the
4.19-cip base will live longer (4 more years).

>
> Happy new year and stay healthy.

Thanks, same to you!

Jan

