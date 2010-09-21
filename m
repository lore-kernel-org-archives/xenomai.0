From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <AANLkTi=HdW-g6KWHYbKiK5UiLb_SNOQrarfwj53ra4cd@domain.hid>
References: <AANLkTi=HdW-g6KWHYbKiK5UiLb_SNOQrarfwj53ra4cd@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 21 Sep 2010 09:29:34 +0200
Message-ID: <1285054174.4114.30.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] t_getreg / t_setreg undefined references in
 pSOS+ skin
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: ronny meeus <ronny.meeus@domain.hid>
Cc: xenomai@xenomai.org

On Mon, 2010-09-20 at 22:42 +0200, ronny meeus wrote:
> Hello
> 
> I see in the psos.h file the function declaration for both the
> t_getreg and the t_setreg functions.
> Also in the psos kernel module I see functionality available.
> What I miss it the references for both service calls in the syscall.c
> file.
> 
> This results in undefined references if I try to use the service call
> in my application.
> 
> Is there any patch available that solves my problem?

Untested:
http://git.xenomai.org/?p=xenomai-rpm.git;a=commit;h=740e3b9e5f77588f3df010752c255ecd24adea4e

> 
> Thanks
> Ronny
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help

-- 
Philippe.



