Message-Id: <4A5D824B.3E52.00F8.0@domain.hid>
Date: Wed, 15 Jul 2009 07:16:25 +0200
From: "Karl Tyss" <tyss.k@domain.hid>
References: <4A5B3928.3E52.00F8.0@domain.hid>
	<b88603c30907140519t7818ff9p88fcb8498f7f050e@domain.hid>
In-Reply-To: <b88603c30907140519t7818ff9p88fcb8498f7f050e@domain.hid>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Subject: Re: [Xenomai-help] ARM: userspace apps result in Segmentation
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Henri Roosen <henriroosen@domain.hid>
Cc: xenomai@xenomai.org

Hi Henry,

it looks like you had more than one problems.  The one with the EABI
settings seems to be solved. What debugger are you using? Are you trying
to debug the "latecy-test" application? If yes then I cannot help you. I
have been using the latency test but I did not have to debug it yet.
Perhaps you should try to build a kernel module with one simple rt_task
that triggers a led or something similar to test basic xenomai
functionality? And did check the tip from Gilles?

Good luck,
Karl
 

Mit Freundlichen Grüßen,
Karl Tyss



>>> Henri Roosen <henriroosen@domain.hid> 07/14/09 2:19 PM >>> 
Hi Karl,

Thanks for the information. However I have tried the option
"--enable-arm-eabi" and unfortunately without success. It solves the
segmentation fault, but results in a hangup of the system.
I was able to debug the latency application until the rt_task_create,
but after that the debugger looses control. Any hints or help on that?

Thanks,
Henri


On Mon, Jul 13, 2009 at 1:39 PM, Karl Tyss<tyss.k@domain.hid> wrote:
> Hi Henri,
>
> I had a similar problem. If you compile Xenomai you will get the old
> abi format by default.
>
> Try the option "--enable-arm-eabi" while compiling Xenomai. It
helped
> in my case. Or try turning the option "Allow old ABI binaries to run
> with this kernel" in the "Kernel Features" page.
>
> Good luck,
> Karl
>
>
> Mit Freundlichen Grüßen,
> Karl Tyss
>
>
>
>
>
---------------------------------------------------------------------------------------
> This email including its attachments is intended for the person or
> entity only to which it is addressed. It may contain confidential
and/or
> privileged material. Any review, forwarding, dissemination, other
use
> of, or taking of any action in reliance upon this information by
persons
> or entities other than the intended recipient is prohibited.
> If you received this email in error, please contact the sender and
> delete the material from any computer system.
>
---------------------------------------------------------------------------------------
>
> Eppendorf AG, Hamburg, Barkhausenweg 1, 22339 Hamburg,
> Amtsgericht Hamburg HRB 76249
> Vors. des Aufsichtsrats: Dipl.-Ing. Adrian Déteindre
> Vorstand: Klaus Fink (Vorsitzender), Detmar Ammermann,
> Dr. Heinz G. Koehn, Dr. Michael Schroeder
>
> Eppendorf Instrumente GmbH, Hamburg, Amtsgericht Hamburg, HRB 69077
> Geschäftsführer: Rainer Treptow
>
> Eppendorf Biochip Systems GmbH, Hamburg, Amtsgericht Hamburg, HRB
96641
> Geschäftsführer: Dr. Sven Buelow
>
> Eppendorf Liquid Handling GmbH, Hamburg, Amtsgericht Hamburg, HRB
92250
> Geschäftsführer: Boris von Beichmann
>



---------------------------------------------------------------------------------------
This email including its attachments is intended for the person or
entity only to which it is addressed. It may contain confidential and/or
privileged material. Any review, forwarding, dissemination, other use
of, or taking of any action in reliance upon this information by persons
or entities other than the intended recipient is prohibited.
If you received this email in error, please contact the sender and 
delete the material from any computer system. 
---------------------------------------------------------------------------------------

Eppendorf AG, Hamburg, Barkhausenweg 1, 22339 Hamburg,
Amtsgericht Hamburg HRB 76249
Vors. des Aufsichtsrats: Dipl.-Ing. Adrian Déteindre
Vorstand: Klaus Fink (Vorsitzender), Detmar Ammermann,
Dr. Heinz G. Koehn, Dr. Michael Schroeder

Eppendorf Instrumente GmbH, Hamburg, Amtsgericht Hamburg, HRB 69077
Geschäftsführer: Rainer Treptow

Eppendorf Biochip Systems GmbH, Hamburg, Amtsgericht Hamburg, HRB 96641
Geschäftsführer: Dr. Sven Buelow

Eppendorf Liquid Handling GmbH, Hamburg, Amtsgericht Hamburg, HRB 92250
Geschäftsführer: Boris von Beichmann

