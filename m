Subject: Re: EAFNOSUPPORT despite kernel build in
References: <c84647b1-bdc6-87f3-2f56-3d9e1b3264b6@compador.de>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <b1794f0d-7507-cbbd-7351-032562cceeff@siemens.com>
Date: Tue, 4 Dec 2018 14:46:55 +0100
MIME-Version: 1.0
In-Reply-To: <c84647b1-bdc6-87f3-2f56-3d9e1b3264b6@compador.de>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Johannes Holtz <johannes.holtz@compador.de>, xenomai@xenomai.org

On 04.12.18 12:04, Johannes Holtz via Xenomai wrote:
> 
> Hello,
> 
> When I request a socket with AF_RTIPC I get an EAFNOSUPPORT in return.
> int sock = socket(AF_RTIPC, SOCK_DGRAM, IPCPROTO_IDDP);

You likely didn't wrap this posix application to link against the Xenomai libs, 
rather than normal libc. See manuals / wikis.

> 
> rtipc.h is included
> #include <rtdm/rtipc.h>
> 
> I have build the support for RTIPC into the kernel (not a module) and
> expected this to work more or less out of the box. Did I forget something
> or must this feature be a module?
> I have searched for a solution but haven't found anything.
> 
> Here information about the system:
> 
> virtual machine (VBox) with 1 CPU,  2.5GB RAM, 15GB disk
> 
> base kernel version is 3.18.20
> 
> xenomai  version is 2.6.5 (from the download page not from the git repo)

Don't start anything new on 2.6 anymore, it's long retired.

> 
> using the included ipipe patch
> xenomai-2.6.5/ksrc/arch/x86/patches/ipipe-core-3.18.20-x86-7.patch

Same goes for such old kernels and patches.

> 
> the kernel config has the feature enabled
> root@xeno:~/kernelbuild# grep RTIPC /boot/config-3.18.20
> CONFIG_XENO_DRIVERS_RTIPC=y
> CONFIG_XENO_DRIVERS_RTIPC_XDDP=y
> CONFIG_XENO_DRIVERS_RTIPC_IDDP=y
> CONFIG_XENO_DRIVERS_RTIPC_BUFP=y
> 

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

