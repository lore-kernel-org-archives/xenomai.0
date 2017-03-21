Date: Tue, 21 Mar 2017 01:22:07 +0000 (UTC)
From: Giulio Moro <giuliomoro@yahoo.it>
Message-ID: <1132124080.7126689.1490059327685@mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <1132124080.7126689.1490059327685.ref@mail.yahoo.com>
Subject: [Xenomai] Documentation for struct threadobj_stat on Alchemy
Reply-To: Giulio Moro <giuliomoro@yahoo.it>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai Mailing List <xenomai@xenomai.org>

In Alchemy RT_TASK_INFO has a member struct threadobj_stat which is undocumented (https://xenomai.org//documentation/xenomai-3/html/xeno3prm/structRT__TASK__INFO.html).
Looking at the source of copperplate/threadobj.h (https://xenomai.org//documentation/xenomai-3/html/xeno3prm/threadobj_8h_source.html) , it turns out it has these members:

struct threadobj_stat {
 ticks_t xtime;
 ticks_t timeout;
 uint64_t msw;
 uint64_t csw;
 uint64_t xsc;
 int cpu;
 int schedlock;
 unsigned int status;
 uint32_t pf;
};

I could not find a documentation of what they are and even a straight forward comparison with rt_task_info from Xenomai 2.6 (http://www.xenomai.org/documentation/trunk/html/api/structrt__task__info.html) does not give an idea of what all of these are (e.g.: timeout, xsc, cpu, schedlock).

The migration guide (https://xenomai.org/migrating-from-xenomai-2-x-to-3-x/) only says "other fields which represent runtime statistics are now avail from a core-specific stat field sub-structure."

Thanks,
Giulio

