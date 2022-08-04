Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E777C
	for <xenomai@lists.linux.dev>; Thu,  4 Aug 2022 17:03:24 +0000 (UTC)
Received: by mail-ed1-f42.google.com with SMTP id f22so424543edc.7
        for <xenomai@lists.linux.dev>; Thu, 04 Aug 2022 10:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=neuraldsp-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YaHlRjhLgn1pnpjteW7o8lVXUpPr1MqA04xlQJQwdI4=;
        b=E/w8CuVvju61ONlxy7bcIA8M4tFCadNJ77Ax/9xm2mbvL5LsB3LjnK79AGDcIFCX6g
         OvLP0rnugW0kiacXLIdPuv7SHHXYZuWICNdq4KnCNZQKvI44QpaQTdFdIg9r/Z+reI+B
         p7wpRK7RC7kt6UsU0bBfRSM5mB7SR7wdazPpOkQ83MiKE4RSfV8b+b0UnCc544GTOsle
         EZ+QC2eyY8IBz56Q6IOlFuL0fxjyZZ2YykgGUjWt3/bRn2gMOgJBvGvAnyAVGLlmX7oe
         2YpOkAMgTCVp+IgvwXEnICmz09JbKvHuNo7Lrlp8ndSfSu7IstHbybqADMD+lL1EsALP
         +aJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YaHlRjhLgn1pnpjteW7o8lVXUpPr1MqA04xlQJQwdI4=;
        b=L5PcOSL4UX8wldfOZWf9hapoVCI3GoU0SCfkRwW/YwIVfYfTspfezxn2v/Sa41HGQY
         D5XNgbPlhNpI9kGUjA3+6rSPVZoHAhCf9qjy7TV/8FLDAvTt4TT/a+sAlxX9DkjsBAcJ
         88S8VksPJ5pukFCprx042G/4CAf2Qvkb3PE/VwnUzCy1QbOInIIx19wUiftQwH4K9up5
         2yajxRUSHFQWHK+yPcEU+ry6XmTzdAnUUJK15TuzH1Isjc29RFytd3/5ty7yAlh5C3r6
         AWXcwJSbfoqk+1u+32LeN/ERVMKNmVXiMAfgQbPHe5rRkpzrv0q3cVsW41/smwwNhTl2
         iMdw==
X-Gm-Message-State: ACgBeo25ziJqwnaRdH4y1K/Pox/Gm5LfZkAtrgr6rkmNEDOCa0oTlabI
	Wg2wp9Mx5/A+dgJ+YQ/GAlNh3Igwd71o3ngXjErm5cIOTHpRRYAj
X-Google-Smtp-Source: AA6agR5fYBSphyp01/hqfbzJntO2qvE8BtH2TTPOiBVo/8qLthwVTZZTadoyGCV0MOFvg6cCLGbktGpBs511SAayoTQ=
X-Received: by 2002:a05:6402:3892:b0:43b:d872:a66 with SMTP id
 fd18-20020a056402389200b0043bd8720a66mr2932708edb.139.1659632602520; Thu, 04
 Aug 2022 10:03:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAANaHT-rev__mHn3geXCSz0yM0VJBkZjidrNoZQfEi8s6e-T8w@mail.gmail.com>
 <87bkt0yy85.fsf@xenomai.org> <CAANaHT9E=73w7_sOugpw7JBToTzfRtDy+aTeW5HgPKZjB_rKQQ@mail.gmail.com>
 <877d3oys2r.fsf@xenomai.org>
In-Reply-To: <877d3oys2r.fsf@xenomai.org>
From: Gabriel Durante <gabriel@neuraldsp.com>
Date: Thu, 4 Aug 2022 14:03:11 -0300
Message-ID: <CAANaHT_1n5todg23D8UaRNQfbJtHQi1kVuPKPRweJSkr-NUZhg@mail.gmail.com>
Subject: Re: Xenomai 4 IMX8MM
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Fair enough Philippe,

Any of those ranges works for me:
/usr/tests/sched-quota-accuracy -c[1-3] -n[1-8] -v

Thanks
Regards
Gabriel

On Thu, Aug 4, 2022 at 11:57 AM Philippe Gerum <rpm@xenomai.org> wrote:
>
>
> Gabriel Durante <gabriel@neuraldsp.com> writes:
>
> > Thanks Philippe,
> >
> > IRQCHIP_PIPELINE_SAFE flag on gpio-pca953x.c did the trick, no issues on dmesg.
> >
> > Now only the issue (kernel hangs) with edt_ft5x06 loaded while running
> > sched-quota-accuracy.
> >
> > [ 2341.500412] edt_ft5x06 2-0038: Unable to fetch data, error: -110
> >
>
> I suspect this may be the outcome of the test overconsuming the CPU
> bandwidth on the same processor which runs the (threaded?) IRQ handler
> serving the touchpad events. IOW, the IRQ handler cannot run quickly
> enough for the touchpad hw and/or driver to be happy, because
> sched-quota-accuracy is keeping the CPU (too) busy.
>
> Three options to check this:
>
> - move the test away from CPU1, which might be shared with the IRQ
>   handler, using the -c <cpu> option (you can run sched-quota-accuracy
>   manually, outside of the 'evl test' scripting).
>
> - change the CPU affinity of the IRQ for the touchpad device, away from
>   CPU1. Fixing up /proc/irq/<irqnum>/smp_affinity accordingly may help,
>   with <irqnum> matching the proper device in /proc/interrupts.
>
> - try reducing the load imposed on the system by the test, e.g. by
>   lowering the number of concurrent threads using the -n <nr_threads>
>   option. Defaults to 3, maybe 1 would allow the test to pass in that
>   configuration.
>
> You also may want to make sure to switch off
> CONFIG_PROVE_LOCKING->CONFIG_DEBUG_LOCK_ALLOC, CONFIG_DEBUG_LIST and
> friends which slow down the (regular) kernel code a lot.
>
> --
> Philippe.
