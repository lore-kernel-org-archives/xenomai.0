Received: from mailout10.t-online.de (mailout10.t-online.de [194.25.134.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B2F216E35
	for <xenomai@lists.linux.dev>; Tue,  4 Feb 2025 18:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.25.134.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738694318; cv=none; b=jTWBqDxn5wlOWxX0VypPEngCGGB6d6gEqssa1BJ9Na57xdNb/i5c+WfW8ujQ1Qm5Cv+LOaoEyGu0t4dYgxUbEzPbzwvPfiy8viT6gbZrCkMReWv5W5GU2xDFOPwN9/ogK2UfPUZSgvQSISWYSdqvppL7amFjEEFtcjHtbGXK84E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738694318; c=relaxed/simple;
	bh=+jd0DdKd7DXh3P7NcvQz5dTcxWm61lW9ReTsDVFRHIc=;
	h=Message-ID:Date:MIME-Version:Subject:References:To:From:
	 In-Reply-To:Content-Type; b=cb4PRYUrT5CyXK5jVP0yIFIHYTqUJALLqkGISfmAAtyObyLxl+orAlC1NXFVuLFm2WgyGI61cFqpXvZdoBpWmAL+4wS9iZvvxnIcfOF9gY76jZNgI9IBUuOBnPP10PrBy+YIhUpz+FSrl5OPFMJHuYLPLwMDPtkOv9x8E/HIfnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=t-online.de; spf=pass smtp.mailfrom=t-online.de; arc=none smtp.client-ip=194.25.134.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=t-online.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-online.de
Received: from fwd80.aul.t-online.de (fwd80.aul.t-online.de [10.223.144.106])
	by mailout10.t-online.de (Postfix) with SMTP id F1DB615C8
	for <xenomai@lists.linux.dev>; Tue,  4 Feb 2025 19:38:33 +0100 (CET)
Received: from [192.168.6.95] ([93.208.75.131]) by fwd80.t-online.de
	with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
	esmtp id 1tfNod-1EzPyy0; Tue, 4 Feb 2025 19:38:31 +0100
Message-ID: <03ebb042-79b6-48c4-b8ce-f2c63b53cf7a@t-online.de>
Date: Tue, 4 Feb 2025 19:38:31 +0100
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: porting xenomai-4 linux-evl arm64 for raspberry pi 3,zero-w2,4,5
References: <a20dea70-8177-4451-b0fb-71bcce201a4f@t-online.de>
To: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
From: Bernd Benner <bernd.benner@t-online.de>
In-Reply-To: <a20dea70-8177-4451-b0fb-71bcce201a4f@t-online.de>
X-Forwarded-Message-Id: <a20dea70-8177-4451-b0fb-71bcce201a4f@t-online.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TOI-EXPURGATEID: 150726::1738694311-20FF693C-07B6BBCC/0/0 CLEAN NORMAL
X-TOI-MSGID: 6b645e2e-0ebf-46f9-ad5c-f089166f23cf

Hello,

   ich have made a patch, patching the raspberry pi kernel source 6.6.74 
( tag: stable-20250127 )  to xenomai-4-evl to have a better raspberry pi 
support for RPI zero 2, RPI 3, RPI 4 and RPI 5.

I will send it for review to the mailing list.

The patch can be downloaded from: 
https://www.b-benner.de/pages/de/raspberrypi/patches/rpi3_4_5_linux-stable_20250127_to_evl.patch

and here is a link to a documentation: 
https://www.b-benner.de/pages/de/raspberrypi/raspberry_pi_xenomai4.html

Best regards

Bernd Benner


