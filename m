Message-ID: <4EA8014F.4070206@domain.hid>
Date: Wed, 26 Oct 2011 14:47:11 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <patchbomb.1318861189@domain.hid>
	<CAAXf6LW+yy24Ks6RNOc4_5-Ltonx12SVOrGEKd-Aw4ATGTVaUg@domain.hid>
In-Reply-To: <CAAXf6LW+yy24Ks6RNOc4_5-Ltonx12SVOrGEKd-Aw4ATGTVaUg@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] [PATCH 0 of 4] xenomai-forge PSOS: miscellaneous
 fixes
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Thomas De Schampheleire <patrickdepinguin+xenomai@domain.hid>
Cc: xenomai@xenomai.org

On 10/26/2011 11:44 AM, Thomas De Schampheleire wrote:
> Hi,
>
> On Wed, Oct 19, 2011 at 5:02 PM, Thomas De Schampheleire
> <patrickdepinguin+xenomai@domain.hid>  wrote:
>> This patch series includes some misc. fixes to xenomai-forge:
>>
>> * definition of ERR_OBJTFULL (should also be added to Xenomai proper)
>> * port long_names feature to xenomai-forge and fix it
>> * add tm_getm() function (not present in pSOS but present in Xenomai proper)
>> * fix compiler warning in task.c
>>
>> Signed-off-by: Thomas De Schampheleire<thomas.de.schampheleire@domain.hid>
>> Signed-off-by: Ronny Meeus<ronny.meeus@domain.hid>
>>
>> ---
>>   include/psos/Makefile.am  |   2 +-
>>   include/psos/Makefile.in  |   2 +-
>>   include/psos/long_names.h |  14 ++++++++++++++
>>   include/psos/psos.h       |   5 +++++
>>   lib/psos/init.c           |  15 +++++++++++++++
>>   lib/psos/pt.c             |   6 ++++++
>>   lib/psos/queue.c          |   6 ++++++
>>   lib/psos/rn.c             |   5 +++++
>>   lib/psos/sem.c            |   6 ++++++
>>   lib/psos/task.c           |   9 +++++++--
>>   lib/psos/tm.c             |   7 +++++++
>>   11 files changed, 73 insertions(+), 4 deletions(-)
>>
>>
>>
>
> Do you have any comments on this patch series?


Merged as discussed, thanks.

>
> Thanks,
> Thomas
>
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
>


-- 
Philippe.

