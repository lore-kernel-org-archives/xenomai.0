Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F23342C11EE
	for <xenomai@lists.linux.dev>; Sat,  8 Aug 2026 06:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786169838; cv=pass; b=T/seeXxO5tV1xZcRpCM0fowMxfHKoMbZ+72t37YoB5QtAmDU+RxJAu5RMRWc0gXE6BaDzDWjsb+Mk5ahhhcmr+T4GIi4ZbGkcm0k+/719OtC7VsnEpv5PfTWSKYVQvMAZSkPyVdv2S8TT7YI0GNFZUrQLm8NuBs/gTq6+NiB/tQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786169838; c=relaxed/simple;
	bh=r/F46F9Vh6B43zesaXOZOcTIe6TQQ6wxop/oM2M7b2Q=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=IGlBGrHaqHhrLMoj18YJG94LsWHDFXm0JSBriWD1yMfyY58ISfFP1W6GaOKnZt+s/AmUnFZ6Ehc2bECX71sBW7OtFJh8X2y9ysPD/FvkTsH+JNVFADpiIcxa0gzlMdV+3Z6CLfIpik9OsxgXB5i1fUeGtEE1HMMM/513RyT7b48=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UrEPh6u/; arc=pass smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UrEPh6u/"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-80e24970f1dso2112677b3.0
        for <xenomai@lists.linux.dev>; Fri, 07 Aug 2026 23:17:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786169836; cv=none;
        d=google.com; s=arc-20260327;
        b=qZWeAeDFCF61oZGJ4eCpfay/4bau0J8noJoyH7A9ReDE6ADec2MNoRajnVtnGV/FQJ
         PvomSSiacmTr4tvDo3vjAocalUUJ3dKzonzaPEOP7HTBcIo+LYKY0Y1tkswVbfrXI0AB
         L08wfvx4CJj8pF8WfeKuP0RfzTPiVKIWXhztEu1bH9ZCKjwwwLIDta0KLdpIbTjIZqhF
         dZVL0wpzZpMLWm5lkvB5A6H2dtDjF64misbYp6v4ewdLV2HQnJ0sIJy5VOh705k1qyR4
         i8k1wJvn4yCmZ5z2KUTnMf6gQmPwWWuIPtPq6juDG+p2o9m0nlZ59/EtbYRQUPCBkrFz
         wb2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=Q3W+3Yc3yRT60qpg5AQRoV0tpQ9QhTJBuN1JdrJjQTo=;
        fh=O15oOK5VJ7+HnQyR0P4j8h8E3vdYlzLasLiICAHXHME=;
        b=JUzPucgNdQk+NMcS3xZI+lKbUuPeA2yHt72PqgxmGo7UWzGbhcwEyvSXcwvZKLzdv+
         +oRob2KrZBieVgRNVTCR5gjstcNQoK/YDsUcuTs4yCwxr1t3t0m5V4GqVGW1bhwb/eEz
         oPJbe00vYNcy7k3tVDnS2S/BoayLoy23fT5wHaCQREhMm7mt4hXBWXPzGYhrjSeAauFw
         l3TFToBXy3QnAUwQuBt69gtatJ1PkLtZsvXMMJBaiTglMo/V5UIPWPrLEobw9onMdEa+
         +VTbguX/M1h+DNn7QORB4KUFv3oaJ+u5nlen0V4Exx9vu2QsgmG2q+xm2DELBOaUIRWR
         8HNg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786169836; x=1786774636; darn=lists.linux.dev;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Q3W+3Yc3yRT60qpg5AQRoV0tpQ9QhTJBuN1JdrJjQTo=;
        b=UrEPh6u/PbcxaZKWOfzsienErgtPAo7bdTBL+P9UaThAQzyJqrP6CvMIeaqmBY3seR
         ua7OXL9yCQ33ddJ+p7zD7Q6+zA3l9dCTMceOxwSdi0czOY7ao0Fuy8hm56eZNd4aMhPE
         nJFBlRhARVzomPrK+2PMZM/qD0FB1vqSBwYxVB9DebtoHQDuVnrnsI8/y9yOVKeOEyT3
         AeIYxlfk6tqt11nR17tXI77bpF+hbcootMllnB9kR9LQKVNC3jJb/Xacvpf7Av81RVCS
         pkirstKV56tiw7bo7AFsMxMSkscN9kFGjZ34XyZFMhZdetpUgFXauVVDrHjyetds9dI6
         6Lcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786169836; x=1786774636;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Q3W+3Yc3yRT60qpg5AQRoV0tpQ9QhTJBuN1JdrJjQTo=;
        b=ceIXBwdGfenOJ9ZVvr68kqFK4bHo2hKs1AcZIWwkj4JVNiWhM4Ubwhzer4YhVxSOxi
         joDzW26AH3TdMCqvW42X3WM+NgycTDd4KT5z4lhxqfXZ8ZC5YUy3wvcf4JYPXHY8rTUD
         T8LKccU3MascxDhNR7ddo1u1o+HAnFmo9OXD+qqywN4LbQjLD/opS5nuSlFjeDbn04I5
         7wdt237u5ZCNOs4hkIpbovwyAOcB8VRubuzU1GfBhP/ZNCr2ADt6wgnME10RpBiwGiSj
         8kYypcqS5FBN8zU5Fp7qE6rP86VlIgWkE8DfLjr6ibXy5yLbCp+VGwVa8CRcLt9mv/T3
         37mw==
