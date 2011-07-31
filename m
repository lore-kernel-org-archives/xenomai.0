From: Wolfgang Denk <wd@domain.hid>
MIME-Version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 8bit
In-reply-to: <4E34A253.5060502@domain.hid>
References: <4E34759D.40405@domain.hid>
	<20110730234906.023BF12B7AE4@domain.hid>
	<4E34A253.5060502@domain.hid>
Date: Sun, 31 Jul 2011 12:19:21 +0200
Message-Id: <20110731101921.D291412B7AE4@domain.hid>
Subject: Re: [Xenomai-help] AT91SAM9G45 support
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: at91_enthus <nwromania@domain.hid>
Cc: xenomai@xenomai.org

Dear at91_enthus,

In message <4E34A253.5060502@domain.hid> you wrote:
>
> I already have a few boards for experimenting with Xenomai. AT91SAM9G45
> has some interesting features with respect to other AT91s.

In cases like yours it is usually a good idea to start reading the
documentation.  For example,
http://www.xenomai.org/index.php/Embedded_Device_Support
will tell you that AT91 in general is supported by Xenomai, so the
eforts needed for your board should be not too big.

On the other hand... I don't know your requirements, but none of the
AT91 processors will actually give whopping real-time performance
(compared to other processors at the same clock rate).  There might be
other, better options.


Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@domain.hid
A verbal contract isn't worth the paper it's written on.
                                                    -- Samuel Goldwyn

