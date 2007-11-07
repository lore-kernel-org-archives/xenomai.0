From: Leopold Palomo-Avellaneda <lepalom@domain.hid>
Date: Wed, 7 Nov 2007 19:12:36 +0100
References: <200711061807.26236.lepalom@domain.hid> <4731CAE5.5080401@domain.hid>
	<200711071859.33094.lepalom@domain.hid>
In-Reply-To: <200711071859.33094.lepalom@domain.hid>
MIME-Version: 1.0
Message-Id: <200711071912.37356.lepalom@domain.hid>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Disposition: inline
Subject: Re: [Xenomai-help] IRQ issues in xenomai and rtnet (update)
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
Cc: mathias_koehrer@domain.hid

A Dimecres 07 Novembre 2007, Leopold Palomo-Avellaneda va escriure:
[....]
> I must put a irq specific for each card if not the kernel doesn't boot or I
> put irq auto and irqpoll in the kenel options. With this configuration I
> can configure the cards:
>
>
> palomo@domain.hid$ sudo ./sbin/rtroute
> Host Routing Table
> Hash    Destination     HW Address              Device
> 3F      10.0.1.255      FF:FF:FF:FF:FF:FF       rteth1
> 3F      10.0.0.255      FF:FF:FF:FF:FF:FF       rteth0
>
> and the system doesn't hang ...
>

the system hanged 5 minutes after send the mail ... 
:-(

Regards,

Leo

