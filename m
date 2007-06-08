From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <403B28AE6257B548B66BB88414AC78330174BC39@domain.hid>
References: <403B28AE6257B548B66BB88414AC78330174BC39@domain.hid>
Content-Type: text/plain
Date: Fri, 08 Jun 2007 16:24:08 +0200
Message-Id: <1181312649.4982.63.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-core] [Adeos-main] periodic mode in adeos-ipipe for
	arm at91 ...
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
To: BOUIN Alexandre <abouin@domain.hid>
Cc: adeos-main@gna.org, xenomai@xenomai.org

On Fri, 2007-06-08 at 16:07 +0200, BOUIN Alexandre wrote:
>                 We (Adeneo) are working on a ARM AT91 RTAI. We
>                 encountered some difficulties such tsc one : in
>                 periodic mode, we reload our timer automatically in
>                 order to avoid reprogramming it. TC timer increments a
>                 16 byte register, which is not enough for a tsc (64
>                 bytes). tsc need to be emulated on ARM.
>                 
>                 With oneshot mode, tsc is updating the 4 least
>                 significant bytes and then increments other bytes each
>                 time counter go back to zero value.
>                 
>                 With our periodic mode, timer reloads himself so we
>                 need to change tsc emulation by incrementing tsc like
>                 this : tsc += period.
>                 
>                 We made some evolutions on ipipe which will be applied
>                 to a hal patch.
>                 
>                 Are you interrested in a such patch for a periodic
>                 mode on ARM ?
>                 

Support for periodic mode has been recently deprecated in the I-pipe
patch, and will be discontinued in future releases.

> _______________________________________________
> Adeos-main mailing list
> Adeos-main@domain.hid
> https://mail.gna.org/listinfo/adeos-main
-- 
Philippe.



