Message-ID: <485AB64D.4020009@domain.hid>
Date: Thu, 19 Jun 2008 21:41:01 +0200
From: Anders Blomdell <anders.blomdell@domain.hid>
MIME-Version: 1.0
References: <A3B06EAFE0D9C14096681C935E0B300802110A0C@zue-s-15.zue.zwick.de>	<4829613B.3000500@domain.hid><0C9896A4B6D338488AD6FFFE58BAEF100276DBF6@domain.hid><48297566.1010607@domain.hid><0C9896A4B6D338488AD6FFFE58BAEF100276DC66@domain.hid>	<4829AA19.8070405@domain.hid>	<0C9896A4B6D338488AD6FFFE58BAEF100276DD0C@serveur3.lgm.com>	<4829C8C9.4020300@domain.hid>	<0C9896A4B6D338488AD6FFFE58BAEF100276DDDE@serveur3.lgm.com>	<482B3BCF.8090700@domain.hid>	<482B3EE5.9030702@domain.hid>	<0C9896A4B6D338488AD6FFFE58BAEF100276E025@domain.hid>	<482D33B3.9070700@domain.hid>	<0C9896A4B6D338488AD6FFFE58BAEF100276E212@domain.hid>	<482D6FF9.3050008@domain.hid>
	<482D82EB.3050608@domain.hid>	<482D885A.7080706@domain.hid>
	<482D8B50.5090502@domain.hid> <482DCAD0.1010408@domain.hid>
In-Reply-To: <482DCAD0.1010408@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] Weird rt_dev_socket behaviour
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai-help <xenomai@xenomai.org>
Cc: Jan Kiszka <jan.kiszka@domain.hid>

With xenomai-2.4.2 and rtnet-0.9.10, is it expected that the following code:

  ...
  mlockall(MCL_CURRENT|MCL_FUTURE);
  rt_task_shadow(&task_self, NULL, 1, T_FPU);
  fd = rt_dev_socket(AF_PACKET, SOCK_DGRAM, 0);
  if (fd < 0) {
    fprintf(stderr, "failed to create socket %d\n", fd);
    exit(1);
  }
  ...

fails with the message "failed to create socket -12", while the following works
as expected:

  ...
  mlockall(MCL_CURRENT|MCL_FUTURE);
  rt_task_shadow(&task_self, NULL, 1, T_FPU);
  rt_task_set_mode(T_PRIMARY, 0, 0);
  fd = rt_dev_socket(AF_PACKET, SOCK_DGRAM, 0);
  if (fd < 0) {
    fprintf(stderr, "failed to create socket %d\n", fd);
    exit(1);
  }
  ...

Regards

Anders Blomdell


-- 
Anders Blomdell                  Email: anders.blomdell@domain.hid
Department of Automatic Control
Lund University                  Phone:    +46 46 222 4625
P.O. Box 118                     Fax:      +46 46 138118
SE-221 00 Lund, Sweden

