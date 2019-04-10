Subject: Re: [PATCH] ci: Tune config
References: <417b55d7-464c-9bb9-3742-b9e3edf8369f@siemens.com>
 <CAODwZ7uB1sNXZaNPWvgGDG+Egpg=eVNfyS8V+QFL_XeQ=sHVLw@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <70d0f25f-c4f9-d06c-af91-76760179f229@siemens.com>
Date: Wed, 10 Apr 2019 07:34:10 +0200
MIME-Version: 1.0
In-Reply-To: <CAODwZ7uB1sNXZaNPWvgGDG+Egpg=eVNfyS8V+QFL_XeQ=sHVLw@mail.gmail.com>
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
Cc: Xenomai <xenomai@xenomai.org>

On 09.04.19 22:47, Roman Stratiienko wrote:
> 
> I have similar issue some time ago on another project, but due to lack of time 
> and low priority it was unsolved.
> And you've found the root cause and it is great, thanks!.

At least it looks like as the rebuild no only takes 15 minutes.

> 
> I did some measurements of ccache size, and results is following:
> - 4.14 arm64 - cache size - 232.7 MB
> - 4.19 arm - cache size - 246.4 MB
> - Others are even less.
> 
> So I suggest to left it 400MB, thus not to use too much disk space of travis's 
> servers.

Look at the statistics you added to our build:

4.14 arm64: 601.6 MB
4.19 arm:   557.7 MB
4.14 x86:   292.5 MB

If you cap the size, ccache may drop artifacts during the build, then refill, 
but may stay below the limit at the end. Still, the cache will be incomplete.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

