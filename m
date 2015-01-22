Message-ID: <54C0AEDE.8000909@siemens.com>
Date: Thu, 22 Jan 2015 09:03:42 +0100
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
References: <1537147.Wm9AbiuW5D@soho>
In-Reply-To: <1537147.Wm9AbiuW5D@soho>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Xenomai-3 booting problems
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Leopold Palomo-Avellaneda <leo@alaxarxa.net>, xenomai@xenomai.org

On 2015-01-22 08:47, Leopold Palomo-Avellaneda wrote:
> Hi,
> 
> 
> I have compiling a Cobalt kernel. I have followed the web "wikipress" [1];-) 
> recommendations. However, my box (a normal desktop computer - Dell Optiplex 
> 7010 -) doesn't boot. It throws a message like:
> ....
> timer doesn't work through interrup-remapped IO-apic

Sounds like interrupt remapping is enabled for your system. That's not
supported by Xenomai / I-pipe so far (on my to-do list, along with
x2APIC support). Disable this via "intel_iommu=off intremap=off" in the
kernel command line or by changing the kernel config to not include
IOMMU / interrupt remapping support.

Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SES-DE
Corporate Competence Center Embedded Linux

