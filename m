MIME-Version: 1.0
From: C Smith <csmithquestions@gmail.com>
Date: Wed, 4 May 2022 22:47:08 -0700
Message-ID: <CA+K1mPHS3UNezeo5hLOkwCP6BLQQLHX5UbQFVxQhrMtO361SCA@mail.gmail.com>
Subject: serial 16550A rx_timeout
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai List <xenomai@xenomai.org>

In my serial_config which I pass to the ioctl() that sets up my
16550A.ko serial port
I have set   .rx_timeout  = 500000
and I am doing non-blocking reads.

This indeed results in a 500us delay when reading a serial port with
no incoming bytes, which I can measure precisely on an oscilloscope (I
have a DIO port pulse depicting the duration of the read()).

This is wasted time in my (RT userspace) app during the read() when
there is no serial traffic on a particular port, and I have many
serial ports. But why must I decide how long to stall the RT process
with a timeout? Can't read() return immediately if there is no data in
the device ?

Must I use an ioctl with RTSER_RTIOC_GET_STATUS to inspect the UART
LSR for data available?

(This is a RT userspace app on Xeno 3.1.2, kernel 4.19.229, intel I5,
16550 compat UART)
thanks,   -C Smith

