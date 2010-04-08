Message-ID: <4BBDD084.50400@domain.hid>
Date: Thu, 08 Apr 2010 14:48:04 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <2319761F7FA0D1479BA77EC2E0A8E7BCDD191D@alpine.pivotalsys.com>
In-Reply-To: <2319761F7FA0D1479BA77EC2E0A8E7BCDD191D@alpine.pivotalsys.com>
Content-Type: text/plain; charset=ISO-8859-15
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
> 

Check the mailing list archive, there was once some SPI driver announced
for the BFIN 537 [1]. I do not recall much details, but I could imagine
that this is a quite good starting point.

In any case, feel free to discuss your interface design here as well as
post early prototypes.

Jan

[1] http://thread.gmane.org/gmane.linux.real-time.xenomai.devel/3451

-- 
Siemens AG, Corporate Technology, CT T DE IT 1
Corporate Competence Center Embedded Linux

