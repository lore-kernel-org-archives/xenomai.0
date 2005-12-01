Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [Xenomai-help] using mq_receive and mq_send
Date: Thu, 1 Dec 2005 10:23:38 +0200
Message-ID: <02AA386EB831044F8537A696BA785C7807648B@ILEX5.IL.NDS.COM>
From: "Landau, Bracha" <BLandau@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <kiszka@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

It is being called from a xenomai thread, as far as I can tell. Here is t=
est code for mq_receive - the call to mq_receive returns with an error. W=
hen I run the same code with the lmqueue library (non-xenomai) that I dow=
nloaded I don't get an error.


void *MyThread (void *dummy)
{
 	char response [20];
	struct mq_attr buf;

	buf.mq_msgsize =3D sizeof (response);
	buf.mq_maxmsg =3D 5;
	mqd_t handle =3D mq_open ("/test", O_CREAT | O_RDONLY, 0, &buf);
	printf ("return from initialize_message_queue, handle=3D%08x\n", handle)=
;

	int status =3D mq_receive (handle, (char *) &response, sizeof (response)=
, 0);
	printf ("return from mq_receive, status =3D %08x, errno =3D %08x, %s\n",=
 status, errno, strerror (errno) );

	return 0;
}

int main (int argc, char *argv[])
{

	pthread_attr_t attr;
	pthread_attr_init (&attr);
	pthread_create (&my_thread_id, &attr, MyThread, NULL);=20

	pause ();

=09
}


-----Original Message-----
From: Jan Kiszka [mailto:kiszka@domain.hid]
Sent: Wednesday, November 30, 2005 5:45 PM
To: Landau, Bracha
Cc: xenomai-help
Subject: Re: [Xenomai-help] using mq_receive and mq_send


Landau, Bracha wrote:
> it says:
>          U __wrap_mq_close
>          U __wrap_mq_open
>          U __wrap_mq_receive
>          U __wrap_mq_send
>          U __wrap_mq_unlink

Are you calling send and receive from a xenomai thread? EPERM (1) is
typically related to non-RT invocations.

Jan

>=20
> -----Original Message-----
> From: Philippe Gerum [mailto:rpm@xenomai.org]
> Sent: Wednesday, November 30, 2005 4:37 PM
> To: Landau, Bracha
> Cc: xenomai@xenomai.org
> Subject: Re: [Xenomai-help] using mq_receive and mq_send
>=20
>=20
> Landau, Bracha wrote:
>> I do link that way. The linking is fine, only the mq_receive and mq_se=
nd don't work. I don't even "own" the regular libmqueue library.
>>
>=20
> What does "nm <your_app>|grep wrap_mq_" says?
>=20
>> -----Original Message-----
>> From: Philippe Gerum [mailto:rpm@xenomai.org]
>> Sent: Wednesday, November 30, 2005 4:01 PM
>> To: Landau, Bracha
>> Cc: xenomai@xenomai.org
>> Subject: Re: [Xenomai-help] using mq_receive and mq_send
>>
>>
>> Landau, Bracha wrote:
>>
>>> I am using Xenomai on the MPC8272ADS board with kernel 2.6.14.3.
>>>
>>> I've created an application that uses posix message queuing from xeno=
mai.
>>>
>>> When I call mq_open, mq_close, mq_setattr, mq_getattr, mq_unlink - th=
e calls succeed.
>>>
>>> When I call mq_receive or mq_send, the call fails (returns -1) and er=
rno is set to 1 (Operation not permited).
>>>
>>> I put some debugging printk's into the xenomai code and it seems it d=
oesn't even get to the call to __mq_receive or __mq_send from syscall.c (=
it does get to printk's that I put in  the other __mq_* functions).
>>>
>>> Can anyone help?
>>>
>>
>> You must link your app with the flags output by "xeno-config=20
>> --posix-ldflags". Have a look at skins/posix/demos/Makefile for a=20
>> working example.
>>
>=20
>=20


--=20
Dipl.-Ing. Jan Kiszka

Institute for Systems Engineering, Real-Time Systems Group (RTS)
Appelstra=DFe 9A, D-30167 Hannover
phone +49 511 762-3974 / fax +49 511 762-4012
http://www.rts.uni-hannover.de

*************************************************************************=
**********
This email message and any attachments thereto are intended only for use =
by the addressee(s) named above, and may contain legally privileged and/o=
r confidential information. If the reader of this message is not the inte=
nded recipient, or the employee or agent responsible to deliver it to the=
 intended recipient, you are hereby notified that any dissemination, dist=
ribution or copying of this communication is strictly prohibited. If you =
have received this communication in error, please immediately notify the =
postmaster@domain.hid and destroy the original message.
*************************************************************************=
**********

