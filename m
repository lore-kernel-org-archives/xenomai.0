From: =?iso-8859-1?Q?Terje_Fr=F8ysa?= <Terje.Froysa@sintef.no>
Date: Tue, 2 Dec 2014 09:28:37 +0000
Message-ID: <314E5ECDAA86314791309FA670550F89C9C51961@SINTEFEXMBX05.sintef.no>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] IRQ155 not handled. Disabling IRQ line
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Dear forum,

Question:
If a driver is deemed buggy and the IRQ disabled, why is it still serving t=
he interrupts?

Running Debian 3.8.13-bone67 and Xenomai 2.6.4

At opening call, my GPIO RTDM IRQ driver enables a GPIO line w/irq.
My user-space program issues read-requests to receive a time-stamp for each=
 irq.
The irq handler is very compact. It only reads the system time, rises a sem=
aphore if not already up and returns RT_INTR_HANDLED.

When starting (open + loop w/reads),  the dmesg log-message appears:  "IRQ1=
55 not handled. Disabling IRQ line".
It appears only once in the start.
Never-the-less, the interrupts are still handled and keep coming.

Regards
Terje Froysa

Dmesg log:
[10745.676319] RTDM IMU pin 27 - irq number 155
[10745.676326] RTDM IMU 27 - request GPIO
[10745.676345] RTDM IMU 27 - request IRQ 155
[10745.676369] RTDM IMU 27 - set IRQ type RISING_EDGE
[10745.676384] RTDM IMU 27 - init semaphore
[10745.676395] RTDM IMU 27 - enable IRQ
[10750.680486] Xenomai: xnintr_irq_handler: IRQ155 not handled. Disabling I=
RQ line.
:
200000 irqs handled, nothing logged.
:
[11745.698291] RTDM IMU 27 - close

Smail: Terje Fr=F8ysa, SINTEF ICT (Information and Communication Technology=
), N-7465 Trondheim, Norway.
Email: terje.froysa@sintef.no<blocked::mailto:terje.froysa@sintef.no> <mail=
to:terje.froysa@sintef.no<blocked::mailto:terje.froysa@sintef.no>>
Phone: +47 930 03603,
Company: Independent R&D, see <http://www.sintef.no/<blocked::http://www.si=
ntef.no/>

