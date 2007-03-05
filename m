From: Sebastian Smolorz <ssm@domain.hid>
Subject: Re: [Xenomai-help] normal mode with rt_dev_ioctl
Date: Mon, 5 Mar 2007 10:08:22 +0100
References: <bc4264770703030456g60c84dc2me77b85281cac9510@domain.hid>
In-Reply-To: <bc4264770703030456g60c84dc2me77b85281cac9510@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <E1HO9Az-0006Yn-6n@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: roland Tollenaar <rolandtollenaar@domain.hid>
Cc: xenomai@xenomai.org

roland Tollenaar wrote:
> Hi,
>
> Is there a flag that allows one to set the socket in normal mode with
> rt_dev_ioctl?

Use CAN_MODE_START with the IOCTL SIOCSCANMODE. But notice that this is a 
controller, not a socket setting.

--
Sebastian

