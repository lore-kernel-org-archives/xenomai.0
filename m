Subject: Re: error: implicit declarations while compiling
 (xenomai3.1+ubuntu20.04)
References: <CAB9YM8jgdbEYTB8Sb7212KWcLEkRDSVjEYZ8P2qCCStaX9CuPQ@mail.gmail.com>
 <a8412431-ccfb-dcc9-dfba-2da5374bcf1a@siemens.com>
 <CAB9YM8hdM5R9nsALRGQnXZ4hX0drJdYMDy=OroH92EzA_rqi5A@mail.gmail.com>
 <f2b82aaf-f92e-ea00-e871-f089562f5a00@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <e87823b6-31b5-bb5d-201f-3054939024de@siemens.com>
Date: Thu, 27 May 2021 14:17:10 +0200
MIME-Version: 1.0
In-Reply-To: <f2b82aaf-f92e-ea00-e871-f089562f5a00@siemens.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?UTF-8?Q?Jo=c3=a3o_Costa?= <joaocostalapin@gmail.com>
Cc: xenomai@xenomai.org

On 27.05.21 14:01, Jan Kiszka via Xenomai wrote:
> On 27.05.21 13:52, João Costa wrote:
>> Thanks for your feedback.
>>
>> I had no report of errors in the CLI while patching the kernel.  
>> In attach you may find the .config file I am using.
>>
> 
> Thanks, will give that a try.
> 

Turn off CONFIG_HYPERV - neither needed nor supported (but the failure
mode is indeed unfortunate).

In general, as you are building a full-featured distro config, you will
likely get much more than you need. And have to wait for that much
longer. I can recommend "make localmodconfig" as alternative.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

