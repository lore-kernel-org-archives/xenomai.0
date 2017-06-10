From: Giulio Moro <g.moro@qmul.ac.uk>
Date: Sat, 10 Jun 2017 19:36:19 +0000
Message-ID: <AM5PR0701MB244908F6BCB8CD90B348F81EB5CF0@AM5PR0701MB2449.eurprd07.prod.outlook.com>
References: <DB6PR0701MB2456788DAE300E14759F9646B5E10@DB6PR0701MB2456.eurprd07.prod.outlook.com>,
 <ee8f012f-ef3d-fdfc-96d6-8318e1f58dfd@xenomai.org>
In-Reply-To: <ee8f012f-ef3d-fdfc-96d6-8318e1f58dfd@xenomai.org>
Content-Language: en-GB
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai] rt_task_bind returns -EINVAL when not using
 --enable-smp
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, "xenomai@xenomai.org" <xenomai@xenomai.org>

re-upping this old one just to say that on the newer kernel I have (Xenomai=
 3.0.5 here on kernel 4.4.68-ti-xenomai-r106 ) I cannot reproduce this one =
(with or without smp I get the result I reported in the new thread I just s=
tarted).
________________________________________
From: Philippe Gerum <rpm@xenomai.org>
Sent: 16 May 2017 10:56
To: Giulio Moro; xenomai@xenomai.org
Subject: Re: [Xenomai] rt_task_bind returns -EINVAL when not using --enable=
-smp

On 05/15/2017 12:04 PM, Giulio Moro wrote:
> Hi,
> I have a 4.4.61 kernel with Xenomai 3.0.4 on am335x (BeagleBone Black) co=
mpiled with
>
> CONFIG_BROKEN_ON_SMP=3Dy
> CONFIG_GENERIC_SMP_IDLE_THREAD=3Dy
> CONFIG_HAVE_SMP=3Dy
> # CONFIG_SMP is not set
> (see XENO flags at the bottom of the email)
>
> When I compile the user-space support with
>     /root/xenomai/configure --with-core=3Dcobalt --enable-smp --enable-ps=
hared
> my program (which uses the Alchemy API) works fine
>
> But when I do it with
>     /root/xenomai/configure --with-core=3Dcobalt --enable-pshared
> , then calls to rt_task_bind or rt_task_create return -EINVAL.
>

I can't reproduce this issue. You may want to check that your
application is compatible with your kernel setup by looking at the
output of <your-app> --dump-config.

e.g.

# latency --dump-config
based on Xenomai/cobalt v3.0.4 -- #90a7ab2 (2017-05-16 11:12:57 +0200)
CONFIG_MMU=3D1
CONFIG_XENO_BUILD_ARGS=3D" '--host=3Darm-linux-gnueabihf' '--prefix=3D/usr'
'--includedir=3D/usr/include/xenomai' '--disable-doc-install'
'--disable-smp' '--disable-tls' '--disable-debug'
'--disable-valgrind-client' '--with-core=3Dcobalt' '--enable-pshared'
'host_alias=3Darm-linux-gnueabihf'"
CONFIG_XENO_BUILD_STRING=3D"x86_64-unknown-linux-gnu"
CONFIG_XENO_COBALT=3D1
...

> Given that SMP is not enabled in the kernel, I would expect the latter to=
 be the correct one and possibly the former to fail.

Running a SMP-capable application on a UP kernel is a non-issue, this
just means that the application code is going to emit memory barriers
uselessly in some cases. The opposite configuration is a problem though,
which the cobalt core detects, i.e.

   0"000.000| BUG in __xenomai_init(): [main] running non-SMP libraries
on SMP kernel?
              build with --enable-smp or disable check with --no-sanity

>
> Note that /usr/xenomai/bin/xeno-test and /usr/xenomai/bin/latency work ok=
 in both cases.
>

You may want to check with demo/altency, which is the strict equivalent
of the latency test written with the legacy alchemy API.

--
Philippe.

