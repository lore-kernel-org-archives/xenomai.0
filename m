Message-ID: <47CDB710.6030103@domain.hid>
Date: Tue, 04 Mar 2008 21:54:40 +0100
From: Anders Blomdell <anders.blomdell@domain.hid>
MIME-Version: 1.0
References: <47CDA626.4010604@domain.hid>
	<18381.44749.419005.112838@domain.hid>
In-Reply-To: <18381.44749.419005.112838@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] How should rt_task_delete(NULL)  be used?
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
Cc: xenomai-help <xenomai@xenomai.org>

Gilles Chanteperdrix wrote:
> Anders Blomdell wrote:
>  > Why does the following program grow it's VMSIZE? This is the output I get:
>  > 
>  > [child =  0,  0] VmSize:            1912 kB
>  > [child =  1,  1] VmSize:            1980 kB
>  > [child =  2,  2] VmSize:            2048 kB
>  > [child =  3,  3] VmSize:            2116 kB
>  > [child =  4,  4] VmSize:            2184 kB
>  > [child =  5,  5] VmSize:            2252 kB
>  > [child =  6,  6] VmSize:            2320 kB
>  > [child =  7,  7] VmSize:            2388 kB
>  > [child =  8,  8] VmSize:            2456 kB
>  > [child =  9,  9] VmSize:            2524 kB
>  > [child = 10, 10] VmSize:            2592 kB
>  > [child = 11, 11] VmSize:            2660 kB
>  > [child = 12, 12] VmSize:            2728 kB
>  > [child = 13, 13] VmSize:            2796 kB
>  > [child = 14, 14] VmSize:            2864 kB
>  > [child = 15, 15] VmSize:            2932 kB
>  > [child = 16, 16] VmSize:            3000 kB
>  > [child = 17, 17] VmSize:            3068 kB
>  > [child = 18, 18] VmSize:            3136 kB
>  > [child = 19, 19] VmSize:            3204 kB
> 
> Could you dump /proc/self/maps at the beginning and the end, to see
> where the reserved memory comes from ?
> 

Sligtly modified program (being sloppy seems to be the better choice, just
returning without trying to cleanup self is cheaper, weird)...

#include <sys/mman.h>
#include <native/cond.h>
#include <native/mutex.h>
#include <native/task.h>
#include <native/timer.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>



static void child(void *arg)
{
  int n = (int)arg;

  printf("[child = %2d", n);
  fflush(stdout);
  if (n < 10) {
    rt_task_delete(NULL);
  }
}

static void dump(char *path)
{
  char buf[4096];
  int N, fd;

  fd = open(path, O_RDONLY);
  while ((N = read(fd, buf, 4096)) > 0) {
    printf("%1.*s", N, buf);
    fflush(stdout);

  }
  close(fd);
}

int main(int argc, char *argv[])
{
  int i;
  RT_TASK task_main;
  RT_TASK task;

  mlockall(MCL_CURRENT|MCL_FUTURE);

  rt_task_shadow(&task_main, "main", 1, T_FPU);

  dump("/proc/self/maps");
  for  (i = 0 ; i < 20 ; i++) {
    if (rt_task_create(&task, NULL, 0, 1, 0)) {
      fprintf(stderr, "Failed to create  task\n");
      exit(1);
    }
    if (rt_task_start(&task, &child, (void*)i)) {
      fprintf(stderr, "Failed to start task\n");
      exit(1);
    }
    rt_task_sleep(1000000000L);
    {
      int fd;
      char *p1 = NULL, *p2 = NULL;
      char buf[4000];

      fd = open("/proc/self/status", O_RDONLY);
      if (read(fd, buf, 4000) > 0) {
        p1 = strstr(buf, "VmSize");
        if (p1) { p2 = strstr(p1, "\n"); }
        if (p1 && p2) { printf(", %2d] %1.*s\n", i, p2 - p1, p1); }
        fflush(stdout);
      }
      close(fd);
    }
  }
  dump("/proc/self/maps");
  exit(0);
}


