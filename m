From: Sebastian Smolorz <Sebastian.Smolorz@domain.hid>
Subject: Re: [Xenomai-help] syslogd breaking rt behaviour of xenomai?
Date: Sun, 4 Mar 2007 19:05:39 +0100
References: <bc4264770703040818l43d966a1tba5d14fa3937c93a@domain.hid>
	<cbe23c50703040845v7125317amd915c3e199c9fd5f@domain.hid>
	<bc4264770703040952x61e3c15icc8d041bf108506@domain.hid>
In-Reply-To: <bc4264770703040952x61e3c15icc8d041bf108506@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200703041905.39500.Sebastian.Smolorz@domain.hid>
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

roland Tollenaar wrote:
> Hi
>
> > Which process is calling syslog ? Your RT task? Another process/daemon
> > running on your system?
>
> I don't  know. Before this started happening I was never aware of
> syslogd. I certainly never called it myself explicitly. Apparently it
> is called by something monitoring the CAN message buffer? Don't know.

Which messages are you referring to? Could you post them? Maybe you are 
referring to the Kernel log messages printed by the RT-CAN-Stack. Then there 
is no syslogd involved at all.

--
Sebastian

