Date: Mon, 15 Feb 2021 07:46:14 -0600 (CST)
From: Per Oberg <pero@wolfram.com>
Message-ID: <1968963516.8138258.1613396774639.JavaMail.zimbra@wolfram.com>
In-Reply-To: <CAFZ-hKiDZg9V7PhGfw_1rPFqm063-CnL0LbQ_6cc5hjZrhDq8A@mail.gmail.com>
References: <CAFZ-hKgrQwCVW8rUsMjj4ySBA_P3aYDss273B244y2x69QrOpQ@mail.gmail.com>
 <358306354.8105980.1613394904650.JavaMail.zimbra@wolfram.com>
 <CAFZ-hKiDZg9V7PhGfw_1rPFqm063-CnL0LbQ_6cc5hjZrhDq8A@mail.gmail.com>
Subject: Re: Mode Switch
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai <xenomai@xenomai.org>


----- Den 15 feb 2021, p=C3=A5 kl 14:16, Leandro Bucci guestleandro11@gmail=
.com skrev:

> Yes I want a mode switch happened, thank for your answer

> Il lun 15 feb 2021, 14:15 Per Oberg < [ mailto:pero@wolfram.com |
> pero@wolfram.com ] > ha scritto:

>> ----- Den 15 feb 2021, p=C3=A5 kl 14:00, xenomai [ mailto:xenomai@xenoma=
i.org |
>> xenomai@xenomai.org ] skrev:

>> > hi, I can't understand why if I use the memcpy function on Xenomai I d=
on't
>> > have any mode switch. Is there a function that copies two arrays and
>> > generates a mode switch?

>> I don't think I understand your question.

>> I don't see why copying data from one memory location to another would c=
ause a
>> mode switch. Not unless you use cause a page-fault or something ...

>> Or, do you WANT a mode switch to happen ?

I feel like I am missing context here, perhaps you have discussed this rece=
ntly in another thread?

But, if you are using Alchemy skin, could you perhaps do : rt_task_set_mode=
(), see [1] below, with the correct flags ?=20

>> Per =C3=96berg

[1] https://xenomai.org/documentation/xenomai-3/html/xeno3prm/group__alchem=
y__task.html#ga915e7edfb0aaddb643794d7abc7093bf

Best regards
Per =C3=96berg

