MIME-Version: 1.0
From: Ashwin Narayan <ashwinnarayan1994@gmail.com>
Date: Wed, 16 Aug 2017 11:50:59 +0800
Message-ID: <CAKbLDQNBWvEbNNkU9tNqjbACqPBJ87DbVZcsXjxtdPfZbz7zDA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Xenomai] Driver Specific Options for analogy_s526
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi all,

This is a follow up to my previous mail about the analogy driver for
the Sensoray model 526 DAQ board. I have the board installed and I'm
able to use inw/outw to verify that the board is working and is
detected by the OS.

However, the board has to be at a non-standard address (0xd00) because
the default is taken up by something else. Also, I had to change the
IRQ channel to IRQ6.

The only problem is getting the driver to detect the board. I load the
xeno_analogy module using `sudo modprobe xeno_analogy` and then try to
do `sudo /usr/xenomai/sbin/analogy_config analogy0 analogy_s526 0xd00`
and I get the message that a4l_attach(analogy_s526) failed with
err=-1.

I wasn't able to find any documentation on the extra driver specific
options for the model 526 driver. The page at
https://xenomai.org/analogy-practical-presentation/ only mentions the
options for the NI devices. Basically I want to find a way to feed in
the correct ioport address and the IRQ number (if it's needed by the
driver).

Can someone point me to some resources about the driver specific
options of the model 526 driver?

-Ashwin

