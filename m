MIME-Version: 1.0
From: Matheus Pinto <lpinto.matheus@gmail.com>
Date: Sat, 11 May 2019 11:47:24 -0300
Message-ID: <CAMDdWuyP7GW_H9xODCDJTGz5c3O8MTRNba=7cYvrQactuo4gVg@mail.gmail.com>
Subject: Process "Killed" by Linux because "OOM-Killer"
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
To: xenomai@xenomai.org

I installed Xenomai version 3.0.5 in a machine with Ubuntu 16.04 LTS.
The machine is a Acer Netbook with the following configurations
- CPU: Pentium Dual Core U5600;
- Memory: 3 GB, DDR3.

I am executing a process that create 5 tasks executing concurrently. This
tasks execute normally as expected.

However, when I trying execute the same executable in another terminal, the
first one is "Killed" by Linux (because of OOM-killer), and the second one
is finalized with the message "Bus error (core dumped)".

I tried disable the "memory overcommit" e "OOM-killer", but when I do that,
the process doesnt started (is launched a "BUG" error).

I also tried maintan the memory overcommit and set the
"/proc/<pid>/omm_score_adj" of the process to "-17", to that the OOM-killer
dont kill it. But, when I trying launch the executable in another terminal,
the first one is maintened, but this second one is "Killed".

I made the same procedure in a Raspberry Board with Xenomai 3.0.5 and
Ubuntu Mate Xenial and works fine in there.

Someone know what I can do?


Atenciosamente*,*

*Matheus Leitzke Pinto*
Professor de Sistemas Embarcados


*Campus Chapec=C3=B3*
+55 (49) 33 13 12 44 <callto:+5549333131244>

*Instituto Federal de Santa Catarina - Campus Chapec=C3=B3*
Rua Nereu Ramos, 3450 D - Semin=C3=A1rio, Chapec=C3=B3 - SC, 89813-000
<http://www.chapeco.ifsc.edu.br>www.chapeco.ifsc.edu.br
