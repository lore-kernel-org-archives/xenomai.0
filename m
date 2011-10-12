MIME-Version: 1.0
In-Reply-To: <1317742884.2082.69.camel@domain.hid>
References: <CAMJ=MEeOYUsNXMOUwLyxTo5kDcTTER90bXUpPiwao0YGZMpTeQ@mail.gmail.com>
	<1316782850.2050.8.camel@domain.hid>
	<CAMJ=MEfe-EKe9V7N3c=udfq=YGz23HhFec9UqvfZ6LtT2R3bjw@domain.hid>
	<1316809390.2050.11.camel@domain.hid> <1317034005.2174.6.camel@domain.hid>
	<CAMJ=MEf+bdds8Cv7vENTJLeVpYpR+ZGq1yP6TEFnFvTLy6iB3Q@mail.gmail.com>
	<1317742884.2082.69.camel@domain.hid>
Date: Wed, 12 Oct 2011 19:16:52 +0200
Message-ID: <CAMJ=MEc42w7WhZf5XK4E_e=wK7PLGx2P-a=JoCc0e8Mkkc5MrQ@mail.gmail.com>
From: Ronny Meeus <ronny.meeus@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] Xenomai-forge: SEGFAULT is pSOS skin
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai-help <xenomai@xenomai.org>

On Tue, Oct 4, 2011 at 5:41 PM, Philippe Gerum <rpm@xenomai.org> wrote:
> On Mon, 2011-09-26 at 22:01 +0200, Ronny Meeus wrote:
>
> <snip>
>
>> Next to this I also adapted the task priority automatically using
>> following algorithm:
>> static int check_task_priority(u_long *psos_prio)
>> {
>> =A0 =A0 =A0 =A0 if (*psos_prio < 1 || *psos_prio > 255) /* In theory. */
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ERR_PRIOR;
>> =A0 =A0 =A0 =A0 /* Do not change priorities <=3D10 and >=3D 240.
>> =A0 =A0 =A0 =A0 =A0* Priorities in between are divided by 4 */
>> =A0 =A0 =A0 =A0 if (*psos_prio > 240)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *psos_prio =3D 70 + *psos_prio - 240;
>> =A0 =A0 =A0 =A0 else if (*psos_prio > 10)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *psos_prio =3D 11 + ((*psos_prio-10)/4);
>>
>> =A0 =A0 =A0 =A0 if ((int)(*psos_prio) >=3D threadobj_max_prio - 1) /* In=
 practice. */
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 panic("current implementation restricts =
pSOS "
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "priority levels to range [1=
..%d]",
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 threadobj_max_prio - 2);
>>
>> =A0 =A0 =A0 =A0 return SUCCESS;
>> }
>>
>> It also works well for our application.
>> Please share your thoughts.
>
> Since we cannot generalize the priority mapping rules, a better way may
> be to allow your own code to be called by the pSOS emulator when such
> mapping is required. So I have committed a tentative solution, defining
> psos_task_normalize_priority() as a weak function, which receives the
> pSOS priority, and should return the POSIX one.
>
> A default implementation is provided by the emulator which does a
> trivial 1:1 mapping.
>
> --
> Philippe.
>
>
>

Philippe

as Thomas indicated in his mail today (see PSOS skin: mismatch in
function signatures cause buffer overflow), we synced with the forge
repo. We used this psos_task_normalize_priority function to remap the
priority for our application and it works well.
Thanks.

Ronny

