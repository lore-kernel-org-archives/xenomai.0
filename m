Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 703D91C08
	for <xenomai@lists.linux.dev>; Sun, 15 Jan 2023 16:07:46 +0000 (UTC)
Received: by mail-pg1-f179.google.com with SMTP id e10so18083025pgc.9
        for <xenomai@lists.linux.dev>; Sun, 15 Jan 2023 08:07:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aHuEkAfHBzHJGrQia/ddGQ8G4PYqBcVZs6zkzGEU8mg=;
        b=KUNYWdgqYmFuEPP/n64TWNqtkvaOXXhxmpfKaekyzGi28UZJawI3ihrEVuqe5f7lpD
         B+g0SHc6HkaOQ1uC6ssc4fRen9A7TLxzPpqxgNJqs+76TBQzFR11WBTDJ5BIeWhhMBSw
         qm69BPdcN2RcN4mwJpsI9e3RZot9wZmsqnAEIPGB9+V+uk+o7+XlQvE97XkefXyHiRUy
         wl6Ys+1FSNZkf52yb61VIDDWV4wF6LnOGXwjlZbF9WH5l0SMVNwU+6RhSlaOL3kowWuX
         eozi73P9epxmCmVtqpi0U82tr+/I07c0bZezGcQZxx+defn7+8Yj4oHYQmIfZs8CEGOK
         bjvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aHuEkAfHBzHJGrQia/ddGQ8G4PYqBcVZs6zkzGEU8mg=;
        b=Ysev9stTo9SzkgDGl1lfPLqxqCjhw0qLNNNl0IUwpR4IsyXXXIlFPFeRPUEMf22oi1
         ZLQGhzOZNv78Ezx/yVxXszGSLNPPHFb9bMihW8WOXnnNZCFjbfEgBKTjyAG8wX5KXeYV
         ClIxzvAqc7KrziKTiYH+3eAQTBC7R3k/OtPxmS92f53v3IVsksPJdlOIF2rAeXkTE0VG
         /5X4mFgX4mqbrc0+twoiEuH+cuQNkVgMnJLCKbIyBe1A0oJXPmJJNQlu+ZbL7x/2I10S
         7fGF7B8s7yf1yL4xODvt7xOk803D7ofuNM2OVtMfkBjQhEeovlOrvOPMWeEtCao7JAVE
         dFKA==
X-Gm-Message-State: AFqh2koQvstU49fOb9qZ5rdvWurkvhS7QR55AoSYG9zEjIlF4RZnq/u1
	mKJ/Pb/iPa6AYgs81whnax0iRMvQ26Af209ldkkQlyrR
X-Google-Smtp-Source: AMrXdXvZ5WbewOUz17DB+wkmfPO9Q3QijI148iKbSYu4vTa6C6VW/qPK+u96Ven4GSmwoa4lGJ/opLMU0/dVNc5FqoI=
X-Received: by 2002:a05:6a00:3693:b0:58b:a3b8:24dc with SMTP id
 dw19-20020a056a00369300b0058ba3b824dcmr1004393pfb.84.1673798865481; Sun, 15
 Jan 2023 08:07:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <1673779013-11742-mlmmj-00f27513@lists.linux.dev> <CAKcohPxHzbQvztgQMQaFq-EoXGbpfQxi1HpPV9nogBUaQ+PUSw@mail.gmail.com>
In-Reply-To: <CAKcohPxHzbQvztgQMQaFq-EoXGbpfQxi1HpPV9nogBUaQ+PUSw@mail.gmail.com>
From: Yunjie Gu <yunjie.gu1@gmail.com>
Date: Sun, 15 Jan 2023 16:07:33 +0000
Message-ID: <CAKcohPxdhCMohJZfSNaL2EvEDcLdm8CRgdy3hUusCu9Y5jexxw@mail.gmail.com>
Subject: while loop in a multi-core cpu
To: xenomai@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hi Guys,

We are trying to develop a polling mode thread to skip the delay of
the interrupt response. This is done by a while loop to check the
hardware (say a gpio or a timer) continuously. When we did this we
found that the system was frozen, meaning that the other cores are not
functioning when we run a polling loop on a single core. But if we do
the same in a normal Linux thread, the system is not frozen. I'm just
wondering if polling mode is allowed for xenomai, or if we did
anything incorrectly. A simple test piece of code to replicate this is
attached below. Our code runs on RaspberryPiCM4 (four-core ARM V7l)
with Linux 4.19 and xenomai 3.1.

Best Regards,
Yunjie

#include <stdio.h>
#include <unistd.h>
#include <alchemy/task.h>
#include <alchemy/timer.h>
#include <alchemy/sem.h>
#include <rtdm/uapi/rtdm.h>
#include <fcntl.h>
#include <linux/types.h>
#include <sys/ioctl.h>
#include <sys/mman.h>
RT_TASK demo_task;

void demo(void *arg)
{
    RT_TASK *curtask;
    RT_TASK_INFO curtaskinfo;

    curtask=rt_task_self();
    rt_task_inquire(curtask,&curtaskinfo);

    printf("Task name : %s \n", curtaskinfo.name);

        //------------------ hello world --------------------
    while (1)
    {
        printf("Hello World!\n");
    }

}

int main(int argc, char* argv[])
{
    char  str[10];

    // rt_print_auto_init(1);

    mlockall(MCL_CURRENT|MCL_FUTURE);

    printf("start task\n");

    sprintf(str,"hello");
    rt_task_create(&demo_task, str, 0, 50, 0);

    rt_task_start(&demo_task, &demo, 0);
    pause();
    rt_task_delete(&demo_task);
}
