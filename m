Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF6C51C59
	for <xenomai@lists.linux.dev>; Fri, 17 May 2024 13:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715951810; cv=none; b=GxVH8zcZGCFezd8LoHryloXgqtSLluL6M6JLw5RzSRjWe06W7hwJZw1Pg4UPVsO3+lnMbuxL51JcW2A4Ijfcito7XLUlpaRZmEdtqaA+QYjNE6kIbFBof4JsQAH5G9ryc+HiWB3hMQe1+eKqgXISJtOlMQZs8HN4WvwASGTLeA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715951810; c=relaxed/simple;
	bh=g66Nr7F4AFsqdOsCrTrvSNiQ5WBDa+quuhmosXga2JM=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=M4G1rgA/iKJDunpv+VDCh2KAR5C/JnxtcNPDd8L18J5B6WOY94nHRGMlfYuk/na448ytiZ5d1NixUgwxH5nQ7RDOKLjYwSuUsQt4+lhrW9UN2DE+lrnPswFQj22naMXl7tyKmSl4ZFIqcOu1ZxUTpwYPr9wpLyB01NN/aAhCMhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-420180b58c5so834635e9.3
        for <xenomai@lists.linux.dev>; Fri, 17 May 2024 06:16:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715951807; x=1716556607;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J6vwrw362+t0aw1olu6fG3M6Ql4X9w6wpGwJveFSlf8=;
        b=YkJTLVJWVLKBraxzUqz62hfgGKB2kjUTDvt56nVDbPra/FX2QnY4AmQUClqD5mkKzj
         NhlVl6MyM/q0IbnAI4PAJYuXH+zavPpu1OHVqQuZwhk1G3JT788aG+UzCM+j3cOQck0N
         5FyAqXjt5eE9e9ZtnmNXArtHxHCjon5ZWQ2VVudVAOeRI6BnVPlzlGPgWX6bWC+dHs0p
         K3C2AOekK4nZCHwXvBsRNl1ACuOq66Y7kM8XlRZcHTqB6NmDxY0UFFdKZNI7kJ94wSrk
         H7EAZSdcbHCeuS6ghENl/B8/gpjpE/YmwGSGzV7Vutff2DtGp/GNflAoGYjvQyaQbvc+
         TIzw==
X-Gm-Message-State: AOJu0Yz/WIjldYnASxSpnRuKuaZWZs5wO7p5lIPFba9JLEPwTnMjhhQI
	OyE9UjQCwoxRhq1otri+UpQ4t1DaUiKkmQPEYY2DIY2pdMjMG2Xsrx5x+g==
X-Google-Smtp-Source: AGHT+IHqNL/Eli18+Ge2AyPxdvpnr4rHLVMtVmEBFwEtv/C/QRCUGZSOL2xYdzAzK30CtqYBzN1WGw==
X-Received: by 2002:a05:600c:5008:b0:41f:e7ac:cc72 with SMTP id 5b1f17b1804b1-41fead643a0mr165944315e9.40.1715951806223;
        Fri, 17 May 2024 06:16:46 -0700 (PDT)
Received: from pyro ([2a01:e0a:19b:3cd0:989a:5c4b:b7ff:baf])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41fccfe1277sm297707555e9.42.2024.05.17.06.16.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 May 2024 06:16:45 -0700 (PDT)
References: <PH0PR11MB59492DDE7F2301CECFD2D8A9F4EE2@PH0PR11MB5949.namprd11.prod.outlook.com>
 <877cfsskke.fsf@xenomai.org>
 <PH0PR11MB5949EC28B447C7534BF8292DF4EE2@PH0PR11MB5949.namprd11.prod.outlook.com>
User-agent: mu4e 1.10.5; emacs 29.3
From: Philippe Gerum <rpm@xenomai.org>
To: "Nechita, Ionut" <ionut.nechita@intel.com>
Cc: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: Re: WARN Kernel v6.9-evl-rebase - do_int80_emulation
Date: Fri, 17 May 2024 15:15:54 +0200
In-reply-to: <PH0PR11MB5949EC28B447C7534BF8292DF4EE2@PH0PR11MB5949.namprd11.prod.outlook.com>
Message-ID: <87y188r32a.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain


"Nechita, Ionut" <ionut.nechita@intel.com> writes:

> Clean now in dmesg. 
> Warn message not appear.
> This patch is fine.
>
> But I notice issue on compiling CONFIG_PINCTRL_CHERRYVIEW at builtin option.
> Kernel failing when CONFIG_PINCTRL_CHERRYVIEW is =y.
>
> I use CONFIG_PINCTRL_CHERRYVIEW=n to compiling your change.
>

There must be something else at work. Builds fine here with
CONFIG_PINCTRL_CHERRYVIEW=y.

The failing build log would help.

-- 
Philippe.
