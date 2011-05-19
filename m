From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4DD5633C.6050708@domain.hid>
References: <1305813493.2118.112.camel@domain.hid>
	<4DD55E3E.2030203@domain.hid>  <4DD5633C.6050708@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 19 May 2011 22:29:44 +0200
Message-ID: <1305836984.2118.125.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [RFC] Getting rid of the NMI latency watchdog
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

On Thu, 2011-05-19 at 20:36 +0200, Jan Kiszka wrote:
> On 2011-05-19 20:15, Gilles Chanteperdrix wrote:
> > On 05/19/2011 03:58 PM, Philippe Gerum wrote:
> >> For this reason, I'm considering issuing a patch for a complete removal
> >> of the NMI latency watchdog code in Xenomai 2.6.x, disabling the feature
> >> for 2.6.38 kernels and above in 2.5.x.
> >>
> >> Comments welcome.
> > 
> > I am in the same case as you: I no longer use Xeno's NMI watchdog, so I
> > agree to get rid of it.
> 
> Yeah. The last time we wanted to use it get more information about a
> hard hang, the CPU we used was not supported.
> 
> Philippe, did you test the Linux watchdog already, if it generate proper
> results on artificial Xenomai lockups on a single core?

This works provided we tell the pipeline to enter printk-sync mode when
the watchdog kicks. So I'd say that we could probably do a better job in
making the pipeline core smarter wrt NMI watchdog context handling than
asking Xenomai to dup the mainline code for having its own NMI handling.

> 
> Jan
> 

-- 
Philippe.



