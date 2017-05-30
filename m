References: <75c20daf-b35f-116e-11c5-75f6fcfc10ed@gmail.com>
 <aeee6ff7-53eb-34e0-00ec-c0f12f46ba0f@xenomai.org>
From: Fyleo <fyleo45@gmail.com>
Message-ID: <90600d56-7dfa-7726-f25b-d9301a915820@gmail.com>
Date: Tue, 30 May 2017 12:23:01 +0200
MIME-Version: 1.0
In-Reply-To: <aeee6ff7-53eb-34e0-00ec-c0f12f46ba0f@xenomai.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: fr-classic
Subject: Re: [Xenomai] dlopen failing when using shared library on xenomai
 3.0.4
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, xenomai@xenomai.org

On 30/05/2017 09:12, Philippe Gerum wrote:
> On 05/29/2017 11:19 PM, Fyleo wrote:
>> Hello all,
>>
>> I'm trying to port machinekit (machinekit.io) to xenomai 3.0.4 which
>> support only xenomai 2.6.4 for the moment.
>>
>> This software is design this way :
>>
>> A : main executable
>>
>> B : shared library abstracting thread API, with one library for posix,
>> for xenomai, ...
>>
>> The xenomai B library is linked against alchemy, copperplate, ...
>> (xeno-config --ldflags --auto-init-solib --skin=alchemy)
>>
>> The program works in a way that, at start time, it load with dlopen the
>> configured API (B).
>>
>> My problem is that dlopen(with RTLD_GLOBAL|RTLD_NOW) fail with the error
>> : "/usr/lib/libcopperplate.so.0: undefined symbol: main"
>>
> Could you pick the change below and retry? Feedback welcome.
>
> http://git.xenomai.org/xenomai-3.git/commit/?id=48b2e57e29ca1c33eba14abb4b5eaa15431130fa
>
Hi,

This fix works, thanks.

But will it always work in executable auto init ? The symbol 
"__real_main" have to be defined in user code if linked with bootstrap.o ?

Fyleo


