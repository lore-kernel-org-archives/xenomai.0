MIME-Version: 1.0
Date: Sat, 28 Nov 2015 14:38:28 -0800
Message-ID: <CAK4EZFT_wVtDGhQe+ZdgJTL2nVoqykBM5J4T0=Fw8iijGZ1G4Q@mail.gmail.com>
From: Adam Vaughan <vaughana@umich.edu>
Content-Type: text/plain; charset=UTF-8
Subject: [Xenomai] Raspberry Pi Real-Time Firmware Issue
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hello,

I've seen a fair amount of Raspberry Pi related discussion on this mailing
list lately, so I thought I'd mention that a real-time latency issue was
fixed in the recent firmware ed611df.

The issue caused disable_pvt not to work on both the RPi 1 and 2 since the
October 6th, 2014 firmware release.  Without disable_pvt, the chip will
stall for ~16 microseconds every half second.

A description is available here:

https://github.com/raspberrypi/firmware/issues/497

-Adam
