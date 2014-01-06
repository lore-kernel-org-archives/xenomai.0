MIME-Version: 1.0
In-Reply-To: <52CB0B6A.8080405@xenomai.org>
References: <CAFnctWFSGJc0Q6ebZ0zBhxRmFEwkvCYKinAEgD-xzcCbfLaPBg@mail.gmail.com>
 <52C7CF1E.2050404@xenomai.org> <52C85088.7020501@xenomai.org>
 <52C86093.4000609@xenomai.org>
 <CAFnctWG1QoQ=f9JCsdxAoU25mc797fKoT9dVS_DdZFRcQ5CP3A@mail.gmail.com>
 <52C891C1.2090007@xenomai.org>
 <CAFnctWFb-dNtNDGf0kckejhQ+tFAj2hBw3gm5Xv8DoALi6f26g@mail.gmail.com>
 <52C949D6.6090904@xenomai.org> <52C9B255.7030702@xenomai.org>
 <52CA622D.806@xenomai.org>
 <CAFnctWGs-mqukTTujenvex9Doq0DoJ_ohFEPDjd7ECYRzu6tpw@mail.gmail.com>
 <52CB0B6A.8080405@xenomai.org>
Date: Mon, 6 Jan 2014 13:25:25 -0800
Message-ID: <CAFnctWGxXWKL2bdnf4s-Xubw2jGe249uSXim9oqLbiSPqxeXFA@mail.gmail.com>
From: Nima Nourozi <n.nourozi@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Xenomai] rtdm_task_init call freezes the system
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On Mon, Jan 6, 2014 at 12:00 PM, Gilles Chanteperdrix <
gilles.chanteperdrix@xenomai.org> wrote:

> On 01/06/2014 08:10 PM, Nima Nourozi wrote:
>
>> [<c00250a0>] (do_undefinstr+0x0/0x1c8) from [<c002abd4>]
>> (__und_svc+0x54/0x80)
>>
>
> What is interesting is what triggers this __und_svc. Will check if I can
> reproduce this bug on at91sam9263. Could you try and disable CONFIG_KGDB in
> the mean-time?
>
> Regards.
>
> --
>                                             Gilles.
>

Thanks for the quick reply Gilles. I can verify that CONFIG_KGDB was never
enabled.
