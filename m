Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B8B57E
	for <xenomai@lists.linux.dev>; Thu, 13 Apr 2023 08:01:43 +0000 (UTC)
Received: (Authenticated sender: philippe.gerum@sourcetrek.com)
	by mail.gandi.net (Postfix) with ESMTPSA id C1CFE20007;
	Thu, 13 Apr 2023 08:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1681372896;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XyvrVxZlWJqyMQ6MUAfhoodCuqcfpkkEb6iJh6UK0B0=;
	b=RIyQgxFioru2vqWy7UMwh/VkYDQBJL94B4FqW2p1+SsU05vq/fbg/n/NDUyRNR5BTgaRdP
	eKV/uiXzzTNPkAB4o2duL9MaMQVi9kIZWOiWQSEurWl03sXazUBUM4qPn9LdRvWiMcEIUq
	cjyFgANAoWEFR6mOiKnPDNa5HdZP0EB7bPZSZxp0oRWufcNTTCJz+Nxj+SEjakWtwcO5zZ
	JA0UiTPy1Cb6APVbFLdu7JijsDBMpM4pJc3Zk01ekrWq3PIJrkdKA/R+tSOwYA/BUvv8zU
	l700p7g16rYSuoWuXeN7zzDGhhbm40EBIVkIxRrFvSSiCuXoBsSZOUtjLAGr0Q==
References: <20230412170927.80793-1-d.sanz@ecler.com>
 <dc1cc7a3be7f77baf0e6de5a6ca4baa548f05165.camel@siemens.com>
User-agent: mu4e 1.8.11; emacs 28.2
From: Philippe Gerum <rpm@xenomai.org>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: Dani Sanz <sbrk.modules@gmail.com>, xenomai@lists.linux.dev
Subject: Re: [PATCH] spi: bcm2835: fix NULL pointer deref for OOB transfers.
Date: Thu, 13 Apr 2023 09:51:48 +0200
In-reply-to: <dc1cc7a3be7f77baf0e6de5a6ca4baa548f05165.camel@siemens.com>
Message-ID: <87ile0i529.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain


Florian Bezdeka <florian.bezdeka@siemens.com> writes:

> On Wed, 2023-04-12 at 19:09 +0200, Dani Sanz wrote:
>> From: Dani Sanz <sbrk.modules@gmail.com>
>> 
>> There was a problem when calling ioctl(fd, SPI_IOC_ENABLE_OOB_MODE,
>> oob_spi_setup) to use spidev in OOB mode after setting up the spidev.
>> 
>> The kernel crashed because on function
>> bcm2835_spi_start_oob_transfer(struct spi_controller *ctlr, struct
>> spi_oob_transfer *xfer), it tried to access bs->slv->prepare_cs,
>> however bs->slv was NULL.
>> 
>> This patch sets the bs->slv value to the correct bcm2835_spidev object
>> during bcm2835_spi_setup(struct spi_device *spi), so the NULL pointer
>> dereference that happened later is avoided.
>> 
>> Signed-off-by: Dani Sanz <sbrk.modules@gmail.com>
>> ---
>>  drivers/spi/spi-bcm2835.c | 2 ++
>>  1 file changed, 2 insertions(+)
>> 
>> diff --git a/drivers/spi/spi-bcm2835.c b/drivers/spi/spi-bcm2835.c
>> index 2626abfc0a5b..1051482df945 100644
>> --- a/drivers/spi/spi-bcm2835.c
>> +++ b/drivers/spi/spi-bcm2835.c
>
> Hi!
>
> Thanks for your patch, but his is the wrong mailing list for this
> issue. The patch should be submitted upstream (Linux) and we will fetch
> it during the next update cycle of Dovetail or IPIPE.
>

Actually, this patch applies specifically to Dovetail, upstream refers
to bs->slv only when TX via DMA is enabled, so there is no issue in this
case. However, Dovetail extends this assumption to any transfer
direction, but fails to init this field accordingly, hence the breakage.

-- 
Philippe.
