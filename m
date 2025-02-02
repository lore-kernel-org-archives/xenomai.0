Received: from mailout08.t-online.de (mailout08.t-online.de [194.25.134.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B261A8F94
	for <xenomai@lists.linux.dev>; Sun,  2 Feb 2025 15:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.25.134.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738510870; cv=none; b=tfl+bXhEQUGpaA1ISoT328jCiUmF2hhkcnjzXfFg7JPyBVh6W7SmivPU5Hw44kMvSozL0J9cdRMsd8vnGeca50ZSxKy5x2Ybs1zAKcVoTmQxRRlZilYkZ4T0JQxygf9Ya0pIYS0pXvjAsXLD6ioL2TUXtRNFF6pRHYTJXz9kkt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738510870; c=relaxed/simple;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=rlQLup9DfUDO6X80jMLmQ3jrsPXMM03S1+2BX1ULjJExPlz1Jqx+tVdEoghbpEV85GYbmAOEphFup7VqEKzPI+Ve/gA0P6Nrc02NX/Tbzt9qnPtLil5VKD4xeknTIlYaUfRZ3Vqwng4Gq2LEPucD9jcZb5C407H9xGKu6hyv0FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=t-online.de; spf=pass smtp.mailfrom=t-online.de; arc=none smtp.client-ip=194.25.134.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=t-online.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-online.de
Received: from fwd74.aul.t-online.de (fwd74.aul.t-online.de [10.223.144.100])
	by mailout08.t-online.de (Postfix) with SMTP id BAA2E9CA
	for <xenomai@lists.linux.dev>; Sun,  2 Feb 2025 16:34:08 +0100 (CET)
Received: from [192.168.6.95] ([93.208.71.192]) by fwd74.t-online.de
	with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
	esmtp id 1tebz6-2MJOPA0; Sun, 2 Feb 2025 16:34:08 +0100
Message-ID: <a20dea70-8177-4451-b0fb-71bcce201a4f@t-online.de>
Date: Sun, 2 Feb 2025 16:34:08 +0100
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: xenomai@lists.linux.dev
From: Bernd Benner <bernd.benner@t-online.de>
Subject: porting xenomai-4 linux-evl arm64 for raspberry pi 3,zero-w2,4,5
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TOI-EXPURGATEID: 150726::1738510448-827FB9E2-EB4AA1BA/0/0 CLEAN NORMAL
X-TOI-MSGID: 91f5ed89-785d-4314-962a-d1edd5afa927


