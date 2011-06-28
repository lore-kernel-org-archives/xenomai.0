From: Henry Bausley <hbausley@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 28 Jun 2011 11:25:51 -0700
Message-ID: <1309285551.669.35.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] Posix Memory Leak w/ sem_open
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org


Using the program below the used main heap continues to grow forever. 

int  main(void)
{
  sem_t *mutex;
  mutex = sem_open(SEM_NAME,O_CREAT,0644,1);
  sem_close(mutex);
  sem_unlink(SEM_NAME);
  return 0;
}

I am using xenomai 2.5.6 with the ipipe-2.6.35.9-powerpc-2.12-02
kernel.  Below you can see the used heap continually grow when
executing the above program.

root@domain.hid# uname -a
Linux powerpmac 2.6.35.9 #4 Tue Jun 28 08:45:19 PDT 2011 ppc GNU/Linux
root@domain.hid# cat /proc/xenomai/version 
2.5.6
root@domain.hid#  test/test && cat /proc/xenomai/heap | grep
main
size=520192:used=9600:pagesz=512  (main heap)
root@domain.hid#  test/test && cat /proc/xenomai/heap | grep
main
size=520192:used=9632:pagesz=512  (main heap)
root@domain.hid#  test/test && cat /proc/xenomai/heap | grep
main
size=520192:used=9664:pagesz=512  (main heap)
root@domain.hid#  test/test && cat /proc/xenomai/heap | grep
main
size=520192:used=9696:pagesz=512  (main heap)
root@domain.hid#  test/test && cat /proc/xenomai/heap | grep
main
size=520192:used=9728:pagesz=512  (main heap)
root@domain.hid#  test/test && cat /proc/xenomai/heap | grep
main
size=520192:used=9760:pagesz=512  (main heap)







Outbound scan for Spam or Virus by Barracuda at Delta Tau


