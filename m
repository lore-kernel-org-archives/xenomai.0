From: Marcel Van Mierlo <Marcel.VanMierlo@marel.com>
Date: Fri, 13 May 2016 13:27:34 +0000
Message-ID: <AM4PR05MB17479649FDCD91F251E66DB991740@AM4PR05MB1747.eurprd05.prod.outlook.com>
Content-Language: en-GB
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] what limits number of pSOS tasks using t_create?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi,


Which parameters limit the number of psos skin tasks that can be created us=
ing t_create()? (ARM (Beagle), Xenomai 3.0).

At the moment I am getting ERR_NOTCB back after creating about 118 tasks (j=
ust calling t_create not t_start). In production we are hitting the limit a=
t about 70 tasks...though sometimes we can go a bit higher.

>From the documentation I see:

* t_create() returns ERR_NOTCB upon memory allocation failure when
trying to get a task control block from the nucleus heap. There is
no control block limit for tasks.


So I adjusted the following:

CONFIG_XENO_OPT_SYS_HEAPSZ=3D1024
CONFIG_XENO_OPT_PRIVATE_HEAPSZ=3D128
CONFIG_XENO_OPT_SHARED_HEAPSZ=3D128

but increasing (doubling) these made no difference to maximum number of tas=
ks which can be created...


This is the guts of the test:

      for (i =3D 0; i < limit; i++)
      {
        result =3D t_create("MAX_THREAD_TEST", 200, 0x1000, 0x1000, T_LOCAL=
, &tids[i]);
        if (result !=3D 0)
          break;
      }


