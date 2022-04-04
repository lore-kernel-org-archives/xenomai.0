Message-ID: <49ea6194-c0da-6039-fc96-9686bec23ad1@siemens.com>
Date: Mon, 4 Apr 2022 13:20:55 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] Alchemy: Fix rt_task_unblock() for RT_MUTEX
Content-Language: en-US
References: <20220330201614.31083-1-richard@nod.at>
 <74b8e93cc14b656f6d97bff5d6ef2c2dd606f64b.camel@siemens.com>
 <637249774.202758.1648715778757.JavaMail.zimbra@nod.at>
 <589a354736795684073a1b35b5605205e72febec.camel@siemens.com>
 <CAFLxGvyvAR5-CHPSnqt=rYEkyd=KtWGg9c69q07JjxFPKFoajg@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <CAFLxGvyvAR5-CHPSnqt=rYEkyd=KtWGg9c69q07JjxFPKFoajg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Richard Weinberger <richard.weinberger@gmail.com>, "Bezdeka, Florian" <florian.bezdeka@siemens.com>
Cc: "richard@nod.at" <richard@nod.at>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 04.04.22 11:39, Richard Weinberger via Xenomai wrote:
> On Fri, Apr 1, 2022 at 9:16 AM Bezdeka, Florian via Xenomai
> <xenomai@xenomai.org> wrote:
>>> With my changes at least the application works again and the tests
>>> on the customer side pass.
>>
>> We would need such / similar tests as well inside the Xenomai testsuite
>> to make sure we don't break it again.
> 
> I'm a bit unsure where to place the test.
> Under testsuite/ seems to be not a single alchemy related test.
> Shall I create a new folder?

There is lib/alchemy/testsuite/ - but also
https://gitlab.com/Xenomai/xenomai-hacker-space/-/issues/32.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

