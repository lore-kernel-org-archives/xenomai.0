From: =?iso-8859-1?Q?H=E4nel-Baas=2C_Alexander?=
 <alexander.haenel-baas@sieb-meyer.de>
Date: Tue, 9 May 2017 11:53:42 +0000
Message-ID: <9BA84827B30CBE4996725F98F7DC9123654093C7@SMExchange01.siebmeyer.org>
Content-Language: de-DE
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Xenomai] delete a suspend rt_task xeno2<>xeno3
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
i'm porting our application from Xeno2 (linux 3.14) to Xeno3(Linux 4.4).

Under Xeno3:
When I delete a suspend task, the suspend task will begin to run.
Under Xeno2 :
The suspend task is deleted successfully, without that the suspend thread w=
ill begin to run.
=20
Example
rt_thread
   for(;;){
       rt_task_suspend(NULL);
      printf("in loop\n");
   }
main:
rt_task_spawn()
. other stuff
rt_task_delete()

So, in Xenomai 2 i have never seen the string "in loop" when we delete the =
task, but under Xenomai 3
after the rt_task_delete() call, i get many "in loop" messages.

I notice the return value from rt_task_suspend is "operation not permitted"=
, because i
have delete successful the task descriptor with rt_task_delete().=20
Right?
Or is there a mistake in my Xenomai installation?

When this point is different to xenomai2 comes here my problem:
This was only a test example.=20
In the real application the rt_task_suspend() call came from another task, =
and not directly from rt_thread loop self.
And so rt_task_suspend() is called at the right time, return "successfully"=
 and the rt_thrad stops fine.=20
Now, when we  want shut down the application we calling rt_task_delete(), a=
nd then the rt_thread begins to run
and we can't delete it.=20

What can I do to delete a suspend rt_task without the task will running in =
the loop, because the task descriptor was going invalid from delete() call?


With best regards,
Alexander=20



