Message-ID: <1342306481.94440.YahooMailNeo@web193905.mail.sg3.yahoo.com>
Date: Sun, 15 Jul 2012 06:54:41 +0800 (SGT)
From: Uttamkumar Sinojia <uttamkumarsinojia@yahoo.in>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] Jitter-test
Reply-To: Uttamkumar Sinojia <uttamkumarsinojia@yahoo.in>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

=0A=0ARespected sir,=0A=0AI have prepared a setup for checking the scheduli=
ng=A0jitter=A0values(current time - expected=A0wake-up=A0time) among five p=
eriodic task having same priority.=0A=0AI have created 5 periodic real-time=
 tasks with equal priority(say, 5) and wake them at the same time.=0AChoose=
n task periods of 100us, 200us, 300us, 400us and 500us , respectively. Here=
 in this case when more than one tasks are going to wake-up at same=A0expec=
ted time, which process will be scheduled should be non-deterministic and i=
 was getting it.=A0=0A=0AIn another case,=A0I have created=A05 periodic rea=
l-time tasks with equal priority(say, 5) and wake them at the same time.=A0=
Choosen task periods of 1ms, 2ms, 3ms, 4ms and 5ms , respectively. In this =
case i was getting the deterministic behavior in scheduling of the task(Whe=
n expected time for more than one task was same, task with larger period wa=
s woken-up first). So, i was not getting the reason for this deterministic =
behavior.=0A=0A=0A=0A[ 4530.480198] Xenomai: 1->iteration 1 ..expected task=
 wake-up....value =A0 =A0 =A0 =A0 1339875162478491464=A0=0A[ 4530.480200] X=
enomai: 1->iteration 1 ..actual task wake-up....value =A0 =A0 =A0 =A0 =A0 =
=A0 =A01339875162478491498=A0=0A[ 4530.480202] Xenomai: 1->1 th jitter init=
ial jitter after first task wake-up....value 34=A0=0A[ 4530.480206]=A0=0A=
=0A=0A[ 4530.481206] Xenomai: 2->iteration 1 ..expected task wake-up....val=
ue =A0 =A0 =A0 =A0 1339875162479491464=A0=0A=0A[ 4530.481209] Xenomai: 2->i=
teration 1 ..actual task wake-up....value =A0 =A0 =A0 =A0 =A0 =A0 =A0133987=
5162479492503=A0=0A[ 4530.481211] Xenomai: 2->1 th jitter initial jitter af=
ter first task wake-up....value 1039=A0=0A[ 4530.481216]=A0=0A[ 4530.481220=
] Xenomai: 1->iteration 2 ..expected task wake-up....value =A0 =A0 =A0 =A0 =
1339875162479491464=A0=0A=0A[ 4530.481223] Xenomai: 1->iteration 2 ..actual=
 task wake-up....value =A0 =A0 =A0 =A0 =A0 =A0 =A01339875162479496632=A0=0A=
[ 4530.481225] Xenomai: 1->2 th jitter initial jitter after first task wake=
-up....value 5168=A0=0A[ 4530.481230]=A0=0A=0A=0A[ 4530.482201] Xenomai: 3-=
>iteration 1 ..expected task wake-up....value =A0 =A0 =A0 =A0 1339875162480=
491464=A0=0A=0A[ 4530.482203] Xenomai: 3->iteration 1 ..actual task wake-up=
....value =A0 =A0 =A0 =A0 =A0 =A0 =A01339875162480491406=A0=0A[ 4530.482205=
] Xenomai: 3->1 th jitter initial jitter after first task wake-up....value =
-58=A0=0A[ 4530.482208]=A0=0A=0A[ 4530.482211] Xenomai: 1->iteration 3 ..ex=
pected task wake-up....value =A0 =A0 =A0 =A0 1339875162480491464=A0=0A=0A[ =
4530.482213] Xenomai: 1->iteration 3 ..actual task wake-up....value =A0 =A0=
 =A0 =A0 =A0 =A0 =A01339875162480494531=A0=0A[ 4530.482215] Xenomai: 1->3 t=
h jitter initial jitter after first task wake-up....value 3067=A0=0A[ 4530.=
482218]=A0=0A=0A=0A[ 4530.483204] Xenomai: 4->iteration 1 ..expected task w=
ake-up....value =A0 =A0 =A0 =A0 1339875162481491464=A0=0A=0A[ 4530.483206] =
Xenomai: 4->iteration 1 ..actual task wake-up....value =A0 =A0 =A0 =A0 =A0 =
=A0 =A01339875162481491620=A0=0A[ 4530.483208] Xenomai: 4->1 th jitter init=
ial jitter after first task wake-up....value 156=A0=0A[ 4530.483211]=A0=0A=
=0A[ 4530.483215] Xenomai: 2->iteration 2 ..expected task wake-up....value =
=A0 =A0 =A0 =A0 1339875162481491464=A0=0A=0A[ 4530.483216] Xenomai: 2->iter=
ation 2 ..actual task wake-up....value =A0 =A0 =A0 =A0 =A0 =A0 =A0133987516=
2481494697=A0=0A[ 4530.483218] Xenomai: 2->2 th jitter initial jitter after=
 first task wake-up....value 3233=A0=0A[ 4530.483221]=A0=0A=0A[ 4530.483224=
] Xenomai: 1->iteration 4 ..expected task wake-up....value =A0 =A0 =A0 =A0 =
1339875162481491464=A0=0A=0A[ 4530.483226] Xenomai: 1->iteration 4 ..actual=
 task wake-up....value =A0 =A0 =A0 =A0 =A0 =A0 =A01339875162481497647=A0=0A=
[ 4530.483228] Xenomai: 1->4 th jitter initial jitter after first task wake=
-up....value 6183=A0
