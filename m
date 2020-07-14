MIME-Version: 1.0
References: <CAAvDm6axS26JLd173jd_7Q9zpzWACHmoxyiV5aiJ30qsVF-RyA@mail.gmail.com>
 <6301dbb7-54a4-2c47-230b-7399ef71667f@siemens.com>
In-Reply-To: <6301dbb7-54a4-2c47-230b-7399ef71667f@siemens.com>
From: =?UTF-8?B?5a2Z5LiW6b6ZIHN1bnNoaWxvbmc=?= <sunshilong369@gmail.com>
Date: Tue, 14 Jul 2020 16:14:57 +0800
Message-ID: <CAAvDm6YZwdt1T8dJUMPRq_gagR4-B6xG2mGG2s28W-kouUNNHA@mail.gmail.com>
Subject: Re: Question about NMIs and Xenomai.
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
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: xenomai <xenomai@xenomai.org>

Thank you for taking the time to answer my question.

>Neiher Xenomai nor I-pipe block NMIs. If Linux is configuring them for
>certain debugging or observation purposes, e.g. perf, they hit also the
>real-time domain.
So, the running Xenomai threads may be interrupted by NMIs. Am I right?
If it's right, should NMIs(e.g NMI watchdog) be disabled to achieve
lower latency?

Thank you for your attention to this matter.
Yours sincerely.
=E5=AD=99=E4=B8=96=E9=BE=99

On Tue, Jul 14, 2020 at 3:45 PM Jan Kiszka <jan.kiszka@siemens.com> wrote:
>
> On 14.07.20 08:52, =E5=AD=99=E4=B8=96=E9=BE=99 sunshilong via Xenomai wro=
te:
> > Hi, list.
> >
> > I have googled for a long time and read the posts on the official
> > website(besides <<Life-with-Adeos>>) carefully, but I still can't find
> > the answers which directly answer these questions about NMIs:
> > *Is it possible that NMI watchdog influences the latency of Xenomai?
> > *Is it possible that Xenomai threads(which are busy running for
> > several seconds) block the Linux domain from handling the non-maskable
> > interrupts?
> >
> > I would be grateful if somebody shed some light on these questions.
> > Yours sincerely.
> >
>
> Neiher Xenomai nor I-pipe block NMIs. If Linux is configuring them for
> certain debugging or observation purposes, e.g. perf, they hit also the
> real-time domain.
>
> Jan
>
> --
> Siemens AG, Corporate Technology, CT RDA IOT SES-DE
> Corporate Competence Center Embedded Linux

