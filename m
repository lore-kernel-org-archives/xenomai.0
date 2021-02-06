Subject: Re: [I-PIPE] ipipe-core-5.4.93-arm-0 released
References: <E1l7t9P-00049k-BZ@xenomai.org>
 <CALLqZ8QE8YCcRayB-Aahy+sWx1sUaKAuEh=jT2GauSOqo04N7A@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <c1ff647d-f977-6b67-3922-10947a22756e@siemens.com>
Date: Sat, 6 Feb 2021 13:25:40 +0100
MIME-Version: 1.0
In-Reply-To: <CALLqZ8QE8YCcRayB-Aahy+sWx1sUaKAuEh=jT2GauSOqo04N7A@mail.gmail.com>
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
To: Greg Gallagher <greg@embeddedgreg.com>, "Xenomai@xenomai.org" <xenomai@xenomai.org>

On 05.02.21 05:56, Greg Gallagher via Xenomai wrote:
> On Thu, Feb 4, 2021 at 11:56 PM xenomai--- via Xenomai <xenomai@xenomai.org>
> wrote:
> 
>> Download URL:
>> https://xenomai.org/downloads/ipipe/v5.x/arm/ipipe-core-5.4.93-arm-0.patch
>>
>> Repository: https://git.xenomai.org/ipipe-arm
>> Release tag: ipipe-core-5.4.93-arm-0
>>
>>
> This is a beta release for the arm-ipipe on 5.4.93, any testing welcome.
> 

And I have something for this one as well:

https://gitlab.denx.de/Xenomai/xenomai-images/-/jobs/218157#L890
https://gitlab.denx.de/Xenomai/xenomai-images/-/jobs/218158#L1374

Line numbers are not accurate, at least for me here. Look for
"setsched.c:120, assertion failed: stats.msw == msw".

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

