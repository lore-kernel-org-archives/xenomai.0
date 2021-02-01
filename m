MIME-Version: 1.0
References: <CAFZ-hKhx9FFTP1wdb2OK9oRtML8Aot2kNrkfzw74JPOfam_OKg@mail.gmail.com>
 <43ef01e1-37b0-f65c-785c-e240017f4974@siemens.com>
In-Reply-To: <43ef01e1-37b0-f65c-785c-e240017f4974@siemens.com>
From: Leandro Bucci <guestleandro11@gmail.com>
Date: Mon, 1 Feb 2021 09:15:32 +0100
Message-ID: <CAFZ-hKgbiY9GTtBGFQU=YiD6S4VoYwQrkOaAG27yokrdaK+jkA@mail.gmail.com>
Subject: Re: Xenomai scheduler
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@xenomai.org

great thanks for the reply

Il lun 1 feb 2021, 09:11 Jan Kiszka <jan.kiszka@siemens.com> ha scritto:

> On 01.02.21 08:47, Leandro Bucci via Xenomai wrote:
> > hi, I wanted to know how the Xenomai scheduler works. If I assign three
> > tasks to processor CPU 0 and four tasks to processor CPU 1, is it
> possible
> > that the tasks will run simultaneously (one on CPU 0 and one on CPU 1)?
> >
>
> Yes.
>
> Xenomai does no load balancing, i.e. it does not touch the affinity you
> assign - or the one Linux picked during startup if you do not assign
> anything.
>
> Jan
>
> --
> Siemens AG, T RDA IOT
> Corporate Competence Center Embedded Linux
>
