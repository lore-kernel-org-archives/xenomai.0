From: Niklaus Giger <niklaus.giger@domain.hid>
Subject: Re: [Xenomai-core] Some new test cases for the vxWorks skin
Date: Sat, 17 Jun 2006 20:45:08 +0200
References: <200606122058.18019.niklaus.giger@domain.hid>
	<200606172025.13228.niklaus.giger@domain.hid>
	<17556.19312.486378.71911@domain.hid>
In-Reply-To: <17556.19312.486378.71911@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <200606172045.09813.niklaus.giger@domain.hid>
Reply-To: niklaus.giger@domain.hid
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Am Samstag, 17. Juni 2006 20:35 schrieb Gilles Chanteperdrix:
> Niklaus Giger wrote:
>  > Am Samstag, 17. Juni 2006 19:53 schrieb Gilles Chanteperdrix:
>  > > Niklaus Giger wrote:
>  > >  > Hi
>  > >  >
>  > >  > Here the reworked patch.
>  > >  >
>  > >  > vxWorks supports empty messages. Only one at a time can be
>  > >  > received.
>  > >
>  > > Could you explain a bit more "Only one at a time can be received" ? I
>  > > do not get it. You mean that one message get lost if posting two null
>  > > length messages while two receivers are blocked in a call to
>  > > msgQReceive ?
>  >
>  > I have two testcases for the 0 length messages. Look in my patch  for
>  > "Test mailbox with 0 length messages". They are:
>  >
>  > a) Post two messages, then call twice msgQReceive and each time I get
>  > one message back. Each time verified using msgQNumMsgs.
>  >
>  > b) Post two messages, then try to receive two messages at once by givi=
ng
>  > 2 (bytes) to msgQReceive see line:
>  >  =A0rc =3D msgQReceive(qid,(char *)&msg,2,NO_WAIT);)
>  > In this case I only get one message back, as msgQNumMsgs reports 1.
>  > This explains the lines:
>  > =A0 =A0rc =3D msgQNumMsgs(qid);
>  > =A0 =A0TEST_ASSERT(rc =3D=3D 1);
>
> The current implementation of message queues in vxworks skin does not
> support anything like "receive two messages at once". Are you sure
> vxworks does for non null messages ?
I am not sure. But will test sometimes next week.

Best regards

=2D-=20
Niklaus Giger

