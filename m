Date: Mon, 11 Sep 2017 16:17:56 +0000
Message-ID: <20170911161756.Horde.5576SR9hJdNX3u6KppQElrb@office.mrmoco.com>
From: Paul Wilkinson <paul.w@mrmoco.com>
References: <20170907153622.Horde.hT_sRaGS6VmkuifQTO4pqBa@office.mrmoco.com>
 <2ceb59af-770f-d99f-1f6a-553a669d20b5@xenomai.org>
 <20170911121830.Horde.hdU-y9sijxk8OGHoWqdylfy@office.mrmoco.com>
 <d8eca49a-1491-0e42-064e-ccbe3c188949@xenomai.org>
In-Reply-To: <d8eca49a-1491-0e42-064e-ccbe3c188949@xenomai.org>
Content-Type: text/plain; charset=utf-8; format=flowed; DelSp=Yes
MIME-Version: 1.0
Content-Disposition: inline
Subject: Re: [Xenomai] Questions around porting app to Xenomai/Cobalt
 resulting in SIGABRT ?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org


Quoting Philippe Gerum <rpm@xenomai.org>:


>> Replacing the std::thread calls with pthread* calls and increasing the
>> thread
>> stack sizes gets around this and a couple of subsequent SIGSEGV failures.
>>
>> Although not quite running correctly yet, this enables the application
>> to get
>> significantly further.
>>
>> I have installed the libstdc++ debug package now, though.
>>
>
> libcobalt uses the PTHREAD_STACK_DEFAULT constant as the default stack
> size, which is defined in include/boilerplate/libc.h. This value is
> currently 64k. STL is prone to massive stack usage; I'm inclined to add
> a tunable parameter for this default value.


Thanks Philippe.

A tunable parameter would be very useful.

Although knowing where to change the default may save me replacing  
std::thread with pthread*.


Paul.




