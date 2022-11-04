Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA6C7C
	for <xenomai@lists.linux.dev>; Fri,  4 Nov 2022 02:37:09 +0000 (UTC)
Received: by mail-lj1-f179.google.com with SMTP id d3so4576858ljl.1
        for <xenomai@lists.linux.dev>; Thu, 03 Nov 2022 19:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=embeddedgreg-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ql3dmkQUx2b/gI8sTto8NJpTqEVgvefKPeWVKOfuUqI=;
        b=BDoSDxKP82gemnwXVx+YQ0fN5zINs7ZKBYVXxIYH2+UWk+1SQ61l+PUkYTH1pOgDKa
         Ab40MVNDAQvDWrjLgoUONJxm7utOhVwEVve+zgNkVKKXO5unpbyMV5z1/XHXE3Jw8Wkt
         q97jz7kpJWZSceZe1+20ZB6+X7eQdI9REtSqUJG5BZ99u8puxN5oCEvMGWRh88zCwAdS
         HBuxzqgjNWpOjsHybMlV0MjYSxuBX4MtiOG/QMjuKGaj0lIMLxcoHqb9BPC9gONQviy5
         zV2pTHaMzj4SZQw1uCZFFyRfOR2+JBTG46TiOLkEXVN4Lh7+IY95D9UL4nc4lCI9KhSe
         uKgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ql3dmkQUx2b/gI8sTto8NJpTqEVgvefKPeWVKOfuUqI=;
        b=BMeuS1DfTVLqNSXmVUD+qIGZn8qhLiuCk1bSUcV53jIbTdLgbdqMv2bKYRnx+UEGT2
         obQ1ly/3g4aUTra5tSy/bos2WtHtDseQcOOJ/U7jWJUBMABsW352m0o8O7FnCMF+bhYZ
         V5xHv43B3iz4PUuNqRLGPPGdT1l17XjDrsKXhXWQfaS+UYavezlloqVSTdY4sroprBBR
         lbyRiw1MFjJCZkuy/t3jLZQ7nuOQDWb6Em/8cOGEFeFYW1IOhtJq4iv92o9u0gRjW+e4
         eOSguQ8V3zYASCMDAHNK7buVDdAdDf+taOcD4PixcB8soHeNRMjhb9q7wKUrlLOzEKZD
         lrGw==
X-Gm-Message-State: ACrzQf23EPUXZBFamnjtdlmKGRsOEdwgGKiAPRWYwbve+3GQ1t2duexV
	N6MOebMr8hgsDh5FE2bIVqI52CD3JvqWYrm2nzmJzA==
X-Google-Smtp-Source: AMsMyM5UPMPDp//ERdf1MiocAcn+4l6L7II5Z41V3wNxlH1ulVzdO713FuMj802tWGqD8eCZP9qREgg1yn1u8DRxEas=
X-Received: by 2002:a2e:9dd0:0:b0:277:c94:8247 with SMTP id
 x16-20020a2e9dd0000000b002770c948247mr12742863ljj.397.1667529427269; Thu, 03
 Nov 2022 19:37:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <8721e84b34268e33f2e5d3c6781a8af3769de816.camel@siemens.com> <CALLqZ8RkrQt1a6tAHbA=73xYOig+hB3FNJEi1UNGUWQ3ekvGJA@mail.gmail.com>
In-Reply-To: <CALLqZ8RkrQt1a6tAHbA=73xYOig+hB3FNJEi1UNGUWQ3ekvGJA@mail.gmail.com>
From: Greg Gallagher <greg@embeddedgreg.com>
Date: Thu, 3 Nov 2022 22:36:56 -0400
Message-ID: <CALLqZ8T46wBOVe_Rm=UGM7Q0q-Dryzoq+e+ExJ9cQ_hOvOYPtQ@mail.gmail.com>
Subject: Re: Several problems with ipipe on arm64
To: "Bezdeka, Florian" <florian.bezdeka@siemens.com>
Cc: "rpm@xenomai.org" <rpm@xenomai.org>, "Kiszka, Jan" <jan.kiszka@siemens.com>, 
	"xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"

Hi

> On Thu, Nov 3, 2022 at 11:39 AM Bezdeka, Florian <florian.bezdeka@siemens.com> wrote:
>>
>> Hi all,
>>
>> this is a small summary of my recent ipipe on arm64 debug session,
>> maybe someone is able to answer some of my questions.
>>
>>
>> First: Difference between ipipe 4.19 and 5.4:
>> ipipe_prepare_panic() in kernel/ipipe/core.c does not call
>> ipipe_context_check_off() in 5.4 [1] but does in 4.19 [2].
>>
>> Is there any difference between 4.19 and 5.4 so that calling
>> ipipe_context_check_off() is no longer necessary, or is that a bug?
>>

 I suspect this is a bug that got missed when this was ported to 5.4

>>
>>
>> Second: IRQ stack overflow on Hikey board:
>> I noticed that we call pr_err(), WARN(), WARN_ONCE() at several places
>> inside the HW IRQ off entry paths. The underlying printk() will call
>> ipipe_unstall_root() at some point so HW IRQs will be *ON* afterwards.
>> As some printk() calls happen before the IRQ ACK we can easily end up
>> in IRQ recursion/nesting, especially for level triggered IRQs. How is
>> that supposed to work?
>>
>> I have commented out such error reporting stuff for now. No IRQ stack
>> overflow seen anymore.
>>

This looks like a bug to me as well, does this happen on both 5.4 and
4.19?   I would expect the ipipe_unstall_root should not be called in
that chain of events.

>> Third: Adding maxcpus=1 to the kernel cmdline breaks all of our CI
>> tests, so something serious is wrong with ipipe. At least 4.19 and 5.4
>> are affected.

This may not have been tested that well, I can't remember if this has
the same behaviour on my ultrascale board.

>
>>
>>
>> Last: The Hikey board in our lab boots up until the first UART hangup
>> occurs. That seems to happen when systemd is trying to spawn getty for
>> the serial port. I'm quite sure we have a problem when one CPU is
>> handling irq_free()/irq_shutdown and there is still one IRQ in flight
>> on another CPU (or the IRQ is still pending/waiting inside the IRQ log
>> due to a stalled root stage).
>>
Do we see the same behaviour on QEMU?

>>
>> I have no physical access to this board and kgdb isn't working as
>> expected. gdb is unable to talk over the serial line. It might be
>> something different...
>>
>>
>> Ideas, comments, ... welcome. Thanks!
>>
I'll fire up my ultrascale board and see if I can help.  Sorry, I've
been MIA of late and unfortunately I've had little time for Xenomai
and the ipipe of late.  I'll find some time this weekend to help out.

>>
>> Best regards,
>> Florian
>>
>> [1] https://source.denx.de/Xenomai/ipipe-arm64/-/blob/ipipe/5.4.y/kernel/ipipe/core.c#L1980
>> [2] https://source.denx.de/Xenomai/ipipe-arm64/-/blob/ipipe/4.19.y-cip/kernel/ipipe/core.c#L1979
>
>
 -Greg
