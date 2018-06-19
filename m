MIME-Version: 1.0
In-Reply-To: <3286435f-71ae-874d-72a5-5a7cbef0d550@siemens.com>
References: <CAD5jUk-DyMgNffkgzvvmbm3+LtceXBnRSoFL0=YwYw7_BCk6yA@mail.gmail.com>
 <CALLqZ8REcWEpxdAg8V5DxAgOrrofpnb-moAHg46Epv5DvBY1+w@mail.gmail.com>
 <3286435f-71ae-874d-72a5-5a7cbef0d550@siemens.com>
From: Greg Gallagher <greg@embeddedgreg.com>
Date: Tue, 19 Jun 2018 10:09:25 -0400
Message-ID: <CALLqZ8Q2+GyXeqTgMMLwK-Rh1YePNukfCyKnSCGjon=HHEnf3w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Xenomai] ipipe-4.4.y LTS
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: "Xenomai@xenomai.org" <xenomai@xenomai.org>

I can run some tests on ARM boards I have.

-Greg

On Tue, Jun 19, 2018 at 3:09 AM, Jan Kiszka <jan.kiszka@siemens.com> wrote:
> On 2018-06-18 15:59, Greg Gallagher wrote:
>> Are there still plans to have a ipipe patch for the CIP kernel?  I
>> think this was brought up at the last meet up?  Maybe the bigger
>> question (which is a lot more work) is do we plan on maintaining ipipe
>> for 4.4, 4.9 and older?
>
> Yes, there are plans to go over 4.4-CIP. So far, I'm only maintaining
> based on 4.4-LTS, just tested on x86, pushed to
> https://lab.xenomai.org/ipipe-jki.git/log/?h=for-upstream/4.4-update.
> Would be happy to receive contributions in form of tests on other
> architectures!
>
> Jan
>
>>
>> -Greg
>>
>> On Mon, Jun 18, 2018 at 8:52 AM, Radu Rendec <radu.rendec@gmail.com> wrote:
>>> Hi all,
>>>
>>> Are there any plans to maintain the ipipe-4.4.y branch and update it to
>>> later versions of kernel 4.4? It would be nice to have, since at this
>>> point kernel 4.4 has the longest projected EOL.
>>>
>>> Currently the latest thing that can be merged cleanly on top of
>>> ipipe-core-4.4.71-powerpc-8 is kernel 4.4.73, which is only 2 releases
>>> later than what's already in there.
>>>
>>> Thanks,
>>> Radu Rendec
>>>
>>> _______________________________________________
>>> Xenomai mailing list
>>> Xenomai@xenomai.org
>>> https://xenomai.org/mailman/listinfo/xenomai
>
> --
> Siemens AG, Corporate Technology, CT RDA IOT SES-DE
> Corporate Competence Center Embedded Linux

