Subject: Re: [PATCH] travis: add checkpatch analysis
References: <20190319142822.31027-1-roman.stratiienko@globallogic.com>
 <bec61ef6-33ff-7caf-2af5-114c4b7c4c18@siemens.com>
 <CAODwZ7u-SvQrBySZyRiBAuCo985j-cbD=xJG=MJyitCsdcpWgA@mail.gmail.com>
 <86594aed-6ffd-9c46-ac16-74a84a0cbdc0@siemens.com>
 <CAODwZ7uY3eQ1n3pMdbXzAjVjiB8Esr=HF_j2WD1pb--snPzmtg@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <78cf964a-d558-b63f-784c-e6bd5ee80b0e@siemens.com>
Date: Fri, 22 Mar 2019 21:54:19 +0100
MIME-Version: 1.0
In-Reply-To: <CAODwZ7uY3eQ1n3pMdbXzAjVjiB8Esr=HF_j2WD1pb--snPzmtg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
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
To: Roman Stratiienko <roman.stratiienko@globallogic.com>
Cc: xenomai@xenomai.org

On 22.03.19 20:45, Roman Stratiienko wrote:
> Thank you for feedback. After testing of this patch I faced some challenges:
> 
> 1. checkpatch.pl <http://checkpatch.pl> from kernel tree always different. Old 
> kernel checkpatch doesn't support git option. So we need to find a way to use 
> ommon utility for all kernel or just enable checkpatch only on most recent kernel
> 2. Even if there is no checkpatch errors, but warnings still present, exit code 
> will be false. And I can't find command line option to override it.
> 3. Getting delta commits in master..next range isn't a trivial task. Travis 
> clone only single branch with - - depth=50 option. Unshallowing entire 
> repository will take some amount of time, that will slow down build process and 
> it is not what me want from CI system.
> 

Yeah... But I guess I start to could run it locally.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

