From: "Mauro S." <mau.salvi@tin.it>
Subject: (rt_)printf and virtual memory
Message-ID: <cf751850-8771-6120-e615-1fb80566a9a5@tin.it>
Date: Tue, 7 Sep 2021 11:21:29 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: it-IT
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi all,

consider the simple code attached.

I'm using Xenomai 3.1 on a x86_64 CPU, 2GB RAM.

I compile and link the code using "xeno-config --skin=alchemy --cflags" 
and "xeno-config --skin=alchemy --ldflags"

* Scenario 1)
   #define printf rt_printf commented out (use printf for prints)

   Changing the NUM_TASKS value, in top command I see these results:

   - NUM_TASKS 2

     PID  PPID USER     STAT   VSZ %VSZ %CPU COMMAND
     496   480 root     S    80068   4%   0% ./test

   - NUM_TASKS 4

     PID  PPID USER     STAT   VSZ %VSZ %CPU COMMAND
     496   480 root     S    80204   4%   0% ./test

   - NUM_TASKS 5

     PID  PPID USER     STAT   VSZ %VSZ %CPU COMMAND
     496   480 root     S    80272   4%   0% ./test

   - NUM_TASKS 6

     PID  PPID USER     STAT   VSZ %VSZ %CPU COMMAND
     496   480 root     S    80340   4%   0% ./test

Virtual memory size increases in a linear way.


* Scenario 2)
   #define printf rt_printf not commented (use rt_printf for prints)

   Changing the NUM_TASKS value, in top command I see these results:

   - NUM_TASKS 2

     PID  PPID USER     STAT   VSZ %VSZ %CPU COMMAND
     496   480 root     S    80068   4%   0% ./test

   - NUM_TASKS 4

     PID  PPID USER     STAT   VSZ %VSZ %CPU COMMAND
     496   480 root     S    80204   4%   0% ./test

   - NUM_TASKS 5

     PID  PPID USER     STAT   VSZ %VSZ %CPU COMMAND
     496   480 root     S     142M   4%   0% ./test

   - NUM_TASKS 6

     PID  PPID USER     STAT   VSZ %VSZ %CPU COMMAND
     496   480 root     S     206M   4%   0% ./test


Starting from a number of tasks > 4, the VMEM got a jump and then 
increases very rapidly.

Is it normal? Or I'm misusing the rt_printf?

Thanks in advance, regards

---
Mauro S.

