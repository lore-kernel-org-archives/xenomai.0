MIME-Version: 1.0
References: <a7d0fed5-77f7-a20a-2d30-527dd8eca570@siemens.com>
In-Reply-To: <a7d0fed5-77f7-a20a-2d30-527dd8eca570@siemens.com>
From: Greg Gallagher <greg@embeddedgreg.com>
Date: Sat, 6 Mar 2021 07:55:09 -0500
Message-ID: <CALLqZ8Qh=zBpCif4oP3CxHGarqQtGjqEEKiUR48Pfk2TLff7jA@mail.gmail.com>
Subject: Re: [ipipe 5.4-arm] WARNING: CPU: 0 PID: 1 at kernel/irq/chip.c:55
 irq_set_chip+0xc4/0xd4
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
Cc: "Bezdeka, Florian (T RDA IOT SES-DE)" <florian.bezdeka@siemens.com>, Quirin Gylstorff <quirin.gylstorff@siemens.com>, Xenomai <xenomai@xenomai.org>

On Sat, Mar 6, 2021 at 6:55 AM Jan Kiszka <jan.kiszka@siemens.com> wrote:

> Hi Greg,
>
> the pipeline is getting greener again but I just ran into this new issue:
>
> https://source.denx.de/Xenomai/xenomai-images/-/jobs/234340
>
> Seen before?
>
> Quirin, Florian, as we were discussing whether such a warning would be
> caught already: this answers it. We just need to see it on the serial
> console.
>
> Jan



> I=E2=80=99m working on it now, I saw this when trying to reproduce the or=
iginal
issue. I have a fix almost ready to go.

Thanks

Greg
