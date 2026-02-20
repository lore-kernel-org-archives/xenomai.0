Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6759A32ED20
	for <xenomai@lists.linux.dev>; Fri, 20 Feb 2026 11:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771586448; cv=none; b=Vuls0j3tzGhFsgbUJlK6LezCpE79NMLoJDVxE7kDWRO4iwphQdjhBwhzj75T69NkI8xxHCdONaqFzYEb6h9ezJwroS1fvcpKyFh/ZGao5FBCBH8vosQjdl6t4n80WfJQhSPppxvTiIA+w4POJiTgb0m6683b5WEIq7dMZwn8UcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771586448; c=relaxed/simple;
	bh=f2hCV+OJeTlQ+l/Ri6MjQDnNBnA67zV5Ucptz+/Ct8k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=j21Ek7DIXF8StOThLEEUvqZwFq0EgjGOT1ZDPdbYTyZfwncSpPeHZip13sWuvfkt4d4/zYmDdGecBus67PreZxn8HLVmcyugzfCf0uNyI2lrQRcO+RZYOhA7/xQX+47ljolPTXQ++UdsFmEkWmBgL+MyzYQgTm5Ztuk9VquapBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=IzokLsYZ; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="IzokLsYZ"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 752623E9CC;
	Fri, 20 Feb 2026 11:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1771586440;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jGjwvBCHeLdG5/jXiHm9Zyq/1DS59YkFMWFiAEiaa4s=;
	b=IzokLsYZQ34Cb9CW51+Wg/4NmeuSnD/WU9yBRcRf5IkPaK3W27v19vQU7EFPGPXK6Vxrcm
	mzvBuQgXmUukC+jeJyf+4a1Utqex5p8/MFayxyNdgfddIW+IbWjyF4Y6hFbMyxFyV+T97r
	sLYtbaN+ZZf5j7SPGuEPCIY9C1/j3q+OEMWvNdOWbjCusmeEdYJpNUPxNNGOStjsARgWC7
	vNXryA9aRQpor2Cv1AXeifFxRjM9gGXoWokV1hfy1MbYrzZxg+1R+Z9iTH5u4+9p0Do+vt
	Is0NDKbDfP56xx5PjXGJqochl5rGJBoaxXfDZdihWHzThXM6ogUpr5H/0l1lpQ==
From: Philippe Gerum <rpm@xenomai.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>,  Xenomai
 <xenomai@lists.linux.dev>
Subject: Re: [PATCH 00/20] y2038: libcobalt: Allow both, native + time64_t
 interfaces at the same time
In-Reply-To: <87cy1zhdob.fsf@xenomai.org> (Philippe Gerum's message of "Fri,
	20 Feb 2026 12:12:04 +0100")
References: <20260220-wip-flo-fix-time64-32bit-native-v1-0-731c773e72cc@siemens.com>
	<87tsvbhigf.fsf@xenomai.org>
	<faebe432-dddb-453a-91d1-77ee48a784ca@siemens.com>
	<87cy1zhdob.fsf@xenomai.org>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Fri, 20 Feb 2026 12:20:40 +0100
Message-ID: <877bs7hd9z.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: rpm@xenomai.org
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvdekfeduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtsehttdertddtredtnecuhfhrohhmpefrhhhilhhiphhpvgcuifgvrhhumhcuoehrphhmseigvghnohhmrghirdhorhhgqeenucggtffrrghtthgvrhhnpedvlefhvdehkeduheevleegiedtueejgfekhfeijeefvdeijeekgeeigfejhfekgeenucfkphepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfpdhhvghlohepphihrhhopdhmrghilhhfrhhomheprhhpmhesgigvnhhomhgrihdrohhrghdpqhhiugepjeehvdeivdefgfelveevpdhmohguvgepshhmthhpohhuthdpnhgspghrtghpthhtohepfedprhgtphhtthhopeigvghnohhmrghisehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtohepfhhlohhrihgrnhdrsggviiguvghkrgesshhivghmvghnshdrtghomhdprhgtphhtthhopehjrghnrdhkihhsiihkrgesshhivghmvghnshdrtghomh
X-GND-State: clean

Philippe Gerum <rpm@xenomai.org> writes:

> some of them for POSIX too. I plan to use this change window for phasing
> out time32 entirely in the same move, which would simplify the POSIX

As in passing requiring glibc >= 2.34 for enabling -D_TIME_BITS=64
-D_FILE_OFFSET_BITS=64, or requiring musl >= 1.2.0 since time64 has been
the default since then. The uClibc situation is still unclear to me ATM
since I saw patches floating around months ago disabling time64 in order
to pass the test suite, maybe this has improved, need to check
again. Anyway, since we cannot do without time64 but we do have
alternatives to uClibc, the choice would be pretty clear if we had to
make one.

-- 
Philippe.
