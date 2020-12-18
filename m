Subject: Re: [xenomai-images][PATCH 0/2] add xenomai 3.1.x to pipeline
References: <20201218094945.6941-1-Quirin.Gylstorff@siemens.com>
 <598760.1608297747@gemini.denx.de>
 <e6cb9740-b142-d84a-84b5-1098887c03cb@siemens.com>
 <603946.1608307997@gemini.denx.de>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <f8729953-af74-c0e0-8813-eea67c521c5d@siemens.com>
Date: Fri, 18 Dec 2020 17:36:24 +0100
MIME-Version: 1.0
In-Reply-To: <603946.1608307997@gemini.denx.de>
Content-Type: text/plain; charset=utf-8
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
To: Wolfgang Denk <wd@denx.de>
Cc: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>, "Q. Gylstorff via Xenomai" <xenomai@xenomai.org>

On 18.12.20 17:13, Wolfgang Denk wrote:
> Dear Jan,
> 
> In message <e6cb9740-b142-d84a-84b5-1098887c03cb@siemens.com> you wrote:
>>
>>>> Add xenomai 3.1 to the build and test pipeline of xenomai-images.
>>>
>>> Is there a specific reason why all the new files come under a MIT
>>> license, and not GPL ?
>>
>> Yes, these are bitbake recipes, derived from Isar recipes. We follow
>> that practice in all related projects.
> 
> I wonder why I can't just get a clear answer?
> 
> I did not ask _what_ you do  - that I see.  I asked _why_ you are
> doing it?  What is the rationale for chosing MIT instead of for
> example GPL?

The decision to use MIT for recipes and layer had been made for the
whole ecosystem in order to ease to adoption by any kind of integration
project, may they be public or private. See also [1] when I relicensed
jailhouse-images.

For Xenomai as well as any other similar GPL project, distributors of
the GPL'ed core actually using or deriving from such integration layers
will have more than sufficiently high motivation to redistribute the
layers and recipes as OSS as well in order to fulfill term 3. So, no
harm done to the valid choice of GPL for the core project itself.

Jan

[1]
https://github.com/siemens/jailhouse-images/commit/3350c450a8738648c59cfd7fa4ef7952093a74d6

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

