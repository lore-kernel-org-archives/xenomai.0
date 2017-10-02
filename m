From: Giulio Moro <g.moro@qmul.ac.uk>
Date: Mon, 2 Oct 2017 01:38:25 +0000
Message-ID: <DB6PR0701MB2456EA2D393F1395D0CA6A21B57D0@DB6PR0701MB2456.eurprd07.prod.outlook.com>
Content-Language: en-GB
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Xenomai] Posix replacement for rt_task_suspend(),
 rt_task_resume() and rt_task_delete()
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
I am porting a Xenomai 3 application from Alchemy to the Posix API*. Under =
Alchemy, I was using rt_task_suspend(NULL) to suspend a task and rt_task_re=
sume(&task) to resume the task from a separate thread. What is the best / r=
ecommended way of porting this to the Posix API?
Are there any drop-in replacements? Otherwise, I was thinking of using a co=
ndition variable.

What about rt_task_delete() ? The Xenomai documentation does not list pthre=
ad_cancel (though I see it is being used by copperplate in the rt_task_dele=
te() call). Is it ok to use pthread_cancel() on a xenomai task?

Thanks,
Giulio

* Posix is measurably faster on our architecture (TI am3358)=

