Content-Type: text/plain; charset=iso-8859-1
Mime-Version: 1.0 (Mac OS X Mail 6.5 \(1508\))
From: Michael Haberler <mail17@mah.priv.at>
In-Reply-To: <51DAC0A9.1010709@xenomai.org>
Date: Mon, 8 Jul 2013 15:45:17 +0200
Content-Transfer-Encoding: quoted-printable
Message-Id: <E46787D6-E990-4573-A1D4-124253BD8DEA@mah.priv.at>
References: <CE260BFE-CB8F-45DC-A46D-8CFE585069EC@mah.priv.at>
	<51DAC0A9.1010709@xenomai.org>
Subject: Re: [Xenomai] q on rt_task_self() and mode switching
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>


Am 08.07.2013 um 15:37 schrieb Philippe Gerum <rpm@xenomai.org>:

> On 07/08/2013 03:23 PM, Michael Haberler wrote:
>> if a userland RT thread gets modeswitched, the SIGXCPU handler =
obviously still executes in the RT domain,
>=20
>=20
> Nope. All regular signal handlers are executed in the linux domain. =
Xenomai 2.x does not provide real-time signal handlers fired from =
primary mode.
>=20
> at least rt_task_self() returns a valid task descriptor - fine.
>>=20
>> If a kernel RT thread misses the release point, it seems the thread =
is immediately switched to linux scheduling
>=20
> With Xenomai 2.x, there is no migration to secondary mode for a =
kernel(-only) RT thread.
>=20
> - or at least rt_task_self() returns NULL in this scenario:
>>=20
>> int result =3D  rt_task_wait_period(&overruns);
>>     switch (result) {
>>=20
>>     case -ETIMEDOUT: // release point was missed
>> 	task =3D rt_task_self(); // this returns NULL
>>=20
>>=20
>> not a big thing - I just would like to get at the thread name for =
error message purposes; any way to do this?
>>=20
>=20
> Certainly, but which context does the code above run? On top of some =
ioctl()?

from the RT thread, which is started by a kernel module

- Michael


