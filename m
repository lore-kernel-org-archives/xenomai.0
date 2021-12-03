Subject: Re: [PATCH] net/drivers: fec: Update fec driver for xenomai 3 + linux
 kernel 5.10 and add I.MX8 support
References: <20211126080247.3392-1-jean-baptiste.tredez@ba-healthcare.com>
 <9c940d0d-8be1-9a37-4c7c-060a00716ed1@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <f27da059-677e-60d7-cd92-ace953b0fdcf@siemens.com>
Date: Fri, 3 Dec 2021 12:12:26 +0100
MIME-Version: 1.0
In-Reply-To: <9c940d0d-8be1-9a37-4c7c-060a00716ed1@siemens.com>
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
To: =?UTF-8?Q?Jean-Baptiste_Tr=c3=a9dez?= <jean-baptiste.tredez@ba-healthcare.com>, xenomai@xenomai.org

On 01.12.21 20:04, Jan Kiszka via Xenomai wrote:
> On 26.11.21 09:02, Jean-Baptiste Trédez via Xenomai wrote:
>> Current fec driver does not build on xenomai 3 and on recent kernel (ex : 5.10). Fec driver was completely rewritten on mainline kernel.
>> This work remove old fec driver, port driver from mainline linux 5.10 to xenomai 3.x and add I.MX8 support.
>>
>> Tested on i.MX8Q target
>>
> 
> Thanks for the contribution! I assume you also tested this driver with
> debug options on to catch any potential locking issues (sorry, TL;DR -
> with "R" = "review")?
> 
> Can we also make add this driver to our CI build (.gitlab-ci.yml)? Which
> options need to be on in addition to make it compile?
> 

It turns out that all needed switches were already set - and... the
build fails for 5.4:

https://gitlab.com/Xenomai/xenomai-hacker-space/-/jobs/1846388391

Could you have a look and fix this up?

Also, it looks like we do not build for 4.19
(https://gitlab.com/Xenomai/xenomai-hacker-space/-/jobs/1846388392). If
that kernel had no support for the target SoC, then this is fine, though.

Thanks,
Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

