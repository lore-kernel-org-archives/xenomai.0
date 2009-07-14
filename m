MIME-Version: 1.0
In-Reply-To: <4A5B3928.3E52.00F8.0@domain.hid>
References: <4A5B3928.3E52.00F8.0@domain.hid>
Date: Tue, 14 Jul 2009 14:19:45 +0200
Message-ID: <b88603c30907140519t7818ff9p88fcb8498f7f050e@domain.hid>
From: Henri Roosen <henriroosen@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
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
To: Karl Tyss <tyss.k@domain.hid>
Cc: xenomai@xenomai.org

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
> Try the option "--enable-arm-eabi" while compiling Xenomai. It helped
> in my case. Or try turning the option "Allow old ABI binaries to run
> with this kernel" in the "Kernel Features" page.
>
> Good luck,
> Karl
>
>
> Mit Freundlichen Gr=FC=DFen,
> Karl Tyss
>
>
>
>
> -------------------------------------------------------------------------=
--------------
> This email including its attachments is intended for the person or
> entity only to which it is addressed. It may contain confidential and/or
> privileged material. Any review, forwarding, dissemination, other use
> of, or taking of any action in reliance upon this information by persons
> or entities other than the intended recipient is prohibited.
> If you received this email in error, please contact the sender and
> delete the material from any computer system.
> -------------------------------------------------------------------------=
--------------
>
> Eppendorf AG, Hamburg, Barkhausenweg 1, 22339 Hamburg,
> Amtsgericht Hamburg HRB 76249
> Vors. des Aufsichtsrats: Dipl.-Ing. Adrian D=E9teindre
> Vorstand: Klaus Fink (Vorsitzender), Detmar Ammermann,
> Dr. Heinz G. Koehn, Dr. Michael Schroeder
>
> Eppendorf Instrumente GmbH, Hamburg, Amtsgericht Hamburg, HRB 69077
> Gesch=E4ftsf=FChrer: Rainer Treptow
>
> Eppendorf Biochip Systems GmbH, Hamburg, Amtsgericht Hamburg, HRB 96641
> Gesch=E4ftsf=FChrer: Dr. Sven Buelow
>
> Eppendorf Liquid Handling GmbH, Hamburg, Amtsgericht Hamburg, HRB 92250
> Gesch=E4ftsf=FChrer: Boris von Beichmann
>

