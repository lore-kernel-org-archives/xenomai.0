Date: Tue, 24 May 2016 21:01:40 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20160524190139.GO13609@hermes.click-hack.org>
References: <CAJ2oMhKbZsPqppakvnKFGi3QnniTCiTJDE3mSsYc-YRSSdV9Jg@mail.gmail.com>
 <20160524180350.GN13609@hermes.click-hack.org>
 <CAJ2oMhKB8rxwH1W6=rhzS0vREsRdrgx7gU8wcu6ooFTaf3O6pg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJ2oMhKB8rxwH1W6=rhzS0vREsRdrgx7gU8wcu6ooFTaf3O6pg@mail.gmail.com>
Subject: Re: [Xenomai] Failure with rtdm_dev_register in rtdmtest
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Ran Shalit <ranshalit@gmail.com>
Cc: xenomai@xenomai.org

On Tue, May 24, 2016 at 09:53:46PM +0300, Ran Shalit wrote:
> On Tue, May 24, 2016 at 9:03 PM, Gilles Chanteperdrix
> <gilles.chanteperdrix@xenomai.org> wrote:
> > On Tue, May 24, 2016 at 08:46:54PM +0300, Ran Shalit wrote:
> >> Hello,
> >>
> >> I am trying to do initial testing of xenomai in my system.
> >> It seems that the boot of kernel with xenomai is without any issues
> >>
> >> zynq> dmesg | grep Xenomai
> >> I-pipe: head domain Xenomai registered.
> >> Xenomai: hal/arm started.
> >> Xenomai: scheduling class idle registered.
> >> Xenomai: scheduling class rt registered.
> >> Xenomai: real-time nucleus v2.6.3 (Lies and Truths) loaded.
> >
> > So you have the same problem with Xenomai 2.6.4?
> >
> >> Xenomai: debug mode enabled.
> >> Xenomai: starting native API services.
> >> Xenomai: starting POSIX services.
> >> Xenomai: starting RTDM services.
> >> zynq> uname -a
> >> Linux 192.168.1.8 3.8.0-xilinx #17 SMP PREEMPT Tue May 24 19:05:08 IDT
> >> 2016 armv7l GNU/Linux
> >>
> >> But on trying to load rtdmtest, I get no /dev/rtdm :
> >
> > You have misread the documentation. /dev/rtdm only exists with
> > Xenomai 3, not Xenomai 2.
> >
> 
> Hi,
> 
> I see in code that it should have created device in
> /dev/rttest-rtdm%d , but I can't find such device:

The device rttest-rtdm%d may exist, but not in the filesystem in
Xenomai 2.

Anyway, if you say that rtdm_dev_register fails, this is a real
issue. So, I suggest again to try Xenomai 2.6.4, in order to be sure
that you do not have a bug that has already been fixed.

-- 
					    Gilles.
https://click-hack.org

