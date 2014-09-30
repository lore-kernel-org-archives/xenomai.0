MIME-Version: 1.0
Sender: dofo79@gmail.com
In-Reply-To: <CANdzn7OmiO_7T2bQN-VH=hwBAnz7TRQBtyn=hZaknB5CfxZRTw@mail.gmail.com>
References: <CANdzn7OYs4n0qjvpdKXM72cZM=AMy_1sBEVP7_P8S-56FJot3A@mail.gmail.com>
 <0d060e3cb01fa61faf28a22cf770bfd7@grandegger.com>
 <CANdzn7PYpjy-4h5upYf=39L-t+5dSQ0W1h6oW+UOHGJ+2=XJcg@mail.gmail.com>
 <CANdzn7OmiO_7T2bQN-VH=hwBAnz7TRQBtyn=hZaknB5CfxZRTw@mail.gmail.com>
Date: Tue, 30 Sep 2014 10:30:04 +0200
Message-ID: <CAKuM+oJ=SPaUGiUWMX2+8NwtEOSCtLOf+0EX9osyOQ0Oze2gpQ@mail.gmail.com>
From: =?UTF-8?Q?Adolfo_Rodr=C3=ADguez_Tsouroukdissian?=
 <adolfo.rodriguez@pal-robotics.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Xenomai and CAN
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jason Sarantopoulos <jasonsaras@gmail.com>
Cc: xenomai <xenomai@xenomai.org>

On Tue, Sep 30, 2014 at 9:48 AM, Jason Sarantopoulos <jasonsaras@gmail.com>
wrote:

> Hi again,
>
> I recompiled the kernel to see if I didn't configure it right in the last
> time by not adding the PEAK drivers. This time when I boot to the RT kern=
el
> I got this message before the login:
> [-1.539543] Xenomai: xnitr_irq_handler: IRQ18 not handled. Disabling IRQ
> line.
>
> And when I log in, my mouse is extremely laggy and bearly moves.
>
> I do not have much experience in RT kernels. Is this an IRQ conflict issu=
e?
>

Jason,

This documentation might help:

http://xenomai.org/2014/06/what-if-xenomai-and-linux-devices-share-the-same=
-irq/


> Regards.
>
> --
> *Jason Sarantopoulos*
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> http://www.xenomai.org/mailman/listinfo/xenomai
>


--=20
Adolfo Rodr=C3=ADguez Tsouroukdissian
Senior robotics engineer
adolfo.rodriguez@pal-robotics.com
http://www.pal-robotics.com

PAL ROBOTICS S.L
c/ Pujades 77-79, 4=C2=BA4=C2=AA
08005 Barcelona, Spain.
Tel. +34.93.414.53.47
Fax.+34.93.209.11.09
Skype: adolfo.pal-robotics
Facebook <http://www.facebook.com/palrobotics1> - Twitter
<http://twitter.com/#%21/palrobotics> - PAL Robotics YouTube Channel
<http://www.youtube.com/user/PALRobotics>

CONFIDENTIALITY NOTICE: This e-mail and the accompanying document(s) may
contain confidential information which is privileged and intended only for
the individual or entity to whom they are addressed.  If you are not the
intended recipient, you are hereby notified that any disclosure, copying,
distribution or use of this e-mail and/or accompanying document(s) is
strictly prohibited.  If you have received this e-mail in error, please
immediately notify the sender at the above e-mail address.
