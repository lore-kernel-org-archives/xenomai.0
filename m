From: Philippe Gerum <rpm@xenomai.org>
References: <182a5ea9-8cde-2ded-0e8c-ff43fb98b2e4@siemens.com>
 <b139c517-83e8-aa62-671c-735873985fdb@xenomai.org>
Message-ID: <890ff00a-2841-e189-ea92-d3c9cb983ed4@xenomai.org>
Date: Mon, 11 Dec 2017 19:33:47 +0100
MIME-Version: 1.0
In-Reply-To: <b139c517-83e8-aa62-671c-735873985fdb@xenomai.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [RFC] Remove support for Blackfin
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>
Cc: Jan Kiszka <jan.kiszka@siemens.com>

On 09/07/2017 11:38 AM, Philippe Gerum wrote:
> On 08/31/2017 07:33 PM, Jan Kiszka wrote:
>> Hi,
>>
>> it appears to me that the Blackfin architecture is no longer of broader
>> use, in general, and likely also in combination with Xenomai. At the
>> same time, it's "special" nature in several details makes maintaining
>> cross-arch changes complicated. And even without that, it's simply
>> another arch to look after in Xenomai, adding work and test efforts.
>>
>> Therefore my proposal: schedule its removal from Xenomai support with
>> the next major release (I suppose that will be 3.1). At that point,
>> Blackfin should also be dropped from any port of the I-pipe patches to
>> newer kernel versions.
>>
>> If you are using Blackfin with Xenomai or planning to do so, this would
>> be the time to speak up!
>>
> 
> Reminder to whom this message may concern: as Jan mentioned, if you
> still see a reason for supporting the Blackfin architecture in the
> future, please chime in. Otherwise, support for Blackfin will be removed
> from Xenomai 3.1.
> 

No feedback so far, which means that nobody cares. So Blackfin support
is officially discontinued.

As a consequence:

- The I-pipe support for Blackfin architecture will not be maintained
beyond kernel 4.9.51 (LTS).

- Blackfin support will be marked as deprecated in the next releases of
the Xenomai 3.0.x series, and not maintained (not even build tested).
This code will be fully removed from the -next branch leading to Xenomai
3.1.

Thanks,

-- 
Philippe.

