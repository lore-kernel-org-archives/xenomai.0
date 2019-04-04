Subject: Re: [PATCH] travis: add more build options
References: <20190402093026.15074-1-roman.stratiienko@globallogic.com>
 <53b2e765-a729-1911-747a-d4ee3f2f80f0@siemens.com>
 <CAODwZ7tUw5kMVMpQ_Rcgom4nfB7K6SU4_TGdb1W=V+70rmSNow@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <86f1a5cc-02ae-872b-9ab4-d16982d849b1@siemens.com>
Date: Thu, 4 Apr 2019 07:21:55 +0200
MIME-Version: 1.0
In-Reply-To: <CAODwZ7tUw5kMVMpQ_Rcgom4nfB7K6SU4_TGdb1W=V+70rmSNow@mail.gmail.com>
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
To: Roman Stratiienko <roman.stratiienko@globallogic.com>, Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

On 03.04.19 22:35, Roman Stratiienko wrote:
> On Tue, Apr 2, 2019 at 1:39 PM Jan Kiszka <jan.kiszka@siemens.com 
> <mailto:jan.kiszka@siemens.com>> wrote:
> 
>     On 02.04.19 11:30, roman.stratiienko--- via Xenomai wrote:
>      > From: Roman Stratiienko <roman.stratiienko@globallogic.com
>     <mailto:roman.stratiienko@globallogic.com>>
>      >
>      > Changes are made by enabling all xenomai-related configs using
>      > menuconfig for arm kernel, then exported with savedefconfig command.
>      >
>      > Other missing and removed options are turned on implicitly.
>      >
> 
>     Very good. That was on my to-do list as well.
> 
>      > Signed-off-by: Roman Stratiienko <roman.stratiienko@globallogic.com
>     <mailto:roman.stratiienko@globallogic.com>>
>      > ---
>      > After this commit 3/4 tasks fails.
> 
>     Which exactly fails?
> 
> 
> Please check status of the build by the link:
> https://travis-ci.com/devel-opi/xenomai-fork/builds/106972535
> 

OK, here are two issue. One of them is related to the rt_e1000e - patch applied 
to next and sent to the list.

The other is related to old 4.1 kernel and spi/spi-sun6i.c:

https://travis-ci.com/xenomai-ci/xenomai/jobs/190231319#L5312

Philippe, would you like to address this, or should we simply drop 4.1 from the 
CI. That kernel is no longer in support anyway, so I'm leaning towards the latter.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

