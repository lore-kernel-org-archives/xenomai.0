From: Steve Hartmann <shartmann@cnt.canon.com>
Date: Thu, 21 Aug 2014 20:04:27 +0000
Message-ID: <D01BBA98.18467%shartmann@cnt.canon.com>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] ENOMEM returned from rt_task_create and rt_sem_create
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi folks,

I am using linux 3.2.21 + xenomai 2.6.2.1 on intel core i7.  This is a user=
 land application.

This code I am having issues with was working pretty well until I added som=
e more semaphores.  As it runs right now, it will call rt_sem_create 544 ti=
mes, then call a single rt_task_create.  There are also about 15 mutexes cr=
eated also.  I didn't count it, but somewhere around 520 or so semaphores, =
I start getting ENOMEM returned from both of these methods.

Is there a way I can increase whatever memory pool these are pulling from? =
 It is feasible to rewrite the code so I use less semaphores, but if it is =
not detrimental, I would like to just raise whatever limit it is that I am =
running into.

Thanks,


Steve
