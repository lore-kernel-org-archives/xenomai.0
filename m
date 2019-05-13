Subject: Re: Process "Killed" by Linux because "OOM-Killer"
References: <CAMDdWuyP7GW_H9xODCDJTGz5c3O8MTRNba=7cYvrQactuo4gVg@mail.gmail.com>
From: =?UTF-8?Q?St=c3=a9phane_Ancelot?= <sancelot@numalliance.com>
Message-ID: <bd606428-8d1a-4c4f-520a-a73d853a1eb5@numalliance.com>
Date: Mon, 13 May 2019 08:51:59 +0200
MIME-Version: 1.0
In-Reply-To: <CAMDdWuyP7GW_H9xODCDJTGz5c3O8MTRNba=7cYvrQactuo4gVg@mail.gmail.com>
Content-Language: fr
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org


Le 11/05/2019 =C3=A0 16:47, Matheus Pinto via Xenomai a =C3=A9crit=C2=A0:
> I installed Xenomai version 3.0.5 in a machine with Ubuntu 16.04 LTS.
> The machine is a Acer Netbook with the following configurations
> - CPU: Pentium Dual Core U5600;
> - Memory: 3 GB, DDR3.
>
> I am executing a process that create 5 tasks executing concurrently. Th=
is
> tasks execute normally as expected.
>
> However, when I trying execute the same executable in another terminal,=
 the
> first one is "Killed" by Linux (because of OOM-killer), and the second =
one
> is finalized with the message "Bus error (core dumped)".
>
> I tried disable the "memory overcommit" e "OOM-killer", but when I do t=
hat,
> the process doesnt started (is launched a "BUG" error).

Your program is being killed, because this program (or another in the=20
process pool) allocates anormally memory.

Your system becomes on memory low, and the kernel kills some processes .

Find the process that consume memory abnormally.

> I also tried maintan the memory overcommit and set the
> "/proc/<pid>/omm_score_adj" of the process to "-17", to that the OOM-ki=
ller
> dont kill it. But, when I trying launch the executable in another termi=
nal,
> the first one is maintened, but this second one is "Killed".
>
> I made the same procedure in a Raspberry Board with Xenomai 3.0.5 and
> Ubuntu Mate Xenial and works fine in there.
>
> Someone know what I can do?
>
>
> Atenciosamente*,*
>
> *Matheus Leitzke Pinto*
> Professor de Sistemas Embarcados
>
>
> *Campus Chapec=C3=B3*
> +55 (49) 33 13 12 44 <callto:+5549333131244>
>
> *Instituto Federal de Santa Catarina - Campus Chapec=C3=B3*
> Rua Nereu Ramos, 3450 D - Semin=C3=A1rio, Chapec=C3=B3 - SC, 89813-000
> <http://www.chapeco.ifsc.edu.br>www.chapeco.ifsc.edu.br
