MIME-Version: 1.0
Date: Wed, 11 Jun 2008 11:18:34 +0200
From: Matthieu <matthieu.connaulte_xenomai@domain.hid>
Message-ID: <e2ba8ccba8e14750cb4a9dbdafcc5be7@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] xenomai scheduler's ticks period
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

So, do I have to understand that all skins have their own scheduler ?
To schedule at 1ms, specifying option tick_arg=3D1000 to xeno_vxworks mod=
ule
doesn't ! I thing
that I do it in a bad way, endeed I added "options xeno_vxworks
tick_arg=3D1000" to /etc/modprobe.conf/local ... (In fact I must add this
module manually, it isn't loaded automatically while a vxworks instructio=
n
need to execute).

Matthieu

On Tue, 10 Jun 2008 11:43:39 +0200, "Gilles Chanteperdrix"
<gilles.chanteperdrix@xenomai.org> wrote:
> On Tue, Jun 10, 2008 at 10:43 AM, Matthieu
> <matthieu.connaulte_xenomai@domain.hid> wrote:
>> Hi
>>
>> Is it possible to change the value of the xenomai scheduler's ticks
> period
>> ? I would like the tasks to be scheduled each 1 millisecond for exempl=
e.
> I
>> found out xnpod_tick_announce, but I didn't find any documentation and=
 I
>> didn't find the sources.
>
> Xenomai scheduler has no tick period. If you want, you may change a
> skin period, either by using Kconfig options, or by using module
> parameters. You will find documentation about the module parameters
> either by using modinfo or in the text file documenting the skin you
> want to use.
>
> --
>  Gilles



