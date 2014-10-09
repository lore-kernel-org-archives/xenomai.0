MIME-Version: 1.0
In-Reply-To: <54365E17.3020102@xenomai.org>
References: <542EA6A2.306@xenomai.org>
 <CACreCVKe_nw=6p1xQkbziPne4cW74kx0EtUWG0kC4roS7+w+yw@mail.gmail.com>
 <20141003191454.GF9452@sisyphus.hd.free.fr>
 <CACreCVLi=QT72p0pca76_7tsJn+TazdQjyy7NHW_NwfxCYbuKA@mail.gmail.com>
 <20141003224829.GA6850@sisyphus.hd.free.fr>
 <CACreCV+TDzXxX=e7MpscYcGn1sTTye9N-mED0iPfqVB9Zm4xdQ@mail.gmail.com>
 <20141004113116.GC7596@sisyphus.hd.free.fr>
 <CACreCV+ok_Ogd3iFPGNS3n640hdLQC3C_Pyzz=w80St-7buXWQ@mail.gmail.com>
 <20141005220404.GL14975@sisyphus.hd.free.fr>
 <CACreCVJFa6FB=3WR_OuMvACeYOWaA035T4KK7dFg8vHhyqkz8w@mail.gmail.com>
 <20141005223051.GN14975@sisyphus.hd.free.fr>
 <CACreCVLQsaq01vsNA_V_bu9_NyMCTwZTiZJo2sFXJHgaaVjQVg@mail.gmail.com>
 <54365E17.3020102@xenomai.org>
Date: Thu, 9 Oct 2014 18:12:55 +0800
Message-ID: <CACreCV+QtwuhhGeFpnuLP-6Y1FfLCQHqNkrzyfwgqEgrxXU9eQ@mail.gmail.com>
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

On Thu, Oct 9, 2014 at 6:06 PM, Gilles Chanteperdrix
<gilles.chanteperdrix@xenomai.org> wrote:
> On 10/09/2014 12:02 PM, GP Orcullo wrote:
>> On Mon, Oct 6, 2014 at 6:30 AM, Gilles Chanteperdrix
>> <gilles.chanteperdrix@xenomai.org> wrote:
>>>
>>> It means that Linux was interrupted by Xenomai during its timer
>>> interrupt, and that Xenomai interrupted it for 280us. This may
>>> happens with switchtest if it has a really long chain of context
>>> switches. If you want to check what happened, enable the I-pipe
>>> tracer, and trigger a trace freeze right before this message.
>>>
>>> --
>>>                                             Gilles.
>>
>> One more piece to the puzzle: disabling CONFIG_IPIPE_DEBUG_INTERNAL
>> causes the system to lockup.
>>
> How do you know this is related?
>
> --
>                                                                 Gilles.

Sorry, I quoted the wrong message.

If CONFIG_PREEMPT is disabled and CONFIG_IPIPE_DEBUG_INTERNAL is not
disabled, the system works fine.

-- 
GP Orcullo

