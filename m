Date: Tue, 1 Jun 2010 18:52:31 +0200
From: Tschaeche IT-Services <services@domain.hid>
Message-ID: <20100601165231.GA9808@domain.hid>
References: <20100601135005.GA5483@domain.hid>
	<1275402757.27918.151.camel@domain.hid>
	<20100601155403.GA8240@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20100601155403.GA8240@domain.hid>
Subject: Re: [Xenomai-help] Handling Linux Signals in primary domain context
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Tschaeche IT-Services <services@domain.hid>
Cc: xenomai@xenomai.org

On Tue, Jun 01, 2010 at 05:54:04PM +0200, Tschaeche IT-Services wrote:
> Then, we implement a workaround sending a rt-signal
> when rt_task_suspend() returns EINTR. In the rt-signal
> handler we explicitely migrate the task to secondary
> domain, where linux signal handling is triggered...

this does not work: rt_task_catch() is only allowed for kernel based tasks :-(
Is there any other possibility to interrupt the task and switch it to
secondary domain?

Thanks,

	Olli

