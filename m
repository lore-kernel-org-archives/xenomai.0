MIME-Version: 1.0
Date: Wed, 19 Nov 2014 09:45:26 +0100
Message-ID: <CANKLDmv=sSdgO9R6cVj6VoT1MpvswS3h=W8sKpaykFaeiv0-aQ@mail.gmail.com>
From: Henri Roosen <henriroosen@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Xenomai] problems with ipipe-3.10 on i.MX6
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Xenomai@xenomai.org" <xenomai@xenomai.org>

Hi,

We are currently transitioning our i.MX6 systems from kernel
ipipe-3.0-imx6q with Xenomai 2.6.2.1 to kernel ipipe-3.10 with Xenomai
2.6.4.

The application uses interrupts from external hardware, fed into the system
by a GPIO pin interrupt.

The system behaves very in-stable with the 3.10 version. I observe kernel
crashes, kernel null pointer dereferences, timer stalls and lock-ups at
various different places. The 3.0 version runs fine.

Are there any known issues like this with the ipipe-3.10 on an i.MX6?
Any suggestions how to tackle this problem?

Thanks,
Henri
