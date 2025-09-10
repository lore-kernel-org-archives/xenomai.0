Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C01E1A7AE3
	for <xenomai@lists.linux.dev>; Wed, 10 Sep 2025 13:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757509277; cv=none; b=LQVLDkHak3Op4N+DcSC8ObCOHvdcDV10bNYI/Mb8QAcfjMgvxNYsEjP/yHtCE7QjmMHEtiRclS7m2PmDXuY34eUH9F5XgKNqj8sAR5zXt1fXwzOGIPddsvVMvP7sCASd4muvLHhbR8TZDECAdxaYIkqO2o9hrLtgtG3HyQi2hW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757509277; c=relaxed/simple;
	bh=vDcgCC1xaeaXO7sb/UIDgdh2FtN/e/9uGGxoh+lB0BI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aeSoMDkL2FO5a/aPey/Vxm4wxFOeW2QcdPVSsGmWqNcpHMWUvjUJLeSfQCYJbDY4gd1LdxFZ+OatYBInoKYaNl/3B9vcT4dMmueN+c0Ay8RXfCQB5nDhHKUQLDWqtvKeDUx5M1XfIkl3pT1hINBIHYlVYICzPpY1mDrX+cx6Rzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=ai9xqaXj; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="ai9xqaXj"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7868B43A9E;
	Wed, 10 Sep 2025 13:01:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1757509271;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n1LMJhLuQrOXzDOJ8ARCYKv5xjlsBn9S7F0r43r4/PQ=;
	b=ai9xqaXjXsZFxPpXcYyJSbuenCzMLXiItwcPGyTCZlxP/g4ImgUwaLcRHnzJTtteYN+ZLC
	wr4HHS/jAszPvwiN58A6nMuaWELetZpytk2/Spmd25yN50pDrT1hhQOv5QrhxUxW4Au2Lo
	j/Qm8Hh0qC1eHjjLNMisUcIJP/VL3VKB9qKPKAWj49N3iAXFOiNNxFfHby6ZErg3MvUEkF
	O3Oo3zOa7Jnjk5t2HWp7DNAo/tvQv5d44MlBdcIXAn6iF9cs/PE7XDrbA+e+14VmiThsSr
	qWTIbiW7nRYjp10MjZEzMlNHsckljcLQU8ty6x5/4HIwhJA9KMqTn4q0a5ubDQ==
From: Philippe Gerum <rpm@xenomai.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@lists.linux.dev>,  "Schaffner, Tobias (T CED SES-DE)"
 <tobias.schaffner@siemens.com>
Subject: Re: [PATCH libevl] utils: net: Add missing initialization of
 query_type
In-Reply-To: <0b07213a-d4d6-415a-9179-b9a632a78aac@siemens.com> (Jan Kiszka's
	message of "Wed, 10 Sep 2025 14:32:56 +0200")
References: <0b07213a-d4d6-415a-9179-b9a632a78aac@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Wed, 10 Sep 2025 15:01:11 +0200
Message-ID: <87plbyxy08.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvfeefhecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefujghffgffkfggtgfgsehtqhertddtreejnecuhfhrohhmpefrhhhilhhiphhpvgcuifgvrhhumhcuoehrphhmseigvghnohhmrghirdhorhhgqeenucggtffrrghtthgvrhhnpeevgedujeehtdehiefhleefffelffeliedtlefglefhudehvddtleejkeetgeehhfenucfkphepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfpdhhvghlohepphihrhhopdhmrghilhhfrhhomheprhhpmhesgigvnhhomhgrihdrohhrghdpnhgspghrtghpthhtohepfedprhgtphhtthhopehtohgsihgrshdrshgthhgrfhhfnhgvrhesshhivghmvghnshdrtghomhdprhgtphhtthhopeigvghnohhmrghisehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtohepjhgrnhdrkhhishiikhgrsehsihgvmhgvnhhsrdgtohhm
X-GND-Sasl: rpm@xenomai.org

Jan Kiszka <jan.kiszka@siemens.com> writes:

> From: Jan Kiszka <jan.kiszka@siemens.com>
>
> Fixes
>
> In function =E2=80=98query_oob_port=E2=80=99,
>     inlined from =E2=80=98main=E2=80=99 at ../utils/evl-net.c:483:3:
> ../utils/evl-net.c:157:24: error: =E2=80=98query_type=E2=80=99 may be use=
d uninitialized [-Werror=3Dmaybe-uninitialized]
>   157 |         if (!which || !*which) {
>       |                        ^~~~~~
> ../utils/evl-net.c: In function =E2=80=98main=E2=80=99:
> ../utils/evl-net.c:371:18: note: =E2=80=98query_type=E2=80=99 was declare=
d here
>   371 |                 *query_type, *vlan_list =3D NULL;
>       |                  ^~~~~~~~~~
>
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>
> We are missing CI for Xenomai 4 to catch such simple issues. Tobias=20
> suggested to add at least a build pipeline to xenomai-images, until we=20
> finally have automated on-device tests. Looking into that, also to keep=20
> xenomai-images itself up-to-date with evl (we had recipe issues on top).
>
>  utils/evl-net.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/utils/evl-net.c b/utils/evl-net.c
> index b45fa60..b1d06a1 100644
> --- a/utils/evl-net.c
> +++ b/utils/evl-net.c
> @@ -368,7 +368,7 @@ static void bad_usage(const char *arg0)
>  int main(int argc, char *argv[])
>  {
>  	const char *netif =3D NULL, *modpath =3D NULL, *ipaddr =3D NULL,
> -		*query_type, *vlan_list =3D NULL;
> +		*query_type =3D NULL, *vlan_list =3D NULL;
>  	bool set_filter =3D false, solicit =3D false, permanent =3D false,
>  		enable =3D false, disable =3D false, query =3D false,
>  		allow_routing =3D false, set_vlans =3D false,

Merged, thanks.

--=20
Philippe.
