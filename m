MIME-Version: 1.0
From: "Stephen D. Cohen" <steve@uscohens.com>
Date: Thu, 28 Mar 2019 12:13:26 -0400
Message-ID: <CAO460_96EVE664TG_VM5jEV0MNBmoJjzThxZp7T9nnu4XkDmRw@mail.gmail.com>
Subject: Issues With rt_task_inquire and Associates
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

Folks,

     I noted a couple of issues with rt_task_inquire and wanted to
share them. I will put together a patch later <makes hand rolling
motion>, but wanted to let folks know sooner rather than later.

     The documentation suggests that the info structure can be NULL.
This is simply not true, as the actual code dereferences the pointer
without checking. Thus a null info pointer will cause an exception and
the thread will die an untimely (though outwardly quiet) death.

     I also note that the rt_task_inquire routine has an exit path
that keeps the thread object in  task control block locked. This is
also a problem. There should really be a put_alchemy_task before the
"goto out;" after the threadobj_stat call.

     I noted that this "keeps the tcb->thobj locked" issue occurs in a
few of the other rt_task routines as well. A careful review is in
order and I will do it when I submit the patches for rt_task_inquire.

Warmest Regards,

Steve

