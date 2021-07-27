Subject: Re: Analogy usage
References: <b6b70b3ef32940ac783748d10d5a91b2@rtxi.org>
 <591b95a6-d81e-0f87-5d36-1af5d05e0688@siemens.com>
From: Peter Laurich <Peter.Laurich@akamina.com>
Message-ID: <4eb17090-1b81-dfd5-b384-6374efd751b4@akamina.com>
Date: Tue, 27 Jul 2021 09:08:59 -0400
MIME-Version: 1.0
In-Reply-To: <591b95a6-d81e-0f87-5d36-1af5d05e0688@siemens.com>
Content-Language: en-CA
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>, ivan@rtxi.org, xenomai@xenomai.org

Good morning,

We do indeed use Analogy for both data acquisition and control. In the 
past, our hardware platforms tended to be x86-based hardware with some 
lower-cost analogue input hardware built into the base such as the 
Diamond Neptune. Since this platform is EOL, we have moved to lower cost 
ARM platforms with a mPCIe interface. Most recently, we added support 
for the ACCES I/O mPCIe-AIO16 8DI/16SE analog input channels. We are 
using the Cannon Automata K1 right now and have used the Cannon Automata 
A2 in the past. For the A2, we developed an Analogy driver which gave us 
access to digital I/O, the CAN Bus as well as the real-time SERCOS III 
communications channel for synchronous motor control. We have a K1 
Analogy driver module that gives us access to digital I/O and CAN Bus 
I/O. I expect that we will look at extending the K1 Analogy driver to 
give us access to the SERCOS communications channel as well. For CAN Bus 
and digital I/O, we considered using existing drivers for CAN Bus I/O 
and GPIO but elected to stick with the Analogy interface instead.

We have also implemented a small number of the Analogy API calls on a 
Windows system so that we could use our higher level code (which calls 
Analogy functions) yet still use NI's acquisition hardware and Windows 
driver code. This worked quite well for input and buffered output since 
the NI code and hardware could fill or empty data buffers in real time 
and all of our code had to do was manage the buffers quickly enough; 
this would not have worked for control where each tick must be managed 
in real time.

In short, we have embraced Analogy for our drivers and the user-space 
threads that access the drivers.

I certainly miss the support for sharing events between kernel modules 
(Analogy drivers) and user-space threads as well as the ability to 
exchanges messages between user-space and kernel-space with Xenomai 
support. I used these capabilities extensively with Xenomai 2.6 and will 
need to find a way to replace the lost direct support for these in 
Xenomai 3.1.

Peter


On 7/26/2021 1:37 AM, Jan Kiszka via Xenomai wrote:
> On 23.07.21 21:58, Ivan F. Valerio via Xenomai wrote:
>> Hi everyone,
>>
>> My name is Ivan and I am the current (new) maintainer for the Real-Time
>> eXperiment
>> Interface (RTXI). This is an application that uses Xenomai to provide
>> real-time
>> performance for experimental setups requiring deterministic control. A
>> number
>> of laboratories both here in the United States and abroad use RTXI for
>> their
>> biological experiments. RTXI uses the Analogy modules in order to interface
>> with a variety DAQ cards. This has allowed easy adoption of RTXI as it
>> provides
>> compatibility among a wide range of DAQ cards out of the box.
>>
>> I am new to the mailing list and while researching came across your
>> discussion to
>> discontinue Analogy. Removing Analogy would undoubtedly have an impact
>> on all
>> laboratories who use RTXI for their setups. What are the current plans for
>> Analogy? What issues can I assist with to improve the state of this module?
>>
> Thanks for you offer! It's great to learn about usage this way and also
> to hear that you would like to help improving the situation.
>
> As I explained in [1], we need at least some basic regular test
> infrastructure. The other thing is to understand how Analogy is used:
> with all its features or with specific aspects only (like Peter said he
> is only using own, out-of-tree drivers with the framework)? The work
> should focus on that first.
>
> Jan
>
> [1] https://xenomai.org/pipermail/xenomai/2021-July/045875.html
>
