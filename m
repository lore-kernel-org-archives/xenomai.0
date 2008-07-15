From: Sebastian Smolorz <Sebastian.Smolorz@domain.hid>
Date: Tue, 15 Jul 2008 08:03:52 +0200
References: <6132061f0807141723u5125f946m324749aa81fbdcc6@domain.hid>
In-Reply-To: <6132061f0807141723u5125f946m324749aa81fbdcc6@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200807150803.52326.Sebastian.Smolorz@domain.hid>
Subject: Re: [Xenomai-help] rtsocketcan in kernel space
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

Breno Carneiro Pinheiro wrote:
> Is it possible to write an application using rtsocketcan to run on kernel
> space? I mean, buid a kernel module using functions from rtsocketcan API.

RTDM provides an inter-driver API, see:
http://www.xenomai.org/documentation/branches/v2.4.x/html/api/group__interdrv.html

This is for calling RTDM driver functions from kernel space. But ask yourself 
whether it is really necessary for you to write an application in kernel 
space. User space applications are highly recommended.

-- 
Sebastian

