MIME-Version: 1.0
In-Reply-To: <CAMcKmiHOC-UAstoUeSiS5m4Q_Qdqc55nQpn=ZjazN_5jJn3K6A@mail.gmail.com>
References: <CAMcKmiHUHPdgg0avFpz+RWi4r6gFDNXdLtOT2vQu1VchnkHs8w@mail.gmail.com>
 <20170824175005.2da5bad5@md1em3qc>
 <CAMcKmiHOC-UAstoUeSiS5m4Q_Qdqc55nQpn=ZjazN_5jJn3K6A@mail.gmail.com>
From: George Broz <brozgeo@gmail.com>
Date: Thu, 24 Aug 2017 09:15:34 -0700
Message-ID: <CAMcKmiGjedxqqvWd8zYLC9fGomP101MhaHH_oGPr6tzAZM7_+g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Xenomai] Fwd:  undefined symbol __wrap_malloc in 3.0.4
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

---------- Forwarded message ----------
From: George Broz <brozgeo@gmail.com>
Date: 24 August 2017 at 09:13
Subject: Re: [Xenomai] undefined symbol __wrap_malloc in 3.0.4
To: Henning Schild <henning.schild@siemens.com>


On 24 August 2017 at 08:50, Henning Schild <henning.schild@siemens.com> wrote:
> Hey,
>
> you are probably a victim of canonical. 3.0.5 fixes that issue, you can
> also cherry-pick
> http://git.xenomai.org/xenomai-3.git/commit/?id=83dea2ad712ee2d2137942c7ab9891da7d4ef841
>
> Henning

Thanks for the quick response. I am cross-compiling for an Altera ARM
SoC using a cross
toolchain built by Yocto. It's the exact same toolchain I used to
build the application under 3.0.2.

I tried adding this to the linker flags anyway, but I still get the
same unresolved symbol message.

Any other suggestions? Is it required now for 3.0.4 applications to
include this mode-check flag
in order to use malloc/free under Xenomai?


--George

>
> Am Thu, 24 Aug 2017 08:38:29 -0700
> schrieb George Broz <brozgeo@gmail.com>:
>
>> Hi ,
>>
>> I am trying to run an application in Xenomai 3.0.4 that was
>> previously running fine in Xenomai 3.0.2.
>>
>> On startup of the application, I get the message:
>> ./my_app: symbol lookup error: ./my_app: undefined symbol:
>> __wrap_malloc
>>
>> (which terminates the application.)
>>
>> I noticed that malloc and free are missing from the cobalt.wrappers
>> in 3.0.4. They are now in "modechk.wrappers"
>>
>> I saw that a xeno-config option was added
>> (--no-mode-check/--mode-check) . I have added this to my link flags
>> for the application. I have tried both options
>> and I still get the same undefined symbol message on startup.
>>
>> Can someone please tell me how I can build the application to now find
>> these wrappers? Does it require a Xenomai kernel configuration option
>> to be selected as well?
>>
>>
>> Thanks in advance!
>>
>> --George Broz
>> Moog Industrial Group
>>
>> _______________________________________________
>> Xenomai mailing list
>> Xenomai@xenomai.org
>> https://xenomai.org/mailman/listinfo/xenomai
>

