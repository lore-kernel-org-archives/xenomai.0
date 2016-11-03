Message-ID: <581B57C4.8020609@numalliance.com>
Date: Thu, 03 Nov 2016 16:29:08 +0100
From: =?UTF-8?B?U3TDqXBoYW5lIGFuY2Vsb3Q=?= <sancelot@numalliance.com>
MIME-Version: 1.0
References: <581A1E18.7040405@numalliance.com>
 <20161103093605.2228191c@md1em3qc>
In-Reply-To: <20161103093605.2228191c@md1em3qc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] ipipe tracer question
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>


On 03/11/2016 09:36, Henning Schild wrote:
> Am Wed, 2 Nov 2016 18:10:48 +0100
> schrieb St=C3=A9phane ancelot<sancelot@numalliance.com>:
>
>   =20
>> Hi,
>> I have got an RT task that seems being disturbed by some system
>> driver.
>>
>> So, I have setted up ipipe tracer in kernel.
>>     =20
> The tracing uses the kernel tracing infrastructure. Use the
> sysfs-Interface or a tool like trace-cmd or perf to collect traces.
> https://www.kernel.org/doc/Documentation/trace/ftrace.txt
>
>   =20
I am now able to trace in the kernel.
I made some function trace in  the shell, but I have not managed to find=20
where is my problem.
I want to find where my tasks spend more time than usuallly. e.g. (end=20
task - start task) > 500us

I have some references to cobalt_head_sysentry , cobalt_head_sys
I made a trace with trace-cmd and I am able to load it with kernelshark.
a bit difficult to understand the graph.



>> But I do not know where to  go  now ?
>> I suppose being on the right way, but what to do next ?
>>
>> Regards,
>> S.Ancelot
>>
>>
>> _______________________________________________
>> Xenomai mailing list
>> Xenomai@xenomai.org
>> https://xenomai.org/mailman/listinfo/xenomai
>>     =20

