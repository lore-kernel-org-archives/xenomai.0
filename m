MIME-Version: 1.0
From: Leandro Bucci <guestleandro11@gmail.com>
Date: Sun, 3 Jan 2021 21:29:24 +0100
Message-ID: <CAFZ-hKiLthiDWtv8cuwRGMa0TAKv5ddWGt5XSsSJo1+UfBqgSg@mail.gmail.com>
Subject: Mode Switch
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi, I have a strange behavior regarding the "mode switch".
In the attached code, the task should never switch to the Linux domain, but
instead I have a value of MSW = 2.
How is it possible?
Even if I do a printf in the task I always get MSW = 2.
I can't understand where the problem is.

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <alchemy/task.h>
#include <alchemy/timer.h>

RT_TASK task;
RT_TASK_INFO info;

void task_body(void *arg)
{
rt_task_inquire(NULL, &info);
}

int main()
{
int err;

err = rt_task_create(&task, "mytask", 0, 1, 0);
if (err != 0){
fprintf(stderr, "failed to create task\n");
exit(EXIT_FAILURE);
}

err = rt_task_start(&task, &task_body, NULL);
if (err != 0){
fprintf(stderr, "failed to start task\n");
exit(EXIT_FAILURE);
}

sleep(5); //sleep for 5 seconds

printf("mode switch = %d\n", (int)(info.stat.msw));

exit(EXIT_SUCCESS);
}
