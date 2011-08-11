From: Carlos Eduardo de Brito Novaes <carlosnov@domain.hid>
Date: Thu, 11 Aug 2011 15:12:39 -0300
References: <201108101449.54243.carlosnov@domain.hid>
	<201108111456.24208.carlosnov@domain.hid>
	<4E4418EE.8000005@domain.hid>
In-Reply-To: <4E4418EE.8000005@domain.hid>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <201108111512.40209.carlosnov@domain.hid>
Subject: Re: [Xenomai-help] Trouble with rtdm timers and events
Reply-To: Carlos Eduardo de Brito Novaes <carlosnov@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

I really did not understand why nor even what exactly it means to overflow =
the=20
source area, but I forgot to mention that I commented it out, so the=20
copy_to_user is not being called at all.

Thanks

=2D-
Carlos Novaaes.

Em qui 11 ago 2011, =C3=A0s 15:01:18, voc=C3=AA escreveu:
> The copy_to_user is still overflowing. And in fact, it is probably the
> cause of the bug you observe, I had not read your example carefully.

