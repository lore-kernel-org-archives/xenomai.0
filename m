References: <48e48b6a-c767-1ae0-29cf-e59dd9c9c0d4@numalliance.com>
 <48cfcb4c-0d7a-3d6e-1b3f-2967df5e7faf@xenomai.org>
 <ed170aa1-e433-a20b-df07-ebd6ec6dcb60@numalliance.com>
From: =?UTF-8?Q?St=c3=a9phane_Ancelot?= <sancelot@numalliance.com>
Message-ID: <3c39509b-67d4-7c46-7a8b-4b63b149e318@numalliance.com>
Date: Mon, 19 Mar 2018 15:37:33 +0100
MIME-Version: 1.0
In-Reply-To: <ed170aa1-e433-a20b-df07-ebd6ec6dcb60@numalliance.com>
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
To: xenomai@xenomai.org

Hi,

We finally found a memory access out of bounds in our code .

the latest branch next works with pshared mode regarding memory heaps.

Regards,
S.Ancelot

Le 19/03/2018 =C3=A0 10:13, St=C3=A9phane Ancelot a =C3=A9crit=C2=A0:
>
>
> Le 16/03/2018 =C3=A0 19:59, Philippe Gerum a =C3=A9crit=C2=A0:
>> On 03/16/2018 12:19 PM, St=C3=A9phane Ancelot wrote:
>>> Hi,
>>>
>>> I upgraded my applications to latest release (next branch) .
>> The next branch is by definition NOT released, this is a development=20
>> tree.
>>
>>> I do not manage to run the shared session , using session-label to ru=
n
>>> the program as user (fixed in a tunable config)
>>>
>>> my session name is numalliance/automat (automat corresponds to my gro=
up
>>> user id 1000)
>>>
>>> however , if I launch the program as root , it works.
>>>
>>> I checked /dev/rtdm files, they all have rw access for user/ group /=20
>>> other
>>>
>>> What else to check for ?
>>>
>>> it fails as follow :
>>> =C2=A0=C2=A0=C2=A0 0"000.413| WARNING: [main] failed to initialize ma=
in shared heap
>>> =C2=A0=C2=A0=C2=A0 0"000.480| WARNING: [main] setup call copperplate =
failed
>>> =C2=A0=C2=A0=C2=A0 0"000.508| BUG in __xenomai_init(): [main] initial=
ization failed,
>> EACCES
>> {rpm@cobalt} git grep -B2 "failed to initialize main shared heap"
>> lib/copperplate/init.c-=C2=A0=C2=A0=C2=A0 ret =3D heapobj_pkg_init_sha=
red();
>> lib/copperplate/init.c-=C2=A0=C2=A0=C2=A0 if (ret) {
>> lib/copperplate/init.c:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 warn=
ing("failed to initialize main=20
>> shared heap");
>>
>> You do know which error is spat out (EACCES), and you know which code =
is
>> involved. You should be able to fire a debugger, and find out what is
>> going on with the inits.
>>
>> This would be a step in the right direction for turning the -next bran=
ch
>> into a release at some point.
>>
> Ok, the problem was comming from our code, at creation of heap that=20
> had not used the same session_label....and thus a different gid..
>
> However, the reason we tried next branch is from a=C2=A0 deeper problem=
=20
> that is also in stable branch.
> We reached a=C2=A0 case where the heap has been broken after linking an=
=20
> heap area .
> this is not easy to reproduce since this occured only when we added a=20
> new memory area.
> changing order of creation hides the problem.....
>
> any new process that want next link to the heap, segfaults .
> /lib64/libc.so.6(+0x34950) [0x7f0a6c28d950]
> /usr/xenomai-3.0-git/lib/libcobalt.so.2(hash_search_probe+0xb3)=20
> [0x7f0a6f34d1a3]
> /usr/xenomai-3.0-git/lib/libcopperplate.so.0(syncluster_findobj+0x84)=20
> [0x7f0a6f562904]
> /usr/xenomai-3.0-git/lib/libalchemy.so.0(alchemy_bind_object+0xa2)=20
> [0x7f0a6f773b12]
>
> We will try to track when code is corrupted. if you have some hints,=20
> please advice.
> Regards
> S.Ancelot
>
>
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> https://xenomai.org/mailman/listinfo/xenomai

