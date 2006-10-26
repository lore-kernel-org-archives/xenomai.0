Message-ID: <4540D998.2090908@domain.hid>
Date: Thu, 26 Oct 2006 10:51:52 -0500
From: Jeff Webb <jeff.webb@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] switchtest and Xenomai 2.2.4
References: <1160947939.4962.27.camel@domain.hid> <453FC4C0.5070105@domain.hid>
	<453FF6AA.6030406@domain.hid> <45406FEF.90806@domain.hid>
In-Reply-To: <45406FEF.90806@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Gilles Chanteperdrix wrote:
> After the first Ctrl-C that does not work, could you try and attach gdb
> to see where the threads are stopped ?

I tried to do this, but was unable to determine the stopping point using gdb.

> Are you using NPTL or Linuxthreads ? 

I'm running a stock Fedora Core 5 configuration, so I think that means NPTL.

> Could you tell us in what state the
> switchtest threads are when running ps and in /proc/xenomai/sched ?
> After the second Ctrl-C, are the threads still alive ?

See the output below.
 
> Since after the first Ctrl-C, CPU 0 switches are no longer displayed,
> the program probably started the cleanup correctly; if gdb does not
> tell you where the main thread is blocked, could you try adding some
> printfs in the main thread ?

I will try this next.

Here is the process information while switchtest is running, but before I press ctrl-c:
 
[root]# cat /proc/xenomai/stat
CPU  PID    MSW        CSW        PF    STAT       %CPU  NAME
  0  0      0          52285      0     01400080   98.5  ROOT/0
  1  0      0          53287      0     01400080   98.5  ROOT/1
  0  2723   1          1          0     00c00180    0.0  switchtest
  0  0      0          5086       0     00000082    0.1  rtk1/0
  0  0      0          5086       0     00000082    0.1  rtk2/0
  0  0      0          5086       0     00400082    0.1  rtk3/0
  0  0      0          5086       0     00400082    0.1  rtk4/0
  0  0      0          5086       0     00400082    0.1  rtk5/0
  0  0      0          5086       0     00400082    0.1  rtk6/0
  0  2725   3          3          0     00c00180    0.0  rtup0-7
  0  2726   3          3          0     00c00180    0.0  rtup0-8
  0  2727   3          3          0     00c00180    0.0  rtup_ufpp0-9
  0  2728   3          3          0     00c00180    0.0  rtup_ufpp0-10
  0  2729   2          5088       0     00c00082    0.1  rtus0-11
  0  2730   2          5088       0     00c00082    0.1  rtus0-12
  0  2731   2          5088       0     00c00082    0.1  rtus_ufps0-13
  0  2732   2          5088       0     00c00082    0.1  rtus_ufps0-14
  0  2733   2545       5087       0     00c00180    0.1  rtuo0-15
  0  2734   2545       5087       0     00c00180    0.1  rtuo0-16
  0  2735   2545       5087       0     00c00180    0.1  rtuo_ufpp0-17
  0  2736   2545       5087       0     00c00180    0.1  rtuo_ufpp0-18
  0  2737   2545       5087       0     00c00180    0.1  rtuo_ufps0-19
  0  2738   2545       5087       0     00c00180    0.1  rtuo_ufps0-20
  0  2739   2545       5087       0     00c00180    0.1  rtuo_ufpp_ufps0-21
  0  2740   2545       5087       0     00c00180    0.1  rtuo_ufpp_ufps0-22
  1  0      0          5184       0     00000082    0.1  rtk1/1
  1  0      0          5184       0     00000082    0.1  rtk2/1
  1  0      0          5184       0     00400082    0.1  rtk3/1
  1  0      0          5184       0     00400082    0.1  rtk4/1
  1  0      0          5184       0     00400082    0.1  rtk5/1
  1  0      0          5184       0     00400082    0.1  rtk6/1
  1  2742   3          3          0     00c00180    0.0  rtup1-7
  1  2743   3          3          0     00c00180    0.0  rtup1-8
  1  2744   3          3          0     00c00180    0.0  rtup_ufpp1-9
  1  2745   3          3          0     00c00180    0.0  rtup_ufpp1-10
  1  2746   2          5186       0     00c00082    0.1  rtus1-11
  1  2747   2          5186       0     00c00082    0.1  rtus1-12
  1  2748   2          5186       0     00c00082    0.1  rtus_ufps1-13
  1  2749   2          5186       0     00c00082    0.1  rtus_ufps1-14
  1  2750   2594       5185       0     00c00180    0.1  rtuo1-15
  1  2751   2594       5185       0     00c00180    0.1  rtuo1-16
  1  2752   2594       5185       0     00c00180    0.1  rtuo_ufpp1-17
  1  2753   2594       5185       0     00c00180    0.1  rtuo_ufpp1-18
  1  2754   2594       5185       0     00c00180    0.1  rtuo_ufps1-19
  1  2755   2594       5185       0     00c00180    0.1  rtuo_ufps1-20
  1  2756   2594       5185       0     00c00180    0.1  rtuo_ufpp_ufps1-21
  1  2757   2594       5185       0     00c00180    0.1  rtuo_ufpp_ufps1-22

