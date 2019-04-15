Subject: Re: Xenomai kernel for BBB
References: <CAFc1U0uSt1WVzeDWfzPp+07SqCD=t=ET8X+2NXieYE0WE66Xfw@mail.gmail.com>
 <4a8a6ec5-cc87-19b5-3ebe-8d0d6da6027b@xenomai.org>
 <072ec5f2-7bee-9cca-cdb6-040bb3afa59d@xenomai.org>
 <21a9ee2c-90e7-b6f3-f0cd-f57277f20a57@siemens.com>
 <20190404092408.rjfg5oxqpro6kn6q@jholzmayr.localdomain>
 <8dfef1e6-e2b0-dddb-755b-c994726419c4@siemens.com>
 <20190404104710.zw3mkhiobnbhy75h@jholzmayr.localdomain>
 <20190413190542.seddobt5flrql4mx@jholzmayr.localdomain>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <4a7ad607-26e8-b769-c840-ffa9a2b317f5@siemens.com>
Date: Mon, 15 Apr 2019 11:59:29 +0200
MIME-Version: 1.0
In-Reply-To: <20190413190542.seddobt5flrql4mx@jholzmayr.localdomain>
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
To: Josef Holzmayr <holzmayr@rsi-elektrotechnik.de>, xenomai@xenomai.org

On 13.04.19 21:05, Josef Holzmayr wrote:
> Hi Jan,
> 
> On Thu, Apr 04, 2019 at 12:47:10PM +0200, Josef Holzmayr via Xenomai wrote:
>> On Thu, Apr 04, 2019 at 12:12:10PM +0200, Jan Kiszka wrote:
>>>
>>> BTW, if you have time to test the current ipipe-4.4.y[-cip] branches, I
>>> would also tag ARM stable releases for them.
> 
> Here we go for 4.4.y-cip, 33f523bee3eba222ac67e9d27d783418f2408078
> xenomai on stable/v3.0.x, 0e79d326061190e08f53e7a41bcea50da4859615
> 
> xeno-test passes
> 
> root@beaglebone-xenomai:~# latency -q -s -t 0 -T 86400
> == Sampling period: 1000 us
> == Test mode: periodic user-mode task
> == All results in microseconds
> warming up...
> running quietly for 86400 seconds
> HSH|--param|--samples-|--average--|---stddev--
> HSS|    min|     86399|      7.876|      0.924
> HSS|    avg|  86399985|     16.155|      4.353
> HSS|    max|     86399|     35.361|      2.108
> ---|-----------|-----------|-----------|--------|------|-------------------------
> RTS|      6.026|     16.659|     52.157|       0|     0|    24:00:00/24:00:00
> 
> root@beaglebone-xenomai:~# latency -q -s -t 2 -T 86400
> == Sampling period: 1000 us
> == Test mode: in-kernel timer handler
> == All results in microseconds
> warming up...
> running quietly for 86400 seconds
> HSH|--param|--samples-|--average--|---stddev--
> HSS|    min|     86399|      0.046|      0.208
> HSS|    avg|  86399987|      4.091|      1.306
> HSS|    max|     86399|     11.764|      1.379
> ---|-----------|-----------|-----------|--------|------|-------------------------
> RTS|     -1.084|      4.605|     20.697|       0|     0|    24:00:00/24:00:00
> 
> Greetz
> 

Great, thanks! Then I'm going to tag 4.4 for ARM, also -cip once I can push 
those releases to the download folder.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

