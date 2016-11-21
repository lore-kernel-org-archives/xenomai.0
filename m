MIME-Version: 1.0
From: "Florian G." <florian.r.groeger@gmail.com>
Date: Mon, 21 Nov 2016 01:46:08 +0100
Message-ID: <CAPdz0-x1Vg2LU-n9BzU4Ozt=AetkZNZYG6fZ849boWSrBgFHFg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Xenomai] UART RT-Driver for BBB
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hey,

I'm using Xenomai 2.6.5 on a 3.8.13 kernel on an ARM 32-bit(BeagleBone
Black).

I have a sensor connected via UART which I have to read in a RT_TASK.
Therefore, I need a RT-Driver for that. Sadly I wasn't able to install
xenomai's xeno-16550A driver because setserial does not work[1]. So, my
first question is:
Does an alternative for setserial exist? If not, can I get the io, irq,
and so on from somewhere else? Maybe I could use the In-Kernel Driver
Setup.

I saw some discussion about that topic in the mailing list already but I
am not sure if the problem was ever resolved.[2] Any hints here would be
highly appreciated.

So the solutions I have in mind right now are, in case I won't be able to
install xeno-16550A are:
1. Reading directly from memory by using mmep
2. Developing my own RTDM.
(3. Using on of the PRUs)
Did I forgot something that I could try as well?

I never had to write my own driver, meaning I am also completly new to
writing my own RTDM. In case I have to develop my own RTDM what is the
best approach here:
1. Just writing a RTDM, which basically only calls the working driver?
(Not sure if this is possible)
2. Using an existing driver, i.e. omap-serial, and change it to a RTDM

I know I have a lot of questions, but this stuff keeps me busy for
a week now. Again any hint would be highly appreciated!

Thanks in advance,
Florian

[1]https://groups.google.com/forum/#!topic/beagleboard/uxa40iKuGEY
[2]http://www.xenomai.org/pipermail/xenomai/2014-November/032201.html
