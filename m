From: Leopold Palomo-Avellaneda <lepalom@domain.hid>
Date: Wed, 21 Nov 2007 10:13:41 +0100
References: <318864.42760.qm@domain.hid>
In-Reply-To: <318864.42760.qm@domain.hid>
MIME-Version: 1.0
Message-Id: <200711211013.42301.lepalom@domain.hid>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Disposition: inline
Subject: Re: [Xenomai-help] can't bringing up eth0
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

A Dimecres 21 Novembre 2007, indra sakti va escriure:
> Hello,...
>
> I'm trying to install xenomai-2.4-rc5 with vanilla kernel 2.6.23... I use
> my old working config file, and disable power management option. I compile
> my kernel and  xenomai, following the tutorial in www.captain.at ..
> Everything is ok, until i reboot and choose my new kernel with xenomai. In
> the startup service, it's always fail in bringing up interface eth0. If i
> choose NO to start that service, then my linux can continue working.
>
> Can anyone tell me how to solve my problem?
>
> Thanx for any answer or suggestion..:)

look the udev rules because changing the kernel maybe the new kernel put 
another name to your network card as eth1 or eth2 ... I have been crazy with 
this kind of problems and after are simple a different name.

Regards,

Leo


