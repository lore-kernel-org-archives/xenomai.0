From: Romain Lenglet <rlenglet@domain.hid>
Subject: Re: [Xenomai-core] Re: [Xenomai-help] General Xenomai / RTAI Skin
	Usage Questions
Date: Tue, 1 Nov 2005 16:52:23 +0900
References: <OF8F0700EC.A1D80BF4-ONC12570AB.004AE3CB-C12570AB.005254F3@domain.hid>
	<200511011227.03173.rlenglet@domain.hid>
	<436718FB.8090207@domain.hid>
In-Reply-To: <436718FB.8090207@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511011652.24312.rlenglet@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

> Actually, Dmitry and I are discussing IRQ sharing between
> real-time driver, not across the RT/non-RT border.

Sorry, I misunderstood.

> The latter case almost always a no-go and should rather be
> solved at hardware level by rearranging the IRQ usage (where
> possible...). The problem is that the non-RT IRQ handler has
> to be called just after the RT handler to make the non-RT
> hardware release the IRQ line. But this cannot be guaranteed
> due to other RT activity and creates an ugly priority
> inversion.
>
> That your system just crashes is likely due to the RT driver
> not being prepared to share IRQs with non-RT. What driver are
> you using?

RTnet's 8169 gigabit ethernet driver, and RTnet's tulip driver.

The problem, on common x86 hardware, is that with only one PCI 
bus and several devices (e.g. I use 4 PCI network cards drived 
by RTnet, in one PC), sharing IRQ seems unavoidable.
The only possible workaround on my test machine is to disable as 
much as I can (USB, sound, serial ports, non-rt ethernet cards, 
etc.) to avoid sharing.

-- 
Romain Lenglet

