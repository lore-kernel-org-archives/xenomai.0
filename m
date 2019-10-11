Subject: Re: Xenomai fails to start when running in QEMU VM
References: <CAJPjb1LG3HTfUC0FFDATAkb3-6f=nj5J+6d+gdLL3yAwxt8avQ@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <9224513f-51e2-1ddb-107f-58a1142b3085@siemens.com>
Date: Fri, 11 Oct 2019 19:32:49 +0200
MIME-Version: 1.0
In-Reply-To: <CAJPjb1LG3HTfUC0FFDATAkb3-6f=nj5J+6d+gdLL3yAwxt8avQ@mail.gmail.com>
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
To: Rob Miller <rob.miller@broadcom.com>, xenomai <xenomai@xenomai.org>

On 11.10.19 19:25, Rob Miller via Xenomai wrote:
> Things were working well with my server but when I went to a VM, it fails
> complaining about no high-res timers.
> 
> I figure it must be a CPU that I have chosen and am wondering what others
> are using. I googled for quite a while but can't seem to find any info so I
> thought I would post here for some advice.
> 

Have a look at https://gitlab.denx.de/Xenomai/xenomai-images for working 
configurations for x86, ARM and ARM64 as well as the related QEMU 
parameters - or use that image directly.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

