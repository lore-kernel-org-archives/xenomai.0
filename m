MIME-Version: 1.0
In-Reply-To: <50349F8D.3080102@xenomai.org>
References: <CAKKWdtei-4S1A_AyhAifj+HxuGcVCuNRsDUeytX=21=bB9UwbQ@mail.gmail.com>
	<50349F8D.3080102@xenomai.org>
Date: Wed, 22 Aug 2012 14:18:33 +0430
Message-ID: <CAKKWdtdwdAmcvzJcKCVoc+8QDYOpHtvq_r5QOwoQ5UXyhfqc7Q@mail.gmail.com>
From: ali hagigat <hagigatali@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Xenomai] Can we have nested interrupt handling in Xenomai?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, Xenomai@xenomai.org

Dear Gilles,

Would you please explain when a pipeline stage is stalled/unstalled? I
wonder if you can explain it in more details.
Regards

>> As far as I understood, when an interrupt comes, that interrupt is
>> disabled and the domain pipeline is stalled and then the interrupt
>> handler is called.
>> When the interrupt handler returns, the domain pipeline is unstalled.
>> Is that correct?
>
> Not quite, it depends on which domain is current and which domain the
> interrupt is for.
>
> --
>                                             Gilles.

