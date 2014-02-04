Message-ID: <52F11FEF.2000904@siemens.com>
Date: Tue, 04 Feb 2014 18:14:23 +0100
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
References: <E1WAhle-0006kK-1j@sd-51317.dedibox.fr>
 <52F10684.8040807@xenomai.org>
In-Reply-To: <52F10684.8040807@xenomai.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [Xenomai-git] Jan Kiszka : copperplate: Fix inclusion
 into C++ programs
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, xenomai@xenomai.org

On 2014-02-04 16:25, Gilles Chanteperdrix wrote:
> On 02/04/2014 04:18 PM, git repository hosting wrote:
>> Module: xenomai-jki
>> Branch: for-forge
>> Commit: b202c018332568d8b7fb3236ad38d76240c32a3e
>> URL:   
>> http://git.xenomai.org/?p=xenomai-jki.git;a=commit;h=b202c018332568d8b7fb3236ad38d76240c32a3e
>>
>>
>> Author: Jan Kiszka <jan.kiszka@siemens.com>
>> Date:   Tue Feb  4 16:16:03 2014 +0100
>>
>> copperplate: Fix inclusion into C++ programs
>>
>> C++ requires explicit type casts
> 
> Are not heapobj.h and threadobj.h internal headers? Do we really have to
> uglify them with these useless explicit casts?

Do you see a way to prevent the inclusion of these headers when pulling
in - in this case - alchemy/task.h?

Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SES-DE
Corporate Competence Center Embedded Linux

