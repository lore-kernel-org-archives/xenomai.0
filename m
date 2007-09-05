From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <18142.49532.752950.449999@domain.hid>
References: <46DD59D9.9010003@domain.hid>
	<1188914054.28092.137.camel@domain.hid>
	<18142.49532.752950.449999@domain.hid>
Content-Type: text/plain
Date: Wed, 05 Sep 2007 17:05:32 +0200
Message-Id: <1189004732.28092.298.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-core] Make watchdog-timer configurable
Reply-To: rpm@xenomai.org
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

On Wed, 2007-09-05 at 16:47 +0200, Gilles Chanteperdrix wrote:
> Philippe Gerum wrote:
>  > On Tue, 2007-09-04 at 15:12 +0200, Johan Borkhuis wrote:
>  > > I made the following change to Xenomai (version 2.3.2, but it could also 
>  > > be applied to 2.4 as the watchdog code has not been changed).
>  > > 
>  > > The watchdog timeout is fixed at 4 seconds. For us this is a problem as 
>  > > there are some processes that take more time than this.
>  > > 
>  > > I made the following change to allow this to be changed through the 
>  > > Linux kernel configuration. The value is configurable between 1 and 60 
>  > > seconds.
>  > > 
>  > > Below is a patchfile that implements this change. Please let me know if 
>  > > you have comments on this, or if there are problems with this change.
>  > > 
>  > 
>  > Looks good. Will merge, thanks.
> 
> I have nothing against the patch.
> 
> That said, if you have a real-time activity that does not let Linux run
> for 4 seconds, you are risking some troubles when the real-time activity
> gives back the control to Linux, such as random lockups for example.
> 

You could also use this feature to lower the deadline below 4 secs,
which is already pretty high.

-- 
Philippe.



