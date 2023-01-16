Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C22257A
	for <xenomai@lists.linux.dev>; Mon, 16 Jan 2023 15:10:47 +0000 (UTC)
Received: by mail-lj1-f182.google.com with SMTP id o7so29915632ljj.8
        for <xenomai@lists.linux.dev>; Mon, 16 Jan 2023 07:10:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=embeddedgreg-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RmXrWzGlTSTyEM9M71DMsG4QK1Tv0+FM51AW8Zi5l6k=;
        b=S2755n4JzTUH572M2c6AVZmYcTc29Ek1jaGRWAQatc1Fp+G3EDNV3VgOFVATqLSpRs
         7p/BBxHr6x3lCE5PQ/VsCO1AAsfMyxQHRj1vLApWvt47qBEkcqnORBgz68PY4qSlRS1X
         JmY6qYOHrLzCY2q4TmvjnkU73MgH4qo+Zm6rpXMdaNfJexpy1uYT+cKIN6JdOOFKiNVy
         5PKN4R8zr3IeGxvoyGbMB0Aia3ZqUnUv3LeN8aTMDiUowfFEn2OrTon+EzmbZrT6GCUe
         lRve8M+fw8PMG0feWUXipC4bMPp5kUqxtVbkMaH2UYUNvkqH2WSbE7DPtowrSLeya3Lh
         muPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RmXrWzGlTSTyEM9M71DMsG4QK1Tv0+FM51AW8Zi5l6k=;
        b=xpP9Ao8ftY6egQFmZxxfHzkYakDMbsnciW93S9jiUDcm58pDBa3jgHYO5hpE0fQAq+
         RFNQGnd7ScO8vINx8sArUnasD8vBRHzH3aZGer+DQ86JBh2rr9M8qkd0NZFHOySXmUuw
         ao094MCFmFve+H8c7mAW1THcD78VusIStCZg4NXxy9Z2w2VQ8YNCkDjw1bW1iSf6CLM6
         IwBvZaowS8pA4LWEBHRJ9Uy9IPtJHSkSgV3+XVcg2211vI1Ghg48eXKAK5FIIBM/goVy
         HbqHA5oM0sv/ovAxblpAL7+eHanikiG/Ls/7h6Hw2CmgjzvAHKebLLFiE9mt3rdBc5g0
         KXGQ==
X-Gm-Message-State: AFqh2kpRPXt/p6pfk3W7i/GWdYshWLFU8Yf/iPvlskdapAZ0EfaIvrGc
	wKoQketT6XnWewgB0Hk6HU23KKwRacExMFAOCt+qDA==
X-Google-Smtp-Source: AMrXdXumVRJ/loXiqLbZ7rJRAMlhypGmW7L2St9oUTDTJYbTno7XiBPn+wNHajXEP/G8few0AbRBImjDi0hgSiC4aCo=
X-Received: by 2002:a2e:b952:0:b0:28b:88b1:79d with SMTP id
 18-20020a2eb952000000b0028b88b1079dmr6549ljs.105.1673881845365; Mon, 16 Jan
 2023 07:10:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <54b46bc9.4a08.185b9bc9cc4.Coremail.yxianyao@126.com> <dfa242d4-9ecd-0bb5-5de1-677128a90946@siemens.com>
In-Reply-To: <dfa242d4-9ecd-0bb5-5de1-677128a90946@siemens.com>
From: Greg Gallagher <greg@embeddedgreg.com>
Date: Mon, 16 Jan 2023 10:10:34 -0500
Message-ID: <CALLqZ8TfhhP9AtsdFBk59WY61SEqii1kRQ8kbVTPmkCwc7cWtQ@mail.gmail.com>
Subject: Re: MSI NOT pipeline-safe & Internal error
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: "Yao,Yongxian" <yxianyao@126.com>, xenomai@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Mon, Jan 16, 2023 at 9:44 AM Jan Kiszka <jan.kiszka@siemens.com> wrote:
>
> On 16.01.23 09:40, Yao,Yongxian wrote:
> >
> > Hi,
> >
> > The following exception occurred when running the kernel(Linux-5.4.180, xenomai-3.2.2) on aarch64 computer.
> > Attachment is startup information and kernel configuration.
> >
> > What caused the exception? Please give me some hints!
>
> Maybe just something like we have in Dovetail already:
>
> https://source.denx.de/Xenomai/linux-dovetail/-/commit/42f44cf859e3525eb26dc090fffa97bfc35e870c
>
> Jan
>
> --
> Siemens AG, Technology
> Competence Center Embedded Linux
>
>

Have you run the ipipe on this platform before?  It looks like you
have an IRQ source that isn't ipipe safe, it may be causing issues
when the IRQ is trying to be handled.  I'm not familiar with this
platform. Did you port it to ipipe?

-Greg
