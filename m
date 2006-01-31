Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 31 Jan 2006 13:28:13 +0100
Message-ID: <FDBBB5CC70676540B3EF7CFE83FD94E00430B4@domain.hid>
From: "ROSSIER Daniel" <Daniel.Rossier@domain.hid>
Subject: [Xenomai-help] Event flag anomaly
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org



Hi,

I've some problems to understand how the event flag semantic is defined.

In the example below, I just defined a RT_EVENT task which waits on =
event mask 1.
(Simply bit 1 has to be set).=20
When I do a rt_event_signal(&meteoEvents, 1) from another task, the =
blocking task
is logically waked up. Fine. On the next iteration, the event bit set is =
remaining
unchanged and the rt_event_wait() doesn't wait anymore since the event =
is activated.
(please consider the rt_event_clear as commented lines as it is). Well, =
it seems
OK. BUT, on the third iteration, the rt_event_wait() is blocking! =
Actually, the bit
set has been cleared in the meanwhile.

Looking at the rt_event_wait() code in native/event.c, it effectively =
turns out that
the bit set is cleared according to the mask, if and only if the task =
doesn't need to wait.

Please could you explain me what's the rationale behind this strange =
behaviour? I would propose that the bits
remain unchanged until a clear().  (I probably missed something in my =
reasoning).

Here is the example:
---------------------------

void meteoDataAcquisition(void *cookie) {

unsigned long receivedMask;

  while(1) {

    rt_event_wait(&meteoEvents, 1, &receivedMask, EV_ANY, TM_INFINITE);
    //rt_event_clear(&meteoEvents, 1, &receivedMask);
   =20
   =20
    printk("#Task activated\n");
  =20
  }
 =20
}
-------------------------------

And a piece of code from event.c

....
 if (((mode & EV_ANY) && (mask & event->value) !=3D 0) ||
        (!(mode & EV_ANY) && ((mask & event->value) =3D=3D mask)))
        {
        *mask_r =3D (event->value & mask);
        event->value &=3D ~mask;        --> this is not done after the =
thread has been waked up.
        goto unlock_and_exit;
        }
.....



