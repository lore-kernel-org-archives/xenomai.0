Subject: Re: TSN support on xenomai
References: <SG2PR04MB325361212B0F13BA9DE98BC0A49D0@SG2PR04MB3253.apcprd04.prod.outlook.com>
 <263bfd52-638e-1205-dc57-c0fb773b0acf@numalliance.com>
 <dee89c0f-c026-33c2-da13-42d090f58d6c@siemens.com>
 <VI1PR05MB59171660A06A205C47F6DF3AF69D0@VI1PR05MB5917.eurprd05.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <c244091f-127a-e3ac-8116-b3624907f17a@siemens.com>
Date: Tue, 16 Jun 2020 11:44:35 +0200
MIME-Version: 1.0
In-Reply-To: <VI1PR05MB59171660A06A205C47F6DF3AF69D0@VI1PR05MB5917.eurprd05.prod.outlook.com>
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
To: Lange Norbert <norbert.lange@andritz.com>, =?UTF-8?Q?St=c3=a9phane_Ancelot?= <sancelot@numalliance.com>, "Xenomai (xenomai@xenomai.org)" <xenomai@xenomai.org>

On 16.06.20 11:41, Lange Norbert wrote:
> 
> 
>> -----Original Message-----
>> From: Xenomai <xenomai-bounces@xenomai.org> On Behalf Of Jan Kiszka
>> via Xenomai
>> Sent: Dienstag, 16. Juni 2020 10:58
>> To: Stéphane Ancelot <sancelot@numalliance.com>; xenomai@xenomai.org
>> Subject: Re: TSN support on xenomai
>>
>> NON-ANDRITZ SOURCE: BE CAUTIOUS WITH CONTENT, LINKS OR
>> ATTACHMENTS.
>>
>>
>> On 16.06.20 10:55, Stéphane Ancelot via Xenomai wrote:
>>> Hi,
>>>
>>> This is natively supported in standard linux kernel
>>>
>>
>> Right. What is missing it linking the Xenomai timebase with that of the kernel
>> so that we would benefit from Linux doing the sync for us already.
> 
> But that means you can't use the synchronizing NIC with RTNet / Realtime traffic.
> 
> Regarding linking timebases, it would help (for various things)
> If you could easily read those various timebases from the kernel. The rest can happen in
> userspace.
> 
> I actually have 3: Linux Monotonic, Xenomai Monotonic, and a PPS synchronized IEEE1588 clock,
> Cant fold them into one but sometimes need to map between these.
> Solved this by letting the NIC read out all 3 and providing them to (Xenomai) userspace.
> 
> Better would be a shared mmap (with 2 or more buffers), so that Linux tasks can asynchronously get that info too.
> 

Latest Intel hardware supports mapping for the PTP time to the system
time (tsc) natively. You only need to read out the conversion factors in
the end. That's what we want to have as well.

If using that will create a conflict with using the NIC for RT traffic?
Likely. But that needs to be sorted out in the future, not only on Intel hw.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

