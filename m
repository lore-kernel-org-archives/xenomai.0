Subject: Re: Installing RTnet
References: <62607370399744fa9b6b6b3fe761f190@meg.mee.com>
 <98102434-0273-fda9-2568-fbe543c8ea48@siemens.com>
 <253c31947f8147cead1cead259b10797@meg.mee.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <a8c00a6e-24cd-4f85-0c86-4c27c7219a40@siemens.com>
Date: Mon, 10 Feb 2020 15:13:07 +0100
MIME-Version: 1.0
In-Reply-To: <253c31947f8147cead1cead259b10797@meg.mee.com>
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
To: "Kloock, Lennard" <Lennard.Kloock@meg.mee.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 10.02.20 15:08, Kloock, Lennard wrote:
> Hey,
> 
> Thank you.
> Do you know if the I218-V is supported on Xenomai 3.x?

A first indication is the presence of the PCI ID (or their symbolic 
value) in a Xenomai driver. Wait... E1000_DEV_ID_PCH_LPT_I217_V is 
present, thus worth a try.

Jan

> 
> Lennard Kloock
> 
> On 10.02.20 14:28 Kiszka, Jan wrote:
> 
>> ...it won't help as that NIC is not supported. There was some update of the  driver shared a while ago, but I'm also not sure if that would have helped - it was using an old kernel as baseline, too.
>>
>> Jan
>>
>> --
>> Siemens AG, Corporate Technology, CT RDA IOT SES-DE Corporate Competence Center Embedded Linux

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

