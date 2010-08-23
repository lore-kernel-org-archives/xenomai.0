Message-ID: <4C7256E7.4010105@domain.hid>
Date: Mon, 23 Aug 2010 13:09:27 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <mailman.63.1282557625.26045.xenomai-git@xenomai.org>
	<4C724E56.7000202@domain.hid>
In-Reply-To: <4C724E56.7000202@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Xenomai-git Digest, Vol 17, Issue 18
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
> xenomai-git-request@domain.hid wrote:
>> Module: xenomai-2.5
>> Branch: master
>> Commit: edaf1e2e54343b6e4bf5cf6ece9175ec0ab21cad
>> URL:    http://git.xenomai.org/?p=xenomai-2.5.git;a=commit;h=edaf1e2e54343b6e4bf5cf6ece9175ec0ab21cad
>>
>> Author: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
>> Date:   Sun Aug 22 15:37:11 2010 +0200
>>
>> Do not assume that XN_NO_HANDLE is NULL
>>
>> ---
>>
>>  src/skins/common/current.c |    1 +
>>  src/skins/native/mutex.c   |    4 ++--
>>  2 files changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/src/skins/common/current.c b/src/skins/common/current.c
>> index 7f36991..4e75690 100644
>> --- a/src/skins/common/current.c
>> +++ b/src/skins/common/current.c
>> @@ -46,6 +46,7 @@ static inline int create_current_key(void)
>>  
>>  static inline void __xeno_set_current(xnhandle_t current)
>>  {
>> +	current = (current == XN_NO_HANDLE ? current : (xnhandle_t)(0));
> 
> I think you meant "!=" here.

Yes, thanks. The slow version makes it working...

-- 
					    Gilles.

