Date: Tue, 29 Jun 2004 09:20:01 +0300 (EEST)
From: "Rus V. Brushkoff" <rus@domain.hid>
Subject: Re: [Adeos-main] Re: Problem with FIFO's (maybe with RTAI/Adeos) at
 2.6.x branch
In-Reply-To: <1088442437.1094.41.camel@domain.hid>
Message-ID: <Pine.LNX.4.53.0406290917130.23093@domain.hid>
References: <Pine.LNX.4.53.0406151339110.1831@domain.hid>
 <1088442437.1094.41.camel@domain.hid>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: adeos-main-admin@domain.hid
Errors-To: adeos-main-admin@domain.hid
List-Help: <mailto:adeos-main-request@domain.hid>
List-Post: <mailto:adeos-main@gna.org>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: <https://mail.gna.org/public/adeos-main/>
To: Philippe Gerum <rpm@xenomai.org>
Cc: adeos-main@gna.org

On Mon, 28 Jun 2004, Philippe Gerum wrote:

:> Default Trap Handler: vector 14: Suspend RT task ef8b8720
:Found the gremlin. As suspected, this was due to the on-demand VM
:mapping resolution. RT tasks were triggering page faults caught in the
:real-time domain that caused them to be killed by the HAL. As you
:noticed, extending the size of the data section makes the odds of
:encountering this situation higher since the module is loaded into
:vmalloc'ed memory by the kernel. Fixed in the vesuvio CVS.

Thanks, will test today ;)

:
:PS: this bug does not affect RTAI running over 2.4 kernels since Adeos
:for 2.4.x has a built-in fix for this.

 Yes, this bug appeared while porting to 2.6 and I thought this was from
my wrong written app.

:

		Rus

