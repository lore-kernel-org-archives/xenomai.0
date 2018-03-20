MIME-Version: 1.0
From: Greg Gallagher <greg@embeddedgreg.com>
Date: Mon, 19 Mar 2018 23:10:22 -0400
Message-ID: <CALLqZ8T2pFw9D8-E00H5Rn2Y2kxWoo1cxCfMVwr=jFCYK_8D+g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Xenomai] Armv7 testing update
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
   I thought I would post a quick update to some armv7 testing I was
doing while creating an image for the raspberry pi 2b board.  I've put
together a list of boards that we currently support in Xenomai (by
supported I mean we have drivers for the board) and if they boot with
the new 4.14 ipipe.

 Boards That Where Tested:
Zynq:
    MicroZed, Zybo, Zedboard, Z706
Raspberry PI:
    Raspberry Pi 2b
Beaglebone
     Beaglebone Black, Beaglebone Green

Status:
Zynq boards all boot and run the gpio driver for both the PS and PL
without issue.  No other RTDM drivers are currently supported for
Zynq.

Raspberry PI 2b boots, gpio driver, spi driver

Beaglebone has gpio issues in the 4.14 ipipe tree, looking into that
this week.  RTDM gpio drivers are almost ready to submit. Hoping to
get this done in the next few weeks.

I left out IMX which I should have time to test out this weekend.

I'll be posting the rootfs hopefully by the weekend along with 4.14
kernels for Zynq and Raspberry Pi 2B.  These pieces will end up
becoming images for people that don't want to build Xenomai from
scratch but want to developed applications.  They just need a little
more testing at the moment before they are ready for alpha release.


-Greg

