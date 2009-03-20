From: Vikesh Rambaran <vikesh.rambaran@domain.hid>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 20 Mar 2009 12:56:31 +0200
Message-Id: <1237546591.9844.115.camel@domain.hid>
Mime-Version: 1.0
Subject: [Xenomai-help] rtserial interface stalls
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

Hi

We have the following setup : 

Hardware : Intel Core Duo, Quatech PCI 200/300 4 channel serial card
Software : Ubuntu 8.04, Linux 2.6.24, Xenomai 2.4.5.

Application : 3 tasks running at (Task1) 100uS (Task2) 20mS (Task3) 1S

Tasks 1 and 3 are 'empty' at the moment. Task 2 transmits and receives
multiple messages on rtser0 and rtser1

Serial ports are configured as follows

  serialConfig.config_mask      = 0xFFFF;
  serialConfig.baud_rate        = configPtr->BitRate;    //= 115200
  serialConfig.parity           = configPtr->Parity;     //= None
  serialConfig.data_bits        = configPtr->DataBits;   //= 8
  serialConfig.stop_bits        = configPtr->StopBits;   //= 1
  serialConfig.handshake        = configPtr->FlowControl;//= None 
  serialConfig.fifo_depth       = RTSER_DEF_FIFO_DEPTH;
  serialConfig.rx_timeout       = RTDM_TIMEOUT_NONE;//RTSER_DEF_TIMEOUT;
  serialConfig.tx_timeout       = RTSER_DEF_TIMEOUT;
  serialConfig.event_timeout    = RTSER_DEF_TIMEOUT;
  serialConfig.timestamp_history= RTSER_RX_TIMESTAMP_HISTORY;
  serialConfig.event_mask       = RTSER_DEF_EVENT_MASK;


Application runs for hours/days with loop back on PCI card connector


Problem
-------

However, between two PCs or external test unit, task 2 stops after a
few minutes. The other tasks are still active.


/proc/xenomai/ while running


seeker@domain.hid$ cat stat 
CPU  PID    MSW        CSW        PF    STAT       %CPU  NAME
  0  0      0          43778348   0     00500080   82.9  ROOT/0
  1  0      0          0          0     00500080  100.0  ROOT/1
  0  8284   1          280862     0     00300184    5.0  ASU_SYNC
  0  8285   2          3946       0     00300184    0.2  HILS
  0  8286   1          33         0     00300184    0.0  DEBUG
  0  0      0          8429       0     00000000    4.1  IRQ16: rtser0
  1  0      0          0          0     00000000    0.0  IRQ16: rtser0
  0  0      0          96987      0     00000000    6.1  IRQ16: rtser1
  1  0      0          0          0     00000000    0.0  IRQ16: rtser1
  0  0      0          45948236   0     00000000    1.2  IRQ233: [timer]
  1  0      0          2102218    0     00000000    0.0  IRQ233: [timer]
seeker@domain.hid$ cat sched 
CPU  PID    PRI      PERIOD     TIMEOUT    TIMEBASE  STAT       NAME
  0  0       -1      0          0          master    R          ROOT/0
  1  0       -1      0          0          master    R          ROOT/1
  0  8284     3      100000     51111      master    D          ASU_SYNC
  0  8285     2      20000000   13078512   master    D          HILS
  0  8286     1      1000000000 553400299  master    D          DEBUG


/proc/xenomai/ when task stalls

seeker@domain.hid$ cat sched 
CPU  PID    PRI      PERIOD     TIMEOUT    TIMEBASE  STAT       NAME
  0  0       -1      0          0          master    R          ROOT/0
  1  0       -1      0          0          master    R          ROOT/1
  0  6223     3      100000     67714      master    D          ASU_SYNC
  0  6224     2      20000000   0          master    W          HILS
  0  6225     1      1000000000 669570391  master    D          DEBUG

seeker@domain.hid$ cat stat 
CPU  PID    MSW        CSW        PF    STAT       %CPU  NAME
  0  0      0          37141696   0     00500080   85.1  ROOT/0
  1  0      0          0          0     00500080  100.0  ROOT/1
  0  6223   1          16318556   0     00300184    4.9  ASU_SYNC
  0  6224   1          9506       0     00300182    0.0  HILS
  0  6225   1          1756       0     00300184    0.0  DEBUG
  0  0      0          20694      0     00000000    2.8  IRQ16: rtser0
  1  0      0          0          0     00000000    0.0  IRQ16: rtser0
  0  0      0          5471547    0     00000000    5.5  IRQ16: rtser1
  1  0      0          0          0     00000000    0.0  IRQ16: rtser1
  0  0      0          39087824   0     00000000    1.2  IRQ233: [timer]
  1  0      0          1891732    0     00000000    0.0  IRQ233: [timer]


Alternative tried (after a bit of debugging)
-----------------

Changed  serialConfig.tx_timeout       = RTSER_DEF_TIMEOUT;
to       serialConfig.tx_timeout       = RTDM_TIMEOUT_NONE;

Task 2 then runs continuously. Writing to rtser0 returns valid number of
bytes written but no data appears on serial port pin. At the same time
rtser1 functions normally.

/proc/xenomai/stat shows rtser0 CSW incrementing. Disconnecting rtser0
stops CSW from incrementing.

Looks like the rtser0 tx interrupt gets 'lost' somehow and never
recovers. Restarting the application restores communication again, for a
while ...


Has any one else experienced a similar situation ?

Any suggestions on how to trace this further, would be greatly
appreciated.

Thanx
Vicki

[PS Downloaded the latest Xenomai and kernel. Going to build and test
that later]