0062e000-00649000 r-xp 00000000 08:05 950516     /lib/ld-2.6.so
00649000-0064a000 r--p 0001a000 08:05 950516     /lib/ld-2.6.so
0064a000-0064b000 rw-p 0001b000 08:05 950516     /lib/ld-2.6.so
0064d000-0079b000 r-xp 00000000 08:05 950517     /lib/libc-2.6.so
0079b000-0079d000 r--p 0014e000 08:05 950517     /lib/libc-2.6.so
0079d000-0079e000 rw-p 00150000 08:05 950517     /lib/libc-2.6.so
0079e000-007a1000 rw-p 0079e000 00:00 0
007d5000-007e9000 r-xp 00000000 08:05 68363      /lib/libpthread-2.6.so
007e9000-007ea000 r--p 00013000 08:05 68363      /lib/libpthread-2.6.so
007ea000-007eb000 rw-p 00014000 08:05 68363      /lib/libpthread-2.6.so
007eb000-007ed000 rw-p 007eb000 00:00 0
08048000-08049000 r-xp 00000000 00:18 2230281
/home/andersb/work/robot/ethercat/xenomai/server/try2
08049000-0804a000 rw-p 00000000 00:18 2230281
/home/andersb/work/robot/ethercat/xenomai/server/try2
b7ef1000-b7ef2000 rw-p b7ef1000 00:00 0
b7f0e000-b7f13000 r-xp 00000000 08:05 4129197    /usr/xenomai/lib/libnative.so.1.0.0
b7f13000-b7f14000 rw-p 00004000 08:05 4129197    /usr/xenomai/lib/libnative.so.1.0.0
b7f14000-b7f15000 r-xp 00000000 08:05 4129207    /usr/xenomai/lib/librtdm.so.1.0.0
b7f15000-b7f16000 rw-p 00000000 08:05 4129207    /usr/xenomai/lib/librtdm.so.1.0.0
b7f16000-b7f17000 rw-p b7f16000 00:00 0
b7f17000-b7f18000 r-xp b7f17000 00:00 0          [vdso]
bf970000-bf985000 rw-p bffeb000 00:00 0          [stack]
[child =  0,  0] VmSize:            1912 kB
[child =  1,  1] VmSize:            1980 kB
[child =  2,  2] VmSize:            2048 kB
[child =  3,  3] VmSize:            2116 kB
[child =  4,  4] VmSize:            2184 kB
[child =  5,  5] VmSize:            2252 kB
[child =  6,  6] VmSize:            2320 kB
[child =  7,  7] VmSize:            2388 kB
[child =  8,  8] VmSize:            2456 kB
[child =  9,  9] VmSize:            2524 kB
[child = 10, 10] VmSize:            2640 kB
[child = 11, 11] VmSize:            2640 kB
[child = 12, 12] VmSize:            2640 kB
[child = 13, 13] VmSize:            2640 kB
[child = 14, 14] VmSize:            2640 kB
[child = 15, 15] VmSize:            2640 kB
[child = 16, 16] VmSize:            2640 kB
[child = 17, 17] VmSize:            2640 kB
[child = 18, 18] VmSize:            2640 kB
[child = 19, 19] VmSize:            2640 kB
0062e000-00649000 r-xp 00000000 08:05 950516     /lib/ld-2.6.so
00649000-0064a000 r--p 0001a000 08:05 950516     /lib/ld-2.6.so
0064a000-0064b000 rw-p 0001b000 08:05 950516     /lib/ld-2.6.so
0064d000-0079b000 r-xp 00000000 08:05 950517     /lib/libc-2.6.so
0079b000-0079d000 r--p 0014e000 08:05 950517     /lib/libc-2.6.so
0079d000-0079e000 rw-p 00150000 08:05 950517     /lib/libc-2.6.so
0079e000-007a1000 rw-p 0079e000 00:00 0
007d5000-007e9000 r-xp 00000000 08:05 68363      /lib/libpthread-2.6.so
007e9000-007ea000 r--p 00013000 08:05 68363      /lib/libpthread-2.6.so
007ea000-007eb000 rw-p 00014000 08:05 68363      /lib/libpthread-2.6.so
007eb000-007ed000 rw-p 007eb000 00:00 0
00b68000-00b73000 r-xp 00000000 08:05 68364      /lib/libgcc_s-4.1.2-20070925.so.1
00b73000-00b74000 rw-p 0000a000 08:05 68364      /lib/libgcc_s-4.1.2-20070925.so.1
08048000-08049000 r-xp 00000000 00:18 2230281
/home/andersb/work/robot/ethercat/xenomai/server/try2
08049000-0804a000 rw-p 00000000 00:18 2230281
/home/andersb/work/robot/ethercat/xenomai/server/try2
0804a000-0806b000 rw-p 0804a000 00:00 0          [heap]
b7e47000-b7e48000 ---p b7e47000 00:00 0
b7e48000-b7e58000 rw-p b7e48000 00:00 0
b7e58000-b7e59000 ---p b7e58000 00:00 0
b7e59000-b7e69000 rw-p b7e59000 00:00 0
b7e69000-b7e6a000 ---p b7e69000 00:00 0
b7e6a000-b7e7a000 rw-p b7e6a000 00:00 0
b7e7a000-b7e7b000 ---p b7e7a000 00:00 0
b7e7b000-b7e8b000 rw-p b7e7b000 00:00 0
b7e8b000-b7e8c000 ---p b7e8b000 00:00 0
b7e8c000-b7e9c000 rw-p b7e8c000 00:00 0
b7e9c000-b7e9d000 ---p b7e9c000 00:00 0
b7e9d000-b7ead000 rw-p b7e9d000 00:00 0
b7ead000-b7eae000 ---p b7ead000 00:00 0
b7eae000-b7ebe000 rw-p b7eae000 00:00 0
b7ebe000-b7ebf000 ---p b7ebe000 00:00 0
b7ebf000-b7ecf000 rw-p b7ebf000 00:00 0
b7ecf000-b7ed0000 ---p b7ecf000 00:00 0
b7ed0000-b7ee0000 rw-p b7ed0000 00:00 0
b7ee0000-b7ee1000 ---p b7ee0000 00:00 0
b7ee1000-b7ef1000 rw-p b7ee1000 00:00 0
b7ef1000-b7ef2000 rw-p b7ef1000 00:00 0
b7efc000-b7efd000 ---p b7efc000 00:00 0
b7efd000-b7f0e000 rw-p b7efd000 00:00 0
b7f0e000-b7f13000 r-xp 00000000 08:05 4129197    /usr/xenomai/lib/libnative.so.1.0.0
b7f13000-b7f14000 rw-p 00004000 08:05 4129197    /usr/xenomai/lib/libnative.so.1.0.0
b7f14000-b7f15000 r-xp 00000000 08:05 4129207    /usr/xenomai/lib/librtdm.so.1.0.0
b7f15000-b7f16000 rw-p 00000000 08:05 4129207    /usr/xenomai/lib/librtdm.so.1.0.0
b7f16000-b7f17000 rw-p b7f16000 00:00 0
b7f17000-b7f18000 r-xp b7f17000 00:00 0          [vdso]
bf970000-bf985000 rw-p bffeb000 00:00 0          [stack]

-- 
Anders Blomdell                  Email: anders.blomdell@domain.hid
Department of Automatic Control
Lund University                  Phone:    +46 46 222 4625
P.O. Box 118                     Fax:      +46 46 138118
SE-221 00 Lund, Sweden

