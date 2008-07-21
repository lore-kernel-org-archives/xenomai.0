Date: Mon, 21 Jul 2008 12:58:27 +0200
From: "Petr Cervenka" <grugh@domain.hid>
MIME-Version: 1.0
Message-ID: <200807211258.30164@domain.hid>
References: <48733483.2050204@domain.hid> <200807091719.17625@domain.hid>
	<4874E1D8.6020307@domain.hid> <200807111518.16150@domain.hid>
	<200807151642.18829@domain.hid> <487CBC4A.5050309@domain.hid>
	<200807161039.8828@domain.hid> <487F1D25.5080508@domain.hid>
In-Reply-To: <487F1D25.5080508@domain.hid>
Content-Type: text/plain; charset="windows-1250"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai-help] Kernel panic: not syncing
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: jan.kiszka@domain.hid
Cc: xenomai@xenomai.org

Jan Kiszka wrote:
>We likely see some race that causes weird memory corruptions. Its
>probability often increases when the code execution frequency raises.
>
>However, reducing the test case is very important now to reduce the
>search domain for this issue. E.g. try to fake peripheral access as far
>as possible, unloading the unused driver and only leaving the test
>program behind that is executable on arbitrary Xenomai installation
>(maybe finally on one of my boxes...).
>
I'm not sure if I will be able to reduce the software. It's dependent on hardware and it's controlled from another windows computer with GUI and control application. And to check if the error is still there usually takes couple of days.
I ran a test during last weekend (and nothing wrong happened). But the /proc/xenomai/stat output is strange. Probably some type cast error, because 18446744071739514846 = 0xFFFFFFFF8A939FDE and the appropriate value perhaps should be 0x000000008A939FDE = 2324930526.

CPU  PID    MSW        CSW        PF    STAT       %CPU  NAME
  0  0      0          18446744071739514846 0     00500088   69.8  ROOT/0
  1  0      0          18446744071675175740 0     00500080   23.2  ROOT/1
  0  5299   0          351459     0     00300182    0.0  LOGGER_TASK_1804289383
  0  5100   8          283613     0     00300186    0.0
  0  5317   0          40591      0     00300182    0.0
  0  5034   2          2330696    0     00300184    0.0  MAIN_TASK_2056
  0  5318   5          18446744071736105613 3     00300180   29.5  REG_TASK_2056
  0  5319   28         36         0     00300182    0.0  WORK_TASK_2056
  0  5321   38926      39159      0     00300380    0.0  CERECV_2056
  0  5323   1159385    2438330    0     00300181    0.0  CESEND_2056
  1  5710   0          18446744071675175740 0     00300184   76.8  HARDWARE_KERNEL
  0  0      0          18446744071964064315 0     00000000    0.7  IRQ520: [timer]
  1  0      0          232145209  0     00000000    0.0  IRQ520: [timer] 

My theory is, that a occasional "longer" work or system call usage in the real-time task corrupts the rest of the system (under some special circumstances).

Petr


