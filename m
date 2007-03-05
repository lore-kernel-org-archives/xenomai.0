From: Sebastian Smolorz <ssm@domain.hid>
Subject: Re: [Xenomai-help] CAN errors and real-time behaviour (IRQ raise
	forever and may lock system)
Date: Mon, 5 Mar 2007 13:01:09 +0100
References: <bc4264770703030609w188a675cj618872986ff1071c@domain.hid>
	<E1HOBKy-0000tp-Kt@domain.hid> <45EC0243.1060301@domain.hid>
In-Reply-To: <45EC0243.1060301@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <E1HOBsC-0004y8-Rb@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rolandtollenaar@domain.hid
Cc: xenomai@xenomai.org

Roland Tollenaar wrote:
> IMHO it would be nice if the warning did get into the message buffer
> (assuming that they cannot -easily- be expelled elsewhere) but that the
> overflowing does not result in triggering non-application

You mean the log printing? Simply don't set CONFIG_XENO_DRIVERS_CAN_DEBUG.

> warning or 
> error handeling mechanisms.

Error handling is the duty of your application. The CAN stack doesn't do this 
for you.

--
Sebastian

