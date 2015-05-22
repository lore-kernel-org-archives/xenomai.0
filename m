Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
From: "Yogi A. Patel" <yapatel@gatech.edu>
In-Reply-To: <20150522210503.GA1987@hermes.click-hack.org>
Date: Fri, 22 May 2015 17:22:24 -0400
Message-Id: <C3F5C748-508E-49F2-BE52-80AE06082D8E@gatech.edu>
References: <245D3361-0412-466A-BFA1-22F2EDDC18B6@gatech.edu>
 <20150522210503.GA1987@hermes.click-hack.org>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] 3.14.17 patch initial ram disk hangup
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

> On May 22, 2015, at 17:05, Gilles Chanteperdrix =
<gilles.chanteperdrix@xenomai.org> wrote:
>=20
> On Fri, May 22, 2015 at 04:47:59PM -0400, Yogi A. Patel wrote:
>> Hi -
>>=20
>> I have a Dell OptiPlex 9020 running 3.14.17. I am trying to get this =
system to run 3.14.17 with xenomai (using the 3.14.17 patch in the =
xenomai 2.6.4 source).
>>=20
>> The computer hangs when I select the kernel at =E2=80=9CLoading =
initial ram disk=E2=80=9D. I tried booting into recovery mode and go the =
following output:
>>=20
>> Kernel panic - not syncing: timer doesn=E2=80=99t work through =
Interrupt-remapped IO-APIC.
>> CPU: 0 PID: 1 Comm: swapper/0 Not tainted 3.14.17-xenomai-2.6.4.
>>=20
>> I=E2=80=99m having a hard time finding the source of the error. =
I=E2=80=99ve attached my config file. Any suggestions appreciated!
>=20
> Does the exact same kernel configuration, but without CONFIG_IPIPE
> and CONFIG_XENOMAI work ?
>=20
> --=20
> 					    Gilles.


I disabled CONFIG_XENOMAI and CONFIG_IPIPE - but when recompiling the =
kernel, I get:

kernel/fork.c: In function =E2=80=98dup_task_struct=E2=80=99:
kernel/fork.c:317:29: error: =E2=80=98struct thread_info=E2=80=99 has no =
member named =E2=80=98ipipe_data=E2=80=99
__ipipe_init_threadinfo(&ti->pipe_data);
make[2] *** [kernel/fork.o] Error 1
make[1] *** [kernel] Error 2

I checked the config and both of those are set to =E2=80=9Cn=E2=80=9D. =
What am I missing?

