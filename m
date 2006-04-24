MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Message-ID: <17484.53834.564922.482694@domain.hid>
Date: Mon, 24 Apr 2006 15:27:38 +0200
Subject: RE: [Xenomai-help] my tick takes a break !! 
In-Reply-To: <5B122FD931231D408AC32630D1B1F7290ADD16EF@BUDMLVEM03.e2k.ad.ge.com>
References: <5B122FD931231D408AC32630D1B1F7290ADD16EF@BUDMLVEM03.e2k.ad.ge.com>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Content-Transfer-Encoding: Quoted-Printable
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "Thomas, Brieuc (GE Healthcare)" <Brieuc.Thomas@domain.hid>
Cc: xenomai@xenomai.org

Thomas, Brieuc \(GE Healthcare\) wrote:
 >=20
 >  > -----Message d'origine-----
 >  > De : Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org]=
=20
 >  > Envoy=E9 : dimanche 23 avril 2006 14:54
 >  > =C0 : Thomas, Brieuc (GE Healthcare)
 >  > Cc : xenomai@xenomai.org
 >  > Objet : RE: [Xenomai-help] my tick takes a break !!=20
 >  >=20
 >  > Thomas, Brieuc \(GE Healthcare\) wrote:
 >  >  > I tried it, but there isn't any change !
 >  >  > I've got the same behaviour.
 >  >=20
 >  > I could reproduce your bug here. The uvm-timer thread is blocked in=
 W state, just as if the interrupts were locked.
 >=20
 > Yes but, I've allowed the interrupts from the compile, and I never use=
d intLock() or something like that!

Neither your code, nor your setup is wrong, the error come from vxworks
uvm. Printing uvm_irqlock shows that the interrupts got disabled
somehow.

 > Then I tried the trunk version, and I've got an error message during t=
he launch, either:   =20
 >=20
 > When I compile a periodic timer mode:
 > Xenomai: UVM skin init failed, code -16
 > Xenomai: starting Vxworks services
 > Or, in aperiodic mode:
 > Xenomai: starting UVM services
 > Xenomai: incompatible timer mode(aperiodic found, need periodic).
 > Xenomai: Vxworks skin init failed, code -16
 >=20
 > Perhaps my first problem, come from to the timer mode? Normally my con=
figuration is status=3Doneshot:setup=3D202:tickval=3D1...=20

UVM and vxworks are separated skins, that require incompatible timer
setting. Since you are using UVM (I guess), select only uvm in kernel
configuration, or select vxworks skin as a module that you do not load
when running applications using the UVM skin.

--=20


					    Gilles Chanteperdrix.

