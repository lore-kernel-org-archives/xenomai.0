Received: from wp072.webpack.hosteurope.de (wp072.webpack.hosteurope.de [80.237.132.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF741FBEBF
	for <xenomai@lists.linux.dev>; Mon, 24 Feb 2025 22:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.132.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740435193; cv=none; b=bvu5zTdZKoWjLEyqqfExWiS/r+MDSLX01QMLPwkJREYVuVgSF3QIRWzMgh1H0hdeNNF9bMsWoDjb4ZBTpBNnf3HoAcVC7sEyRGe94OCIrjbvzAVg/tGupGrG2DXix2jX6/HVcJkNIcuAbAHlPnRa4vpHT+gyiLx7F465pb0/OPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740435193; c=relaxed/simple;
	bh=afQJ59TU9pCZkBpWNuSymQw9Tl1jRiQY83ZHaNtDmYM=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=eaUfh7YzgQfxQ90A3h7E4E4gQHL8QOY4fCpYMfjdIyUJEXe8pJlateeSW/TXHIXJAq7YaV+2idS+dEjfaA+4vV440TsiPHxu8QEK0qvaJ8Znb2/kRRSCHE1oA5JKJTASoMPyA2WJbfTIn1uf3P/t0iiXxHrPyhHchb+faQR58ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fam-obermayr.at; spf=pass smtp.mailfrom=fam-obermayr.at; dkim=pass (2048-bit key) header.d=fam-obermayr.at header.i=@fam-obermayr.at header.b=Yab+6Z0F; arc=none smtp.client-ip=80.237.132.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fam-obermayr.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fam-obermayr.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fam-obermayr.at header.i=@fam-obermayr.at header.b="Yab+6Z0F"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fam-obermayr.at; s=he109608; h=Content-Transfer-Encoding:Content-Type:
	Subject:From:To:MIME-Version:Date:Message-ID:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=fj7PiMG21/l+8nKsUVDydcXJLoQisjcg9F9ZQmgFC+M=; t=1740435191; x=1740867191; 
	b=Yab+6Z0F94JAy8YRDYc4vv+dFNlaRs3J6E5++SSdTB+j7rgNUvJbOkd9U88vpLjPOYSkdwFZpdh
	USoJFF+yzCqU2Gg7DZYZQYblnUwIZOpaHDB8S4eScTW/gobYf8ZcOfT2LHHTHz1QM4kQ558Z2zroa
	BJzQ6ppYhP0ezC/FmOP0CDoDpcp6zgf1gMtja6qFz8n8TrsSA3SNPeIxsES0UtqAvDJhI8aj9v71l
	Cw2aA5NugnDm2Pf0/KWb5G9OBVfKeYPJ/cjWShnjtITAozwyDVlhuqdzk8EEU4UoGORjUDW2kJrcj
	nwx6DgE248j5fA3BzZ68AeONipBEOlex3xWg==;
Received: from 83-215-235-230.stat.cablelink.at ([83.215.235.230] helo=[10.30.248.78]); authenticated
	by wp072.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128)
	id 1tmgF3-00F2HB-3D;
	Mon, 24 Feb 2025 22:43:58 +0100
Message-ID: <6aca85a3-49a5-484b-9546-840fb92e86b4@fam-obermayr.at>
Date: Mon, 24 Feb 2025 22:43:57 +0100
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: xenomai@lists.linux.dev
Content-Language: en-GB
From: Johann Obermayr <johann@fam-obermayr.at>
Subject: xenomai 3.2.5 16550A driver with irq sharing
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;johann@fam-obermayr.at;1740435191;09efb833;
X-HE-SMSGID: 1tmgF3-00F2HB-3D

Hi,

is this correct, that xeno_16550A driver does not support IRQ sharing ?

i load xeno_16550A with parameter io=0x3f8,0x2f8,0x3e8,0x2e8,0x2f0,0x2e0 
irq=4,4,4,4,4,4
this work, but after open a rtserX, I get
2022-01-01 01:27:41 kern.info kernel:[   93.857347][  T579] genirq: 
Flags mismatch irq 4. 00210000 (rtser5) vs. 00210000 (rtser0)

irq 4 is only used by xenomai.

Regards
   Johann
