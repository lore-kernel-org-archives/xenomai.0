Received: from smtp5-g21.free.fr (smtp5-g21.free.fr [212.27.42.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935E517FAA4
	for <xenomai@lists.linux.dev>; Wed, 12 Jun 2024 15:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718204509; cv=none; b=WxE0EKdn9R+9a8JZOJL/28kKo3YShQDe2sEBaf2ZQFsA47U+NZO8ZLElZjHlBU5JLL6WLzcpH+SmAw4vOJ1qaDZf3WaR66/CB08I7Xns91ISRR0lvcwQDRovB9tjpyizHmE5TH0LL6wdBhhLzPtWtiHlAghNLOzZYBe0qB8m3ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718204509; c=relaxed/simple;
	bh=LP8Kx9pekSg3MTZUxt0wxrBEvkplEt8b99WqET/f+qU=;
	h=From:In-Reply-To:Content-Type:Date:Cc:To:MIME-Version:Message-ID:
	 Subject; b=auSpErssbqBaDmGp9LoT6EHyqVLSD7hsKR8A+t6m3Z//IGOOSMxCT1lXgHO190Upr2mt831JTN0CpKag4YBJxVr5VpZ+J5Nf3LdxLdmK/0fI9HPCQNUSX88kTzflOAARq9faHhJXXAP69had8t9e5Iq+2nSAI/BOlBsM4BMcJ/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thom.fr.eu.org; spf=pass smtp.mailfrom=thom.fr.eu.org; dkim=permerror (0-bit key) header.d=thom.fr.eu.org header.i=@thom.fr.eu.org header.b=w1ty7zqX; arc=none smtp.client-ip=212.27.42.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thom.fr.eu.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thom.fr.eu.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=thom.fr.eu.org header.i=@thom.fr.eu.org header.b="w1ty7zqX"
Received: from mail.thom.fr.eu.org (unknown [IPv6:2a01:e0a:2aa:1dd0::2])
	by smtp5-g21.free.fr (Postfix) with ESMTPS id 15C2860134;
	Wed, 12 Jun 2024 17:01:43 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mail.thom.fr.eu.org (8.15.2/8.15.2/Debian-22) with ESMTP id 45CF1cCE414365;
	Wed, 12 Jun 2024 17:01:38 +0200
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/simple; d=thom.fr.eu.org;
	s=default; t=1718204498;
	bh=LP8Kx9pekSg3MTZUxt0wxrBEvkplEt8b99WqET/f+qU=;
	h=From:In-Reply-To:Date:Cc:To:Subject;
	b=w1ty7zqXFAkvyVD4wK10V0pKofb88uUJhqzdWUK/izTzOtQ6v7nJofqDtxKBXbovQ
	 AEdeAfKw0mkSAewpRvW35WBjlGNedx4GmeXeHgZIcOsbo4NSX2lZ3ds/Eq8+QJCuPE
	 iQujfynD63I7p4ueHz9OaV0weundJHaWpkPyzcwbzyfLL7VNW6Uw8xcFYjjwTKrfKf
	 YGeQIfOeQSWU4vpaoyJfn5ePes36bi5cXJsBN6hJbQ8uQWnuNHeGUm4ue7wV8X5RLX
	 nF/OI8PHyu9qFzYiQf9lGGywLPIolN3TtKK4t4eIdmsSWlCHCYAYzx5cUq7o8SKbPc
	 C/I/gAeBS8Igg==
From: =?utf-8?q?Fran=C3=A7ois_Legal?= <devel@thom.fr.eu.org>
In-Reply-To: <CAFLxGvzhmZEL4+22UjkPD34g9AqMfdA4xUavug5itv_1GR=dPA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
X-Forward: 217.109.173.233, 147.161.180.87
Date: Wed, 12 Jun 2024 17:01:38 +0200
Cc: =?utf-8?q?Chen=2C_Hongzhan?= <hongzhan.chen@intel.com>,
        "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
To: "Richard Weinberger" <richard.weinberger@gmail.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Message-ID: <1158-6669b880-17-2e725200@6131903>
Subject: =?utf-8?q?Re=3A?= Porting RT net driver to dovetail
User-Agent: SOGoMail 5.0.1
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: clamav-milter 0.103.10 at tls-srv-03
X-Virus-Status: Clean

Well, I'm not sure but last time I checked, RTNET would not be part of =
xenomai 4 IIRC. So I guess EVL is the way to go.

Fran=C3=A7ois

Le Mercredi, Juin 12, 2024 14:40 CEST, Richard Weinberger <richard.wein=
berger@gmail.com> a =C3=A9crit: 
 
> On Wed, Jun 12, 2024 at 2:09=E2=80=AFPM Fran=C3=A7ois Legal <devel@th=
om.fr.eu.org> wrote:
> >
> > Thanks for the answer.
> >
> > Maybe I mixed things up, but I thought that with dovetail, one woul=
d somehow use  linux network stack with special OOB drivers, and have n=
o more to rely on RTNET. Is that correct ?
> 
> It depends on whether you want to use Xenomai or EVL.
> 
> -- 
> Thanks,
> //richard

