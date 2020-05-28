Subject: Re: cobalt_check_features for x86
References: <3c56f660-1ab6-2bbb-794f-209cb4e1f68a@nicevt.ru>
 <2217d0e2-71b0-3710-0abd-687b3df3adf6@siemens.com>
From: Alexander Frolov <frolov@nicevt.ru>
Message-ID: <5f389aa5-ec91-d85c-56aa-6ab47a51da15@nicevt.ru>
Date: Thu, 28 May 2020 11:56:46 +0300
MIME-Version: 1.0
In-Reply-To: <2217d0e2-71b0-3710-0abd-687b3df3adf6@siemens.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@xenomai.org


On 5/28/20 11:04 AM, Jan Kiszka wrote:
> On 28.05.20 09:57, Alexander Frolov via Xenomai wrote:
>> Hi all!
>>
>> I am using Xenomai v3.1 for x86_64 platform. So I've noticed that
>> cobalt_check_features returns nothing for x86_64.
>> Is it done by some reason or just missed ..? Thank you!
>>
> Yes, there is nothing to do for this function then, nothing problematic
> could be configured away in that setup.
>
> Do you face any concrete problems?

No, nothing special.

I was looking for XENOMAI_SYSCALL2(sc_cobalt_archcall, ...) examples and 
these can only be found in
cobalt_check_features for arm and arm64.

Thank you.

> Jan
>


