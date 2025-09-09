Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C870B3191C6
	for <xenomai@lists.linux.dev>; Tue,  9 Sep 2025 13:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757425630; cv=none; b=nlNKuS3F2eUa12jnrBd1uiXGKiY5+t2EQVzJElKCBKSLNfyz/m9uVKErusDPoU4bZGcmiC3rPT1mZuVvlnJalyStB3QY3ddyzMGfCDsukMkvslYsG1J0pCiQUkaq5vykHP3nmr5YIG1JFMaosqYJSMj0Io0vGizYhB4H+O+HVQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757425630; c=relaxed/simple;
	bh=SH8o5butMnDyUH0+xLVdJwk0OsOWuHhgdXvMic3nYYM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=b7bkUXyB+WrR4sr39tYFhxm0fC6FUZfBBtliP20gck02jW46iIkOJhZF82OHiFhq8rY6K7nkeoAqiPnR/t8LxIhcqQYZS+nNKypyjc7bEx4aXYT+aVwGyeybODcgw7vmMvCpwW4yrvWGDAvhzn3g3xr9oOuKnpHuhX1LPFjZWRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=KkWM5AZq; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="KkWM5AZq"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4F1A543354;
	Tue,  9 Sep 2025 13:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1757425625;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Sp+SiR+TwCx+h+0ofeS1DO0JpofXAHAXqceSl0HKrOU=;
	b=KkWM5AZqpLeeh2s7UE5+dP+rh+laTQchy+teIMvKiOJkvGImaZxg5FH1I/Ql1KvkrZmN3f
	sRquzRw/2EjdN5o0XMOfQbPxsStKbaV8l+gTSvcB7eAxbls4BBnJXl/LcpE5XYqZKwU5z8
	4u4l4IHq4tn+wa2SLEuzavEuhURFD6I0JKBDazszmEqK18XUznaDt3c20uj1oBVrBE6rUt
	YhXrwHR7k4DqbcbUoUVegE+McJ+k1Up2V1ptVfdIlRf1FsvdhXiU3EaSS5O9qy2lI2Cn7p
	oJ1lXN+jAFG1vFgHSaNLwQg9eNyC73msVsc+V6vRoTE1vSsVwbo8i4VPwpH+SA==
From: Philippe Gerum <rpm@xenomai.org>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: xenomai@lists.linux.dev,  Fabian Scheler <fabian.scheler@siemens.com>,
  Tobias Schaffner <tobias.schaffner@siemens.com>,  Jan Kiszka
 <jan.kiszka@siemens.com>
Subject: Re: [PATCH Dovetail 6.10 - 6.16] x86: irq_pipeline: Fix build
 failure for !IRQ_PIPELINE but X86_FRED
