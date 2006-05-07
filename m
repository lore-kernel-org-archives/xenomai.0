From: Thomas Witzel <witzel.thomas@domain.hid>
Subject: Re: [Xenomai-help] RTDM driver questions
References: <050720061514.21865.445E0ED2000D33230000556922058863609C0E0301089BD2040A969B0799@domain.hid>
	<445E68C0.7060404@domain.hid>
In-Reply-To: <445E68C0.7060404@domain.hid>
MIME-Version: 1.0
Content-Disposition: inline
Date: Sun, 7 May 2006 22:02:22 +0000
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200605072202.22555.witzel.thomas@domain.hid>
Reply-To: witzel.thomas@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

On Sunday 07 May 2006 21:38, you wrote:

> Already had a look at the interfaces comedi provides for this? Do you
> know of Alexis' ongoing effort to port comedi over RTDM? There is some
> code in the Xenomai SVN as a branch. I'm not up-to-date with its
> development, but if you are interested, I guess Alexis will be happy to
> comment on this.
Yes, I did look at comedi. The driver for this project will however be very 
specialized and comedi wouldn't easily allow the implementation of what I 
need without abusing it. A port of comedi to RTDM in general would be a good 
thing to have however.

> Generally spoken, mmap can make sense if you have a significant amount
> of data to transfer, not "just" a few kbyte/s. RTDM has the elementary
> support for such device interfaces now, and this has already been used
> for a frame-grabbing driver.
What would be the proper procedure for just a few kbytes ? I expect less than 
500 kB./second in my application.

> The on-board timers surely have lower jitters than software-driven
> timers can provide. Depending on your application, this can make a
> difference. On the other hand, application-driven acquisition timing can
> be easier to implement (less synchronisation issues). Again, I would
> suggest a look at comedi if and how such capabilities are used there.
I think when I looked last comedi would not have supported the mode that I'm 
using now. If I remember correctly comedi would only allow either software 
paced or hardware paced with fifo interrupt modes, but not single sample 
hardware interrupts. Of course the single sample interrupt mode would become 
unreasonable at high sample rates, but I'm hoping that I'll be fine with 
10-20kHz.

Thomas

