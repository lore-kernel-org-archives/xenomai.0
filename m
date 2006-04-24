content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [Xenomai-help] my tick takes a break !! 
Date: Mon, 24 Apr 2006 11:49:17 +0200
Message-ID: <5B122FD931231D408AC32630D1B1F7290ADD16EF@BUDMLVEM03.e2k.ad.ge.com>
From: "Thomas, Brieuc \(GE Healthcare\)" <Brieuc.Thomas@domain.hid>
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


 > -----Message d'origine-----
 > De : Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org
 > Envoy=E9 : dimanche 23 avril 2006 14:54
 > =C0 : Thomas, Brieuc (GE Healthcare)
 > Cc : xenomai@xenomai.org
 > Objet : RE: [Xenomai-help] my tick takes a break !!=20
 >=20
 > Thomas, Brieuc \(GE Healthcare\) wrote:
 >  > I tried it, but there isn't any change !
 >  > I've got the same behaviour.
 >=20
 > I could reproduce your bug here. The uvm-timer thread is blocked in W =
state, just as if the interrupts were locked.
 >=20
 > --=20
 >=20
 >=20
 > 					    Gilles Chanteperdrix.
 >=20

Yes but, I've allowed the interrupts from the compile, and I never used =
intLock() or something like that!
By the way, I made some test: and if I add a taskLock() before the heavy =
while() and a taskUnlock() just after this while, my tick number is =
updated. But the task behaviour is the same; the task doesn't give the =
priority to the other task.
The second test is: I've added a takdelay() before the heavy while(). =
The tick counter work's, the task behaviour is fine, but evidently the =
workout takes a long time! =20

In fact, I think than I never seen working the schedule without delay() =
(like taskdelay() or msqReceive(WAIT)...)  I've got probably a bad =
configuration somewhere!
Then I tried the trunk version, and I've got an error message during the =
launch, either:   =20

When I compile a periodic timer mode:
Xenomai: UVM skin init failed, code -16
Xenomai: starting Vxworks services
Or, in aperiodic mode:
Xenomai: starting UVM services
Xenomai: incompatible timer mode(aperiodic found, need periodic).
Xenomai: Vxworks skin init failed, code -16

Perhaps my first problem, come from to the timer mode? Normally my =
configuration is status=3Doneshot:setup=3D202:tickval=3D1...=20

Any idea?
=20
	Brieuc THOMAS.

