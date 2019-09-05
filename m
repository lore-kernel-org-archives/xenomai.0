From: Johann Obermayr <johann.obermayr@sigmatek.at>
Subject: Task Priority & Domain switch
Date: Thu, 5 Sep 2019 13:26:57 +0000
Message-ID: <VI1PR08MB337564202AA59428E7A0C1A5F5BB0@VI1PR08MB3375.eurprd08.prod.outlook.com>
Content-Language: de-DE
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hello,

i need some explain about task priority & domain switch.


  1.  Xenomai 2.6.x ( CONFIG_XENO_OPT_PERVASIVE=3Dy    CONFIG_XENO_OPT_PRIO=
CPL=3Dy )

rt_task_shadow( &handle, 0 );

task running default in releaxed ( secondary domain). After take a xenomai =
mutex lock, it switch to the primary domain.

After mutex unlock the task switch back to secondary domain or after next x=
enomai-function call ?



rt_task_shadow( &handle, 10 );

task run default in primary domain. After do  a linux-syscall  , the task s=
witch to secondary domain.

With XENO_OPT_PRIOCPL it take the xenomai priority 10 to Linux rt_priority =
10.

After call a xenomai function, it switch back to primary domain.





  1.  Xenomai 3.0.x

Is there a different work to xenomai 2.6.x ?




Or where can I found more information about this theme ?

Thanks & regards
                Johann

PS: I known that xenomai 2.6.x is out of date. But we must support some old=
 versions.
