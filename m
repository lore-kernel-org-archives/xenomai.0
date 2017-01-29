References: <8de4d9c7-231a-d954-5926-3a0367ed839e@numalliance.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <2b9cc063-765e-0246-c999-65701f980952@xenomai.org>
Date: Sun, 29 Jan 2017 16:04:28 +0100
MIME-Version: 1.0
In-Reply-To: <8de4d9c7-231a-d954-5926-3a0367ed839e@numalliance.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] init_memory_pool error
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?UTF-8?Q?St=c3=a9phane_Ancelot?= <sancelot@numalliance.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 01/25/2017 05:58 PM, St=E9phane Ancelot wrote:
> Hi,
>=20
> I am stuck with the next branch of xenomai, when using tune variables .
>=20
> when launching the program without any parameters , I have the next
> error message :
>=20
> init_memory_pool(): invalid pool
>    0"006.881| BUG in heapobj_pkg_init_private(): [main] cannot
> initialize TLSF memory manager
>=20
> however, if I launch it with --mem-pool-size option, it runs ....
>=20
> here is what I setted up in tunables variables :
>=20
> static int foo_tune(void)
> {
>=20
>              set_config_tunable(session_label, "toot");
>             set_config_tunable(mem_pool_size,8000000);
>             printf("mem pool size=3D%ld\n",
> get_config_tunable(mem_pool_size));
>             return 0; /* Success, otherwise -errno */
> }
>=20

A TLSF issue revealed by a recent commit. Fixed by this one:
http://git.xenomai.org/xenomai-3.git/commit/?h=3Dstable-3.0.x&id=3D00e3d016=
519efc54cb2b2b33437814ff6725cf33

--=20
Philippe.

