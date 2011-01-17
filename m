From: "Peter Hua" <Phua@domain.hid>
References: <007901cbb667$db66b860$92342920$@innovative-dsp.com>
	<4D347656.1050609@domain.hid>
In-Reply-To: <4D347656.1050609@domain.hid>
Date: Mon, 17 Jan 2011 10:37:57 -0800
Message-ID: <008e01cbb675$a916be60$fb443b20$@innovative-dsp.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Content-Language: en-us
Subject: Re: [Xenomai-help] Xenomai mmap
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: 'Gilles Chanteperdrix' <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org, pwfhua@domain.hid

Platform: X86, 64-bit

Thanks for the API linke.  I have recoded to not use =
"rtdm_iomap_to_user" and used the mmap call.  However, I am not able to =
open the driver with the open() call.  It returned -1.   Any suggestion? =
 Example?

Thanks,
Peter Hua
Innovative Integration
805-578-4275


-----Original Message-----
From: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org
Sent: Monday, January 17, 2011 9:03 AM
To: Peter Hua
Cc: xenomai@xenomai.org; pwfhua@domain.hid
Subject: Re: [Xenomai-help] Xenomai mmap

Peter Hua wrote:
> Is there any example code to map PCI registers into user space?  I am =
having
> problem getting functions rtdm_iomap_to_user and mmap to compile.   My =
code
> is attached. =20

What platform? What error message do you get?

--=20
                                                                Gilles.


