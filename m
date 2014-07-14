Message-ID: <53C38040.4040802@siemens.com>
Date: Mon, 14 Jul 2014 09:01:20 +0200
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
References: <E1X5FGA-00080E-2w@sd-51317.dedibox.fr>
 <53C2B020.6050209@xenomai.org>
In-Reply-To: <53C2B020.6050209@xenomai.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] [Xenomai-git] Jan Kiszka : arch/x86: Fix section
 mismatch warning for mach_x86_c1e_disable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, xenomai@xenomai.org

On 2014-07-13 18:13, Gilles Chanteperdrix wrote:
> Le 10/07/2014 16:23, git repository hosting a écrit :
>> Module: xenomai-jki
>> Branch: for-forge
>> Commit: dcac4e7a3e7ccf19e4b38169e7c89eb88c821483
>> URL:    http://git.xenomai.org/?p=xenomai-jki.git;a=commit;h=dcac4e7a3e7ccf19e4b38169e7c89eb88c821483
>>
>> Author: Jan Kiszka <jan.kiszka@siemens.com>
>> Date:   Wed Jul  9 17:50:30 2014 +0200
>>
>> arch/x86: Fix section mismatch warning for mach_x86_c1e_disable
>>
>> mach_x86_c1e_disable is called from non-__init function mach_x86_init,
>> thus can't be tagged as __init. mach_x86_init can't be converted as it
>> is referenced by the persistent xnarch_machdesc structure.
> 
> Well, it seems to me that mach_x86_init truly is an init function, is
> not there any other way to fix this?

I do not see any due the pointed out conflict around that data structure.

Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SES-DE
Corporate Competence Center Embedded Linux

