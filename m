Subject: Re: i-pipe tracer - how to view traced data
References: <CAPm8-H4hcfGuZBbnX9DO1X6ZeYa5g3JeOd7G+AARKa0LkO1+XQ@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <59b261b2-dffa-f089-b408-11a41d936aee@siemens.com>
Date: Wed, 28 Aug 2019 13:34:09 +0200
MIME-Version: 1.0
In-Reply-To: <CAPm8-H4hcfGuZBbnX9DO1X6ZeYa5g3JeOd7G+AARKa0LkO1+XQ@mail.gmail.com>
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
To: Laurentiu-Cristian Duca <laurentiu.duca@gmail.com>, xenomai <xenomai@xenomai.org>

On 28.08.19 10:11, Laurentiu-Cristian Duca via Xenomai wrote:
> Hello there,
> 
>    I want to use ipipe tracer for tracing RTNet drivers.
>    In the tutorial
> https://gitlab.denx.de/Xenomai/xenomai/wikis/Using_The_I_Pipe_Tracer
> it does not specify which file to "cat" in order to view the function traces
> so if anybody used it please provide this info.
>    How to view the traced data?
> 

cat .../frozen or .../max

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

