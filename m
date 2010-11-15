From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <AANLkTing6YXQzXTiGG8PsOPnWM6b2bc0u+Lv3Rmn96je@domain.hid>
References: <AANLkTing6YXQzXTiGG8PsOPnWM6b2bc0u+Lv3Rmn96je@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 15 Nov 2010 11:37:55 +0100
Message-ID: <1289817475.1933.112.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Is anybody using the pSOS skin in userland?
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: ronny meeus <ronny.meeus@domain.hid>
Cc: Xenomai-core@domain.hid

On Wed, 2010-11-03 at 22:42 +0100, ronny meeus wrote:
> Hello
>  
> we are investigating to usage of the pSOS+ skin to port a large legacy
> pSOS application to Linux.
> The application model consist of several processes in which the
> application lives. All processes will make use of the pSOS library.
>  
> After playing around with the library for some time we have observed
> several missing service calls, bugs and differences in behaviour
> compared to a real pSOS implementation:
> - missing sm_ident 
> - missing t_getreg / t_setreg in userland (patch already included in
> 2.5.5)
> - not possible to use skin from the context of different processes
> (patch already included in 2.5.5)
> - added support for identical task/queue/semaphore/region names by
> making names unique.
> - strange behaviour in pSOS message queue (see post "Possible memory
> leak in psos skin message queue handling").
>  
> I can (and will) deliver patches for all issues I have found, but I'm
> wondering whether there are other people using the pSOS skin (in
> userland) in a real live application. The target for my project would
> be an embedded system with strong reliability requirements (very
> stable / long running etc).
> Any feedback is welcome and appreciated.
>  
> It is not clear to me either which tests are executed before a new
> version is released.

T-e-s-t? What's this? We are proud to deliver the greatest uncertainty,
where the deepest fears about upgrading may turn into the highest hopes.
And vice-versa.

>  Is there any test-suite available for the pSOS skin?

This is a good start, used to validate the Xenomai SOLO implementation.
http://git.denx.de/?p=xenomai-solo.git;a=tree;f=psos/testsuite;h=54411570e19dec40e14a1226084024c05c0f3e53;hb=ee9c11895ac7cf2d72b1158a4836a4465f478a0b

This needs to be slightly adapted to run over the current Xenomai 2.x
architecture, but the test logic of course is the same.

>  
> Best regards,
> Ronny 
>  
>  
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core

-- 
Philippe.



