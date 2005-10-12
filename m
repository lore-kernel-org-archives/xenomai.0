From: Wolfgang Denk <wd@domain.hid>
Subject: Re: [Xenomai-core] 2.4 vs 2.6 in embedded space 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 8bit
In-reply-to: Your message of "Wed, 12 Oct 2005 16:39:02 +0200."
	<434D2006.1060908@domain.hid> 
Date: Wed, 12 Oct 2005 17:00:08 +0200
Sender: wd@domain.hid
Message-Id: <20051012150008.A98AA353A4F@atlas.denx.de>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

Dear Philippe,

in message <434D2006.1060908@domain.hid> you wrote:
>
> Open question: to your opinion, is 2.6 on low-end embedded hw doomed "by design" 

Something like that.

> and why, or do you think that part of the reluctance to move to 2.6 is mostly 
> explained because 2.4 is just fine and up to the task, IOW it's kind of a "don't 
> fix if it ain't broken" perception?

Please see
http://www.denx.de/twiki/bin/view/Know/Linux24vs26
and
http://www.denx.de/twiki/bin/view/Know/Clock100vs1000Hz

The major causes of the serious performance degradation under 2.6 are
(1) the increased code size (especially the code that is running in
    interrupt context and for test switching - check for example just
    the code size of the scheduler and compar ewith it's size under 2.4),
    and
(2) the increased clock frequency.

OK, (2) has been partially fixed in the mean time by making the clock
frequency adjustable, so you can go back to the old value of  100  Hz
on  low  end  systems. The other factor remains. And yes, this is "by
design" - Linux is more and more designed for high end machines  like
fat  servers  running  thousands  of  tasks  or  other multiprocessor
systems with N GHz clocks. A MPC860 at 50 Mhz is just another world.

<joke>
I see a business opportunity to revive the 2.2 or even the 2.0 kernel
tree  development  especially  for  small   systems   wth   real-time
requirements.
</joke>

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@domain.hid
If there was anything that depressed him more than his own  cynicism,
it was that quite often it still wasn't as cynical as real life.
                                 - Terry Pratchett, _Guards! Guards!_