[root]# ps a -T
  PID  SPID TTY      STAT   TIME COMMAND
 2656  2656 pts/0    S+     0:00 /bin/sh /usr/xenomai/bin/xeno-load
 2679  2679 pts/0    S+     0:00 /bin/sh /usr/xenomai/bin/xeno-load
 2723  2723 pts/0    SLl+   0:00 ./switchtest
 2723  2724 pts/0    SLl+   0:00 ./switchtest
 2723  2725 pts/0    SLl+   0:00 ./switchtest
 2723  2726 pts/0    SLl+   0:00 ./switchtest
 2723  2727 pts/0    SLl+   0:00 ./switchtest
 2723  2728 pts/0    SLl+   0:00 ./switchtest
 2723  2729 pts/0    SLl+   0:00 ./switchtest
 2723  2730 pts/0    SLl+   0:00 ./switchtest
 2723  2731 pts/0    SLl+   0:00 ./switchtest
 2723  2732 pts/0    SLl+   0:00 ./switchtest
 2723  2733 pts/0    SLl+   0:00 ./switchtest
 2723  2734 pts/0    SLl+   0:00 ./switchtest
 2723  2735 pts/0    SLl+   0:00 ./switchtest
 2723  2736 pts/0    SLl+   0:00 ./switchtest
 2723  2737 pts/0    SLl+   0:00 ./switchtest
 2723  2738 pts/0    SLl+   0:00 ./switchtest
 2723  2739 pts/0    SLl+   0:00 ./switchtest
 2723  2740 pts/0    SLl+   0:00 ./switchtest
 2723  2741 pts/0    SLl+   0:00 ./switchtest
 2723  2742 pts/0    SLl+   0:00 ./switchtest
 2723  2743 pts/0    SLl+   0:00 ./switchtest
 2723  2744 pts/0    SLl+   0:00 ./switchtest
 2723  2745 pts/0    SLl+   0:00 ./switchtest
 2723  2746 pts/0    SLl+   0:00 ./switchtest
 2723  2747 pts/0    SLl+   0:00 ./switchtest
 2723  2748 pts/0    SLl+   0:00 ./switchtest
 2723  2749 pts/0    SLl+   0:00 ./switchtest
 2723  2750 pts/0    SLl+   0:00 ./switchtest
 2723  2751 pts/0    SLl+   0:00 ./switchtest
 2723  2752 pts/0    SLl+   0:00 ./switchtest
 2723  2753 pts/0    SLl+   0:00 ./switchtest
 2723  2754 pts/0    SLl+   0:00 ./switchtest
 2723  2755 pts/0    SLl+   0:00 ./switchtest
 2723  2756 pts/0    SLl+   0:00 ./switchtest
 2723  2757 pts/0    SLl+   0:00 ./switchtest


