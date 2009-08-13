From: Henry Bausley <hbausley@domain.hid>
Content-Type: multipart/alternative; boundary="=-tYwHi3V7PCDkEpCHSB0Z"
Date: Thu, 13 Aug 2009 11:02:21 -0700
Message-Id: <1250186541.23699.8.camel@domain.hid>
Mime-Version: 1.0
Subject: [Xenomai-help] pthread_setschedparam: Resource temporarily
	unavailable
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

--=-tYwHi3V7PCDkEpCHSB0Z
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

We are using 2.6.28.8 and xenomai 2.4.7 on a AMCC PowerPC 460EX platform
and getting 
the following message.

Xenomai Posix skin init: pthread_setschedparam: Resource temporarily
unavailable


It takes quite a while for this to happen.  The /proc/xenomai/heap value
for used keeps increasing.
Once the "used" gets very close to "size" the user space xenomai
applications can no longer run. 
I have isolated the problem to opening and closing shared memory areas.


  shmfd = shm_open(RTL_SHM_NAME, O_CREAT | O_RDWR, 0777);
  if (shmfd == -1) {
    printf("Gp Share mem Open, Err: %d Msg: (%s)\n", errno,
strerror(errno));
    return -1;
  }
  ftruncate(shmfd,MAKE_PAGESIZE(sizeof(struct SHM)));

  pshm = mmap(NULL,MAKE_PAGESIZE(sizeof(struct SHM)),PROT_READ |
PROT_WRITE,MAP_SHARED, shmfd,0);

  munmap(pshm, MAKE_PAGESIZE(sizeof(struct SHM)));
  close(shmfd);
  shm_unlink(RTL_SHM_NAME);


The above calls are in a shared library that an applications call.

**********************************************************
Outbound scan for Spam or Virus by Barracuda at Delta Tau
**********************************************************

--=-tYwHi3V7PCDkEpCHSB0Z
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 TRANSITIONAL//EN">
<HTML>
<HEAD>
  <META HTTP-EQUIV="Content-Type" CONTENT="text/html; CHARSET=UTF-8">
  <META NAME="GENERATOR" CONTENT="GtkHTML/3.18.3">
</HEAD>
<BODY>
We are using 2.6.28.8 and xenomai 2.4.7 on a AMCC PowerPC 460EX platform and getting <BR>
the following message.<BR>
<BR>
Xenomai Posix skin init: pthread_setschedparam: Resource temporarily unavailable<BR>
<BR>
<BR>
It takes quite a while for this to happen.&nbsp; The /proc/xenomai/heap value for used keeps increasing.<BR>
Once the &quot;used&quot; gets very close to &quot;size&quot; the user space xenomai applications can no longer run. <BR>
I have isolated the problem to opening and closing shared memory areas.<BR>
<BR>
<BR>
&nbsp; shmfd = shm_open(RTL_SHM_NAME, O_CREAT | O_RDWR, 0777);<BR>
&nbsp; if (shmfd == -1) {<BR>
&nbsp;&nbsp;&nbsp; printf(&quot;Gp Share mem Open, Err: %d Msg: (%s)\n&quot;, errno, strerror(errno));<BR>
&nbsp;&nbsp;&nbsp; return -1;<BR>
&nbsp; }<BR>
&nbsp; ftruncate(shmfd,MAKE_PAGESIZE(sizeof(struct SHM)));<BR>
<BR>
&nbsp; pshm = mmap(NULL,MAKE_PAGESIZE(sizeof(struct SHM)),PROT_READ | PROT_WRITE,MAP_SHARED, shmfd,0);<BR>
<BR>
&nbsp; munmap(pshm, MAKE_PAGESIZE(sizeof(struct SHM)));<BR>
&nbsp; close(shmfd);<BR>
&nbsp; shm_unlink(RTL_SHM_NAME);<BR>
<BR>
<BR>
The above calls are in a shared library that an applications call.

</BODY>
</HTML>

--=-tYwHi3V7PCDkEpCHSB0Z--



