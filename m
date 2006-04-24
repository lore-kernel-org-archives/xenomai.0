Message-ID: <444CD47D.7010800@domain.hid>
Date: Mon, 24 Apr 2006 15:37:01 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] my tick takes a break !!
References: <5B122FD931231D408AC32630D1B1F7290ADD16EF@BUDMLVEM03.e2k.ad.ge.com>
	<17484.53834.564922.482694@domain.hid>
In-Reply-To: <17484.53834.564922.482694@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Gilles Chanteperdrix wrote:
> Thomas, Brieuc \(GE Healthcare\) wrote:
>  >=20
>  >  > -----Message d'origine-----
>  >  > De : Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org=
t]=20
>  >  > Envoy=E9 : dimanche 23 avril 2006 14:54
>  >  > =C0 : Thomas, Brieuc (GE Healthcare)
>  >  > Cc : xenomai@xenomai.org
>  >  > Objet : RE: [Xenomai-help] my tick takes a break !!=20
>  >  >=20
>  >  > Thomas, Brieuc \(GE Healthcare\) wrote:
>  >  >  > I tried it, but there isn't any change !
>  >  >  > I've got the same behaviour.
>  >  >=20
>  >  > I could reproduce your bug here. The uvm-timer thread is blocked =
in W state, just as if the interrupts were locked.
>  >=20
>  > Yes but, I've allowed the interrupts from the compile, and I never u=
sed intLock() or something like that!
>=20
> Neither your code, nor your setup is wrong, the error come from vxworks
> uvm. Printing uvm_irqlock shows that the interrupts got disabled
> somehow.
>=20
>  > Then I tried the trunk version, and I've got an error message during=
 the launch, either:   =20
>  >=20
>  > When I compile a periodic timer mode:
>  > Xenomai: UVM skin init failed, code -16
>  > Xenomai: starting Vxworks services
>  > Or, in aperiodic mode:
>  > Xenomai: starting UVM services
>  > Xenomai: incompatible timer mode(aperiodic found, need periodic).
>  > Xenomai: Vxworks skin init failed, code -16
>  >=20
>  > Perhaps my first problem, come from to the timer mode? Normally my c=
onfiguration is status=3Doneshot:setup=3D202:tickval=3D1...=20
>=20
> UVM and vxworks are separated skins, that require incompatible timer
> setting. Since you are using UVM (I guess), select only uvm in kernel
> configuration, or select vxworks skin as a module that you do not load
> when running applications using the UVM skin.
>=20

If you feel lucky, the 3rd option coming with v2.2 is to get rid of the=20
UVM and use the new direct call interface now available from user-space=20
for the VxWorks skin. In such a case, you need 1) the development=20
trunk/, 2) to load xeno_vxworks, 3) work with the new VxWorks interface=20
from user-space exactely the way one would use the existing native or=20
POSIX skin.

--=20

Philippe.

