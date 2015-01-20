Date: Tue, 20 Jan 2015 12:08:48 +0100 (CET)
From: Huy Cong Vu <huy-cong.vu@wandercraft.eu>
Message-ID: <1415631089.199145.1421752128845.JavaMail.zimbra@wandercraft.eu>
In-Reply-To: <1035674281.199094.1421752087064.JavaMail.zimbra@wandercraft.eu>
References: <214896079.184274.1421401577183.JavaMail.zimbra@wandercraft.eu>
 <20150116165318.GC1157@hermes.click-hack.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] xenomai 3-next kernel boot failed exit signal 15
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org



----- Mail original -----
> De: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
> =C3=80: "Huy Cong Vu" <huy-cong.vu@wandercraft.eu>
> Cc: xenomai@xenomai.org
> Envoy=C3=A9: Vendredi 16 Janvier 2015 17:53:18
> Objet: Re: [Xenomai] xenomai 3-next kernel boot failed exit signal 15

> On Fri, Jan 16, 2015 at 10:46:17AM +0100, Huy Cong Vu wrote:
>> Hello everyone,
>> I pulled the xenomai 3 - next branch & patch into linux 3.14.17 kernel o=
n an x86
>> Intel. The system failed to boot up.
>> Here are the 2 lines in kernel log when failed:
>> kernel: Kernel logging (proc) stopped.
>> rsyslogd: [origin software=3D"rsyslogd" swVersion=3D"5.8.6" x-pid=3D"580=
"
>> x-info=3D"http://www.rsyslog.com"] exiting on signal 15.
>> I think I followed the guide in "TROUBLESHOOTING" section & "Configuring=
 for
>> x86-based dual kernels" but maybe I missed something.
>> I attached the kernel config file, if any1 can show me where I was wrong=
 I'll be
>> very grateful.
>=20
> As explained on this page:
> https://xenomai.org//asking-for-help/
>=20
> We need much more than two lines of the logs to help you.
>=20
In fact, I tried to investigate further on the problem, it seems that it on=
ly occurs if I tried to build RTNet in kernel, if I builded it as module, I=
 can boot into the kernel normally:
CONFIG_XENO_DRIVERS_NET=3Dm

Is this a normal behavior?

And also, I have problem when trying to load rtpacket & rtcap modules.=20

Some more informations about my system:=20
arch x86_64
Intel Core i5-4250U 1.3 GHz
xenomai-3-next (most recent commit) patched on linux 3.14.17
boot options: ro quiet splash xenomai.smi=3D-1 elevator=3Ddeadline vt.hando=
ff=3D7=20
xenomai lib build options: --with-core=3Dcobalt --enbale-smp --enable-pshar=
ed --enable-dlopen-libs
Ethernet controller: Intel Corporation Ethernet Connection I218-V (run with=
 rt_e1000e in realtime)

Thanks for your help!

> --
> =09=09=09=09=09    Gilles.

--=20
Huy Cong
Wandercraft SAS