After I press ctrl-c once:

[root]# cat /proc/xenomai/stat
CPU  PID    MSW        CSW        PF    STAT       %CPU  NAME
  0  0      0          158228     0     01400080   98.5  ROOT/0
  1  0      0          174623     0     01400080   98.5  ROOT/1
  0  2723   1          1          0     00c00180    0.0  switchtest
  0  0      0          15399      0     00000082    0.1  rtk1/0
  0  0      0          15399      0     00000082    0.1  rtk2/0
  0  0      0          15399      0     00400082    0.1  rtk3/0
  0  0      0          15399      0     00400082    0.1  rtk4/0
  0  0      0          15399      0     00400082    0.1  rtk5/0
  0  0      0          15399      0     00400082    0.1  rtk6/0
  0  2729   2          15401      0     00c03088    0.1  rtus0-11
  0  2730   2          15401      0     00c03088    0.1  rtus0-12
  0  2731   2          15401      0     00c03088    0.1  rtus_ufps0-13
  0  2732   2          15401      0     00c03088    0.1  rtus_ufps0-14
  0  2733   7701       15400      0     00c03088    0.1  rtuo0-15
  0  2734   7701       15400      0     00c03088    0.1  rtuo0-16
  0  2735   7701       15400      0     00c03088    0.1  rtuo_ufpp0-17
  0  2736   7701       15400      0     00c03088    0.1  rtuo_ufpp0-18
  0  2737   7701       15400      0     00c03088    0.1  rtuo_ufps0-19
  0  2738   7701       15400      0     00c03088    0.1  rtuo_ufps0-20
  0  2739   7701       15400      0     00c03088    0.1  rtuo_ufpp_ufps0-21
  0  2740   7701       15400      0     00c03088    0.1  rtuo_ufpp_ufps0-22
  1  0      0          16995      0     00000082    0.1  rtk1/1
  1  0      0          16995      0     00000082    0.1  rtk2/1
  1  0      0          16995      0     00400082    0.1  rtk3/1
  1  0      0          16995      0     00400082    0.1  rtk4/1
  1  0      0          16995      0     00400082    0.1  rtk5/1
  1  0      0          16995      0     00400082    0.1  rtk6/1
  1  2742   3          3          0     00c00180    0.0  rtup1-7
  1  2743   3          3          0     00c00180    0.0  rtup1-8
  1  2744   3          3          0     00c00180    0.0  rtup_ufpp1-9
  1  2745   3          3          0     00c00180    0.0  rtup_ufpp1-10
  1  2746   2          16997      0     00c00082    0.1  rtus1-11
  1  2747   2          16997      0     00c00082    0.1  rtus1-12
  1  2748   2          16997      0     00c00082    0.1  rtus_ufps1-13
  1  2749   2          16997      0     00c00082    0.1  rtus_ufps1-14
  1  2750   8499       16996      0     00c00082    0.1  rtuo1-15
  1  2751   8499       16996      0     00c00082    0.1  rtuo1-16
  1  2752   8499       16996      0     00c00082    0.1  rtuo_ufpp1-17
  1  2753   8499       16996      0     00c00082    0.1  rtuo_ufpp1-18
  1  2754   8499       16996      0     00c00082    0.1  rtuo_ufps1-19
  1  2755   8499       16996      0     00c00082    0.1  rtuo_ufps1-20
  1  2756   8499       16996      0     00c00082    0.1  rtuo_ufpp_ufps1-21
  1  2757   8499       16996      0     00c00082    0.1  rtuo_ufpp_ufps1-22

