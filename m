Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49BB4525E
	for <xenomai@lists.linux.dev>; Tue, 26 Mar 2024 10:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711449812; cv=none; b=tlG0uh4l1QGyyHrK/gIHABjP9Mj5k20gVPz8u83Dd5dJ1av5vZXqbtga0LfwI1C0pPocsOSU0dOuUAVyCl3y6Sots+ZzYX62VZwoyV0LjXJD0gcHQdUTG+MMtGTgG2+h4N/WpPl1F1aY7qHPjw66JVOztFCVkvE9xNZR57ynsAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711449812; c=relaxed/simple;
	bh=1u0gOJ9/3w87ugQEmDQglfjVl6g3aM0w60ZnSykVWTY=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=br+MijqGy5zQgS44PfPTWqoaV3ga2dO97I9XrKtYe9n48RIArvXVjnllxBq7em29r70HR6i1lHjZnsWdPmZA7P4kDmSA17HhNg4CeMr+lG7JqXDxCrFEGRVca4/fLe0sxpOZzU1R5X68m6ChCEBtDZDELImRxJ4qqbE6WSwmwRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2d6dda3adb9so17408281fa.1
        for <xenomai@lists.linux.dev>; Tue, 26 Mar 2024 03:43:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711449808; x=1712054608;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xv3CsmaJF8QFONDcRtLIpK5UEAxm++44K058xFmy0Sc=;
        b=s+a1/t+s6A2C/dnPD/ah6VjwglQDoCUefHXWhWI/t7LeoYthXUsa7e7sidYY+ytaK4
         IyvNWHZK9jSdu+zS3R+ElyR2lSklCa7aIWAn/74J6QBXP9vLcv+J8Tu2IXiWxunTDSHW
         WvOxgqiW4gB6JVNYhg6vmQcoJbLpkc/II2POGH34b5FF8OBXKvNsgOcj877QW4gcHyrz
         UolThIBz+1uwfxODDKHm5q5oWSZpMtcJ7xm8Y/EatNkRuf9hid7R4OPuPiL34rJg41zV
         1kCkeNAuCEUl6cOKow7slGpYggKwk5Pyiz9Tu+WzlZo/KyMj8N4JMCZduJXScLlVXb7r
         5eDA==
X-Forwarded-Encrypted: i=1; AJvYcCXftPjOHzHTx7AUEGRvFUehkmaOkxAKprupg5LlrXStj8YILSMXAssIBl0eN8Lo1v0Sea1NcOqTmW9yKm/f7ZVm1gEh/d5KIQ==
X-Gm-Message-State: AOJu0YxwEZIISLvaFkG0OU0RSBWPc5m7O8tJp5+c3dpIaFozzwErq8s2
	8+oHbEi7F6G3l567vbfA0jL72sW0NndEx8TVd1TTB58XgQvL7CBOppKnkiEd
X-Google-Smtp-Source: AGHT+IGv8UutzTZg6UB3UMf/q85UTDo7DgtkscgQGwSIkZ04YoX8gJMQlzyaumaYrGV0F0y5pWDAVw==
X-Received: by 2002:a05:651c:4cc:b0:2d2:c83e:d4ce with SMTP id e12-20020a05651c04cc00b002d2c83ed4cemr1900949lji.34.1711449808120;
        Tue, 26 Mar 2024 03:43:28 -0700 (PDT)
Received: from pyro ([2a01:e0a:19b:3cd0:989a:5c4b:b7ff:baf])
        by smtp.gmail.com with ESMTPSA id g9-20020a05600c4ec900b00414659ba8c2sm11338402wmq.37.2024.03.26.03.43.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 03:43:27 -0700 (PDT)
References: <cover.1711434664.git.jan.kiszka@siemens.com>
 <7c7653e02bb847ef04cf9380ebf93d7ad2c3fbc8.1711434664.git.jan.kiszka@siemens.com>
 <8af04cee5eb692db362ba2ccadf905f872284e3c.camel@siemens.com>
User-agent: mu4e 1.10.5; emacs 29.2
From: Philippe Gerum <rpm@xenomai.org>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@lists.linux.dev
Subject: Re: [PATCH 19/25] drivers/net/corectl: Provide proper prototypes
 via corectl.h
Date: Tue, 26 Mar 2024 11:42:56 +0100
In-reply-to: <8af04cee5eb692db362ba2ccadf905f872284e3c.camel@siemens.com>
Message-ID: <877chpmfxx.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain


Florian Bezdeka <florian.bezdeka@siemens.com> writes:

> On Tue, 2024-03-26 at 07:30 +0100, Jan Kiszka wrote:
>> diff --git a/kernel/drivers/net/stack/include/corectl.h b/kernel/drivers/net/stack/include/corectl.h
>> new file mode 100644
>> index 0000000000..6dc7fadeb9
>> --- /dev/null
>> +++ b/kernel/drivers/net/stack/include/corectl.h
>> @@ -0,0 +1,20 @@
>> +/*
>> + * Copyright (C) 2016 Gilles Chanteperdrix <gch@xenomai.org>.
>> + *
>> + * This program is free software; you can redistribute it and/or
>> + * modify it under the terms of the GNU General Public License as
>> + * published by the Free Software Foundation; either version 2 of the
>> + * License, or (at your option) any later version.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + *
>> + * You should have received a copy of the GNU General Public License
>> + * along with this program; if not, write to the Free Software
>> + * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
>> + */
>> +
>> +void rtnet_corectl_register(void);
>> +void rtnet_corectl_unregister(void);
>
> This seems a bit inconsistent with patch 11, SPDX identifier vs.
> license text. I would vote for the SPDX way.

As long as Gilles's signature is kept. Thanks.

-- 
Philippe.
