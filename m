Subject: Re: [PATCH 00/31] Update fec driver for xenomai 3 and linux kernel
 5.4 and add I.MX8 support
References: <20210511160535.26580-1-jean-baptiste.tredez@alstefgroup.com>
 <a32688bc-fa55-f0d3-f764-81edfd865def@siemens.com>
 <a4b5893b-3bdb-2fcb-ccde-fa331f90e380@alstefgroup.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <d3ae3c1f-d4ca-2f27-5967-86778365bd44@siemens.com>
Date: Mon, 17 May 2021 18:06:11 +0200
MIME-Version: 1.0
In-Reply-To: <a4b5893b-3bdb-2fcb-ccde-fa331f90e380@alstefgroup.com>
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
To: Jean-Baptiste Tredez <jean-baptiste.tredez@alstefgroup.com>, xenomai@xenomai.org

On 12.05.21 11:52, Jean-Baptiste Tredez wrote:
> 
> Le 12/05/2021 à 08:57, Jan Kiszka a écrit :
>> On 11.05.21 18:05, Jean-Baptiste Trédez via Xenomai wrote:
>>> Update fec driver for xenomai 3 and linux kernel 5.4 and add I.MX8
>>> support
>>>
>>> Patch  1 to 27 : rtnet-mcast+vlan branch from Philippe Gerum with
>>> updated driver for 4.18.85 kernel
>>> Patch 28 to 29 : update driver for 5.4 kernel and add I.MX8 support
>>> Patch 30 : bugfix on fec_enet_reset_skb
>>> Patch 31 : reduce latency
>>>
>>>
>>> Christophe Carton (1):
>>>    utils/net: ping: display min and average round-trip time
>>>
>>> Florian Bezdeka (1):
>>>    cobalt uapi: Introducing new feature flag for time64 availability
>>>
>> Seems your baseline was off. Please check that you were really sending
>> from the right branch.
>>
>> Jan
> 
> The patch "[PATCH 01/31] cobalt uapi: Introducing new feature flag for
> time64 availability" was kept when i rebased rtnet-mcast+vlan branch on
> next. I can resend the whole set without it if needed.
> 

Thanks, understood. Let me go through these first. May still take a
while, too much stuff on the table ATM.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