X-Gm-Message-State: AOJu0Yy8bvZGp3xwvCTwT1k7PdiZVEoHQ4cH6Fx2v4U1ANaVm8ruf0At
	3NoPNL/aqCUoSaA/gIiGLYUINTizKcQ2xTC5rgNRhu8+l9JkJtoXiLCd7aX/gb69SXPJszqygKW
	YDeYsOgpQPVmj4dne9kHL3Y9C5B/Ow22nbOKQ
X-Gm-Gg: AR+sD11fQ1vyVPg2v7AMxI7besw1UrUzNsT+fhliSBnK/RtCZ6vaTNjJNJ83uDT/aSf
	5qvMqP6P/ywX8j1sjZcX39ttg+JvKGG4JIbXeMbB/Lux41X9KwzWDDPsAf+XEeet5vn0owLkmhF
	ODfac3/JRZbnP6gzuJkXdMATJxZy59iPgZ01YUrsZvLwWsWAxnUJdy+NHYblmpzsnsHNkHY/TmK
	25H+iTaYmGSlono1qPpHU+X8jlFWUXS0Rfat7A95cRvtsVL+GDhu5oUNN2UuGphYpe+7hlttc1c
	k7ndle9IQlRIa97AVxbvGXJAbS2d/diLNSQms49caJ+aXzY=
X-Received: by 2002:a05:690c:6a0d:b0:81d:c233:aea0 with SMTP id
 00721157ae682-8225ba2b29emr86316747b3.18.1786169835894; Fri, 07 Aug 2026
 23:17:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: C Smith <csmithquestions@gmail.com>
Date: Fri, 7 Aug 2026 23:17:04 -0700
X-Gm-Features: AUfX_mz3Xwx9EqvNBD7KmRW0Up1UZUvjw_sID-MoPmbYbfiRB9dwTnvXrIDQnMo
Message-ID: <CA+K1mPGqEW4d+HOhyaNhDLe3tv9TFgcUtTFa6hH_7SPq892pXA@mail.gmail.com>
Subject: Cobalt scheduler preemption behavior
To: Xenomai <xenomai@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"

I am using Xenomai 3.1, Cobalt kernel 4.19.229 X8664  (I know it's old
but this is a legacy system our company still develops).  I am
wondering about expected Cobalt scheduler behavior on a single core. I
have set isolcpus to reserve core 1, my first real time task sets
affinity to core 1, the priority is 99.

ret = rt_task_create(&main_task, "my_rt_task", 0, 99, T_JOINABLE);
CPU_ZERO(&cpus);
CPU_SET(1, &cpus);
rt_task_set_affinity(&main_task, &cpus)

Then I do the same with a second RT task, giving it the same priority
(99) and same CPU core 1 affinity.

First Question: If the first RT task is executing, and the second RT
task wakes up from a sleep, can I expect the scheduler to preempt the
first RT task to run the second RT task on that same CPU core?

I put DIO pulses around both tasks and the oscilloscope says 'yes',
the second task preempts the first. I'm a bit confused about that, as
I expected FIFO non-preemptable behavior from the Cobalt kernel.  ie:
I thought the first task would finish, then the second task would run.

Second question: Is there a way to configure the Cobalt kernel, or my
two RT tasks, such that they can't preempt one another, but when there
is contention the first to run is allowed to finish before the second
runs?

thanks,
-C Smith
