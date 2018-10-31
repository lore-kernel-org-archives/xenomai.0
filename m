MIME-Version: 1.0
From: Matheus Pinto <lpinto.matheus@gmail.com>
Date: Wed, 31 Oct 2018 19:00:22 -0300
Message-ID: <CAMDdWuz_CkFKsE1oo5AjLEUOEpmVNQhQxGbJ8pP7hdOPQnqONg@mail.gmail.com>
Subject: Problem when binding a queue (rt_queue_bind) on Xenomai 3
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

I am trying to simple bind a queue in a task on a executable file, where
the queue is created on another task on another executable file.
The queue is created normally, no error is sent. In both task I use the
exactly same string name to identify the queue when created in one task
(rt_queue_create) and binded in the other task (rt_queue_bind). When I try
bind the queue in another task with rt_queue_bind, a error is returned.
However, the error dont fit in anyone errors described on API, or in
"/usr/include/asm-generic/errno-base.h"  and
"/usr/include/asm-generic/errno.h" . The error value is -110.

My system is:

-Ubuntu Mate 16.04.2 (Xenial)
-Xenomai/cobalt v3.0.6
-Raspberry Pi 3 with Broadcom BCM2837

--=20
Atenciosamente*,*

*Matheus Leitzke Pinto*
Professor de Sistemas Embarcados


*Campus Chapec=C3=B3*
+55 (49) 33 13 12 44 <callto:+5549333131244>

*Instituto Federal de Santa Catarina - Campus Chapec=C3=B3*
Rua Nereu Ramos, 3450 D - Semin=C3=A1rio, Chapec=C3=B3 - SC, 89813-000
<http://www.chapeco.ifsc.edu.br>www.chapeco.ifsc.edu.br
