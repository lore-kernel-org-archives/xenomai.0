From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: arm64: More syscall corruptions
Message-ID: <2ef3a424-7085-73da-2eb0-5e450d8fa827@siemens.com>
Date: Mon, 9 Aug 2021 09:41:59 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>, Philippe Gerum <rpm@xenomai.org>, "Bezdeka, Florian (T RDA IOT SES-DE)" <florian.bezdeka@siemens.com>

Hi all,

the failing y2038 testcase we see in CI [1] is caused by another problem 
of our syscall wrappers, this time on arm64:

        /* Timeout is never read by the kernel, so NULL should be OK */
        ret = XENOMAI_SYSCALL5(sc_nr, mq, msg, strlen(msg), 0, NULL);
    235c:       b940dfe0        ldr     w0, [sp, #220]
    2360:       32040000        orr     w0, w0, #0x10000000
    2364:       2a0003e8        mov     w8, w0
--> w8 holds the syscall number
    2368:       b980d3e0        ldrsw   x0, [sp, #208]
    236c:       910043e0        add     x0, sp, #0x10
    2370:       aa0003e1        mov     x1, x0
    2374:       910043e0        add     x0, sp, #0x10
    2378:       94000000        bl      0 <strlen>
                        2378: R_AARCH64_CALL26  strlen
--> w8 is clobbered
    237c:       aa0003e2        mov     x2, x0
    2380:       d2800003        mov     x3, #0x0                        // #0
    2384:       d2800004        mov     x4, #0x0                        // #0
    2388:       d4000001        svc     #0x0

The problem is that w8/r8 is the "Indirect result location register", 
thus can be overwritten when calling a function - and that's what strlen 
does.

What are we missing in our syscall black magic to prevent this? Or this 
this the final call to move the wrapper into am out-of-line function?

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

