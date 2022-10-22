Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC2C3D71
	for <xenomai@lists.linux.dev>; Sat, 22 Oct 2022 17:16:25 +0000 (UTC)
Received: by mail-pj1-f44.google.com with SMTP id f9-20020a17090a654900b00210928389f8so9465728pjs.2
        for <xenomai@lists.linux.dev>; Sat, 22 Oct 2022 10:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/VEzrpZ/XHgCK6mVf1tYWiWrTu8VTDYqbRd4wS599qg=;
        b=VcMSe2F76H3BPcIzYGaw5CrJz/keqvDgg+JHaLGlGD1IizzSIEBI9rOPxG+G2Bx1YW
         6bDhJP768Zev/GILDgp/QEQEc26tQ0evcFF8+R6mfhsjFBItPQWjY6RBDAiceNribWE6
         YleSq4Kx60awbvwTsn4wRrNNQiR6cPpOw+gKC6A3pwgnKMaSYgDETuY+MKsEsZAN3SKz
         tf0PtWG3/msr7TLZBr4oUy+YVz2GqqPkKQv+mAuJ5HP5016ynoycZS6licWU/mu4sSBh
         /UN4Lm+xcf7zMgggZ1Y7IHBsTSNudqwJUE7h1LXWHCrWIsNT+3K9o11Qu2seBQCrnMtz
         xfDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/VEzrpZ/XHgCK6mVf1tYWiWrTu8VTDYqbRd4wS599qg=;
        b=XOtGskOc+YDYSVY9AuBR4Rd2AEFzxbIoRdP90LUtkSUG1Xuy7J8W/X9M8JG5IJyU5i
         UmcUiJsFGJjso0TZwhlVbt92AkQIbvVC/ct647KdWS8QLywANaIHdAUr7DePQoBc6WZ8
         rlNF+//BCGUfB5nOPyKfiPQXdFp+PspOum5GxHIq01cbenktDGTgsrzeoFolOOkyk/8u
         k4P7RSp1E+J4QosqFoWGjeZ+HPJu85qOwaudfn3HAxbXQj5SrojQbnhDfaK45tl6u5B6
         ZgKriOyXqwgHqXk0F9Yy8wWqtk0PdT2OvQkfW0RWE0eXtWRnbNU6/myOnbFvtmrbp2+X
         jeuw==
X-Gm-Message-State: ACrzQf3o62OMeN/6STR5rCWm0BtQUNrpj78vlQ51aD6U5Iz0Ht5hsABF
	Ved7i9wu2X6APAkJrWj3OXR7Ud0lPUup2fCDlw/bwZLuJkA=
X-Google-Smtp-Source: AMsMyM6dMUhEmsL6s+v5dtZHFOBa2Y41RXwtLNFheMNMTPoLKaYi/z4ZiK+QnSke6BCNCC+i3grm0ykRtHcgYaYVq6o=
X-Received: by 2002:a17:902:ecd2:b0:183:7b19:eb8c with SMTP id
 a18-20020a170902ecd200b001837b19eb8cmr25159903plh.11.1666458984711; Sat, 22
 Oct 2022 10:16:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAH0t8y31sXMGTmmAvLc5Z=wRYNbZoNhiv-KCRj5b941QSJmt=A@mail.gmail.com>
 <babd3769-0cb0-2c8a-8433-10c95ecfc15e@siemens.com>
In-Reply-To: <babd3769-0cb0-2c8a-8433-10c95ecfc15e@siemens.com>
From: =?UTF-8?B?VGFtw6FzIFBhw6Fs?= <paal.tam@gmail.com>
Date: Sat, 22 Oct 2022 19:16:13 +0200
Message-ID: <CAH0t8y1URX9Ckqwk-PxDMiU66qAWFhXQPxvFsGRrH4vN5nfo=g@mail.gmail.com>
Subject: Re: I need advice on thread scheduling policy.
To: xenomai@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> On 21.10.22 14:21, Tam=C3=A1s Pa=C3=A1l wrote:
> > Dear All,
> >
> > I am using Xenomai 3.2.1 and a Dovetail patched kernel on an x86 PC.
> >
> > My application has about 30 threads. 3 of them are time critical. The
> > low priority threads are interact with the time critical ones, using
> > semaphores for data synchronization. The scheduling policy of these
> > time critical threads are SCHED_RR to be Xenomai threads. The others
> > are SCHED_OTHER so (in my understanding) handled by the Linux
>> scheduler.
>>
>> Is this the right solution, or should I make all threads to be Xenomai t=
hreads?
> >
>> What is the best practice to get the lowest latency for the time
>> critical threads? To get some load off of the Xenomai scheduler (by
>> removing the not time critical threads to Linux scheduler) or keep all
>> threads as Xenomai threads?

> The best latency you generally get via
> - having RT threads on isolated cores, doing as little other stuff
>   as possible there
> - using wait-free algorithms for the RT side to exchange data with the
>  non-RT side

> Jan

Thank you for the fast response!
I have 6 CPU cores. I isolate Linux from the upper four using the
"isolcpus" kernel parameter.
I "move" the RT threads to the upper two cores via pthread_setaffinity.
I "move" the non-RT threads to the 3rd and 4th cores the same way.
The question was if I should keep the non-RT threads in the Linux
domain, or make them to be RT threads (by changing the scheduling
policy to SCHED_RR) ) with lower priority than the time critical RT
threads? The first might introduce interaction between Linux and
Xenomai, the second one puts more load on the Xenomai scheduler. Which
one is the better approach?
Thak you,
Tamas

Jan Kiszka <jan.kiszka@siemens.com> ezt =C3=ADrta (id=C5=91pont: 2022. okt.=
 21.,
P, 18:43):
>
> On 21.10.22 14:21, Tam=C3=A1s Pa=C3=A1l wrote:
> > Dear All,
> >
> > I am using Xenomai 3.2.1 and a Dovetail patched kernel on an x86 PC.
> >
> > My application has about 30 threads. 3 of them are time critical. The
> > low priority threads are interact with the time critical ones, using
> > semaphores for data synchronization. The scheduling policy of these
> > time critical threads are SCHED_RR to be Xenomai threads. The others
> > are SCHED_OTHER so (in my understanding) handled by the Linux
> > scheduler.
> >
> > Is this the right solution, or should I make all threads to be Xenomai =
threads?
> >
> > What is the best practice to get the lowest latency for the time
> > critical threads? To get some load off of the Xenomai scheduler (by
> > removing the not time critical threads to Linux scheduler) or keep all
> > threads as Xenomai threads?
>
> The best latency you generally get via
>  - having RT threads on isolated cores, doing as little other stuff
>    as possible there
>  - using wait-free algorithms for the RT side to exchange data with the
>    non-RT side
>
> Jan
>
> --
> Siemens AG, Technology
> Competence Center Embedded Linux
>
