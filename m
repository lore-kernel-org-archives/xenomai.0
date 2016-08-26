References: <20160826014749.10789380535@webmail.sinamail.sina.com.cn>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <5a518727-540f-5585-9ccc-e090855e9050@xenomai.org>
Date: Fri, 26 Aug 2016 16:36:43 +0200
MIME-Version: 1.0
In-Reply-To: <20160826014749.10789380535@webmail.sinamail.sina.com.cn>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] overruns with Celeron J1900
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: wangyuchi1017@sina.com, xenomai <xenomai@xenomai.org>

On 08/26/2016 03:47 AM, wangyuchi1017@sina.com wrote:
>  Hello, everyone!  I am setting up a real-time platform using the Advantech MIO-5251 board which uses the intel Celeron J1900 CPU. It's details can be found at http://www.advantech.com/products/bc6786b7-b69b-4fdd-9b63-79180dbd5dcb/mio-5251/mod_ff8534cc-e858-40ba-9bc2-386f19bfee4a. It's quite powerful. I use Linux-4.1.18, Xenomai-3.0.2 and Lubuntu 16.04. Kernel command line "xenomai.smi=enabled" was added, but when I run the latency -t0 (-t1, -t2) test, overruns occurred.
>   .config, dmesg files are pasted below. Can anyone give me some help?

Please do not inline config file contents, especially without line
terminators. It is better to attach it only when asked to.

The kernel log is barely readable also due to the lack of line
terminators. Please resend properly.

Some fragment of the latency program output is missing too; this
information is required to better understand the issue.

It looks like the SMI workaround was successfully enabled for your
chipset, which does not mean all offending SMI sources have been shut
though. Sometimes one may just be unlucky, due to vendor BIOS woes.

However, CONFIG_PERF_EVENTS using NMI-based sampling is clearly an issue
on Intel, due to sluggish ACPI lookups and/or PMU management from the
NMI handler. You may want to try disabling this feature to make sure, or
alternatively disabling the NMI event before testing, with:

# echo 0 > /proc/sys/kernel/nmi_watchdog

-- 
Philippe.

