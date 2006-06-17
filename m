MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Message-ID: <17556.19312.486378.71911@domain.hid>
Date: Sat, 17 Jun 2006 20:35:28 +0200
Subject: Re: [Xenomai-core] Some new test cases for the vxWorks skin
In-Reply-To: <200606172025.13228.niklaus.giger@domain.hid>
References: <200606122058.18019.niklaus.giger@domain.hid>
	<200606151340.55710.niklaus.giger@domain.hid>
	<17556.16823.734335.713312@domain.hid>
	<200606172025.13228.niklaus.giger@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Content-Transfer-Encoding: Quoted-Printable
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: niklaus.giger@domain.hid
Cc: xenomai@xenomai.org

Niklaus Giger wrote:
 > Am Samstag, 17. Juni 2006 19:53 schrieb Gilles Chanteperdrix:
 > > Niklaus Giger wrote:
 > >  > Hi
 > >  >
 > >  > Here the reworked patch.
 > >  >
 > >  > vxWorks supports empty messages. Only one at a time can be receiv=
ed.
 > >
 > > Could you explain a bit more "Only one at a time can be received" ? =
I do
 > > not get it. You mean that one message get lost if posting two null
 > > length messages while two receivers are blocked in a call to msgQRec=
eive
 > > ?
 > I have two testcases for the 0 length messages. Look in my patch  for =
"Test=20
 > mailbox with 0 length messages". They are:
 >=20
 > a) Post two messages, then call twice msgQReceive and each time I get =
one=20
 > message back. Each time verified using msgQNumMsgs.
 >=20
 > b) Post two messages, then try to receive two messages at once by givi=
ng 2=20
 > (bytes) to msgQReceive see line:
 >  =A0rc =3D msgQReceive(qid,(char *)&msg,2,NO_WAIT);)
 > In this case I only get one message back, as msgQNumMsgs reports 1.
 > This explains the lines:
 > =A0 =A0rc =3D msgQNumMsgs(qid);
 > =A0 =A0TEST_ASSERT(rc =3D=3D 1);

The current implementation of message queues in vxworks skin does not
support anything like "receive two messages at once". Are you sure
vxworks does for non null messages ?


--=20


					    Gilles Chanteperdrix.

