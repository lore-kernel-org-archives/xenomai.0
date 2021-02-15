MIME-Version: 1.0
References: <CAFZ-hKgrQwCVW8rUsMjj4ySBA_P3aYDss273B244y2x69QrOpQ@mail.gmail.com>
 <358306354.8105980.1613394904650.JavaMail.zimbra@wolfram.com>
 <CAFZ-hKiDZg9V7PhGfw_1rPFqm063-CnL0LbQ_6cc5hjZrhDq8A@mail.gmail.com>
 <1968963516.8138258.1613396774639.JavaMail.zimbra@wolfram.com>
In-Reply-To: <1968963516.8138258.1613396774639.JavaMail.zimbra@wolfram.com>
From: Leandro Bucci <guestleandro11@gmail.com>
Date: Mon, 15 Feb 2021 14:52:45 +0100
Message-ID: <CAFZ-hKg=m0t_dF7iqzzb=xSd15zJdyFK6kxZ9oEXcJyqJ+zXew@mail.gmail.com>
Subject: Re: Mode Switch
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Per Oberg <pero@wolfram.com>
Cc: xenomai <xenomai@xenomai.org>

What I want is to have a function that generates me mode switches

Il giorno lun 15 feb 2021 alle ore 14:46 Per Oberg <pero@wolfram.com> ha
scritto:

>
> ----- Den 15 feb 2021, p=C3=A5 kl 14:16, Leandro Bucci guestleandro11@gma=
il.com
> skrev:
>
> > Yes I want a mode switch happened, thank for your answer
>
> > Il lun 15 feb 2021, 14:15 Per Oberg < [ mailto:pero@wolfram.com |
> > pero@wolfram.com ] > ha scritto:
>
> >> ----- Den 15 feb 2021, p=C3=A5 kl 14:00, xenomai [ mailto:
> xenomai@xenomai.org |
> >> xenomai@xenomai.org ] skrev:
>
> >> > hi, I can't understand why if I use the memcpy function on Xenomai I
> don't
> >> > have any mode switch. Is there a function that copies two arrays and
> >> > generates a mode switch?
>
> >> I don't think I understand your question.
>
> >> I don't see why copying data from one memory location to another would
> cause a
> >> mode switch. Not unless you use cause a page-fault or something ...
>
> >> Or, do you WANT a mode switch to happen ?
>
> I feel like I am missing context here, perhaps you have discussed this
> recently in another thread?
>
> But, if you are using Alchemy skin, could you perhaps do :
> rt_task_set_mode(), see [1] below, with the correct flags ?
>
> >> Per =C3=96berg
>
> [1]
> https://xenomai.org/documentation/xenomai-3/html/xeno3prm/group__alchemy_=
_task.html#ga915e7edfb0aaddb643794d7abc7093bf
>
> Best regards
> Per =C3=96berg
>
