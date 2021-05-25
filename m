MIME-Version: 1.0
References: <PR3PR02MB6202C5373D6CECC72EBF45DAD12B9@PR3PR02MB6202.eurprd02.prod.outlook.com>
 <CADYdroOAiKwD_um-ONn=UfNQrOxjs0fM-7ozhUNc18jUQX9cQw@mail.gmail.com>
 <AM7PR02MB6194C2E06B14077092AA06A0D12A9@AM7PR02MB6194.eurprd02.prod.outlook.com>
 <CADYdroNm+rLkqXV3tjtQ94_PQM_mTiHvmx3JzJG5h2YHbRfguA@mail.gmail.com>
 <851697925.52293.1621518874455.JavaMail.zimbra@efficios.com>
 <201689209.52304.1621519010729.JavaMail.zimbra@efficios.com>
 <186729016.52398.1621523346736.JavaMail.zimbra@efficios.com>
 <CADYdroOCUu7BWqMZ1CMa5mHSJB50V1aS+98sVfgXQRPdnJTyYg@mail.gmail.com>
 <PR3PR02MB6202E077AEC8C62B022780EED1299@PR3PR02MB6202.eurprd02.prod.outlook.com>
In-Reply-To: <PR3PR02MB6202E077AEC8C62B022780EED1299@PR3PR02MB6202.eurprd02.prod.outlook.com>
From: Norbert Lange <nolange79@gmail.com>
Date: Tue, 25 May 2021 10:46:35 +0200
Message-ID: <CADYdroMmANMwnkfVMUOJuFJ-=_ggnE_4u=qoFSsdtgk_1SkTEQ@mail.gmail.com>
Subject: Re: [lttng-dev] LTTng - Xenomai : different results between
 timestamp-lttng and rt_time_read()
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: MONTET Julien <julien.montet@reseau.eseo.fr>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, lttng-dev <lttng-dev@lists.lttng.org>, Jan Kiszka <jan.kiszka@siemens.com>, Xenomai <xenomai@xenomai.org>

Am Fr., 21. Mai 2021 um 12:13 Uhr schrieb MONTET Julien
<julien.montet@reseau.eseo.fr>:
>
> Hello Mathieu, Norbert and Jan,
>
> Thank you for all of your explainations and the overview of the system.
> No I didn't change the ipipe patch for the vDSO, I may try this.
> If I have correctly understood, this patch prevents Cobalt from entering in a deadlock when the kernel is using the vDSO and the program interrupts the kernel at the same time. On which kernel does it word (aroubd 4.19) ?
> I currently try to avoid kernel 5.4 because I remember I faced some boot issues (but it is on another topic).

That patch was for 4.19 AFAIR, but its specific to x86. The Linux
kernel cleaned up the vdso handling to have a common base with some
5.x version,
but back then its been separate for each arch

>
> Here the issues i faced (drawn on TraceCompass). Are these the deadlocks we are talking about ?
> https://postimg.cc/BP4G3bF0 (on 11:02:56:380)
> https://postimg.cc/q6wHvrcC

Nope, if you get such a deadlock, then your only hope is Xenomai's
Watchdog killing the process.
It should happen very rarely (but thats not an argument if your
software should run for years).

Norbert

