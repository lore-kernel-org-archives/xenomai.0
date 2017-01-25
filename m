From: =?UTF-8?Q?St=c3=a9phane_Ancelot?= <sancelot@numalliance.com>
Message-ID: <8de4d9c7-231a-d954-5926-3a0367ed839e@numalliance.com>
Date: Wed, 25 Jan 2017 17:58:22 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] init_memory_pool error
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

I am stuck with the next branch of xenomai, when using tune variables .

when launching the program without any parameters , I have the next 
error message :

init_memory_pool(): invalid pool
    0"006.881| BUG in heapobj_pkg_init_private(): [main] cannot 
initialize TLSF memory manager

however, if I launch it with --mem-pool-size option, it runs ....

here is what I setted up in tunables variables :

static int foo_tune(void)
{

              set_config_tunable(session_label, "toot");
             set_config_tunable(mem_pool_size,8000000);
             printf("mem pool size=%ld\n", 
get_config_tunable(mem_pool_size));
             return 0; /* Success, otherwise -errno */
}

Please advice if more informations are needed.

Regards,

S.Ancelot


