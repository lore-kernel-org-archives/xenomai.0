Message-ID: <5661E4D5.5010804@web.de>
Date: Fri, 04 Dec 2015 20:09:09 +0100
From: Jochen Behnke <jk.behnke@web.de>
MIME-Version: 1.0
References: <trinity-3a616500-d86a-4f71-bb11-16fa1d6cf8a2-1448533977790@3capp-webde-bs12>
 <20151128064325.GC10399@hermes.click-hack.org>
 <trinity-4550a539-a311-4cb6-853e-f6f5fb983201-1448975385774@3capp-webde-bap47>
 <20151201181155.GC30041@hermes.click-hack.org>
 <trinity-8e5e4a49-df3c-4391-b1ce-b1bc4d77ffcc-1449061119000@3capp-webde-bs35>
 <trinity-edf656b8-4eef-4967-92eb-85856ad3f8bd-1449246268211@3capp-webde-bs27>
 <20151204163315.GD29398@hermes.click-hack.org>
In-Reply-To: <20151204163315.GD29398@hermes.click-hack.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] "RT throttling" issue
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Hello Gilles,

thanks for your response.

>>
>> Now I have the following questions
>> 1. What is meant by "domain stalled", "current" and "current+stalled"?
>> 2. What is that process having ID "[   0]"
>> 3. How can I tell processes running in secondary mode from others?
>>     (just by looking at the priority value?)
>>
>> Any hint on interpreting my frozen file is appreciated.
>
> This trace is worthless. To have a meaningful trace, enable tracing
> on functions entry (the default when you enable the I-pipe tracer).
>
Do you mean CONFIG_FUNCTION_TRACE?

Regards
Jochen


