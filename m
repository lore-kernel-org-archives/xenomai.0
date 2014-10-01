MIME-Version: 1.0
In-Reply-To: <CAKuM+oJ=SPaUGiUWMX2+8NwtEOSCtLOf+0EX9osyOQ0Oze2gpQ@mail.gmail.com>
References: <CANdzn7OYs4n0qjvpdKXM72cZM=AMy_1sBEVP7_P8S-56FJot3A@mail.gmail.com>
 <0d060e3cb01fa61faf28a22cf770bfd7@grandegger.com>
 <CANdzn7PYpjy-4h5upYf=39L-t+5dSQ0W1h6oW+UOHGJ+2=XJcg@mail.gmail.com>
 <CANdzn7OmiO_7T2bQN-VH=hwBAnz7TRQBtyn=hZaknB5CfxZRTw@mail.gmail.com>
 <CAKuM+oJ=SPaUGiUWMX2+8NwtEOSCtLOf+0EX9osyOQ0Oze2gpQ@mail.gmail.com>
Date: Wed, 1 Oct 2014 16:55:16 +0300
Message-ID: <CANdzn7MgUYd6mBXu=W1joLXw1OHhw1x45FsstXsN4DwYey4CGw@mail.gmail.com>
From: Jason Sarantopoulos <jasonsaras@gmail.com>
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
To: =?UTF-8?Q?Adolfo_Rodr=C3=ADguez_Tsouroukdissian?= <adolfo.rodriguez@pal-robotics.com>
Cc: xenomai <xenomai@xenomai.org>

Thank you Adolfo Rodr=C3=ADguez, it was very helpful.

I actually got lucky and I had one PCI slot with no shared interrupts, so I
just switched the position of the PEAK card and the conflict issue
resolved. I found out these simple programs:

# cat /proc/rtcan/devices # Check the device.
# /usr/xenomai/sbin/rtcanconfig rtcan0 -b 1000000 -v start # Start the
device
# /usr/xenomai/bin/rtcanrecv rtcan0 # Receive messages from canbus
In another terminal:
# /usr/xenomai/bin/rtcansend rtcan0 -i 0x000 0x00 # send a message

I sent this update in case a beginner like me deals with the same problem,
looking at the mailing list.

Regards.
JS
