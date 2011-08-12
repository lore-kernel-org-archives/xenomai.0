Date: Fri, 12 Aug 2011 17:13:26 +0200
From: "Petr Cervenka" <grugh@domain.hid>
References: <20110809174031.7B1346B2@domain.hid>,
	<1312905835.2112.106.camel@domain.hid>,
	<20110811103352.902F5E9E@centrum.cz>,
	<1313053817.2133.71.camel@domain.hid>, <4E43A2BE.4080903@domain.hid>,
	<1313057016.2133.79.camel@domain.hid> <1313057178.2133.80.camel@domain.hid>
In-Reply-To: <1313057178.2133.80.camel@domain.hid>
MIME-Version: 1.0
Message-Id: <20110812171326.7C74322E@centrum.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] rt_queue_bind() returns -EACCES
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-help <xenomai@xenomai.org>


Hello.

I have couple of notices (or maybe errors) and questions
1) rt_mutex_acquire(...) causes now segmentation fault, when the mutex is=
 not initialized with rt_mutex_create(...)

2) rt_queue_bind(&queue, TM_INFINITE) is not possible to interrupt by rt_=
task_unblock(...).=20
See the qclient example from my previous message, where the signal handle=
r is not able to unblock the main task.

3) Do you have any advice or idea how to create following scheme (or some=
thing similar):
I have one server application which creates RT_QUEUE (and listens on it).
Then I have couple of clients which binds to that queue (and possibly cou=
ld send some request message to it from time to time).
How to ensure the possibility to close the server and open it again?
Because even if I don't call the rt_queue_delete(...) explicitly at the e=
nd of server, the result is perhaps the same (when server process finishs=
).
Thanks in advance for any help.

Best regards
Petr Cervenka

______________________________________________________________
> Od: "Philippe Gerum" <rpm@xenomai.org>
> Komu: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
> Datum: 11.08.2011 12:06
> P=C5=99edm=C4=9Bt: Re: [Xenomai-help] rt_queue_bind() returns -EACCES
>
> CC: "xenomai-help" <xenomai@xenomai.org>
>On Thu, 2011-08-11 at 12:03 +0200, Philippe Gerum wrote:
>> On Thu, 2011-08-11 at 11:37 +0200, Gilles Chanteperdrix wrote:
>> > On 08/11/2011 11:10 AM, Philippe Gerum wrote:
>> > > On Thu, 2011-08-11 at 10:33 +0200, Petr Cervenka wrote:
>> > >> Hello.
>> > >>
>> > >> I created a simple examples which describe my problem.
>> > >> It is some kind of server and client.
>> > >> At first run a qserver and then qclient.
>> > >> After that close the qserver and try to run it again.
>> > >> It disallows (in my configuratio) to create the queue because it =
already exists and also the binding to it fails with error -EACCES.
>> > >> This behavior continues till the qclient is closed. It's perhaps =
caused by the rt_queue_delete() at the end of qserver.
>> > >=20
>> > > That is the intended behavior. When deleted, the queue is maintain=
ed
>> > > internally until the last client bound to it exits, which also dis=
allows
>> > > creating another queue with the same name until the latter event
>> > > happens.
>> > >=20
>> > > However, deleting the queue also makes it unreachable for further
>> > > bindings, until it is completely dismantled after the last client =
exits.
>> > > At which point you may re-create a queue with the same name and bi=
nd to
>> > > it. Logically speaking, that deleted queue does not exist anymore,
>> > > except for the currently bound client(s), for consistency reasons.
>> >=20
>> > Maybe we could return -EIDRM instead of -EEXIST when in this case?
>> >=20
>>=20
>> Not sure. EIDRM is conventionally about telling the caller that some
>> previously valid identifier has been revoked while the operation was
>> ongoing, which does not match the case of trying to establish a fresh
>> binding to a zombie object.
>
>Or trying to create a new object, the same way.
>
>>  In the first case, we did have a valid
>> object on entry, in the second one, that object has never been valid
>> from the caller's standpoint.
>>=20
>> I'm unsure that returning EIDRM would be trivial to implement anyway. =
We
>> would have to make the registry layer aware of the "magic" tags used b=
y
>> the upstream interfaces, so that it could check atomically EIDRM vs
>> EEXIST when failing to hash the object key. Granted, we could move thi=
s
>> magic into the xnobject struct directly though and get rid of it
>> elsewhere. Some work ahead in such a case.
>>=20
>
>--=20
>Philippe.
>
>
>

