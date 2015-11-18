MIME-Version: 1.0
In-Reply-To: <20151118135249.GA24942@hermes.click-hack.org>
References: <trinity-3b905084-1366-4586-b761-0f15088b0d82-1447853696479@3capp-webde-bap53>
 <20151118135249.GA24942@hermes.click-hack.org>
Date: Wed, 18 Nov 2015 15:38:38 +0100
Message-ID: <CAPRPZsDn9AFciNrBESG8Tn8oWwEeQ78Hzrnd0E0rknrjY1C+WQ@mail.gmail.com>
From: Jeroen Van den Keybus <jeroen.vandenkeybus@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] rtdm_clock_read overhead/accuracy question
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

>>
>>    Is that realistic?
>
> This seems to be a lot.

It looks quite long, yes, for what should essentially be an RDTSC instruction.

Why not test without the sleep and compare two back-to-back
rtdm_clock_read()s to make sure that you're not measuring jitter from
the sleep function ?


Jeroen.

