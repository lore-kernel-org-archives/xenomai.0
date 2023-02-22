Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698561FDD
	for <xenomai@lists.linux.dev>; Wed, 22 Feb 2023 09:25:29 +0000 (UTC)
Received: by mail-lf1-f54.google.com with SMTP id s22so9053574lfi.9
        for <xenomai@lists.linux.dev>; Wed, 22 Feb 2023 01:25:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dP1OfpCRHVymnLD3qrddQ01TRBd2YDM7SoHW/9FhiSI=;
        b=Fyc/Vlwn+BmVnC/0ILARFMNlUzvDMrRVBxRokYxX8aeLIPnoAsaqRjs374oCDHSFof
         FwnAV8Vp/YYJ3zQnpgshq+/ON0Z4gitN9f4Om0O3iSVA+eS6Cpcqn+t1AB8Vm8vhWk2J
         0zbJEwWm5uKF5m8f80O9wuN9MQvaqsCw1Ad3Pgpwp2y15KBQbv/7yyWkBx4bvg70fxNZ
         c+iAEEviAHtg7lDWyol6roCBnobfs5UFM6HLfb3SVwTe4auFLOUU5HtIrhWj97Kb2F6D
         PJKhGZjMDkYfj7fcLLn7QW8sxslz/BHP9b1lYw5Tce4b+sSRyqF2SqV55OIvx/V8yBP0
         jK0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dP1OfpCRHVymnLD3qrddQ01TRBd2YDM7SoHW/9FhiSI=;
        b=Mb4hRkvMqDL7gJ/DNDoXzAm1C31U5LjNepIa7R7SaQxB5FKqObB1Dn146kwrJd793O
         zbKbu+NCujFEiAXov+GGlGtHLU/sUXpPjecAxBcztQbT23CFiIu7ltZ8o7t9MPR3+Wjs
         3/u8bpCNJFerWvYoSUf5PwCz+pdid7HOl/arReC98HDBb6atRVGX7sBP7PJUdl0lkntE
         UyK4d/kwab/TXI5zblix2g/H6AYQOsn5fq2OqogE8gKX1pbBhhfeygP7wneNaUHYNagV
         yXuqcpIatxx8P8fAitai8ZBbueCKRmT74UZwtCcyoY8lm1h29xQY3O1ZKISs2/lp83SQ
         AI3w==
X-Gm-Message-State: AO0yUKUN+MItAzeRCKAYcJVqjrFEUPHVwGdC/JBEkFVmGwm1Oo21cpvh
	2qHXoZnj8J5Ecz251V0NCg5h45/dIoRzrQajKcA=
X-Google-Smtp-Source: AK7set8U+7NE7asU4GVK55iD7uzt1nOR4pYYKmNxQJN5OqZ5bpRha9Wbsn6i4iFuI6Rjeb0CJC9R3FwuHpVsNEzzUbM=
X-Received: by 2002:a05:6512:340f:b0:4d8:86c2:75ea with SMTP id
 i15-20020a056512340f00b004d886c275eamr2835267lfr.3.1677057927308; Wed, 22 Feb
 2023 01:25:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <de5bac83-77b1-87bf-1a66-c1e712e52a7c@siemens.com>
In-Reply-To: <de5bac83-77b1-87bf-1a66-c1e712e52a7c@siemens.com>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Wed, 22 Feb 2023 10:25:15 +0100
Message-ID: <CAFLxGvwrKVG8aBhrv5-VwfiQeCcgfGswXDnC=3FawvQMd58c6w@mail.gmail.com>
Subject: Re: Meet-up around EOSS (Prague, end of June)
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"

On Wed, Feb 22, 2023 at 8:33 AM Jan Kiszka <jan.kiszka@siemens.com> wrote:
> as just discussed in the community call, I'd like to propose having a
> Xenomai meet-up at or around the Embedded Open Source Summit in Prague
> this year [1]. If you plan to go there - I do - and are interested in
> chatting about Xenomai topics face-to-face, please let us know.

I'll be at EOSS and would like to have Xenomai related meeting. :-)

Thanks,
//richard
