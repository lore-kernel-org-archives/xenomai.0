content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [Xenomai-help] my tick takes a break !! 
Date: Wed, 19 Apr 2006 18:55:06 +0200
Message-ID: <5B122FD931231D408AC32630D1B1F7290AC5B129@domain.hid>
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

=20
Thomas, Brieuc \(GE Healthcare\) wrote:
 > Hi every one !
 >
 > I really don't understand, my porting of application works very well
> (under vxworks skin), message, semaphore, timer... Except the task !!
 > I've got a curious behaviour, when I've got a heavy task, the kernel
> tick counter stop during the process!!
 >
 > And take back when this one is finish.
 >
 > Therefore the other tasks are freeze and my application crash.
 >
 >
 >
 > have You already seen this case?

I do not know if it is what you mean, but when running Xenomai, your
tasks are supposed to suspend sufficiently frequently to leave Linux
tick normally. This means that if you configured CONFIG_HZ=3D100, your
real-time activity (including kernel-space tasks and user-space tasks in
primary mode) is supposed to take a break at least once every 1/100
second.

--=20


					    Gilles Chanteperdrix.

Oh no! Sorry, I mean the real-time tick counter!
But if my real-time activity don't take a break during a while (more
than 1/100 second), Is it dangerous for my real-time activity?=20

Brieuc THOMAS.

