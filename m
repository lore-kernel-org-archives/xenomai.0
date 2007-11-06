Message-ID: <3d3b73870711061228j4199abes6eb3106c6d585a57@domain.hid>
Date: Tue, 6 Nov 2007 17:28:31 -0300
From: "Hugo Braga" <hugovaz@domain.hid>
Sender: hugobraga@domain.hid
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Subject: [Xenomai-help]  the system has halted while running xeno-test
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Hi,

I desabled xeno_irqbench as Jan Kiszka told me to but the system keeps
without response. Sometimes when I run xeno-test, the system stops
working after this message has been shown:
...
running: cat /proc/xenomai/rtdm/named_devices
Ter Nov  6 15:52:15 BRT 2007
running: cat /proc/xenomai/rtdm/protocol_devices
Hash	ProtocolFamily:SocketType	Driver		/proc

Ter Nov  6 15:52:15 BRT 2007
running: top -bn1c
top - 15:52:16 up  3:59,  3 users,  load average: 4.61, 4.08, 2.87
Tasks:  80 total,   6 running,  74 sleeping,   0 stopped,   0 zombie
Cpu(s): 16.0%us, 11.9%sy,  1.0%ni, 70.3%id,  0.9%wa,  0.0%hi,  0.0%si,  0.0%st
Mem:    507600k total,   500820k used,     6780k free,    13272k buffers
Swap:   979924k total,       40k used,   979884k free,   330728k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
 8715 root      25   0  2880  560  460 R 19.7  0.1  10:17.42 dd if /dev/zero of
 9220 root      25   0  2880  556  460 R 19.7  0.1   6:37.86 dd if /dev/zero of
 9695 root      25   0  2880  556  460 R 19.7  0.1   3:50.25 dd if /dev/zero of

Ter Nov  6 15:52:16 BRT 2007
running: ./run -- -sh -T 120 -t0 # latency
*
*
* Type ^C to stop this application.
*
*
...

Sometimes it completes latency test 1 and 2 but halts at latency test
3. In both cases I have to reboot the machine. Even when it completes
latency test 1 or 2, it takes a long time to start showing this
message:
...
== Sampling period: 100 us
== Test mode: periodic user-mode task
== All results in microseconds
warming up...
RTT|  00:00:01  (periodic user-mode task, 100 us period, priority 99)
...

When I disabled "Processor type and features->Symmetric
multi-processing support" and "Processor type and features->Multi-core
scheduler support" in the kernel's configuration file, the system
didn't stop, althought the latency has increased.

My machine is:
Intel Core 2 Duo 2.00GHz
Intel Deskop Board D946GZIS
I built linux 2.6.19.7 linux kernel with xenomai 2.3.4 and
adeos-ipipe-2.6.19-i386-1.7-03.patch

Please help me to solve this issue.

Thank you
Hugo Braga.

