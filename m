From: MONTET Julien <julien.montet@reseau.eseo.fr>
Subject: Docker  - Xenomai hangs on rt_task_wait_period()
Date: Tue, 22 Jun 2021 16:38:33 +0000
Message-ID: <AM7PR02MB61947BF8EFF0C1BCEE882A1AD1099@AM7PR02MB6194.eurprd02.prod.outlook.com>
Content-Language: fr-FR
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

Hello the developers,

I have been using Xenomai for the past two months on different targets / sk=
ins / architectures, and it is a great real time solution !
For the past few days, I have been trying to use my code on a docker :

  *   Compiled on a debian 10.9 with Xenomai libraries (3.1) for an ARM tar=
get
  *   This code runs on a raspberry pi 3B with an IPIPE patch (Cobalt)
  *   The kernel version is 4.19+

My code is running fine with different methods, there is no crash.
However, the execution hangs when  I use the couple rt_task_set_periodic/rt=
_task_wait_period.
Methods such as "RTIME", rt_printf(), rt_task_set_periodic() do not hangs, =
but my code seems to keep waiting on rt_task_wait_period().

I am aware someone had this issue four years ago :
https://xenomai.org/pipermail/xenomai/2017-November/037890.html
According to the link above, Cobalt does not support PID namespaces.
I also understood it is needed to convert vpid <-> pid by using the find_ta=
sk_vpid().

I am not an expert on the interaction between Docker and Linux - specifical=
ly on PID.
Is it a normal behaviour in my case ? Where would it be interesting to make=
 these changes ?
What is the link between RT_TASK and PID / vPID ?

Regards,

Julien
