Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Date: Wed, 04 Mar 2020 10:00:37 +0100
Subject: GPIO interrupt not working on Zynq7000
Message-ID: <7231-5e5f6e00-9-3b6a0580@56070809>
From: =?utf-8?q?Fran=C3=A7ois_Legal?= <devel@thom.fr.eu.org>
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

Hello,

trying to diagnose an interrupt problem on a Zynq 7000 hardware. The en=
vironment is linux 4.4.189, xenomai 3.0.9.

I'm trying to trig some realtime thread pending on a gpio read.

At the beginning, the system would freeze if the GPIO pin was toggled, =
because the GPIO int pending status was never cleared by the existing c=
ode.
So now I don't get the system freeze anymore, however, the RTDM gpio  i=
rq handler never gets called whenever the interrupt is raised.

I'm not sure how to diagnose that. For what I could see, the IRQ is reg=
istered in ipipe domain "xnsched=5Frealtime=5Fdomain", and I'm not sure=
 if that matches "ipipe=5Fhead=5Fdomain" that is used in the =5F=5Fipip=
e=5Fdispatch=5Firq

Any help appreciated

Fran=C3=A7ois


