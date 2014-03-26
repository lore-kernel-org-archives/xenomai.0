From: "Mnatsakanyan, M." <m.mnatsakanyan@tue.nl>
Date: Wed, 26 Mar 2014 15:55:40 +0000
Message-ID: <6781B7C7F03D8A4BAF673DC4478144C406909DD7@XSERVER21A.campus.tue.nl>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Xenomai] Enabling Round-robin scheduling
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hello,

My question is related to enabling round-robin scheduling using Native Xeno=
mai API 2.6.3.
It is a beginner's question, but I hope it is ok to post it here.

The problem is that I am not managing to enable round-robin scheduler.
The only place where I could find something about it is this page:
http://www.cs.ru.nl/lab/xenomai/exercises/ex07/Exercise-7.html

But it is rather old page and seems many things have changed after that.
Simply set, it advises to enable RR by following two calls:

rt_task_set_mode(0,T_RRB ,NULL);
rt_task_slice(task_descr,quantum)

T_RRB is not defined in 2.6.3 so I tried to replace it with XNRRB and call =
these two methods inside my task function but it did not work. I used the c=
ode example given in the mentioned page.

My first question is whether it is the right method to enable RR?

Given the description of rt_task_set_mode in API documentation I have anoth=
er question.

As I understand if we want to use RR scheduler, we call rt_task_set_mode fr=
om task function in order to specify that the task undergoes a round-robin =
scheduling. So it is up to task to decide whether it wants to be scheduled =
by RR or not. Is it a correct assumption?

My question is whether it is possible to have tasks undergoing RR and not u=
ndergoing in the same application?

If yes, how all the tasks are scheduled?

Your elaboration on these questions would be a great help.

Thank you!


