From: =?utf-8?q?Fran=C3=A7ois_Legal?= <devel@thom.fr.eu.org>
MIME-Version: 1.0
Date: Mon, 31 May 2021 18:06:48 +0200
Subject: Hunting mode switches
Message-ID: <10a7-60b50980-27-35a6e6c0@188334738>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hello,

I'm having trouble hunting mode switches on an arm embedded application=
.

When I look at cat /proc/xenomai/sched/stat

CPU  PID    MSW        CSW        XSC        PF    STAT       %CPU  NAM=
E
  0  0      0          476986     0          0     00218000   84.5  [RO=
OT/0]
  1  0      0          137743     0          0     00218000   99.3  [RO=
OT/1]
  1  667    0          137550     0          0     00200042    0.7  [rt=
net-stack]
  0  669    0          2          0          0     00220042    0.0  [rt=
net-rtpc]
  1  901    110        218        203        0     00264044    0.0  APP=
=5FMain
  0  911    1          1216       3524       0     00240046    0.0  Thr=
eadPar
  0  912    3          56683      3531       0     00240046    0.2  Thr=
eadMessage
  0  913    309702     470522     2152301    0     00240046    8.9  Thr=
eadExec
  0  914    7          62         71         0     00240042    0.0  The=
adGO
  0  915    3          647        1190       0     00248046    0.0  Thr=
eadDbg
  0  916    1          2024       3087       0     00248046    0.0  Thr=
eadCt
  0  917    1          35801      320489     0     00248046    0.8  Thr=
eadSupInv
  0  918    1          1231       3596       0     00248046    0.0  Thr=
eadMessage2
  0  919    1          161554     479305     0     00248042    1.4  Thr=
eadSched
  0  0      0          247850     0          0     00000000    0.4  [IR=
Q18: [timer]]
  1  0      0          15419      0          0     00000000    0.0  [IR=
Q18: [timer]]
  0  0      0          137548     0          0     00000000    1.5  [IR=
Q31: rteth0]
  1  0      0          0          0          0     00000000    0.0  [IR=
Q31: rteth0]
  0  0      0          1          0          0     00000000    0.0  [IR=
Q118: rteth1-tx]
  1  0      0          0          0          0     00000000    0.0  [IR=
Q118: rteth1-tx]
  0  0      0          0          0          0     00000000    0.0  [IR=
Q119: rteth1-rx]
  1  0      0          0          0          0     00000000    0.0  [IR=
Q119: rteth1-rx]

But when following the procedure in [1], I get 
no slacker

I can however see that Thread 913 seem to switch to secondary more than=
 once out of 2 cycles !
What am I doing wrong.

Thanks in advance

Fran=C3=A7ois

[1] : https://source.denx.de/Xenomai/xenomai/-/wikis/Finding=5FSpurious=
=5FRelaxes


