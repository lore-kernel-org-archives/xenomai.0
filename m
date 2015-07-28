Date: Tue, 28 Jul 2015 15:19:11 +0000 (UTC)
From: Frederik Bayart <frederik_bayart@yahoo.co.uk>
Message-ID: <1320019080.4249709.1438096751088.JavaMail.yahoo@mail.yahoo.com>
In-Reply-To: <55A7CF2E.40508@xenomai.org>
References: <55A7CF2E.40508@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] xenomai-3.0-rc5 : binding named semaphores from
 external process
Reply-To: Frederik Bayart <frederik_bayart@yahoo.co.uk>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

>> ./stest --session=3Dfoo 1
>>
>> The first process binds to the named semaphore which is not yet created.=
 According to the description of rt_sem_bind,=C2=A0 if the object does not =
exist on entry, the caller may block until a semaphore of the given name is=
 created.
>>
>> So based on this description, I would I expect that if the second proces=
s is started, the first process would bind and continue and blocks in the p=
 operation. The same for the 2nd process. Is this correct ? At the moment, =
if I start the 2nd process, I get a segfault in rt_sem_create :
>>
>> [ 9758.887921] [Xenomai] switching main to secondary mode after exceptio=
n #14 from user-space at 0x7f6ad8c4a43e (pid 9256)
>> [ 9758.887930] main[9256]: segfault at 7f903bf6e038 ip 00007f6ad8c4a43e =
sp 00007fffbd2c2eb8 error 6 in libcobalt.so.2.0.0[7f6ad8c3d000+1e000]
>>
>
>Looking at the copperplate code, yep, this definitely can't work. Ok,
>queued.

I noticed also :

=C2=A0./stest --session=3Dfoo 1
=C2=A0./stest --session=3Dfoo 0

Both processes are waiting in rt_sem_p . The first process catches SIGINT, =
the second doesn't. If you press CTRL+C on the second process it stops but =
also the first process is falling through the rt_sem_p although no rt_sem_v=
 is raised. At that moment no process is pending on rt_sem_p anymore. But i=
f you do then a rt_sem_inquire, nwaiters is still 1.
>
>>
>> 2)
>>
>> The fuse filesystem is not unmounted. This is because in xenomai-3.0-rc5=
/lib/copperplate/regd/regd.c the fullpath is hardcoded to fusermount and um=
ount
>>
>> I could fixed it, with the diff below. It's not clear to me why access o=
f umount is tested and not from fusermount.
>>
>
>Piping the "which" output seems seriously overkill. Besides, we don't
>want to rely on the environment to find those paths, we are running with
>supervisor privileges (i.e. we don't want to run what the user tells us
>what "umount" should be, but rather what the distro actually says
>"umount" is).
>
>Per LSB 3.0, /bin/umount would be the place to find this, so basically,
>testing a couple of reasonable locations should be enough.
>
>
>--=20
>Philippe.
