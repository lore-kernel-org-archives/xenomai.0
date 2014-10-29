MIME-Version: 1.0
In-Reply-To: <20141029061655.GA14496@sisyphus.hd.free.fr>
References: <20141005223051.GN14975@sisyphus.hd.free.fr>
 <CACreCVLQsaq01vsNA_V_bu9_NyMCTwZTiZJo2sFXJHgaaVjQVg@mail.gmail.com>
 <54365E17.3020102@xenomai.org>
 <CACreCV+QtwuhhGeFpnuLP-6Y1FfLCQHqNkrzyfwgqEgrxXU9eQ@mail.gmail.com>
 <5436607B.7090609@xenomai.org>
 <CACreCV+HdWC9Deysy2miL2NZ65RFVRRk87uG9rBaUBrn=hhqag@mail.gmail.com>
 <5436A64B.90705@xenomai.org>
 <CACreCVJUPiiX_7733g1EWZCVmUH0oFWhLknhKB2K8se1fi4a1g@mail.gmail.com>
 <20141022062825.GC29673@sisyphus.hd.free.fr>
 <CACreCVJSytzK85ANWmwWjctBpJfEr1b916R6dNPmSGugN_vRLA@mail.gmail.com>
 <20141029061655.GA14496@sisyphus.hd.free.fr>
Date: Wed, 29 Oct 2014 15:24:52 +0800
Message-ID: <CACreCVL2OyGYeWSOPAxR3rWG_RWiN3BAcPck1VyTMjyrASyNoQ@mail.gmail.com>
From: GP Orcullo <kinsamanka@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] Switchtest failures on ODROIDU3
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

On Wed, Oct 29, 2014 at 2:16 PM, Gilles Chanteperdrix
<gilles.chanteperdrix@xenomai.org> wrote:
> On Wed, Oct 29, 2014 at 09:23:16AM +0800, GP Orcullo wrote:
>> Exynos is not using the arm global timers.
>
> I do not understand what you mean... You said you had problems
> when the global timer was shared with Linux, this patches tries to
> address that by not remapping the global timer for xenomai, and
> sharing the mapping defined by Linux. And now you say Exynos is not
> using the global timers? You will have to explain a bit more than
> that... I quote what you said:
>
>> >> The problem was traced to the tsc emulation,  the counter somehow gets
>> >> messed up when the global timer is shared with Linux.
>
>

Sorry, I was referring to the global timer that exynos uses - MCT,
multi core timer.

>>
>> I'm still experiencing some intermittent "rcu_preempt detected stalls".
>>
>> Maybe I'm dealing with more than one issue here.
>>
>
> I would tend to prefer solving them one by one, and from where I
> stand the global timer issue is not solved.
>
> --
>                                             Gilles.

-- 
GP Orcullo

