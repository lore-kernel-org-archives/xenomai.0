MIME-Version: 1.0
From: Sebastien Schneider <seb.schneider@gmail.com>
Date: Mon, 19 Dec 2016 15:04:28 +0100
Message-ID: <CA+_GcoBZSOuEs_yrdG0EWXxUk5_PEC1qf69+jfqQFC_MpgFb9w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Xenomai] System hang when doing several rtdm_task_init() calling
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

I am facing issues with the rtdm_task_init() function when trying to
developp a xenomai real-time base driver.
I firstly call the rtdm_task_init() method for a non periodic task with the
lowest priority. This lowest priority task infinitly executes code which
first consists on a rtdm_task_sleep() for a predefined amount of time,
before other various operations.
Then, I secondly call the rtdm_task_init() method for an another non
periodic task with the highest priority. And what happens after compiling
the code and trying to insert the obtained module, is that the system seems
to hang.

Has anyone some idea that can help me ?
