Date: Mon, 01 Sep 2008 11:44:25 +0200
From: "stephane ancelot" <sancelot@domain.hid>
Content-Type: text/plain; format=flowed; delsp=yes; charset=utf-8
MIME-Version: 1.0
References: <131064.26848.qm@domain.hid>
Message-ID: <op.ugsqobwznuwxn3@domain.hid>
In-Reply-To: <131064.26848.qm@domain.hid>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-core] Kernel 2.6.26 Hung With Xenomai 2.4.5
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: yasser_kashfi@domain.hid, xenomai@xenomai.org

Hi,

I noticed some problems, if you disable the apic in kernel (lapic=3Dno)

My kernel keeps stable while I am not going into xenomai interrupt driver=
 =20
context.

In interrupt driver context, at the moment , for unknown reasons, my =20
driver is called but this is a spurious interrupt and the interrupt is no=
t =20
shared ....


Best Regards
Steph

Le Thu, 28 Aug 2008 11:16:30 +0200, Yasser Kashfi =20
<yasser_kashfi@domain.hid> a =C3=A9crit:

> Hi
> I have a bad problem, please advise me if you have an solution.
> I worked with older xenomai on Linux kernel 2.6.17 from one year ago an=
d =20
> do not have any problem. but now, I decide to install xenomai-2.4.5 wit=
h =20
> Linux kernel 2.6.24 or 2.6.25 or 2.6.26 on SUSE.
> after compile and install all things :), when boot the new kernel, I =20
> some times see the cursor stop flashing and kernel hung. another =20
> problem, when I run the my program (xenomai user space task ) see kerne=
l =20
> oop and kernel panic :( .
>
> I glad to see your comments.
>
>
>
>
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core
>
>



