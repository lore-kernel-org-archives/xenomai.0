References: <20170907153622.Horde.hT_sRaGS6VmkuifQTO4pqBa@office.mrmoco.com>
 <2ceb59af-770f-d99f-1f6a-553a669d20b5@xenomai.org>
 <20170911121830.Horde.hdU-y9sijxk8OGHoWqdylfy@office.mrmoco.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <d8eca49a-1491-0e42-064e-ccbe3c188949@xenomai.org>
Date: Mon, 11 Sep 2017 16:22:53 +0200
MIME-Version: 1.0
In-Reply-To: <20170911121830.Horde.hdU-y9sijxk8OGHoWqdylfy@office.mrmoco.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
To: Paul Wilkinson <paul.w@mrmoco.com>, xenomai@xenomai.org

On 09/11/2017 02:18 PM, Paul Wilkinson wrote:
> 
> Quoting Philippe Gerum <rpm@xenomai.org>:
> 
> 
>>
>> Do you have the libstdc++ debug package installed? It would be useful to
>> know which source location issues the exception. GDB is not able to
>> resolve the symbols in the libstdc++ DSO it seems.
>>
> 
> 
> Replacing the std::thread calls with pthread* calls and increasing the
> thread
> stack sizes gets around this and a couple of subsequent SIGSEGV failures.
> 
> Although not quite running correctly yet, this enables the application
> to get
> significantly further.
> 
> I have installed the libstdc++ debug package now, though.
> 

libcobalt uses the PTHREAD_STACK_DEFAULT constant as the default stack
size, which is defined in include/boilerplate/libc.h. This value is
currently 64k. STL is prone to massive stack usage; I'm inclined to add
a tunable parameter for this default value.

-- 
Philippe.

