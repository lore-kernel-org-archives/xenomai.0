References: <20170907153622.Horde.hT_sRaGS6VmkuifQTO4pqBa@office.mrmoco.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <f9704809-eeea-3ee0-99f6-896ed32200be@siemens.com>
Date: Fri, 8 Sep 2017 10:57:03 +0200
MIME-Version: 1.0
In-Reply-To: <20170907153622.Horde.hT_sRaGS6VmkuifQTO4pqBa@office.mrmoco.com>
Content-Type: text/plain; charset="utf-8"
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

On 2017-09-07 17:36, Paul Wilkinson wrote:
> I have a legacy multithreaded C++ app that requires one thread to run RT
> and
> communicate using EtherCAT via RTnet, I'm running Debian 8 + Xenomai 3.0.5
> +
> ipipe-core-4.9.24-x86-2.patch.
> 
> By extracting the functionality of that RT thread from the application and
> creating a standalone POC (1RT + 2NRT threads) compiled and linked under
> Xenomai Cobalt I've proved the RT & EtherCAT requirements can be met.
> 
> In addition to the RT requirement, a number of threads forming this
> application
> need to communicate with clients using TCP/IP via non-RTnet NIC.
> 
> To achieve this I prefixed all socket related calls in the class handling
> TCP/IP with __real_ and compiled and linked the app using the xeno-config
> output.
> 
> The app starts OK (I haven't rolled in the RT EtherCAT thread yet) with a
> NRT thread  listening on a TCP/IP port, when a client connects over TCP/IP
> the message is received and a NRT thread is created, immediately followed
> by the following message .... and the app aborts.
> 
> terminate called after throwing an instance of 'std::system_error'
>   what():  Operation not permitted
> 
> The application currently uses std::thread & std::mutex and I'm mindful
> that
> Xenomai/Cobalt may be reducing thread stack sizes, and that std::thread
> doesn't seem to provide a mechanism to increase.
> 
> My questions :-
> 
> - is the approach I'm taking to allow threads of the class requiring TCP/IP
>   comms reasonable, namely using __real_ on all socket related calls ?
> 
> - I'm assuming, but don't know for certain, that Zenomai/Cobalt has
>   intercepted the pthread calls underlying std::thread ?
>   'nm -a' executable shows _wrap_pthread*
> 
> - Does anyone have any insight into what could be causing this problem
> and/or
>   how I might further diagnose it ?

Are you running the application as normal user instead of root, or is
something else taking away permissions (CAP_SYS_NICE) from it?

Jan

-- 
Siemens AG, Corporate Technology, CT RDA ITP SES-DE
Corporate Competence Center Embedded Linux

