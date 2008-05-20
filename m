MIME-Version: 1.0
Date: Tue, 20 May 2008 09:04:07 +0200
From: Matthieu <matthieu.connaulte_xenomai@domain.hid>
In-Reply-To: <2ff1a98a0805160909r19c9ab0fsc0b838bcc306a1ea@domain.hid>
References: <2ff1a98a0805160909r19c9ab0fsc0b838bcc306a1ea@domain.hid>
Message-ID: <ccf58fbf26b7175c000f3dd18c8c0b8b@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai-help] =?utf-8?q?_Re=3A__Re=3A_VxWorks_skin_problem_conce?=
 =?utf-8?q?rning_WIND=5FTCBstructure?=
Reply-To: matthieu.connaulte_xenomai@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org



On Fri, 16 May 2008 18:09:58 +0200, "Gilles Chanteperdrix"
<gilles.chanteperdrix@xenomai.org> wrote:
> On Fri, May 16, 2008 at 12:11 PM, Matthieu
> <matthieu.connaulte_xenomai@domain.hid> wrote:
>>> I suggest you patch your kernel with the patch Philippe sent, adapt i=
t
>>> to suit your needs, maybe changing TASK_DESC as in vxworks taskLib.h,
>>> test and debug it, then send us a patch which we will be happy to
>>> merge.
>>>
>>> --
>>>  Gilles
>>
>> Ok, I was about doing it.
>>
>> I still have some questions about the migration of my app, as I don't
> know
>> Xenomai in details.
>>
>> Here is part of my code which aims at defining a procedure to restart =
a
>> task. If you have time to have a look on it, it would be helpful.
>=20
> taskRestart is not supported in user-space by the VxWorks skin. So,
> the first thing to do is to check if your application really needs
> this service, and if it does, implement taskRestart.
>=20
> --
>  Gilles

I finally needn't taskRestart.
I'm about modifing the patch. When I finish it, I'll send you.

Matthieu



