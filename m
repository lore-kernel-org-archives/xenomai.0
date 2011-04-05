From: Robert Berger <gmane@domain.hid>
Date: Tue, 05 Apr 2011 17:51:52 +0300
Message-ID: <infaa9$eoe$1@domain.hid>
References: <COL122-W376680783697A8A880DC2BBDA20@domain.hid>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
In-Reply-To: <COL122-W376680783697A8A880DC2BBDA20@domain.hid>
Subject: Re: [Xenomai-core] Tiny Core Linux + xenomai/RTAI
Reply-To: gmane@domain.hid
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org
Cc: rtai@domain.hid

Hi Krishna,

On 04/05/2011 04:48 PM, krishna m wrote:
> Has anyone tried applying Xenomai or RTAI patch to the tiny core Linux?

No

> Will it give a better performance compared to the plain vanilla Linux
> because the kernel footprint is small?

I guess the Linux Kernel is pretty much the same with the vanilla
kernel. The reason it might offer better performance does most likely
not come from the kernel, but because in such a small system less
services are running, which might eat less CPU time.

Will performance be better?

Depends on what you mean with performance.

If you apply Xenomai/RTAI to a vanilla Linux kernel throughput and
number crunching (performance) will get worse and determinism will get
better.

Real-time is not about "performance" (speed, throughput), but about
determinism and those are conflicting requirements.

You can have a look at an article of mine for a more detailed
explanation of what I mean:
http://www.eetimes.com/design/embedded/4204740/Getting-real--time--about-embedded-GNU-Linux

Regards,

Robert

> 
> 
> 
> _______________________________________________
> Rtai mailing list
> Rtai@domain.hid
> https://mail.rtai.org/cgi-bin/mailman/listinfo/rtai

...A clever person solves a problem.A wise person avoids it.- Einstein

My public pgp key is available at:
http://pgp.mit.edu:11371/pks/lookup?op=get&search=0x90320BF1



