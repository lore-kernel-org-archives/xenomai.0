Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4397F4F5
	for <xenomai@lists.linux.dev>; Sun, 18 Feb 2024 08:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.50.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708244921; cv=none; b=S9mmWRwgZGQdE8XicyXrPNg4j5tNntglmuhtEmbhDXp4A4KySog0QcdQSzIB2p4vElmjV0105zJLEyy9xV6wC3/vC8b2pTIueWDEHY10U3C/5TVT1xH6x+z2t0U13OxAA7oAw6QRQ2IaHo0oxS9cV9Q49qr+SBYYy6PaXU2nOFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708244921; c=relaxed/simple;
	bh=dR+7xYU4qUdrertXep/4SE2RQ9WQ8kaXMcNOBLb9d1Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Ujlh/Azpp39aztFCZfNRFijM7ljAFMf72o7yZbycdK00JD9Kg0THh90w3Uy5GvmopDZCutY71Qili2SM/OJaNIYrFRz+UA/F/8GpuOrKKCyJ3Ya8Vw8f4MJIkA7Ym4aQ/buwmuhtRGwZeTXUv99DYIYODrDQgoJgj/kmGT6xUww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Jpqkqqsk; arc=none smtp.client-ip=45.254.50.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Jpqkqqsk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=Wo8Z79MBWhvaHuTlb4/OmP/V9mJOq1MicWAT1jeCOh0=;
	b=JpqkqqskKVjN67x+ZZQLpCUUiC0Yic6oHitqNURE2nPNaYh6vT2TVzELUoCZHJ
	vYYOUBSOTHNQCpmr5qg5BAnAuUdXbXIBooIgTMys8UOc/p6SMOmRLfQ99AeWzBdo
	wnyMO4QCtUwvl56jaTsyqLpHMIJJt2Jvkxy0PYR639M60=
Received: from [192.168.50.118] (unknown [122.4.100.186])
	by gzga-smtp-mta-g0-4 (Coremail) with SMTP id _____wDX332tv9FlyKGXEg--.40248S2;
	Sun, 18 Feb 2024 16:28:32 +0800 (CST)
Message-ID: <cf05016f-a0b5-48ab-11bd-703765b114b5@163.com>
Date: Sun, 18 Feb 2024 16:28:29 +0800
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: xenomai user space application static link
Content-Language: en-US
To: Jan Kiszka <jan.kiszka@siemens.com>,
 "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
References: <SY6P282MB3909502DB24D7E09607571FCEB4D2@SY6P282MB3909.AUSP282.PROD.OUTLOOK.COM>
 <19c3f7d7-a1dc-4796-80ee-8d41b95c81fa@siemens.com>
From: luozhenhai <ericvic@163.com>
In-Reply-To: <19c3f7d7-a1dc-4796-80ee-8d41b95c81fa@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wDX332tv9FlyKGXEg--.40248S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvj4RRhF4DUUUU
X-CM-SenderInfo: phulu4llf6il2tof0z/xtbBXgiHtWVOBfgtAAACsd


On 2024/2/16 23:25, Jan Kiszka wrote:
> 
> Didn't find anything in our docs quickly (probably because static
> linking is harmful ;-)), but you need to split linking into two steps to
> avoid wrapping also the system library symbols. There is wrap-link.sh
> which may help and is used also internally.
> 
> Jan
> 
Thanks for your reply.I have already try split linking with wrap-link.sh 
but it`s still not work!


luo

