Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B4612CD8F
	for <xenomai@lists.linux.dev>; Thu, 13 Jun 2024 18:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718301912; cv=none; b=YddduGqnpSGkRKTaqkzz2yuUEa/LOhRXUI2I5B6hJP1UiAQNLhRsMX97gy4qQQx3MSOvhz7Dy5gApPobqDLTC9cFkU9tCl+H9/T+Wl9vObBa/aldEPWuFbypMNXoGn4Q1SXfVjVErUCVcdnLsCi/MR3ULOEbTNKZ4zz6y9iwtWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718301912; c=relaxed/simple;
	bh=MCb44nCF09n9IimsFces0dBYsLkFwn5k+eHTNMAOHB8=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=PEYKlGrUkAlRjyB5CwtY6zv7aYQFA6W2/47QoI4b8XcR65L/z18JaI0mAGaL/8+p6f1KKqvc8tlkO4HFAfygIKZKHTFy99DTkgaEO1NV8DJm3egNm7Yj64+gr/1nDxoHm7MkPJiu0wnB1OqFCNdAavgSMN1XuE5pQ6s5K1YeXQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-42179dafd6bso15668165e9.0
        for <xenomai@lists.linux.dev>; Thu, 13 Jun 2024 11:05:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718301909; x=1718906709;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=114OjdkgD64o5UI2Hu7KFXFvDU5ik8AXilpssR2egOE=;
        b=mF5NgeuGBlYwkV6SY/dx+ubXn6z3akkKYDiNU8rO48cqCweUZaIvtQxkeqt0rB9Zqk
         dFVvDNPyDx6hKiGJqOLgqdLcW5bwLfjgf1Xu/oaTSV09qdDKx6gareyNZaCx0vUPTpiW
         t4W6VpRy7tsy7KsVKzPV8tqYsuTQ34O5KgTD31rKZ9HljTDFjxZs2Y83XhB+rgCFKDu+
         UrueXyPwi0zi0dNk2v53wArSNH0hiRTXDa3F8DtYcjaOlC7ZJeFxZXZvycGthhyLfYRp
         g04rCtWMUKycZBDCppIbRNTSxpNmeOQuxe49Miua2gWiXoGYffKMK+X8tZY+cDhhjjgD
         XQjQ==
X-Forwarded-Encrypted: i=1; AJvYcCX4DXyisyo00MqUBK3F7vZsqKZSyw6WAZwePZauAjF5azQOfmxF4xr2b+RjXV1ID9V5CV+ZTo7NxVI49TweFYQlq7YvBamEhw==
X-Gm-Message-State: AOJu0YyWwrTMp6yYzwutOq5aaVyM+gqupXtxuY+swfChwKsY09ILdR66
	MHqsU6bt5oEP5XiRuDvdJuf55lJ9dg+Hx0ewkSY181MMe0JXMLIJ
X-Google-Smtp-Source: AGHT+IGZhQ4Jfp+UQEaXYhjrAoSF2iG4eJfc19m4MhvKUPfOlhhJeD+Fub+8fSMYA4DQH4G84+84WQ==
X-Received: by 2002:a05:600c:5102:b0:421:7dc3:9a15 with SMTP id 5b1f17b1804b1-422b6fc45a6mr35216765e9.11.1718301909302;
        Thu, 13 Jun 2024 11:05:09 -0700 (PDT)
Received: from pyro ([2a01:e0a:19b:3cd0:989a:5c4b:b7ff:baf])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422f5f33c43sm33946115e9.7.2024.06.13.11.05.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 11:05:08 -0700 (PDT)
References: <20240613134557.4013044-1-tobias.schaffner@siemens.com>
 <20240613134557.4013044-4-tobias.schaffner@siemens.com>
 <87jzisrkfo.fsf@xenomai.org>
User-agent: mu4e 1.10.5; emacs 29.3
From: Philippe Gerum <rpm@xenomai.org>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Tobias Schaffner <tobias.schaffner@siemens.com>,
 xenomai@lists.linux.dev, jan.kiszka@siemens.com,
 jorge.ramirez.ortiz@gmail.com
Subject: Re: [libevl][PATCH 3/4] evl-test: Start evl-test with load by default
Date: Thu, 13 Jun 2024 19:27:10 +0200
In-reply-to: <87jzisrkfo.fsf@xenomai.org>
Message-ID: <87v82cpvl8.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain


Philippe Gerum <rpm@xenomai.org> writes:

> Tobias Schaffner <tobias.schaffner@siemens.com> writes:
>
>> Stress evl with a load command while running the tests. The load command
>> may be set to an empty string to run tests without stressing the system.
>>
>> To align with xeno-test the -l command line argument was used for the load
>> command. Listing of the unittests can now be done with --list and --List.
>>
>
> Nak. Compat with xeno-test is definitely not a requirement if this means
> breaking the existing evl command line usage. Besides, --List looks
> strange as an option. Let's pick a different option for the load command
> instead.
>

We may want to implement the stress utility as a separate evl-stress
command, keeping evl-test for unit testing which has a different
purpose. evl-stress as a script could generate the load (dohell) and
possibly check the latency figures reported by latmus (using the -K and
-A switches to detect weird behavior).

PS: Jorge is going to look into leveraging stress-ng for load
generation.

-- 
Philippe.
