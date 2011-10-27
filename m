MIME-Version: 1.0
Sender: patrickdepinguin@domain.hid
In-Reply-To: <5d59799b.ccfc.133457711d4.Coremail.idiotdream@domain.hid>
References: <5d59799b.ccfc.133457711d4.Coremail.idiotdream@domain.hid>
Date: Thu, 27 Oct 2011 15:37:56 +0200
Message-ID: <CAAXf6LUp-yVWO-XKhyZMimODKnWaY7criZz7oajx+83UgO-6pQ@mail.gmail.com>
From: Thomas De Schampheleire <patrickdepinguin+xenomai@domain.hid>
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] for helping!
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: =?GB2312?B?sNez1dK7w84=?= <idiotdream@domain.hid>
Cc: xenomai@xenomai.org

Hi,

2011/10/27 =B0=D7=B3=D5=D2=BB=C3=CE <idiotdream@domain.hid>:
> hello experts:
> I am a newer of xenomai.this days I try to build xenomai in archlinux on =
my
> pc (PD3.4G cpu).i use the version of 2.6.0_rc4 and 2.6.0-rc5 on kernel
> 2.6.38 for many times. all most every time, i built the kernel and user
> space succesfully.(in different /.config files,for total 42 times),but wh=
en
> i run the tests in /usr/xenomai/bin,for examples(latency),i got the error=
 :
> xenomai: /dev/rtheap is missing
> (chardev, major=3D10 minor=3D254)
> every times.
> i realy do not know how and what to do,why thus?? thank you!

I quote an earlier reply of Gilles on a similar issue:

"You have probably missed the following message when running "make
install":

*** Warning: you are not super-user and sudo does not work, real-time devic=
es
*** nodes will not be created.
*** If you do not create these devices by hand, Xenomai test programs will =
not
*** work.
*** To create these devices please run "make devices" with super-user
*** privileges."

Best regards,
Thomas

