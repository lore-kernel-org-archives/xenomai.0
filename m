References: <48e48b6a-c767-1ae0-29cf-e59dd9c9c0d4@numalliance.com>
 <48cfcb4c-0d7a-3d6e-1b3f-2967df5e7faf@xenomai.org>
From: =?UTF-8?Q?St=c3=a9phane_Ancelot?= <sancelot@numalliance.com>
Message-ID: <ed170aa1-e433-a20b-df07-ebd6ec6dcb60@numalliance.com>
Date: Mon, 19 Mar 2018 10:13:50 +0100
MIME-Version: 1.0
In-Reply-To: <48cfcb4c-0d7a-3d6e-1b3f-2967df5e7faf@xenomai.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] shared session and latest release
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, "xenomai@xenomai.org" <xenomai@xenomai.org>



Le 16/03/2018 =C3=A0 19:59, Philippe Gerum a =C3=A9crit=C2=A0:
> On 03/16/2018 12:19 PM, St=C3=A9phane Ancelot wrote:
>> Hi,
>>
>> I upgraded my applications to latest release (next branch) .
> The next branch is by definition NOT released, this is a development tr=
ee.
>
>> I do not manage to run the shared session , using session-label to run
>> the program as user (fixed in a tunable config)
>>
>> my session name is numalliance/automat (automat corresponds to my grou=
p
>> user id 1000)
>>
>> however , if I launch the program as root , it works.
>>
>> I checked /dev/rtdm files, they all have rw access for user/ group / o=
ther
>>
>> What else to check for ?
>>
>> it fails as follow :
>>     0"000.413| WARNING: [main] failed to initialize main shared heap
>>     0"000.480| WARNING: [main] setup call copperplate failed
>>     0"000.508| BUG in __xenomai_init(): [main] initialization failed,
> EACCES
> {rpm@cobalt} git grep -B2 "failed to initialize main shared heap"
> lib/copperplate/init.c-	ret =3D heapobj_pkg_init_shared();
> lib/copperplate/init.c-	if (ret) {
> lib/copperplate/init.c:		warning("failed to initialize main shared heap=
");
>
> You do know which error is spat out (EACCES), and you know which code i=
s
> involved. You should be able to fire a debugger, and find out what is
> going on with the inits.
>
> This would be a step in the right direction for turning the -next branc=
h
> into a release at some point.
>
Ok, the problem was comming from our code, at creation of heap that had=20
not used the same session_label....and thus a different gid..

However, the reason we tried next branch is from a=C2=A0 deeper problem t=
hat=20
is also in stable branch.
We reached a=C2=A0 case where the heap has been broken after linking an h=
eap=20
area .
this is not easy to reproduce since this occured only when we added a=20
new memory area.
changing order of creation hides the problem.....

any new process that want next link to the heap, segfaults .
/lib64/libc.so.6(+0x34950) [0x7f0a6c28d950]
/usr/xenomai-3.0-git/lib/libcobalt.so.2(hash_search_probe+0xb3)=20
[0x7f0a6f34d1a3]
/usr/xenomai-3.0-git/lib/libcopperplate.so.0(syncluster_findobj+0x84)=20
[0x7f0a6f562904]
/usr/xenomai-3.0-git/lib/libalchemy.so.0(alchemy_bind_object+0xa2)=20
[0x7f0a6f773b12]

We will try to track when code is corrupted. if you have some hints,=20
please advice.
Regards
S.Ancelot


