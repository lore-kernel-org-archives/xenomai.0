From: Sagi Maimon <SMaimon@advaoptical.com>
Date: Mon, 4 Jun 2018 08:24:30 +0000
Message-ID: <81447d4fbbd44e3ca473502b0755813a@advaoptical.com>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] xenomai scheduling
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Xenomai@xenomai.org" <Xenomai@xenomai.org>

Hi all,
Going over the xenomai documentation and code there is something I can't qu=
ite understand.

As far as I understand :
One of the xenomai/nucleus tasks is INIT task, this task triggers the Linux=
 kernel scheduler when no other xenomai task needs the CPU time.
In the RPI system when a xenomai task migrate to secondary domain (Linux), =
the INIT task gets the migrating task priority.
That way xenomai preserve the priority scheme consistent across both schedu=
lers.

But what about Linux timer interrupt?
In case of Linux timer interrupt, ADOS/xenomai will pass interrupt to Linux=
 handling which during scheduler_tick() will invoke the Linux scheduler.
In this case a Linux process can get precedence over a xenomai task, how ca=
n it be?

I guess I am missing something, can someone explain?

Thanks,

Sagi Maimon
Manager R&D Software Oscilloquartz SA.
ADVA Optical Networking
Phone: +972 9 775 0124
Mobile: +972 54 5662632
e-mail: SMaimon@advaoptical.com
www.oscilloquartz.com
www.advaoptical.com

