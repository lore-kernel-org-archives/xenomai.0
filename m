Date: Mon, 11 Sep 2017 12:18:30 +0000
Message-ID: <20170911121830.Horde.hdU-y9sijxk8OGHoWqdylfy@office.mrmoco.com>
From: Paul Wilkinson <paul.w@mrmoco.com>
References: <20170907153622.Horde.hT_sRaGS6VmkuifQTO4pqBa@office.mrmoco.com>
 <2ceb59af-770f-d99f-1f6a-553a669d20b5@xenomai.org>
In-Reply-To: <2ceb59af-770f-d99f-1f6a-553a669d20b5@xenomai.org>
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


>
> Do you have the libstdc++ debug package installed? It would be useful to
> know which source location issues the exception. GDB is not able to
> resolve the symbols in the libstdc++ DSO it seems.
>


Replacing the std::thread calls with pthread* calls and increasing the thread
stack sizes gets around this and a couple of subsequent SIGSEGV failures.

Although not quite running correctly yet, this enables the application to get
significantly further.

I have installed the libstdc++ debug package now, though.

Thanks.




