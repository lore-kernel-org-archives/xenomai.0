Message-ID: <55BB9D9F.5050508@free.fr>
Date: Fri, 31 Jul 2015 18:09:03 +0200
From: =?windows-1252?Q?St=E9phane_ANCELOT?= <sancelot@free.fr>
MIME-Version: 1.0
References: <55B9E768.6050209@free.fr>
In-Reply-To: <55B9E768.6050209@free.fr>
Content-Type: text/plain; charset="windows-1252"; format="flowed"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] running as user issue
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

giving a+rwx access to /dev/shm/xeno:mysession.heap permits to run=20
xenomai_init,
but unfortunately, the heap alloc / binds do not work.
Regards,
S.Ancelot

On 30/07/2015 10:59, St=E9phane ANCELOT wrote:
> Hi,
>
> I have problems running as user.
>
> pshared mode is enabled,
> conf tunables are defined (session_label , and mem_pool_size overloaded)
> and the program is running as root.
>
> user's group 1000 has been echoed to=20
> /sys/module/xenomai/parameters/allowed_group
>
> xenomai_init() reports EACCESS, although ulimit set up to unlimited=20
> memory lock.
>
>
> ulimit -a
> core file size          (blocks, -c) 0
> data seg size           (kbytes, -d) unlimited
> scheduling priority             (-e) 0
> file size               (blocks, -f) unlimited
> pending signals                 (-i) 15346
> max locked memory       (kbytes, -l) unlimited
> max memory size         (kbytes, -m) unlimited
> open files                      (-n) 65536
> pipe size            (512 bytes, -p) 8
> POSIX message queues     (bytes, -q) 819200
> real-time priority              (-r) 0
> stack size              (kbytes, -s) 8192
> cpu time               (seconds, -t) unlimited
> max user processes              (-u) 15346
> virtual memory          (kbytes, -v) unlimited
> file locks                      (-x) unlimited
>
>
>  ./print_erreur
> conf tunable
> mem pool size=3D5000000
>    0"003.362| WARNING: [main] failed to initialize main shared heap
>    0"003.439| WARNING: [main] setup call copperplate failed
>    0"003.493| BUG in xenomai_init(): [main] initialization failed, EACCES
>
> Regards,
> Steph
>
>
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> http://xenomai.org/mailman/listinfo/xenomai


