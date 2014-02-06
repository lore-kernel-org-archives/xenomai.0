Message-ID: <52F3B77F.3020405@marel.com>
Date: Thu, 6 Feb 2014 16:25:35 +0000
From: Marcel van Mierlo <marcel.vanmierlo@marel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] High CPU load using q_send under pSOS skin
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi,

I've been investigating this for a couple of days and would really 
appreciate some insight
on what might be going on or what I can do to progress this...

I am porting a legacy pSOS application - to Xenomai on BeagleBoard Black 
3.8 kernel
and have noticed %CPU (via. top) of MAIN around 40% when using q_send, 
and doing no "work".

Surprisingly,  if I add a printf() and fflush() to the task body then 
the CPU drops down to < 1%.

I've checked compile options, nothing obviously wrong. Here is the 
(abridged) body of the task.
It just provides a periodic message for watchdog purposes.


[%CPU ~%40]
while{1}
{
     q_send(ulCanTQid, (INT32 *)&oCanMsg);
     tm_wkafter(100);  // ~100ms
}


[%CPU < %1]
while{1}
{
     q_send(ulCanTQid, (INT32 *)&oCanMsg);
     tm_wkafter(100);  // ~100ms

     printf("WAKING");
     fflush(stdout);
}

there is a task calling q_receive on the queue, but I have stubbed out 
any work to keep it as simple as possible.


root@arm:~# cat /proc/xenomai/version
2.6.3

Here is xenomai/stat when running at ~40 %CPUfrom top. I presume that 
ROOT/0 represents the
Xenomai/I-PIPE kernel. Nothing is reported as hogging the CPU....

Every 2.0s: cat /proc/xenomai/stat                      Sat Jan  1 
00:09:03 2000

CPU  PID    MSW        CSW        PF    STAT       %CPU  NAME
   0  0      0          186436     0     00500080   94.2  ROOT/0
   0  2882   16         427        0     00300380    0.0  MAIN
   0  2883   0          54128      0     00300184    1.0 onemsscheduler
   0  2884   0          542        0     00300184    0.0  FREE
   0  2885   0          1499       0     00300184    0.0  flsh
   0  2886   0          1          0     00300182    0.0  EWRN
   0  2887   0          45158      0     00300186    0.8  EEDT
   0  2888   0          53921      0     00300184    1.4  RESP
   0  2889   1          1          0     00300380    0.0  SERV
   0  2890   0          10784      0     00300184    0.4  CMND
   0  2891   2          1370       0     00300186    0.1  SERP
   0  2896   0          53080      0     00300184    0.8  SERO
   0  2899   0          536        0     00300186    0.0  CANP
   0  2900   0          1          0     00300182    0.0  CANG
   0  2901   0          1          0     00300182    0.0  CANE
   0  2902   0          315        0     00300182    0.0  CANT
   0  2903   1          1          0     00300380    0.0  CNMN
   0  2904   236        628        0     00300184    0.0  CIOW
   0  0      0          699350     0     00000000    1.0  IRQ83: [timer]


So questions are:

- Why does the %CPU under xenomai/stat not reflect whats reported by top 
(where is the 40% going)?
- How can I track down the high CPU load?
- Why would using printf and fflush make such a massive difference to 
%CPU? The application is not busy waiting or doing any CPU intensive work...



Any pointers greatly appreciated...happy to provide any further 
information....

Cheers,
Marcel.
