From: thierry bultel <tbultel@pixelsurmer.com>
Message-ID: <0ce3f46c-39c7-2f7e-02e1-12004a80da5d@pixelsurmer.com>
Date: Wed, 8 Feb 2017 18:36:58 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] kernel hangs when accessing /proc/xenomai/sched/stat
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Dear all,

After some months away from the world of realtime applications, I am 
back on a project on which I want to use xenomai3 with cobalt.

The CPU is a IMX6solo

The linux kernel is the latest git://git.xenomai.org/ipipe.git, branch 
ipipe-4.4.y

The issue I have is reproducible on both xenomai-3 branches master & next

I simply do

#cat /proc/xenomai/sched/stat

and this hangs the system.

Best regards






