Subject: Re: [Xenomai-core] [PATCH - ARM] ldrex/strex syntax errors with
	recent compilers
From: Stelian Pop <stelian.pop@domain.hid>
In-Reply-To: <1173966835.16299.49.camel@domain.hid>
References: <1173966835.16299.49.camel@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Date: Thu, 15 Mar 2007 17:02:59 +0100
Message-Id: <1173974580.16299.91.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

Le jeudi 15 mars 2007 =E0 14:53 +0100, Stelian Pop a =E9crit :

> It appears that the patch below fixes the compile error. I also verifie=
d=20
> that gcc-4.0.0 generates identical code using both forms.

FWIW, the same fix at a different place in the mainline kernel has been
acked by Catalin Marinas from ARM.

Ah, and the patch I submitted was against the 2.3.x branch although it
will probably apply more or less cleanly on trunk.

Thanks,

--=20
Stelian Pop <stelian.pop@domain.hid>


