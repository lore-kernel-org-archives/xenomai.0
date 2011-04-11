Date: Tue, 12 Apr 2011 00:30:56 +0200
From: Alexis Berlemont <alexis.berlemont@domain.hid>
Message-ID: <20110411223056.GA2654@domain.hid>
References: <4D9627BC.2040705@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4D9627BC.2040705@domain.hid>
Subject: Re: [Xenomai-help] Porting comedi drivers to the analogy layer
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Julien Delange <julien@domain.hid>
Cc: xenomai@xenomai.org

Hi,

Sorry for answering late.

Julien Delange wrote:
> Dear all,
> 
> I'm currently using Xenomai with the analogy drivers for one card.
> It works perfectly and I am able to interface real-time apps with my
> national instrument card. However, the card I had until now
> (PCI-6071E) is supported by both the analogy layer of Xenomai and
> comedi. Now, I would like to use another national instrument card :
> the PCI-6704. Unfortunately, it seems not supported by the analogy
> layer even if the comedi driver supports it. 

Indeed, the code for this driver is located in ni_670x.c in the
linux/staging tree.

> So, I am wondering if
> porting the driver from comedi to the analogy layer would require a
> significant development effort 

The size of the source code seems limited (~400 lines) and it seems
there is no asynchronous functionalities (no cmd only instructions);
so, I think that this port should not be too difficult. It should only
be literal translation of the Comedi functions calls into the analogy
ones. 

> and if there was similar initiative
> (potential port that were not backported to the trunk of Xenomai).
> 

I was not informed of any port for this driver.

> Thanks for any comment/suggestion,
> 
> Best regards,
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help

-- 
Alexis.

