Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE83342EEBD
	for <xenomai@lists.linux.dev>; Thu, 26 Feb 2026 17:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772125254; cv=none; b=WJG+7jOp+ddkuriWCNKGG0SheQ6uU3hV/xPstMVbVfN8qb1odh0RWhEPF5Q2dzc0Dd1mmm1AhZLOde4g4bB2wlWrn7Qrza2Ky75fRIOvh2Rynnq7JKOSM7zlubWN4IEsdplgug+4BXYlxw8Yg2fDs8jHDuDKpfLL8wy8GF/zF04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772125254; c=relaxed/simple;
	bh=8YjJx0kgGwC+DgD5aS38GUgyKTavl+1ciSdIc/s1eWw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=k7GIL3UxFFfEZxAe+H4WfYKeFCN9X5a4tBKq+IoIw05RXFYxPrD1kL5NoM1VI4Vz0wHvs4OTHoweVLvdv0JqjpgAloX8gmiW9OKhNDUEZ5hONKE5wa9slKFXFvhN+cKD2HqwZRNo15gV8WtqU0uynvw3dsoj0/2YJDPhYaillgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=UGTdM2cv; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="UGTdM2cv"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 90AAA44478;
	Thu, 26 Feb 2026 17:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1772125243;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=w6SaaZ6YdoRvevtNz25gvMkzSlGyiM2OQfrZdcSOLTw=;
	b=UGTdM2cv41VOELetGZAttNUDlzaX1FCwUyBDOZ1wFbonw2C3h2vnhWD44qFeAq0hyjUEc/
	7ruBMMDPhZ31TqCJEXze2uyS6pXYwAErQVsXJb5Q1EX1u35+IzGsDJtSoU9UAmpYqvS4+R
	0yUAov97wWenEQ8tWCN2Pr1RBkxR4jk5EmQYSvCJ+4QazihLjkSx26tXhBjKyRx5I6Ntm2
	3IU8EyW9W3AKsl/CITHydN0I7ooLqG9FoxMEpqqtawQFiZ3WekBM1l/fiNTAaK0nm+B69L
	h5wappZ7sztbbs/gG8FeUBnD8OUNEk56zkGwzDxr2iED+tnqFu1DeElHYCOW0g==
From: Philippe Gerum <rpm@xenomai.org>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: xenomai@lists.linux.dev,  Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: [PATCH Dovetail 6.19] e1000e: Fix merge mistake, reintroduce
 FLAG2_IN_NETPOLL
In-Reply-To: <20260225151413.1929834-1-florian.bezdeka@siemens.com> (Florian
	Bezdeka's message of "Wed, 25 Feb 2026 16:14:13 +0100")
References: <20260225151413.1929834-1-florian.bezdeka@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Thu, 26 Feb 2026 18:00:43 +0100
Message-ID: <87ikbjwibo.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: rpm@xenomai.org
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgeeiheelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtsehttdertddtredtnecuhfhrohhmpefrhhhilhhiphhpvgcuifgvrhhumhcuoehrphhmseigvghnohhmrghirdhorhhgqeenucggtffrrghtthgvrhhnpedvlefhvdehkeduheevleegiedtueejgfekhfeijeefvdeijeekgeeigfejhfekgeenucfkphepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfpdhhvghlohepphihrhhopdhmrghilhhfrhhomheprhhpmhesgigvnhhomhgrihdrohhrghdpqhhiugepledtteetteeggeegjeekpdhmohguvgepshhmthhpohhuthdpnhgspghrtghpthhtohepfedprhgtphhtthhopehjrghnrdhkihhsiihkrgesshhivghmvghnshdrtghomhdprhgtphhtthhopeigvghnohhmrghisehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtohepfhhlohhrihgrnhdrsggviiguvghkrgesshhivghmvghnshdrtghomh

Florian Bezdeka <florian.bezdeka@siemens.com> writes:

> Seems I miss-interpreted the change while forward porting as a rename.
> But: It's two flags using the same bit().
>
> Reintroducing FLAG2_IN_NETPOLL to make the e1000e driver buildable
> again.
>
> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
>  drivers/net/ethernet/intel/e1000e/e1000.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/net/ethernet/intel/e1000e/e1000.h b/drivers/net/ethernet/intel/e1000e/e1000.h
> index 200ab51b07c8e..7e08444efd932 100644
> --- a/drivers/net/ethernet/intel/e1000e/e1000.h
> +++ b/drivers/net/ethernet/intel/e1000e/e1000.h
> @@ -501,6 +501,7 @@ s32 e1000e_get_base_timinca(struct e1000_adapter *adapter, u32 *timinca);
>  #define FLAG2_CHECK_SYSTIM_OVERFLOW       BIT(14)
>  #define FLAG2_ENABLE_S0IX_FLOWS           BIT(15)
>  #define FLAG2_DISABLE_K1		   BIT(16)
> +#define FLAG2_IN_NETPOLL                  BIT(17)
>  
>  #define E1000_RX_DESC_PS(R, i)	    \
>  	(&(((union e1000_rx_desc_packet_split *)((R).desc))[i]))

Merged, thanks.

-- 
Philippe.
