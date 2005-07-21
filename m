Date: Thu, 21 Jul 2005 09:49:45 +0200
From: Sven Krewitt <sven@domain.hid>
Message-ID: <86B0924B71F63459F064BA28@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Subject: [Adeos-main] adeos kernel panic
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: adeos-main@gna.org

Hi,

i am trying to get adeos working with a 2.4.21 kernel for an arm (altera 
excalibur) processor. I work with the ep9301_hal17_2.4.21-rmk1-epxa.patch 
as a template.

When all adeos code (except the machine-dependent, which I replaced with 
code for my machine, if needed) was in place, I could compile the kernel 
without errors.

When I boot this kernel, it stops with a kernel panic at the init-process.

Can anyone give me a hint, where in the adeos code I have to search for 
errors and must make any corrections? Or some method to debug the kernel.

Thanks in advance,
	Sven

Here are the logs:

[...]
Adeos 2.4arm-epxa: Root domain Linux registered.
Adeos: Pipelining started.
[...]
Mounted devfs on /dev
Freeing init memory: 56K
all done. starting init now...
Unable to handle kernel paging request at virtual address 6000001c
pgd = c1f10000
[6000001c] *pgd=00000000, *pmd = 00000000
Internal error: Oops: 5
CPU: 0
pc : [<c0018224>]    lr : [<c0018218>]    Not tainted
sp : c01e5fa0  ip : c01e5fa0  fp : 00000000
r10: 4000c7fc  r9 : 00000000  r8 : 00000000
r7 : 60000010  r6 : 40001394  r5 : bfffff94  r4 : ffffffff
r3 : 60000010  r2 : 40001394  r1 : bfffff94  r0 : c01e5fa0
Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  Segment user
Control: 317F  Table: 01F10000  DAC: 00000015
Process init (pid: 1, stack limit = 0xc01e4380)
Stack: (0xc01e5fa0 to 0xc01e6000)
5fa0: 400044cc bfffff94 0000007f 000044cc 00000000 00000000 40000000 
bfffff10
5fc0: 00000000 00000000 4000c7fc 00000000 00000004 bffffe20 40000001 
40001394
5fe0: 60000010 ffffffff 00000000 c01e5ff8 c0019c4c c001604c 00000000 
00000000
Backtrace: no frame pointer
Code: eb0015f3 e1a03007 e1a02006 e1a01005 (e597700c)
exit code: 11
Kernel panic: Attempted to kill init!
Adeos: Current domain=Linux on CPU #0 [stackbase=00000000]
   Linux[cpuid=0]: priority=100, status=0x0, pending_hi=0x0


-- 
** *** ***** ******* *********** ************* *****************
Key:http://pgp.mit.edu:11371/pks/lookup?op=get&search=0xE5DB12F6
Fingerprint:   BB5A 8312 1DED E5EB 2558 3CD7 860F E280 E5DB 12F6


