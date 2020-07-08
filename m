Subject: Re: How can I investigate the cause of "watchdog: BUG: soft lockup"?
References: <CAAvDm6bA37PeCYST66hZniEFFLG1e7Sry408RyGxryhD2iehQA@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@web.de>
Message-ID: <f569108e-bd2e-5c45-7164-69539360923e@web.de>
Date: Wed, 8 Jul 2020 19:14:57 +0200
MIME-Version: 1.0
In-Reply-To: <CAAvDm6bA37PeCYST66hZniEFFLG1e7Sry408RyGxryhD2iehQA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?UTF-8?B?5a2Z5LiW6b6ZIHN1bnNoaWxvbmc=?= <sunshilong369@gmail.com>, xenomai <xenomai@xenomai.org>

On 04.07.20 03:56, =E5=AD=99=E4=B8=96=E9=BE=99 sunshilong via Xenomai wrot=
e:
> Hi, list
> I encountered the error of "watchdog: BUG: soft lockup" when I sent
> data through the can bus.
> Could you please give me some hint on how to investigate the cause deepl=
y?
> Thank you for your attention to this matter.

 From the backtrace, it is not yet clear to me which role Xenomai/I-pipe
plays here. Furthermore, it points to an out-of-tree CAN dri (advcan)
which makes it even harder to tell cause and effect apart.

In general, system-level tracing can help in such scenarios to gain an
overview about what is going on.

Jan

