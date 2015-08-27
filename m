Message-ID: <55DEB6E6.6030608@free.fr>
Date: Thu, 27 Aug 2015 09:06:14 +0200
From: =?windows-1252?Q?St=E9phane_ANCELOT?= <sancelot@free.fr>
MIME-Version: 1.0
References: <55B9E768.6050209@free.fr> <55BB9D9F.5050508@free.fr>
 <55BBA495.1000102@xenomai.org> <55C1C32B.3040409@free.fr>
In-Reply-To: <55C1C32B.3040409@free.fr>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="windows-1252"; Format="flowed"
Subject: Re: [Xenomai] running as user issue
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi,

Enclosed you will find a heap regression test program.
The main problem, is that I am not able to bind it using normal user , =

using pshared and session mode.

  xenomai configure flags: --enable-smp --enable-pshared =

--enable-dlopen-libs --enable-tls

  running this program does follwoing things:
  as root user, creates and alloc heap
  as normal user, bind to the created heap by root user  and alloc it

  as root user :
  umask 0002
  ./heaptest

  now, as user in the 1000 gid group . 1000 gid group is added to the =

root group:
  ./heaptest
  =3D> problem it does not manage to bind it.


On 05/08/2015 10:02, St=E9phane ANCELOT wrote:
> On 31/07/2015 18:38, Philippe Gerum wrote:
>> On 07/31/2015 06:09 PM, St=E9phane ANCELOT wrote:
>>> giving a+rwx access to /dev/shm/xeno:mysession.heap permits to run
>>> xenomai_init,
>> This does not make sense unless you are trying to bind to an existing
>> session with incompatible user privileges.
> Do you mean it is not possible to "mix" user privileges. I mean =

> running a root process and another one as user ? Because this may be =

> my problem, some processes are running root and gui's processes as =

> user . Do I need to switch all processes to the same world ...?
>>
>>> but unfortunately, the heap alloc / binds do not work.
>> I'm sorry, I have no clue about what you are trying to do. More details
>> would probably help, like how many processes share the same session,
>> what are their respective user/privileges, which Xenomai-specific
>> command line switches are passed to them?
>>
>>> Regards,
>>> S.Ancelot
>>>
>>> On 30/07/2015 10:59, St=E9phane ANCELOT wrote:
>>>> Hi,
>>>>
>>>> I have problems running as user.
>>>>
>>>> pshared mode is enabled,
>>>> conf tunables are defined (session_label , and mem_pool_size =

>>>> overloaded)
>>>> and the program is running as root.
>>>>
>>>> user's group 1000 has been echoed to
>>>> /sys/module/xenomai/parameters/allowed_group
>>>>
>>>> xenomai_init() reports EACCESS, although ulimit set up to unlimited
>>>> memory lock.
>>>>
>>>>
>>>> ulimit -a
>>>> core file size          (blocks, -c) 0
>>>> data seg size           (kbytes, -d) unlimited
>>>> scheduling priority             (-e) 0
>>>> file size               (blocks, -f) unlimited
>>>> pending signals                 (-i) 15346
>>>> max locked memory       (kbytes, -l) unlimited
>>>> max memory size         (kbytes, -m) unlimited
>>>> open files                      (-n) 65536
>>>> pipe size            (512 bytes, -p) 8
>>>> POSIX message queues     (bytes, -q) 819200
>>>> real-time priority              (-r) 0
>>>> stack size              (kbytes, -s) 8192
>>>> cpu time               (seconds, -t) unlimited
>>>> max user processes              (-u) 15346
>>>> virtual memory          (kbytes, -v) unlimited
>>>> file locks                      (-x) unlimited
>>>>
>>>>
>>>>   ./print_erreur
>>>> conf tunable
>>>> mem pool size=3D5000000
>>>>     0"003.362| WARNING: [main] failed to initialize main shared heap
>>>>     0"003.439| WARNING: [main] setup call copperplate failed
>>>>     0"003.493| BUG in xenomai_init(): [main] initialization failed, =

>>>> EACCES
>>>>
>>>> Regards,
>>>> Steph
>>>>
>>>>
>>>> _______________________________________________
>>>> Xenomai mailing list
>>>> Xenomai@xenomai.org
>>>> http://xenomai.org/mailman/listinfo/xenomai
>>>
>>> _______________________________________________
>>> Xenomai mailing list
>>> Xenomai@xenomai.org
>>> http://xenomai.org/mailman/listinfo/xenomai
>>>
>>
>
>
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> http://xenomai.org/mailman/listinfo/xenomai

-------------- next part --------------
A non-text attachment was scrubbed...
Name: heaptest.cpp
Type: text/x-c++src
Size: 2493 bytes
Desc: not available
URL: <http://xenomai.org/pipermail/xenomai/attachments/20150827/74e2ce25/at=
tachment.cpp>
