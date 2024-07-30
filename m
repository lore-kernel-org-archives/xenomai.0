Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E7F2194A71
	for <xenomai@lists.linux.dev>; Tue, 30 Jul 2024 09:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722332317; cv=none; b=WiOT/jTrFzQTdhwQ8JpdRLfi7XW9lkncA6YMOhgSxSbIOW1k2ASgY5ROlzBLn9uqH1COjfEfMlnd4+UVmh9Q79jXZ5gOmptq/c+hrUOQDE9vkcIn5PeknWpBMUDYjXFMnymFYislWU2uUGJkuL6A9RzetpoJ7RJQHfDZ+Jmq4GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722332317; c=relaxed/simple;
	bh=KiYHvKL9gfvb4WV13+MDcyGKtBIsRWASkWQPFUDUam8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Q8zsK7vsTUz5wkOiS54+uDWnv6Zs/JLDNQdGF3+KekagzV29IEKAmi5kD24YoUDyXG/rnHzaJZ2lmhe0/V7Vhio7VHrvkUmUJmh9NGvhwFDIkFeEeiXhEqywICgyQ46zR7d9OXHrfddD8T2YDrfzJqgOwfvm+cGA2evA2Ebkccc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-368663d7f80so2041678f8f.3
        for <xenomai@lists.linux.dev>; Tue, 30 Jul 2024 02:38:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722332314; x=1722937114;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2bcT/ysmZyidq3zw8Ub7fJ3r8Kuay//3oRXRu7Nh6h4=;
        b=VD+6wjEBAKT1I+IKRoITd8bwnIddpnqmjAgR8MPdlxi9Fm4CI2Sso+Bk83yPzY1N69
         pV+NR0BVEA/lDJiQuVpY3qdY1uX/niB9kCaAaTtjcqn7dGQ7bkIaTTrCg5l15aVQE/8m
         KHs6HT+lqpgFY5DImkNqkx8K8ICTkyrEgOGap5rnzaOrM1nfBtpvpQNeQ0Q0bPJBg1uE
         0pJ89uYXOxwKg2MdD6/qT5m9p0j4JJqNORnFWH7cS+2GF7HEVWT+qS4oQC8/x1CRCB5C
         jN+HWyvTTn57TldJJ+SLAPGQQ4yZyiNuOmz/lx46AMEZ8IrKnJ4eh0iu8VPdbx1v9dxv
         aoRw==
X-Gm-Message-State: AOJu0Yw7ynSmVC9Yu105vH3ila8zDavDxrqJsX6zVVOE5VgWjaCq37S2
	Hd+G3fIhyUvIPK1TXgLmj0FVp5jVEYS8XiLv+n9TllfwoRWuCBEEcYgwxg==
X-Google-Smtp-Source: AGHT+IH4Y3XEAHHmPvyNNxaBh8PLLYQ+zxra5AWGrvvXKiuq+WHlAajXd0SqHCeLdlatqnvUu/Tv2A==
X-Received: by 2002:adf:e98d:0:b0:367:9854:791d with SMTP id ffacd0b85a97d-36b5d0bca31mr6948262f8f.43.1722332313536;
        Tue, 30 Jul 2024 02:38:33 -0700 (PDT)
Received: from pyro ([2a01:e0a:19b:3cd0:989a:5c4b:b7ff:baf])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b36861b29sm14190905f8f.93.2024.07.30.02.38.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 02:38:32 -0700 (PDT)
From: Philippe Gerum <rpm@xenomai.org>
To: "Nechita, Ionut" <ionut.nechita@intel.com>
Cc: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: Re: WARN Kernel v6.9-evl-rebase - EVL: invalid out-of-band syscall
 <0x43564d41> - Firefox browser
In-Reply-To: <PH0PR11MB5949AE14DD34B53E647A0896F4B72@PH0PR11MB5949.namprd11.prod.outlook.com>
	(Ionut Nechita's message of "Mon, 29 Jul 2024 15:51:39 +0000")
References: <PH0PR11MB59493E21636F9CA955E2DE8BF4EE2@PH0PR11MB5949.namprd11.prod.outlook.com>
	<87wmnmq8v9.fsf@xenomai.org>
	<PH0PR11MB59491C18ADB51F5FEAEF4B3FF4EB2@PH0PR11MB5949.namprd11.prod.outlook.com>
	<PH0PR11MB59490B50D2D2717B8155EFCDF4EB2@PH0PR11MB5949.namprd11.prod.outlook.com>
	<87h6eprhbg.fsf@xenomai.org>
	<PH0PR11MB5949B24CB222FBB2D387BF24F4EB2@PH0PR11MB5949.namprd11.prod.outlook.com>
	<87cypdr5fm.fsf@xenomai.org>
	<PH0PR11MB5949453FBEBCA4520CAF80A2F4B42@PH0PR11MB5949.namprd11.prod.outlook.com>
	<871q3g3qva.fsf@xenomai.org>
	<PH0PR11MB5949E741DE6A97AF6E1A741DF4B72@PH0PR11MB5949.namprd11.prod.outlook.com>
	<87y15kff0y.fsf@xenomai.org>
	<PH0PR11MB5949AE14DD34B53E647A0896F4B72@PH0PR11MB5949.namprd11.prod.outlook.com>
User-Agent: mu4e 1.12.1; emacs 29.4
Date: Tue, 30 Jul 2024 11:38:28 +0200
Message-ID: <87ttg7qkx7.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

"Nechita, Ionut" <ionut.nechita@intel.com> writes:

> Hi Philippe,
>
> My .config kernel configuration:
>

Ok, this is reproducible locally now, thanks. Will fix.

-- 
Philippe.
