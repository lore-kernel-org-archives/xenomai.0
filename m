Subject: Re: Shared Memory by using RT_HEAP
References: <tencent_FCAD0A1D7FA4BE4D69B7E1AC0C2CB1E6C10A@qq.com>
From: Peter Laurich <Peter.Laurich@akamina.com>
Message-ID: <fec9898d-cca5-e37c-11b7-c8b5471450b1@akamina.com>
Date: Thu, 1 Apr 2021 08:43:03 -0400
MIME-Version: 1.0
In-Reply-To: <tencent_FCAD0A1D7FA4BE4D69B7E1AC0C2CB1E6C10A@qq.com>
Content-Language: en-CA
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hello,

I suspect that your problem may be the same as I had earlier. If you are 
sharing heaps then you have more than one program that needs to have the 
same Xenomai session. Here is how I spawn two programs that share the 
same heap and other Xenomai objects:

    ./initSys  --session=akamina --mem-pool-size=20M &
    ./sacqScan --session=akamina --mem-pool-size=20M &

where initSys and sacqScan are two of my programs, I have chosen to name 
the session akamina and I wanted a memory pool size of 20M (rather than 
the default of 1M).

Good luck with your upgrade. I have found the upgrade from 2 to be 
incredibly painful and I am now stuck a little further down the path 
than you. I found that I lost functionality that I relied on (e.g. 
exchanging events and messages between kernel drivers and user-space 
programs) that is not easy to replace. I looked at staying with Xenomai 
2 but I do need a more recent kernel so I am stuck.

Good luck.

Peter


On 3/31/2021 9:25 PM, zy via Xenomai wrote:
> Hi all,
>
> On Xenomai-2.6.5, I use rt_heap_create with flag "H_SHARED" to create rt_heap
> in one process and call rt_heap_bind to get this rt_heap by the same name in another
> process. I use rt_heap as shared memory between process. But on Xenomai-3.1, I
> find this method does not work. When calling rt_heap_bind using "TM_INFINITE",
> the function doesn't return, using "TM_NONEBLOCK", returns -11. I check this
> email system , find "--enable-pshared" should be configured before installation  and
> I do it, but it doesn't work.
> Can anyone give me a detailed solution? Or, shared memory cannot be created by
> RT_HEAP on Xenomai-3.
>
> Best regards,
> Zhou Yang
