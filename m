MIME-Version: 1.0
From: Pintu Kumar <pintu.ping@gmail.com>
Date: Thu, 15 Mar 2018 13:54:42 +0530
Message-ID: <CAOuPNLjjqZgqzwRe5ACxdPiCUpedbEW4Xh3FU=gSZc9tMmdgjw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Xenomai] segmentation fault during rt_task_unblock
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Xenomai@xenomai.org" <xenomai@xenomai.org>

Hi All,

I am trying to test rt_cond_bind() and rt_task_unblock() API with a
simple thread program using the Xenomai native skin, and with xenomai
3.0.6.

But, during call to rt_task_unblock(&task1) from the main function, I
get the segmentation fault.

# ./cond_bin_test
PINTU: Inside bind_test task....
PINTU: Before rt_task_unblock
Segmentation fault (core dumped)

This is the code snippet for the program:

void bind_test(...)
{
        ....
        err = rt_cond_bind(&cond, "COND1", TM_INFINITE);
        if (err == -EINTR)
               printf("error....");
}

int main(...)
{
         ....
         rt_task_create(&bind_test, .....);
         rt_task_start(&bind_test, .......);

         err = rt_task_unblock(&bind_test);

         rt_task_delete(&bind_test);


         return 0;
}

What is wrong with the above sample ?
I suppose this code was working on Xenomai 2.6.x

If there is any thing missing please let me know.


Thank You!

Regards,
Pintu

