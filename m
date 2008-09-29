From: Niklaus Giger <niklaus.giger@domain.hid>
Date: Tue, 30 Sep 2008 00:59:42 +0200
References: <200809282321.25635.niklaus.giger@domain.hid>
In-Reply-To: <200809282321.25635.niklaus.giger@domain.hid>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_f3V4IKb6L2X5WUx"
Message-Id: <200809300059.43864.niklaus.giger@domain.hid>
Subject: Re: [Xenomai-core] Problems using rt_intr_wait on PowerPC
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

--Boundary-00=_f3V4IKb6L2X5WUx
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi

I still could not figure out, what is going wrong. It seem that no
interrupt is coming through. I would appreciate if anybody could take
a look at the attached program.

Since yesterday I fixed the following two errors:
rt_intr_create returned ENOSYS, as CONFIG_XENO_OPT_NATIVE_INTR was
not enabled.

Secondly I erronously ignored the -EIDRM return value from rt_intr_wait.

I am puzzled that (as seen on this input) that  rt_intr_enable returns ENODEV.
It seems that is used to check the validity include/asm-powerpc/wrappers.h
but I cannot figure out the reason why it fails.
> main: counter1 0 errors 0 irq_number 25
> main: rt_intr_create returns 0 ENOSYS ist 38
> main: rt_task_create returns 0
> main: before enabling interrupts
> enableInt: rt_intr_enable failed -19 ENODEV 19
> irq_server: Starting. intrDesc 0x10048184 cookie 0xbeef
> main: rt_task_start returns 0
> enableInt: rt_intr_enable failed -19 ENODEV 19
> main: counter 0 errors 0 done
> irq_server: deleted interrupt object descriptor -43
> cleanup: counter 0 errors 0 done
What I see however in /proc/interrupts that my interrupt 25
does not show up, e.g. 
>  cat /proc/interrupts
>            CPU0
>  16:       2371   UIC   Level     serial
>  17:       8996   UIC   Level     MAL TX EOB
>  18:      14879   UIC   Level     MAL RX EOB
>  19:          0   UIC   Level     MAL SERR
>  20:          0   UIC   Level     MAL TX DE
>  21:          0   UIC   Level     MAL RX DE
>  22:          0   UIC   Level     EMAC
> BAD:          0
I am a little bit confused about what I have to do to get my interrupt
handler working.

Best regards

Am Sonntag 28 September 2008 23.21:24 schrieb Niklaus Giger:
> Hi
>
> Based on the user_irq.c I created a simple test program for my PPC405GPr
> board.
>
> We have a FPGA which generates an interrupt every millisecond.
> It seems to work as simple test (fire it once and assure that it
> sets the interrupt-bit).
>
> When I connect it to the irq_server however (letting the main task
> sleep 1 second) I get around 2321964 error and not a single OK from
> rt_intr_wait.
> Also my debug LED flicker very fast.
Th
> The FPGA is connected to the External Interrupt 0, which has the number 25.
>
> I think that I either got the polarity/level/edge register wrong or
> I am playing with the wrong interrupt.
>
> Could anybody tell me, whether I used the correct interrupt number?
> Does Linux somewhere overwrite the values for the UIC polarity/level, etc
> settings written by U-Boot (e.g. for my board in board_early_init_f)
>
> Any hints are welcome.
>
> Best regards

-- 
NIklaus Giger


--Boundary-00=_f3V4IKb6L2X5WUx
Content-Type: text/x-csrc;
  charset="iso-8859-1";
  name="tick_interrupt.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="tick_interrupt.c"

#include <sys/mman.h>
#include <native/task.h>
#include <native/intr.h>
#include <bsp_def.h>
#include <unistd.h>
#include <stdlib.h>

#define TASK_PRIO  99 /* Highest RT priority */
#define TASK_MODE  0  /* No flags */
#define TASK_STKSZ 0  /* Stack size (use default one) */

RT_INTR intr_desc;

RT_TASK server_desc;
static int counter, errCounter;
int s_tickResetValue  = TICK_INT_ENABLE | TICK_INT_RESET | TICK_START | TICK_INTERVAL_1000_US;
int s_tickEnableValue = TICK_INT_ENABLE                  | TICK_START | TICK_INTERVAL_1000_US;
void cleanup (void);

void enableInt()
{
	int err;
	sys_set_tick_control_register_value(TICK_INT_RESET);
	sys_set_tick_control_register_value(s_tickResetValue);
	sys_set_tick_control_register_value(s_tickEnableValue);
	err = rt_intr_enable(&intr_desc);
	printf("%s: rt_intr_enable failed %d ENODEV %d\n", __FUNCTION__, err, ENODEV);
}

void irq_server (void *cookie)
{
	int err;
	printf("%s: Starting. intrDesc %p cookie %p\n", __FUNCTION__, &intr_desc, cookie);
	for (;;) {

		/* Wait for the next interrupt on channel #7. */
		err = rt_intr_wait(&intr_desc,TM_INFINITE);
		if (err == -EIDRM) { printf("%s: deleted interrupt object descriptor %d\n", __FUNCTION__, err); return; }
		if (err) errCounter++; 
		else {
			/* Process interrupt. */
			counter++;
			sys_set_tick_control_register_value(s_tickResetValue);
			sys_set_tick_control_register_value(s_tickEnableValue);
		}
		sysLedSet((errCounter+counter)/1000);
		if ((counter + errCounter) > 800000) 
		{
			printf("%s: Done. counter1 %d errors %d\n", __FUNCTION__, counter, errCounter);
			return;
		}
	}
}

int main (int argc, char *argv[])
{
	int err;
	int irq_number;
	atexit(cleanup);
	mlockall(MCL_CURRENT|MCL_FUTURE);
	bsp_init();
	irq_number = sys_get_imc_interrupt_vector(IMC_BUS_INTERRUPT_0);

	counter = 0;
	errCounter = 0;
	sysLedSet(3);

	printf("%s: counter1 %d errors %d irq_number %d\n", __FUNCTION__, counter, errCounter,irq_number);
	err = rt_intr_create(&intr_desc,"Ext Int 0",irq_number, 0);
	printf("%s: rt_intr_create returns %d ENOSYS ist %d\n", __FUNCTION__, err, ENOSYS);
	if (err) {
		printf("%s: rt_intr_create failed %d ENOSYS ist %d\n", __FUNCTION__, err, ENOSYS);
		printErrno(-err);
		return 2;
	}
	err = rt_task_create(&server_desc,
				"MyIrqServer",
				TASK_STKSZ,
				TASK_PRIO,
				TASK_MODE);
	printf("%s: rt_task_create returns %d\n", __FUNCTION__, err);
	if (err) {
		printf("%s: rt_task_create failed %d\n", __FUNCTION__, err);
		printErrno(-err);
		return 2;
	}
	printf("%s: before enabling interrupts\n", __FUNCTION__);
	enableInt();
	err = rt_task_start(&server_desc,&irq_server, 0xbeef);
	printf("%s: rt_task_start returns %d\n", __FUNCTION__, err);
	enableInt();
	sleep(1);
	printf("%s: counter %d errors %d done\n", __FUNCTION__, counter, errCounter);
	return 0;
}

void cleanup (void)
{
	rt_intr_delete(&intr_desc);
	rt_task_delete(&server_desc);
	printf("%s: counter %d errors %d done\n", __FUNCTION__, counter, errCounter);
}

--Boundary-00=_f3V4IKb6L2X5WUx--

