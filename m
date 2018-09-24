References: <653076205.1537344140916.JavaMail.root@webmail>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <0483a9c4-643e-ed99-73bc-a08db4100cdf@siemens.com>
Date: Mon, 24 Sep 2018 15:16:45 +0200
MIME-Version: 1.0
In-Reply-To: <653076205.1537344140916.JavaMail.root@webmail>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] kernelshark to check the CPU usage of the xenomai
 task.
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?UTF-8?B?67CV7J6s7Zi4?= <jaeho@seoultech.ac.kr>, xenomai@xenomai.org

On 19.09.18 10:02, 박재호 wrote:
> Hi, all
> 
> 
> 
> I'm using kernelshark to check the CPU usage of the xenomai task.
> 
> 
> 
> To check the cpu share of the xenomai task according to the cpu load given by Linux.
> 
> Using the stress-ng tool on Linux .
> 
> "# stress-ng -c0 -l100"
> 
> gives 100% load to cpu, and xenomai has a run time of 750us for 1ms cycle.
> 
> 
> 
> Checking /proc/xenomai/stat we were able to verify the use of 75% CPU.
> 
> However, I checked the cpu quota of xenomai and linux(stress-ng) using tracd-cmd and kernelshark
> 
> I expected xenomai to use more cpu because its priority was higher than normal Linux, but the result was not so.

Are you using trace-cmd and kernelshark as-is (unmodified versions)? Then they 
lack knowledge about Xenomai and cannot visualize RT task switches properly. I 
think I once shared some patches we used in-house, but I'm not sure anymore if 
that was public.

> 
> The task that is "ecat-embedded" in the picture is the xenomai task. Why are these results coming out?
> 

Note that html-emails easily get filtered on public lists. Attach any non-text 
information you need to share in a addition to the description in a plain-text 
email.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

