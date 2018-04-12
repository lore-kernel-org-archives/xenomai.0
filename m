Date: Thu, 12 Apr 2018 10:20:09 -0400
Message-ID: <20180412142009.qnow5n5652xngbd5@csclub.uwaterloo.ca>
References: <CAOuPNLhmVjMMm80Xmu9DKCAD7QqyRZ_qBbnmCi38nKX9defDVQ@mail.gmail.com>
 <fg9ar1ooobcbsnuj1ib0ko69.1523444325709@embeddedgreg.com>
 <20180411134504.c5pswbha72ywtc7l@csclub.uwaterloo.ca>
 <CALLqZ8SApBe3Zfix9p6vfFH-S1_20j7d5_A9kve3iL3H+F2HYQ@mail.gmail.com>
 <CAOuPNLhVJ2wFG_nZ4+c4BPpX+idyDd-fNVVb9s7izej-qajcbA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOuPNLhVJ2wFG_nZ4+c4BPpX+idyDd-fNVVb9s7izej-qajcbA@mail.gmail.com>
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Subject: Re: [Xenomai] How to use rtdm serial driver on beagle bone
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Pintu Kumar <pintu.ping@gmail.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Thu, Apr 12, 2018 at 11:56:20AM +0530, Pintu Kumar wrote:
> In BeagleBone there is no direct serial interface available.
> However, we use Serial over USB (ttyUSB0) to connect to minicom.
> In this case it is possible to use this interface over Xenomai and
> check latency improvement?

I thought that was only true on the black.  I think the white had a real
serial port.  At least the original explicitly lists "Black removes the
on-board USB JTAG and serial adapters".  So I believe that had a USB to
serial adapter on board connected to a UART.

-- 
Len Sorensen

