From: Gowtham Garimella <ggarime1@jhu.edu>
Date: Tue, 14 Jul 2015 17:08:08 +0000
Message-ID: <CO1PR01MB2560ACAC2B7CA52372B5A7B949B0@CO1PR01MB256.prod.exchangelabs.com>
References: <CO1PR01MB256AC4CE16186B5C49AEABD949B0@CO1PR01MB256.prod.exchangelabs.com>
 <55A4BA1C.9080306@siemens.com>
 <9f7421b4e96ca7d5e6ce77ffe8fc34f6.squirrel@sourcetrek.com>,
 <55A4C2C5.1040202@siemens.com>
In-Reply-To: <55A4C2C5.1040202@siemens.com>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] xenomai latency test hangs due to kernel paging
	request
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>
Cc: "jan.kiszka@siemens.com" <jan.kiszka@siemens.com>


Hi Everyone,
I used the new kernel suggested by Gilles i.e 3.14.39 downloaded from here:

https://www.kernel.org/pub/linux/kernel/v3.x/linux-3.14.39.tar.gz

and the patch from previous email. I am still using xenomai 2.6.4 and also =
disabled the CONFIG_DEBUG_STACK_USAGE in the kernel config. I generated the=
 config by following steps:
make defconfig
make menuconfig
Followed the steps from "Configuring for x86 based kernels" on xenomai webs=
ite

Compiled and installed kernel. I am able to boot into the OS without any is=
sues. But when I run xeno latency the test still hangs and keeps printing l=
ot of log messages in the syslog. It also shows a Oops and the bug I specif=
ied from previous email. I also find that the log says Xorg and compiz are =
tainted. I do not know what these mean. Do I need to enable any specific dr=
iver etc? I am attaching the full sys log as suggested before. I am also at=
taching the new config file.  =


I believe I applied the right patch to the kernel and I do not understand w=
hat this means "userspace is out of sync wrt to the kernel used here". Is t=
here any way to check this ? =


Thank you for your help. Please let me know if you need any other informati=
on. =


Regards,
Gowtham Garimella.
________________________________________
From: Jan Kiszka <jan.kiszka@siemens.com>
Sent: Tuesday, July 14, 2015 4:05 AM
To: Gilles Chanteperdrix
Cc: Gowtham Garimella; xenomai@xenomai.org
Subject: Re: [Xenomai] xenomai latency test hangs due to kernel paging requ=
est

On 2015-07-14 09:36, Gilles Chanteperdrix wrote:
>
> Jan Kiszka wrote:
>> What this tells us, though, is that userspace is likely out of sync /wrt
>> to the kernel used here. Please check if both installations actually
>> match.
>
> How is that? The kernel ABI is versioned and the version is checked at
> startup, so, I believe the user and kernel can not be "out of sync".
>
> Can not the name pointer passed to rt_task_create simply be invalid?

Could be - if that weren't the standard latency test.

Jan

--
Siemens AG, Corporate Technology, CT RTC ITP SES-DE
Corporate Competence Center Embedded Linux

-------------- next part --------------
A non-text attachment was scrubbed...
Name: syslog_final
Type: application/octet-stream
Size: 153457 bytes
Desc: syslog_final
URL: <http://xenomai.org/pipermail/xenomai/attachments/20150714/c6f38f7d/at=
tachment.obj>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: config_3_14_39
Type: application/octet-stream
Size: 94921 bytes
Desc: config_3_14_39
URL: <http://xenomai.org/pipermail/xenomai/attachments/20150714/c6f38f7d/at=
tachment-0001.obj>
