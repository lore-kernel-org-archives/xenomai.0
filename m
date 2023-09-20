Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5466636B12
	for <xenomai@lists.linux.dev>; Wed, 20 Sep 2023 14:00:16 +0000 (UTC)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-9ada2e6e75fso918545566b.2
        for <xenomai@lists.linux.dev>; Wed, 20 Sep 2023 07:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1695218414; x=1695823214; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sWsNbn5W+0m2ZP/iyUdQ0uIAUdry35/YEgterE+PeOI=;
        b=kSd9i/nscrasaYf2EsDjJ71KTWSexicN2u8lVnSN0zhlLeeijH6Qjzh3LC4Unm2mWp
         n/Ofn5hlC+SIX5gCCJ8lr7Ef1cYYlcvZ4djc897CMGS+WfeykoUo0lnUW6K7M0e6fFl2
         a8drS5IPLuIYl4v6wVnly5Wj0wt6W9gZhnc0KfV4zeOLqOPidR0RQ1sllxonTlBJ6CgS
         TUdyHXZOIgVWvtMMdfgkgUPa49URUTRZR2BC4XOwC/r2eaIQDjxHwUGOF4mhyLFIyrA4
         mZx+lyhI68xXyTqPtomVa4ZoBiSpLsvTnpptC8colE8RCx3eqsLLmypU4NnyODJtzePK
         mriA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695218414; x=1695823214;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sWsNbn5W+0m2ZP/iyUdQ0uIAUdry35/YEgterE+PeOI=;
        b=Y4KCbuNE8/46fnr9ES1WQ4kVztbInLonYJanE3C6bkUvzeSpJx07aDaooxGOtxYQzX
         L8VpGsm6n252Cr4sxTNmKL2e8FhErfMn++Qa4rXV154LAc8634SeO/XmHWM1V/QswYDK
         /bTHnB8fAldUiuHlwJ+yWf6GQnRGsx5zWUeTkX9fS1Qnem2K7sJ4H3WMQGPpg1USVOw0
         MDL3FFEH9UFagA3R58FBzb1mXo6S668k9OdY+j9uG3iMw+vdfA55p6fzT4AsRIe9BlwC
         anWfcrPTDciFJSbHNoCcqnzj6lAb626NME+fKSzKAvgvfDVMhWpyt9V/Ev5tKbs+wNzu
         mOTw==
X-Gm-Message-State: AOJu0YyswvwNxOxUdl7Oew497oCM2bF78H0IIH+MgXKjRCa2XNwm758/
	KZWPzjBgk3D2m3ApbL5Na5mbBQ==
X-Google-Smtp-Source: AGHT+IEu9lHOwKkOQCPA7hN0+vv1FkO9zZK12El645nlEiz7vfFx4yXo6+pcVmqZPOFjhAGnR5RJGA==
X-Received: by 2002:a17:906:530c:b0:9ae:4096:61bf with SMTP id h12-20020a170906530c00b009ae409661bfmr2314024ejo.66.1695218414581;
        Wed, 20 Sep 2023 07:00:14 -0700 (PDT)
Received: from mail ([82.150.214.1])
        by smtp.gmail.com with ESMTPSA id se17-20020a170907a39100b009adc86b75d5sm8080177ejc.189.2023.09.20.07.00.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 07:00:14 -0700 (PDT)
Date: Wed, 20 Sep 2023 16:00:13 +0200
From: Aaron Marcher <aaron@sigma-star.at>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: xenomai@lists.linux.dev
Subject: Re: [PATCH 01/10] testsuite: Fully integrate alchemytests into smokey
Message-ID: <20230920140013.ozt47y73sluwfqxk@mail>
Mail-Followup-To: Aaron Marcher <aaron@sigma-star.at>,
	Jan Kiszka <jan.kiszka@siemens.com>, xenomai@lists.linux.dev
References: <20230720145150.24607-1-aaron@sigma-star.at>
 <20230724135239.10579-1-aaron@sigma-star.at>
 <20230724135239.10579-2-aaron@sigma-star.at>
 <c8b63b8bf2c3d4f803d6049d874e9a37f5dac284.camel@siemens.com>
 <1befb87a-cc47-460b-9615-10a04f752062@siemens.com>
 <20230816124344.oq7n42fmkuxlswck@mail>
 <901c80cc-d506-445e-add9-00aa0e536803@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <901c80cc-d506-445e-add9-00aa0e536803@siemens.com>

Hi Jan,

sent you a patch series on top of `next`, fixing/improving the discussed
points. Let me know what you think of the solution I came up with.

Thanks,
Aaron

-- 
sigma star gmbh | Eduard-Bodem-Gasse 6, 6020 Innsbruck, AUT
UID/VAT Nr: ATU 66964118 | FN: 374287y

On Thu, Sep 14, 2023 at 01:11:02PM +0530, Jan Kiszka wrote:
> Hi Aaron,
> 
> Any news on this?
> 
> Jan
> 
> -- 
> Siemens AG, Technology
> Linux Expert Center
