MIME-Version: 1.0
References: <CAFZ-hKgcskeJnaBe6+_qAZQ6TQQhyVnShHXwaE==ScSVJLtU_w@mail.gmail.com>
 <acf6f25c-0b03-35fd-cba0-6b2727daae70@siemens.com>
In-Reply-To: <acf6f25c-0b03-35fd-cba0-6b2727daae70@siemens.com>
From: Leandro Bucci <guestleandro11@gmail.com>
Date: Mon, 8 Mar 2021 11:35:58 +0100
Message-ID: <CAFZ-hKgG8grVdqO_JaTE8LZhiiXhytRuvBFoK_0g-+Ak=-JFrA@mail.gmail.com>
Subject: Re: Execution time
Content-Type: text/plain; charset="UTF-8"
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

very interesting thanks

Il lun 8 mar 2021, 11:23 Jan Kiszka <jan.kiszka@siemens.com> ha scritto:

> On 03.03.21 15:45, Leandro Bucci via Xenomai wrote:
> > Hi, I noticed a very strange but also interesting fact. When a certain
> > periodic task is executed, if the period is small (for example 0.5ms) I
> > have that the execution times are more or less constant (about 5 micro
> > seconds). If, on the other hand, the period of the same task is larger
> (for
> > example 10ms), the execution times are less predictable and range from 5
> > micro seconds to 15 micro seconds.
> >
> > How is this possible? I am using a raspberry Pi3 and the task is running
> on
> > a core dedicated to xenomai.
>
> In general, you can see cache "temperature" effects when reducing the
> period of a task: The more frequently it runs, the hotter the cache will
> be and the less likely it is that relevant content for that task has be
> evicted. But all that depends on many factors, the non-rt load, the load
> of the task itself, the caching system etc.
>
> Jan
>
> --
> Siemens AG, T RDA IOT
> Corporate Competence Center Embedded Linux
>
