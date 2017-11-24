MIME-Version: 1.0
From: Greg Gallagher <greg@embeddedgreg.com>
Date: Fri, 24 Nov 2017 00:37:52 -0500
Message-ID: <CALLqZ8TWgsZAzRuYBQ1gd4s5KO_wO_aaY+UyVEMDBw5k9rSQqQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Xenomai] Gpio-core question
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Xenomai@xenomai.org" <xenomai@xenomai.org>

Hi,
  I'm finishing up my work on a patch to add a RTDM gpio driver for
the zynq-7000 platform.  I ran into a situation where I needed to call
gpio_request in gpio-core because the zynq gpio driver uses the
gpio_request function to enable the gpio pins on the board.
    A side effect that I found when testing is that the driver will fail to
load
if another application has exported a gpio pin via sysfs and likewise sysfs
won't allow anyone to export gpio pins once the rtdm gpio driver has been
loaded.
My implementation calls gpio_request on each pin as they are  registered
under /dev/rtdm.
    I'm not sure if the above is an issue or not, if the RTDM driver has
claimed the
gpio pins then I think it would make sense for them not to be accessible by
applications
via sysfs.  If my assumption is not correct then maybe one option could be
to only call gpio_request on each pin as need, maybe via ioctl?

Any guidance would be appreciated,

Greg