[root]# ps a -T
  PID  SPID TTY      STAT   TIME COMMAND
 2656  2656 pts/0    S+     0:00 /bin/sh /usr/xenomai/bin/xeno-load
 2679  2679 pts/0    S+     0:00 /bin/sh /usr/xenomai/bin/xeno-load
 2723  2723 pts/0    SLl+   0:00 ./switchtest
 2723  2729 pts/0    SLl+   0:00 ./switchtest
 2723  2730 pts/0    SLl+   0:00 ./switchtest
 2723  2731 pts/0    SLl+   0:00 ./switchtest
 2723  2732 pts/0    SLl+   0:00 ./switchtest
 2723  2733 pts/0    SLl+   0:00 ./switchtest
 2723  2734 pts/0    SLl+   0:00 ./switchtest
 2723  2735 pts/0    SLl+   0:00 ./switchtest
 2723  2736 pts/0    SLl+   0:00 ./switchtest
 2723  2737 pts/0    SLl+   0:00 ./switchtest
 2723  2738 pts/0    SLl+   0:00 ./switchtest
 2723  2739 pts/0    SLl+   0:00 ./switchtest
 2723  2740 pts/0    SLl+   0:00 ./switchtest
 2723  2741 pts/0    SLl+   0:00 ./switchtest
 2723  2742 pts/0    SLl+   0:00 ./switchtest
 2723  2743 pts/0    SLl+   0:00 ./switchtest
 2723  2744 pts/0    SLl+   0:00 ./switchtest
 2723  2745 pts/0    SLl+   0:00 ./switchtest
 2723  2746 pts/0    SLl+   0:00 ./switchtest
 2723  2747 pts/0    SLl+   0:00 ./switchtest
 2723  2748 pts/0    SLl+   0:00 ./switchtest
 2723  2749 pts/0    SLl+   0:00 ./switchtest
 2723  2750 pts/0    SLl+   0:00 ./switchtest
 2723  2751 pts/0    SLl+   0:00 ./switchtest
 2723  2752 pts/0    SLl+   0:00 ./switchtest
 2723  2753 pts/0    SLl+   0:00 ./switchtest
 2723  2754 pts/0    SLl+   0:00 ./switchtest
 2723  2755 pts/0    SLl+   0:00 ./switchtest
 2723  2756 pts/0    SLl+   0:00 ./switchtest
 2723  2757 pts/0    SLl+   0:00 ./switchtest

After I press ctrl-c a second time:

[root]# cat /proc/xenomai/stat
CPU  PID    MSW        CSW        PF    STAT       %CPU  NAME
  0  0      0          158240     0     01400080  100.0  ROOT/0
  1  0      0          249722     0     01400080   98.9  ROOT/1
  0  0      0          15399      0     00000082    0.0  rtk1/0
  0  0      0          15399      0     00000082    0.0  rtk2/0
  0  0      0          15399      0     00400082    0.0  rtk3/0
  0  0      0          15399      0     00400082    0.0  rtk4/0
  0  0      0          15399      0     00400082    0.0  rtk5/0
  0  0      0          15399      0     00400082    0.0  rtk6/0
  1  0      0          24306      0     00000082    0.0  rtk1/1
  1  0      0          24306      0     00000082    0.0  rtk2/1
  1  0      0          24306      0     00400082    0.0  rtk3/1
  1  0      0          24306      0     00400082    0.0  rtk4/1
  1  0      0          24306      0     00400082    0.0  rtk5/1
  1  0      0          24306      0     00400082    0.0  rtk6/1
  1  2747   2          24308      0     00c03088    0.1  rtus1-12
  1  2748   2          24308      0     00c03088    0.1  rtus_ufps1-13
  1  2749   2          24308      0     00c03088    0.1  rtus_ufps1-14

[root]# ps a -T
  PID  SPID TTY      STAT   TIME COMMAND
 2656  2656 pts/0    S+     0:00 /bin/sh /usr/xenomai/bin/xeno-load
 2679  2679 pts/0    S+     0:00 /bin/sh /usr/xenomai/bin/xeno-load
 2723  2723 pts/0    Zl+    0:00 [switchtest] <defunct>
 2723  2747 pts/0    SLl+   0:00 [switchtest]
 2723  2748 pts/0    SLl+   0:00 [switchtest]
 2723  2749 pts/0    SLl+   0:00 [switchtest]
 2765  2765 pts/1    R+     0:00 ps a -T


