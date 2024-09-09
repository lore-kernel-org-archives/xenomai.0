Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F6028EC
	for <xenomai@lists.linux.dev>; Mon,  9 Sep 2024 14:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725893491; cv=none; b=LkxDvvUIYsOZEB56YNzLN3QzaA2nTMK0tq3vdav2kb4mMU6X+huR3rwWk+m78+14ddvlAW1ugXCLL1BqoUtOkz3jWOQiDLuBCeT/RiB5AXQhGsKVNoDXm+ZlVg65bFiqaT+WBaWtKgkmPgVy84zBlFG77UNZwknBYSPARx5KEHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725893491; c=relaxed/simple;
	bh=l0LlDN6tJcXtpJihH7o1iJEzHDjDqfqvAGbJa6HxpSQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=s84+Ucfe9lu/oPKPSr4KiQxugs+wC9A6jjjIAVSiBCCRd8jn5LXf1oEaQbTQdHrhaXnJoVv0UP3MmI6a6GSMGnXyLiXE6xXXdqjPX+x2lBOQ7m11cqBNVJ0Mjnxx2SP1uciZTeLFDUfSCmuSmsjPvrNSHd0i348jvgIr6uPHFEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=EblAov0J; arc=none smtp.client-ip=185.136.65.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="EblAov0J"
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 202409091451223bc61c44f2ab61f314
        for <xenomai@lists.linux.dev>;
        Mon, 09 Sep 2024 16:51:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=l0LlDN6tJcXtpJihH7o1iJEzHDjDqfqvAGbJa6HxpSQ=;
 b=EblAov0Ji8IldOdi1GaoZU2tBhfVdcilBExA+2Po6C6HCeLt+/BuMxEK2X2nACwbwQN0xc
 /a36/8UOO9oORd16Y0Q1kn/tLmtUGsB0/CDKmUPYbdGt/BcWq0gurg/pQ0ZWt73zIeoik8Bm
 fV3yiDHbjKt78DtXXijYYQ+bVkXsvd+2CQVg3+Iriy47hCM/u78RrKBOIkleNt8HB8RbCuPY
 SP1expA9yyVE/OFY1c4Xe7TiFRm5k47A0ArOXJRy9vdprs1zATusYlGDJ93gTZMsO10n8l8+
 arrwoVff1Nw2hsrzniRQjGGrVern11QBT+bMh2unc5CERtrVngzMaCvg==;
Message-ID: <05df8b68c3896b4fc8fcfef5a2cf8953e453d05b.camel@siemens.com>
Subject: Re: [PATCH dovetail 6.10] x86: dovetail: Allow multiple HV guest
 extensions to be enabled
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@lists.linux.dev, Jan Kiszka <jan.kiszka@siemens.com>
Date: Mon, 09 Sep 2024 16:51:21 +0200
In-Reply-To: <87jzfqxez9.fsf@xenomai.org>
References: <20240823091858.3355791-1-florian.bezdeka@siemens.com>
	 <87jzfqxez9.fsf@xenomai.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer


>=20
> 6.1.y, 6.6.y and 6.10 series merged, thanks.

Thanks. Might I ask why it was not applied to 6.11? Any problems
detected or just forgotten? 6.11 did not (yet) exist at the time of the
series but the patch for 6.10 version should apply cleanly.

6.11 currently still has the problem that only one HV guest code can be
active at build time.

Florian

>=20
> --=20
> Philippe.