In-Reply-To: <20250905-wip-flo-fix-build-failure-no-pipline-but-fred-v1-1-492c5e4edd52@siemens.com>
	(Florian Bezdeka's message of "Fri, 05 Sep 2025 11:38:07 +0200")
References: <20250905-wip-flo-fix-build-failure-no-pipline-but-fred-v1-1-492c5e4edd52@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Tue, 09 Sep 2025 15:47:04 +0200
Message-ID: <87zfb3viuf.fsf@xenomai.org>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtdehiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefujghffgffkfggtgfgsehtqhertddtreejnecuhfhrohhmpefrhhhilhhiphhpvgcuifgvrhhumhcuoehrphhmseigvghnohhmrghirdhorhhgqeenucggtffrrghtthgvrhhnpeevgedujeehtdehiefhleefffelffeliedtlefglefhudehvddtleejkeetgeehhfenucfkphepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfpdhhvghlohepphihrhhopdhmrghilhhfrhhomheprhhpmhesgigvnhhomhgrihdrohhrghdpnhgspghrtghpthhtohephedprhgtphhtthhopehjrghnrdhkihhsiihkrgesshhivghmvghnshdrtghomhdprhgtphhtthhopehtohgsihgrshdrshgthhgrfhhfnhgvrhesshhivghmvghnshdrtghomhdprhgtphhtthhopehfrggsihgrnhdrshgthhgvlhgvrhesshhivghmvghnshdrtghomhdprhgtphhtthhopeigvghnohhmrghisehlihhsthhsrdhlihhnuhigrdguv
 ghvpdhrtghpthhtohepfhhlohhrihgrnhdrsggviiguvghkrgesshhivghmvghnshdrtghomh
X-GND-Sasl: rpm@xenomai.org

Florian Bezdeka <florian.bezdeka@siemens.com> writes:

> The POSTED_MSI_NOTIFICATION_VECTOR is present since 6.10, so
> FIRST_SYSTEM_APIC_VECTOR was off by one resulting in the following build
> warning:
>
> ./arch/x86/include/asm/irq_vectors.h:104:41: error: array index in initia=
lizer exceeds array bounds
>   104 | #define POSTED_MSI_NOTIFICATION_VECTOR  0xeb
>       |                                         ^~~~
> arch/x86/entry/entry_fred.c:98:37: note: in definition of macro =E2=80=98=
SYSVEC=E2=80=99
>    98 | #define SYSVEC(_vector, _function) [_vector - FIRST_SYSTEM_VECTOR=
] =3D fred_sysvec_##_function
>       |                                     ^~~~~~~
> arch/x86/entry/entry_fred.c:121:16: note: in expansion of macro =E2=80=98=
POSTED_MSI_NOTIFICATION_VECTOR=E2=80=99
>   121 |         SYSVEC(POSTED_MSI_NOTIFICATION_VECTOR,  posted_msi_notifi=
cation),
>       |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ./arch/x86/include/asm/irq_vectors.h:104:41: note: (near initialization f=
or =E2=80=98sysvec_table=E2=80=99)
>   104 | #define POSTED_MSI_NOTIFICATION_VECTOR  0xeb
>       |                                         ^~~~
> arch/x86/entry/entry_fred.c:98:37: note: in definition of macro =E2=80=98=
SYSVEC=E2=80=99
>    98 | #define SYSVEC(_vector, _function) [_vector - FIRST_SYSTEM_VECTOR=
] =3D fred_sysvec_##_function
>       |                                     ^~~~~~~
> arch/x86/entry/entry_fred.c:121:16: note: in expansion of macro =E2=80=98=
POSTED_MSI_NOTIFICATION_VECTOR=E2=80=99
>   121 |         SYSVEC(POSTED_MSI_NOTIFICATION_VECTOR,  posted_msi_notifi=
cation),
>       |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> Required build configuration:
>   - CONFIG_IRQ_PIPELINE =3D n
>   - CONFIG_X86_FRED =3D y
>
> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
> Cc: Fabian Scheler <fabian.scheler@siemens.com>
> Cc: Tobias Schaffner <tobias.schaffner@siemens.com>
> Cc: Jan Kiszka <jan.kiszka@siemens.com>
> Cc: Philippe Gerum <rpm@xenomai.org>
> ---
>  arch/x86/include/asm/irq_vectors.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/x86/include/asm/irq_vectors.h b/arch/x86/include/asm/ir=
q_vectors.h
> index de7592d870e9..dd755c95f3b4 100644
> --- a/arch/x86/include/asm/irq_vectors.h
> +++ b/arch/x86/include/asm/irq_vectors.h
> @@ -109,7 +109,7 @@
>  #define FIRST_SYSTEM_APIC_VECTOR	CALL_FUNCTION_OOB_VECTOR
>  #define NR_APIC_VECTORS	        	(NR_VECTORS - FIRST_SYSTEM_VECTOR)
>  #else
> -#define FIRST_SYSTEM_APIC_VECTOR	LOCAL_TIMER_VECTOR
> +#define FIRST_SYSTEM_APIC_VECTOR	POSTED_MSI_NOTIFICATION_VECTOR
>  #endif
>=20=20
>  #define NR_VECTORS			 256
>
> ---
> base-commit: eec111a874f5899e1078ef785ccf29dff986e5a0
> change-id: 20250905-wip-flo-fix-build-failure-no-pipline-but-fred-3951c96=
cb5a5
>
> Best regards,

Merged into v6.12, v6.16. Thanks.

--=20
Philippe.
