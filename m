Subject: Re: Trying Xenomai3.2 and has some web browser problem
References: <TY2PR04MB3838919175C4210652E4FCD4AA939@TY2PR04MB3838.apcprd04.prod.outlook.com>
 <ae935e63-ad36-7d98-da3a-7046948ab38a@siemens.com>
 <TY2PR04MB3838BC44901BBCE5A33A14A8AA949@TY2PR04MB3838.apcprd04.prod.outlook.com>
 <6bd9fd83a953df456c4864fdf030eb918cf6e644.camel@siemens.com>
 <TY2PR04MB38382DD227A50372A8E60025AA949@TY2PR04MB3838.apcprd04.prod.outlook.com>
 <7c06251b-ea57-fef3-ddb5-c6c1771dc680@siemens.com>
 <TY2PR04MB3838FDC0FB744785FE7DCA30AA949@TY2PR04MB3838.apcprd04.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <546568f6-3391-d890-16ba-7cc16f348202@siemens.com>
Date: Thu, 11 Nov 2021 19:03:06 +0100
MIME-Version: 1.0
In-Reply-To: <TY2PR04MB3838FDC0FB744785FE7DCA30AA949@TY2PR04MB3838.apcprd04.prod.outlook.com>
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
To: Ando Yuta <andouyuuta@yamaha-motor.co.jp>, "Bezdeka, Florian" <florian.bezdeka@siemens.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 11.11.21 12:30, Ando Yuta wrote:
> Hello Jan
> 
>> I'm starting to reproduce, and there is some behavioral difference on
>> 5.10 with vs. without Dovetail/Xenomai. I'm now trying to narrow this down, will keep you posted.
> 
> Thank you.
> We are waiting for your fix as we continue testing xenomai 3.2.
> 
> Yuta Ando
> 
> -----Original Message-----
> From: Jan Kiszka <jan.kiszka@siemens.com> 
> Sent: Thursday, November 11, 2021 8:03 PM
> To: Ando Yuta <andouyuuta@yamaha-motor.co.jp>; Bezdeka, Florian <florian.bezdeka@siemens.com>; xenomai@xenomai.org
> Subject: Re: Trying Xenomai3.2 and has some web browser problem
> 
> On 11.11.21 11:58, Ando Yuta wrote:
>> Hello
>>
>>> Sandbox enabled:
>>> stat("/sys/fs/cgroup/cpuset/chrome", 0x7f9068a987c0) = -1 ENOSYS 
>>> (Function not implemented) Sandbox disabled:
>>> stat("/sys/fs/cgroup/cpuset/chrome", 0x7f9e3a03a7c0) = -1 ENOENT (No 
>>> such file or directory) You have updated the kernel, but did you 
>>> update your libseccomp security profile as well? (IOW: Have you updated your userspace as well?) I know about some problems in the past where similar affects were observed when using syscalls that were not known to the security profile in use. The stat call is not new, but ENOSYS is unexpected.
>>
>> Yes I checked. My seccomp version is 2.5.1-1ubuntu1~18.04.1.
>> Is there anything else I need to do to update the security profile of libseccomp?
>>
> 
> I'm starting to reproduce, and there is some behavioral difference on
> 5.10 with vs. without Dovetail/Xenomai. I'm now trying to narrow this down, will keep you posted.
> 

This seems to resolve the issue:

diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
index ac53de5717bd..ecf68779d9fb 100644
--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -76,8 +76,8 @@
  * Status codes of syscall entry when Dovetail is enabled. Must not
  * conflict with valid syscall numbers.
  */
-#define EXIT_SYSCALL_OOB	(-1)
-#define EXIT_SYSCALL_TAIL	(-2)
+#define EXIT_SYSCALL_OOB	(-2)
+#define EXIT_SYSCALL_TAIL	(-3)
 
 /**
  * arch_check_user_regs - Architecture specific sanity check for user mode regs


Proper patch with explanation will follow later.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

