Subject: Re: [Xenomai-help] Error: cat: /proc/xenomai/stat: Cannot allocate
	memory
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <Pine.LNX.4.64.0702021705370.12191@domain.hid>
References: <19981456.1170405795640.JavaMail.ngmail@domain.hid>
	<1170426719.4981.66.camel@domain.hid> <45C34DEE.2020101@domain.hid>
	<200702021455.51991.paul_c@domain.hid>
	<Pine.LNX.4.64.0702021705370.12191@domain.hid>
Content-Type: text/plain
Date: Fri, 02 Feb 2007 16:16:41 +0100
Message-Id: <1170429402.4981.79.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "Rus V. Brushkoff" <rus@domain.hid>
Cc: xenomai@xenomai.org

On Fri, 2007-02-02 at 17:07 +0200, Rus V. Brushkoff wrote:
> :On Friday 02 February 2007 14:42, Jan Kiszka wrote:
> :> >>  Tested on K8 x86_64 SMP and K8 x86 UP : SMP system leaks memory, UP
> :> >> doesn't.
> :> Must be .config-dependent. My UP box (.config attached) doesn't expose
> :> any leak on /proc/interrupt loops with 2.6.19.2.
> :
> :x86_64 SMP on 2.6.19.2 doesn't appear to leak here either. Perhap 
> :http://lkml.org/lkml/2006/12/26/112 might have been a contributary fix..
> 
>  With my config (attached) plain 2.6.19.2 x86_64 SMP leaks memory, so this 
> is config related.
> 

I don't know for Paul, but unlike Jan, we both run with
CONFIG_DEBUG_KERNEL features on. I'm going to check if this makes a
difference on my setup.

> :
> :
> 
> 		Rus
> _______________________________________________ Xenomai-help mailing list Xenomai-help@domain.hid https://mail.gna.org/listinfo/xenomai-help
-- 
Philippe.



