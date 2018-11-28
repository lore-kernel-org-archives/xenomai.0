Subject: Re: Testing of 4.4/Ipipe + Xenomai 3.0.X on ARM32
From: Jan Kiszka <jan.kiszka@siemens.com>
References: <20181123122716.tgg3utytwyrkzyid@jholzmayr.localdomain>
 <d1808069-d213-7e9f-010f-abd2c88b0480@siemens.com>
 <20181126143029.6jts36bo267l776s@jholzmayr.localdomain>
 <47252724-7145-7e15-2df8-a5d625b1f95d@siemens.com>
 <20181128124039.ppsitvbbqbtge3im@jholzmayr.localdomain>
 <cb0a1231-e0ef-ac55-eb32-63c87b9a5b58@siemens.com>
Message-ID: <28bcb7c5-5c35-9adb-3528-d4d5cdd9a111@siemens.com>
Date: Wed, 28 Nov 2018 19:23:42 +0100
MIME-Version: 1.0
In-Reply-To: <cb0a1231-e0ef-ac55-eb32-63c87b9a5b58@siemens.com>
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
To: Josef Holzmayr <holzmayr@rsi-elektrotechnik.de>, Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

On 28.11.18 15:42, Jan Kiszka wrote:
> On 28.11.18 13:40, Josef Holzmayr wrote:
>> Digging deeper, I now have a couple of questions. xeno-test gives me
>>
>> net_packet_dgram skipped (no kernel support)
>> net_packet_raw skipped (no kernel support)
>> net_udp skipped (no kernel support)
> 
> That should be
> 
> CONFIG_XENO_DRIVERS_NET=m
> CONFIG_XENO_DRIVERS_NET_RTIPV4_UDP=m
> CONFIG_XENO_DRIVERS_NET_RTPACKET=m
> 
> at least. But you may see crashes then (reminds me of that open issue).
> 
>> ...
>> mutex_trylock not supported
> 
> Hmm, I don't recall ATM what triggers this... need to dig.
> 

Philippe can likely recall this. Comparing stable to next, where this message
disappeared, leads to commit 43d383cc that says: "At this chance, the lock
stealing test is also fixed."

Probably means we cannot do better than "not supported" over stable.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

