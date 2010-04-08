Message-ID: <4BBDEB36.5070800@domain.hid>
Date: Thu, 08 Apr 2010 16:41:58 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <2319761F7FA0D1479BA77EC2E0A8E7BCDD191D@alpine.pivotalsys.com>
In-Reply-To: <2319761F7FA0D1479BA77EC2E0A8E7BCDD191D@alpine.pivotalsys.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Standard API for RTDM SPI driver
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Sherk Chung <sherk.chung@domain.hid>
Cc: xenomai@xenomai.org

Sherk Chung wrote:
> Hi folks, after a fruitless search for a real-time SPI driver we are
> considering having one developed.  It looks like there is a Xenomai RTDM
> API for serial and CAN, but not for SPI.  Would it make sense to try to
> come up with an RTDM API for SPI before we kick off the driver
> development so that anything we build will conform to some standard. 
> Any suggestions on what a SPI RTDM API should look like?

>From my point of view, we need two APIs: the first in kernel-space, to
be used by device drivers which want to use SPI, which will probably
look a lot like Linux SPI API.

Another for applications using RTDM, which will be an RTDM device
profile, or socket protocol. This named device or socket protocol
implementation will be generic, and simply use the kernel-space API.

But I think you should propose the APIs, so that we do not discuss in
the void.

-- 
					    Gilles.

