Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C50C383982
	for <xenomai@lists.linux.dev>; Tue,  6 Oct 2026 21:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791323528; cv=none; b=FV70bYmm8Eg1Ov3VO5v0aC5kx3GcbNKFguHtNdms5z3pFUO9wLzLYkr/KymLSMEMjqlzxawGu7kpCUeU0Lsk1DBn4lWf2U5K9xqJ2ZDfPA5IOeNuiVIqkpRrD9R4SJzjBcGswnhSKqy/W2yrtPpv9vB0VkyHZv1JQe/7ZUoeFzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791323528; c=relaxed/simple;
	bh=cqBETtQwTD1Blwv0zF14dRKsv+qUZMxida3vAmh/Dac=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Tt+LdF+hnrjg+YDb/cN7k3VVmRQ81hIjnHjLGiB/wtgTlzpBWNAxx4gOuNecy+Z7Uw4QOC+ms8qF5XTv5HriqNjzjUrav/Flf+D1vHT03QRtLO2JhDRvoyfRqxzgMvV/odGr2P8awLLYLuPOsj1sdmPnLZ1vhPWr5qalPpWOLSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=Rvt0POdf; arc=none smtp.client-ip=185.136.64.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="Rvt0POdf"
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 202610062141475041e0e525000207f9
        for <xenomai@lists.linux.dev>;
        Tue, 06 Oct 2026 23:41:47 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=cqBETtQwTD1Blwv0zF14dRKsv+qUZMxida3vAmh/Dac=;
 b=Rvt0POdfqc+T2RDTS9cyeXI2VH/xnRqe/i+VVecPYMBAXG9lcjhXKsfGlmsgDTY+evSdNg
 OrTo9BRX/EsLFinHqkvniaTq+DsGoCECFS2ZVH+cEVnUAw2HC4SelXzyzjEfDKKj/ScSPfEb
 PK8mt7+IwwhGE0ZXNZgFpX/Slu20odIhSBjDt0M375yFuz/V0iFZPxbHAF5m2G+Tsi+eKhnB
 iZL4TvJJgFJiVLaNYnMHIwdy6UgzpfGR4iGC4S/Y+FWboQvthQhXrXgUd/dqOw7FIwL0m2et
 yHeZx+vxVC4bpAZ0IMWql6cAk4EWTBeT2SXS9lY8wl/JZhgNDFlnnNFw==;
Message-ID: <2417db8d2c58bfe4df77802f7d6883e45af7e6b4.camel@siemens.com>
Subject: Re: Issue using recvmsg
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: =?ISO-8859-1?Q?Fran=E7ois?= Legal <francois.legal@eventlab.fr>, 
	xenomai@lists.linux.dev
Date: Tue, 06 Oct 2026 23:41:46 +0200
In-Reply-To: <1208-6ac49e80-43-2c92e940@166990351>
References: <1208-6ac49e80-43-2c92e940@166990351>
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

On Tue, 2026-10-06 at 09:09 +0200, Fran=C3=A7ois Legal wrote:
> Hello,
>=20
> still porting my system from Xenomai 3.2 + linux 5.4 Ipipe to Xenomai 3.3=
 + linux 6.12 dovetail, I'm having what looks like a weird build issue :
> I'm using the recvmsg call to get network message + ancillary data. On my=
 new system, it returns -1 + errno set to 88 (ENOTSOCK). So I dug a little,=
 and it happens that recvmsg64 gets called, which does not seem to be wrapp=
ed by libcobalt to xenomai SC.
>=20
> The fix for this is decorating the recvmsg call with a __RT() or __COBALT=
() macro
>=20
> Is it expected ?

Not sure yet. Probably not.

Can you please elaborate which (g)libc version is being used and for
full transparency write down the code from your application and the
necessary prototypes from your standard libc library.

The wrappers in place are matching glibc, where the 64 bit variant of
recvmsg() is named __recvmsg64.


Note: There is a conference week going on. Expect some delays. I will
try to come back to that topic.
