Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050F37E
	for <xenomai@lists.linux.dev>; Thu,  4 May 2023 14:27:34 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-3f178da21afso4575565e9.1
        for <xenomai@lists.linux.dev>; Thu, 04 May 2023 07:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile-fr.20221208.gappssmtp.com; s=20221208; t=1683210453; x=1685802453;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:from:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fZnkidROes4I36t0aVTD4lbgiy+OcITx1Wa6B4w+6+c=;
        b=ERzYMKKHc0qecjSLJlJ5YIRUD2leUrIJynTb/1BIO/zwZFW8C4/rE4MYC5Xq37D5Ln
         4nRz1ZYpDwq0TxcappetTvqHrPjcqSUB4cVUU6IGQC5vlHO12gxj6cQ1aMC+OetJj9ku
         mpC2ICydm7cdTq+z9W9eWru0IKeEdryueVwPsRGkd+WFPhbnFbCxROML2tbgl9E8iXup
         VCD/Oldl0wuWsIAw+Gk6DpcECKYoqyMMxVYNk35QDihPjNJatPzzSM4GnVmW69LFs2H0
         Tt05Oe0z2KpQO8Lnec0VjqIxlB88lF/QyjN2GZef05rP7CB4Ag4CCe5YOxxjQalsROmr
         S61Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683210453; x=1685802453;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fZnkidROes4I36t0aVTD4lbgiy+OcITx1Wa6B4w+6+c=;
        b=HE9DGKnfk9Ykro+iFUztgy8dOpUYT0P9wXf9xg6U9my2e8DvuUZEDIcr4ZZrpdPsG0
         eoj1ljkhHvroxW0q/1g9zvrmwDrOep9PTf8Lo1umH5IKn6/o8pi2HgUxRZYxm8nbkbyE
         wN4dXp7CBBZ6HudlD4xT1YrUHzUURSG5TPisSsUlmDIpUcrlnaj+JZbvgIfFXEY2YeHB
         Mb4GFCb6PzF9BYSqzQjTWhQ+H7nKfEElu1T+lBgDKXiqMlcMDtkolVQOpLbsE6+LZQ2g
         4nc5A67xkiqOGCnwmmjqH3BsZQn4cM+JK2Nir7SFeYC5CxDhPr5bxy0mzyJ4rgiT/bqy
         onOw==
X-Gm-Message-State: AC+VfDz/xV6BE+zUVFiqAFbIIJEoUmxEesK/gSPWQ3/t9Lc8Vp4i+nQl
	jB8dkbxTgL30rLsmfPa3U/G7SprMGeQG4jpJ7wA=
X-Google-Smtp-Source: ACHHUZ4qSJSW38T1X1fiOPKt+z+4lajrYAjWGHn/nahHZ4oFyJUtkIPCYV9B2wVfd0qmSdjMWA+K/w==
X-Received: by 2002:a5d:420a:0:b0:306:b48:3fc4 with SMTP id n10-20020a5d420a000000b003060b483fc4mr2665421wrq.31.1683210452869;
        Thu, 04 May 2023 07:27:32 -0700 (PDT)
Received: from [192.168.101.56] (i19-lef02-th2-212-194-241-67.ft.lns.abo.bbox.fr. [212.194.241.67])
        by smtp.gmail.com with ESMTPSA id p7-20020adfcc87000000b003062ad45243sm12800974wrj.14.2023.05.04.07.27.32
        for <xenomai@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 May 2023 07:27:32 -0700 (PDT)
Message-ID: <5523da9b-bb44-a1be-9e54-bcad21867eb6@smile.fr>
Date: Thu, 4 May 2023 16:27:32 +0200
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
From: Julien Aube <julien.aube@smile.fr>
Subject: Re: Question about a freeze under Xenomai 3.2.1
To: xenomai@lists.linux.dev
References: <5a8afa1e-d6d7-df9f-2895-6832ffa9673f@smile.fr>
 <189dee91-923f-131a-ccae-0afcccd06107@siemens.com>
 <7dfbe0c0-161f-0977-4332-75575f1a17ce@smile.fr>
 <9a48d273-5ebd-f557-7941-8532b7ec4b67@siemens.com>
Content-Language: fr
In-Reply-To: <9a48d273-5ebd-f557-7941-8532b7ec4b67@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

> Is there any own driver involved, or can you reproduce the issue without
> it as well?

I could not reproduce the issue since for now I'm booting on an NFS 
filesystem, and the hang happens when the GEM driver does the detection 
of the phy (thus maybe the issue is rather in the phy layer rather than 
the ethernet driver).

The crash might happen elsewere but I have not seen it.

I'll try to create a setup were the rootfs is on the storage, disable 
ethernet driver and see what happens. Thanks for the idea.

> I'm furthermore no longer sure if the Zynq 7030 is officially / fully
> supported by dovetail. Maybe Philippe can comment on that.

It's a dual cortex-a9 , and it was working in xenomai 2 / kernel 3.9 , 
so if it's not working I hope the issue is a small one.

In the meantime I'll see what I can do with a jtag probe.

Thanks !

Julien


