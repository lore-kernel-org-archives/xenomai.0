Message-ID: <trinity-e90136c9-0797-4d97-8ccf-0af03809fa74-1569916165035@3c-app-webde-bap28>
From: "Sascha-Carsten Wedler" <FXMaveric@web.de>
Subject: Aw: Re: rt_task_create returns EEXIST on restart a task
Date: Tue, 1 Oct 2019 09:49:25 +0200
In-Reply-To: <87a0f568-b27e-17a3-8954-16f4cb721ffe@siemens.com>
References: <trinity-6d62c670-77a5-4657-bd6f-23e37c37af06-1569911626962@3c-app-webde-bap28>
 <73e6846e-8095-6655-57ff-97ef29343b78@siemens.com>
 <trinity-e9083284-ca0e-4dd0-8814-1cf89d9a5bb8-1569913831944@3c-app-webde-bap28>
 <87a0f568-b27e-17a3-8954-16f4cb721ffe@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@xenomai.org>

   Hello Jan,

   thank you for your effort.
   The problem was in my test enviroment.
   Different task had the same (internal) description, so i thougt the
   error was related to another task. (restarted the wrong task)
   It works fine now.
   Thank you.

   Regards Sascha

   Gesendet: Dienstag, 01. Oktober 2019 um 09:16 Uhr
   Von: "Jan Kiszka" <jan.kiszka@siemens.com>
   An: "Sascha-Carsten Wedler" <FXMaveric@web.de>, Xenomai
   <xenomai@xenomai.org>
   Betreff: Re: rt_task_create returns EEXIST on restart a task
   [re-adding the list]
   On 01.10.19 09:10, Sascha-Carsten Wedler wrote:
   > Hello Jan
   > I am using xenomai 3.0.2 on a cobalt core. If i add a
   >   memset(&RT_TaskHandle,0,sizeof(RT_TaskHandle));
   > bevor the rt_task_create
   > the fist start runs fine like bevore.
   > after the delete, the -EEXIST on rt_task_create still occurs but the
   task isn't
   > startable anymore.
   > rt_task_start return -EINVAL in this case.
   > Running with a differnt name works, but this is where i am irritated
   about.
   > should rt_task_delete not de-register the name?
   It should. Let me check with an up-to-date version, if the issue is
   still present.
   Jan
   > Regards Sascha
   > *Gesendet:* Dienstag, 01. Oktober 2019 um 08:42 Uhr
   > *Von:* "Jan Kiszka" <jan.kiszka@siemens.com>
   > *An:* "Sascha-Carsten Wedler" <FXMaveric@web.de>, xenomai@xenomai.org
   > *Betreff:* Re: rt_task_create returns EEXIST on restart a task
   > On 01.10.19 08:33, Sascha-Carsten Wedler via Xenomai wrote:
   > > Hello,
   > >
   > > I have a task, which I create in this way:
   > >
   > > string _name = "Task1";
   > > rt_task_create(&RT_TaskHandle, _name.c_str(), 0, _Prio,0);
   > > ....
   > > later i stop the task
   > > rt_task_delete(&RT_TaskHandle);
   > > (returns zero)
   > >
   > > if I try to restart the task using
   > > rt_task_create(&RT_TaskHandle, _name.c_str(), 0, _Prio,0);
   > > it returns -EEXIST.
   > >
   > > rt_task_start will work anyway for this task and restart it
   anyway....
   > >
   > > So I assume that the name is still registered. It is a normal
   bevahiour
   > > that the name will not be de-registered and
   > > i cannot use the same name to reschedule the task?
   > >
   > > Or have i a missunderstanding in general?
   > >
   >
   > Conceptually, this should work.
   >
   > Which version are you on, which variant (cobalt, mercurial)? Does a
   memset on
   > RT_TaskHandle after the delete change the picture? Or do you need to
   use a
   > different name for the task?
   >
   > Jan
   >
   > --
   > Siemens AG, Corporate Technology, CT RDA IOT SES-DE
   > Corporate Competence Center Embedded Linux
   --
   Siemens AG, Corporate Technology, CT RDA IOT SES-DE
   Corporate Competence Center Embedded Linux
