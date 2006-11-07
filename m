From: Wolfgang Denk <wd@domain.hid>
Subject: Re: [Xenomai-help] RT-SocketCan + Xenomai on MPC5200B 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 07 Nov 2006 14:22:10 GMT."
	<DD39B5C3F4963040ADC9768BE7E430CB014DEFF0@domain.hid> 
Date: Tue, 07 Nov 2006 21:31:39 +0100
Sender: wd@domain.hid
Message-Id: <20061107203139.00DAC353B57@domain.hid>
Content-Transfer-Encoding: quoted-printable
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Daniel Schnell <daniel.schnell@domain.hid>
Cc: xenomai@xenomai.org

In message <DD39B5C3F4963040ADC9768BE7E430CB014DEFF0@domain.hid=
l.net> you wrote:
>
> I would suspect it is the clock setting, as we have also problems with
> clock_nanosleep() running 4 times too fast. I assume then that the IPB
> clock frequency is wrong ?

As you can see from the U-Boot startup messages,  the  IPB  clock  on
your board is set to 66 MHz.

Best regards,

Wolfgang Denk

--=20
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@domain.hid
Success in marriage is not so much finding the right person as it  is
being the right person.

