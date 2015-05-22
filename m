Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (1.0)
From: "Yogi A. Patel" <yapatel@gatech.edu>
In-Reply-To: <20150522215216.GB1987@hermes.click-hack.org>
Date: Fri, 22 May 2015 18:00:56 -0400
Content-Transfer-Encoding: quoted-printable
Message-Id: <64026009-C15A-45D5-B090-94546E3E25BB@gatech.edu>
References: <245D3361-0412-466A-BFA1-22F2EDDC18B6@gatech.edu>
 <20150522210503.GA1987@hermes.click-hack.org>
 <9184F070-BBB8-44F8-AD64-79536BCDFA52@gatech.edu>
 <20150522215216.GB1987@hermes.click-hack.org>
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
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

> On May 22, 2015, at 17:52, Gilles Chanteperdrix <gilles.chanteperdrix@xeno=
mai.org> wrote:
>=20
>> On Fri, May 22, 2015 at 05:37:16PM -0400, Yogi A. Patel wrote:
>>=20
>>> On May 22, 2015, at 17:05, Gilles Chanteperdrix <gilles.chanteperdrix@xe=
nomai.org> wrote:
>>>=20
>>> On Fri, May 22, 2015 at 04:47:59PM -0400, Yogi A. Patel wrote:
>>>> Hi -
>>>>=20
>>>> I have a Dell OptiPlex 9020 running 3.14.17. I am trying to get this sy=
stem to run 3.14.17 with xenomai (using the 3.14.17 patch in the xenomai 2.6=
.4 source).
>>>>=20
>>>> The computer hangs when I select the kernel at =E2=80=9CLoading initial=
 ram disk=E2=80=9D. I tried booting into recovery mode and go the following o=
utput:
>>>>=20
>>>> Kernel panic - not syncing: timer doesn=E2=80=99t work through Interrup=
t-remapped IO-APIC.
>>>> CPU: 0 PID: 1 Comm: swapper/0 Not tainted 3.14.17-xenomai-2.6.4.
>>>>=20
>>>> I=E2=80=99m having a hard time finding the source of the error. I=E2=80=
=99ve attached my config file. Any suggestions appreciated!
>>>=20
>>> Does the exact same kernel configuration, but without CONFIG_IPIPE
>>> and CONFIG_XENOMAI work ?
>>>=20
>>> --=20
>>>                        Gilles.
>>=20
>> Sorry, I may have misunderstood but if you=E2=80=99re asking if 3.14.17 w=
orks out of the box (withough being patched), then yes it does work.
>=20
> The question is: with the exact same configuration?
>=20
> --=20
>                        Gilles.

I can't get the kernel to compile if I turn those two options off (but leave=
 everything else the same).

I get the following error:=20

kernel/fork.c: In function =E2=80=98dup_task_struct=E2=80=99:
kernel/fork.c:317:29: error: =E2=80=98struct thread_info=E2=80=99 has no mem=
ber named =E2=80=98ipipe_data=E2=80=99
__ipipe_init_threadinfo(&ti->pipe_data);
make[2] *** [kernel/fork.o] Error 1
make[1] *** [kernel] Error 2

Yogi=

