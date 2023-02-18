Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C99641
	for <xenomai@lists.linux.dev>; Sat, 18 Feb 2023 05:34:12 +0000 (UTC)
Received: by mail-lj1-f171.google.com with SMTP id h23so63674ljb.4
        for <xenomai@lists.linux.dev>; Fri, 17 Feb 2023 21:34:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=embeddedgreg-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UNiUaBcS/80KYLminXc4ZI1Ph3VBSOO/2nFqmXU1AkY=;
        b=XOsBvBwjITq0p/ZQkCcIbV5IDekDBZDiWxSA18BVbbRBeU+bmjMn8F43bjOF20yG/3
         3OfM59Q5+5TqIamF/pt2eSnmoTdS8c237G/7WIn2j75bFrWq9KmyxVB/dUBtb4WNtZX0
         8CR27B27hywVTZUnigTcgiFiq9PUIeLgwtPq7mFenmBkQO68kFBNZgHLOzYF5JtmCmWO
         Rs/at6KNR5iMBnU5IeeCF25SFU6or8O+qQYk50bsXG9CY6E56ZaLRx8+buWi9uPFQ/As
         kCaru+2vXnYNxCbVMXjdWlknpIhgDu8RIG24I3JgT/whGtEo9uuA94U8i+KFnfyrWgVr
         g1Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UNiUaBcS/80KYLminXc4ZI1Ph3VBSOO/2nFqmXU1AkY=;
        b=xcUipLNcQE0sJ/WIQdSZ7augimwX+f9qH5JFJFUDM5rJM+nfbkcSO/ot29d6A5WVI4
         +vH/Lge900Wm9oqqcl9WO13ZY1p8+5NCCRlK+XHDcr72oPDHMxtB61gVFGqMRCohMmNX
         +LEPePjBvjaCge5jYnt8r+5E3tq092x2Mc/W//GWTpLxAMKD/b8FM5ke3BZGQGsPtA3H
         K+pn4mt6S2f3z96jrWvfOY+e+5OMp1lh2wsl7Bedx1p24HL7HxVPWS6fDO78elEg66LZ
         8L46LyPALGHNaTV61+rR8Y3oWxtYr5DbSSRFSyBsRO9BlpNCc3w5mid2RZSxwDUnqViU
         P5Kw==
X-Gm-Message-State: AO0yUKUqiRPu9Kgwdbtxa06HDkR9+LfeU15+27zLg/fyPCdaL1J1TZky
	KiQQ6hxNrla+EdodmFCfMMKSCqlzLW1XNBkq38iN/w==
X-Google-Smtp-Source: AK7set95QqfDAmVKp2MLUuamWPcxgF4nta3vQU5UlqLSfOdUvsDh0dos1sF9nzGdulYSr/0HMWdR5CV/q1I1kKfyQYw=
X-Received: by 2002:a05:651c:10b1:b0:293:2d4e:ae22 with SMTP id
 k17-20020a05651c10b100b002932d4eae22mr998908ljn.7.1676698450049; Fri, 17 Feb
 2023 21:34:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CALLqZ8T=c_ngHcuU5vkpLVfzbN4Kpfh-Aqzq2vKErCYqbzyQWQ@mail.gmail.com>
 <252602b1508b13bc480f6c971e13b02ae7702071.camel@siemens.com>
In-Reply-To: <252602b1508b13bc480f6c971e13b02ae7702071.camel@siemens.com>
From: Greg Gallagher <greg@embeddedgreg.com>
Date: Sat, 18 Feb 2023 00:33:58 -0500
Message-ID: <CALLqZ8SiSB8e1VJcCv06H7Gc=zwiLf=6kBisB73yCT6VhRRRug@mail.gmail.com>
Subject: Re: arm/arm-64 ipipe release
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: xenomai@lists.linux.dev, Jan Kiszka <jan.kiszka@siemens.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, Feb 14, 2023 at 11:56 AM Florian Bezdeka
<florian.bezdeka@siemens.com> wrote:
>
> Hi Greg!
>
> On Mon, 2023-02-13 at 23:01 -0500, Greg Gallagher wrote:
> > Hi,
> >    I'm almost ready to release the next arm and arm64 ipipe patch. I'm
> > working on stable release 231 since it contains the patch that
> > hopefully fixes the UART irq issue seen in CI.  If there's a problem
> > with using 231 let me know.  Finishing my local test this week.
>
> Thanks for letting us know. If there is a chance that you publish a
> public available -rc somewhere, it would be possible to tweak our CI a
> bit and trigger a full test run in our lab.
>
> That should help us to identify any leftovers upfront.
>
> Best regards,
> Florian
>
>
> >
> > Thanks
> >
> > Greg
> >
>

I'll get -rc releases out this weekend.  I'll post back once they are
done and the -rc tags are pushed up.

Thanks

Greg
