Subject: Re: [PATCH][4.14] arm/ipipe: Fix IPIPE_TRAP_UNDEFINSTR reporting
References: <6be2fdec-0246-1169-67ad-882abb73cc5e@siemens.com>
 <84b6d0fc-97e3-e543-3d56-98daba195512@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <8a5dd5d0-4fd9-bc5e-8f26-ad50253ebad8@xenomai.org>
Date: Sat, 1 Dec 2018 18:53:20 +0100
MIME-Version: 1.0
In-Reply-To: <84b6d0fc-97e3-e543-3d56-98daba195512@siemens.com>
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
To: Jan Kiszka <jan.kiszka@siemens.com>, Xenomai <xenomai@xenomai.org>

On 11/30/18 9:14 PM, Jan Kiszka wrote:
> On 30.11.18 21:09, Jan Kiszka via Xenomai wrote:
>> Something moved the value of this constant but didn't update the
>> hard-coded instances. Fix this and avoid future problems by using the
>> proper symbolic value.
>>
>> That just requires harding asm/ipipe_base.h for assembly use.
>>
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>> ---
> 
> Just checked: This is a regression of 4.14 over previous versions.
> 

Merged, thanks.

-- 
Philippe.

