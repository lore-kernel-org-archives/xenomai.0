From: "Stoidner, Christoph" <c.stoidner@arvero.de>
Date: Wed, 10 Dec 2014 16:23:51 +0000
Message-ID: <2a74ff40de88431da68f4922b415da89@EX132MBOX1A.de2.local>
References: <471986235a5c47e395ece6b3d18830bd@EX132MBOX1A.de2.local>
 <20141207124041.GS10014@hermes.click-hack.org>
 <76bf78d4e9644f9394558dc10207fb96@EX132MBOX1A.de2.local>
 <20141207135204.GT10014@hermes.click-hack.org>
 <08dc5da0a9d94655819f8094c4ac6c7a@EX132MBOX1A.de2.local>
 <acbe2f0f37f447bea2205fcafd963830@EX132MBOX1A.de2.local>
 <3d1763453771465c9d014b3313bc82c6@EX132MBOX1A.de2.local>,
 <20141209205914.GQ30777@hermes.click-hack.org>
In-Reply-To: <20141209205914.GQ30777@hermes.click-hack.org>
Content-Language: de-DE
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai] Sleeping function called from invalid context
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

=0A=
>=0A=
> Anyway, is not it simply a deadlock in your application ?=0A=
=0A=
I don't think so. Here is a list of all tasks:=0A=
=0A=
~ # cat /proc/xenomai/stat =0A=
CPU  PID    MSW        CSW        PF    STAT       %CPU  NAME=0A=
  0  0      0          7452       0     00500080   98.9  ROOT=0A=
  0  83     196        196        0     00300380    0.0  DOS4=0A=
  0  81     13         13         0     00300380    0.0  DOS5=0A=
  0  97     618        830        0     00300380    0.0  @WDG=0A=
  0  101    751        1127       0     00300380    0.0  HSSR=0A=
  0  128    1268       2186       0     00300380    0.0  DOS8=0A=
  0  129    1          1          0     00300380    0.0  @CGI=0A=
  0  130    7          10         0     00300182    0.0  LOG =0A=
  0  131    1          2          0     00300184    0.0  IOXP=0A=
  0  142    20         42         0     00300380    0.0  KTMR=0A=
  0  151    1652       1901       0     00300380    0.0  Sdrv=0A=
  0  152    383        489        0     00300380    0.0  LApp=0A=
  0  156    0          1          0     00300380    0.0  DOS9=0A=
  0  0      0          14937556   0     00000000    1.0  IRQ16: [timer]=0A=
=0A=
Most of them are in state 00300380, that means:=0A=
  XNSTARTED=0A=
  XNMAPPED=0A=
  XNRELAXED=0A=
  XNFPU=0A=
  XNSHADOW=0A=
=0A=
For a deadlock I would expect all threads must be wait for a semaphore or s=
omething else (state flag XNPEND). However all tasks are freezed.=0A=
=0A=
> Please check that Xenomai timer is still running by checking that=0A=
> its counter increases in cat /proc/xenomai/irq result.=0A=
=0A=
That's the output:=0A=
=0A=
~ # cat /proc/xenomai/irq =0A=
IRQ         CPU0=0A=
 16:    14155140         [timer]=0A=
1027:        5233         [virtual]=0A=
~ # cat /proc/xenomai/irq =0A=
IRQ         CPU0=0A=
 16:    14158294         [timer]=0A=
1027:        5233         [virtual]=0A=
~ # cat /proc/xenomai/irq =0A=
IRQ         CPU0=0A=
 16:    14159556         [timer]=0A=
1027:        5233         [virtual]=0A=
~ # =0A=
=0A=
The time-IRQ (16) is still counting. However the IRQ 1027 - called "virtual=
" - is stopped when all xenomai tasks are freezed. Do you know for what tha=
t 'virtual' IRQ is? =0A=
=0A=
> If Xenomai and Linux timers are shared (I believe they are on=0A=
> imx28), checking the same thing for Linux timer in /proc/interrupts=0A=
> is sufficient, Xenomai timer can not possibly be jammed if Linux=0A=
> timer still ticks.=0A=
=0A=
Linux timer seem to run as well:=0A=
=0A=
~ # cat /proc/interrupts =0A=
           CPU0       =0A=
 16:      49931         -  MXS Timer Tick=0A=
 18:         61         -  mxs-dma=0A=
 19:          0         -  mxs-dma=0A=
 25:         11         -  mxs-mmc=0A=
 26:          0         -  mxs-spi=0A=
207:          0         -  mxs-lradc-touchscreen=0A=
208:          0         -  mxs-lradc-thresh0=0A=
209:          0         -  mxs-lradc-thresh1=0A=
210:          0         -  mxs-lradc-channel0=0A=
211:          0         -  mxs-lradc-channel1=0A=
212:          0         -  mxs-lradc-channel2=0A=
213:          0         -  mxs-lradc-channel3=0A=
214:          0         -  mxs-lradc-channel4=0A=
215:          0         -  mxs-lradc-channel5=0A=
216:          0         -  mxs-lradc-channel6=0A=
217:          0         -  mxs-lradc-channel7=0A=
218:          0         -  mxs-lradc-button0=0A=
219:          0         -  mxs-lradc-button1=0A=
220:          0         -  RTC alarm=0A=
224:         90         -  80072000.serial=0A=
225:       2982         -  uart-pl011=0A=
226:          0         -  ci13xxx_imx=0A=
227:      40138         -  800f0000.ethernet=0A=
Err:          0=0A=
~ # cat /proc/interrupts =0A=
           CPU0       =0A=
 16:      49958         -  MXS Timer Tick=0A=
 18:         61         -  mxs-dma=0A=
 19:          0         -  mxs-dma=0A=
 25:         11         -  mxs-mmc=0A=
 26:          0         -  mxs-spi=0A=
207:          0         -  mxs-lradc-touchscreen=0A=
208:          0         -  mxs-lradc-thresh0=0A=
209:          0         -  mxs-lradc-thresh1=0A=
210:          0         -  mxs-lradc-channel0=0A=
211:          0         -  mxs-lradc-channel1=0A=
212:          0         -  mxs-lradc-channel2=0A=
213:          0         -  mxs-lradc-channel3=0A=
214:          0         -  mxs-lradc-channel4=0A=
215:          0         -  mxs-lradc-channel5=0A=
216:          0         -  mxs-lradc-channel6=0A=
217:          0         -  mxs-lradc-channel7=0A=
218:          0         -  mxs-lradc-button0=0A=
219:          0         -  mxs-lradc-button1=0A=
220:          0         -  RTC alarm=0A=
224:         90         -  80072000.serial=0A=
225:       3115         -  uart-pl011=0A=
226:          0         -  ci13xxx_imx=0A=
227:      40154         -  800f0000.ethernet=0A=
Err:          0=0A=
~ # =0A=
=0A=
=0A=
Regards,=0A=
Christoph=0A=

