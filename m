Message-ID: <50449CEC.6060900@evidence.eu.com>
Date: Mon, 03 Sep 2012 14:05:00 +0200
From: Claudio Scordino <claudio@evidence.eu.com>
MIME-Version: 1.0
References: <2211797.6MhXv49D68@valtin-rt> <50436D2A.2070607@xenomai.org>
In-Reply-To: <50436D2A.2070607@xenomai.org>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Scicos/Xcos Code Generation
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Markus Valtin <valtin@control.tu-berlin.de>
Cc: xenomai@xenomai.org

Il 02/09/2012 16:28, Gilles Chanteperdrix ha scritto:
> On 08/22/2012 06:28 PM, Markus Valtin wrote:
>
>> Hello all,
>>
>> i have a question regarding automated code generation from Scilab Xcos/Scicos.
>>
>> Is this possible? And if yes, how is the necessary setup.
>>
>> Background:
>>
>> We currently use RTAI for hard realtime but we want to use recent Kernel
>> versions, so Xenomai with his RTAI skin seamed promising.
>>
>> However I read that the RTAI emulation was removed from version 2.6.0 because
>> of lack of feedback / lack of LXRT emulation.
>>
>> So, is there another way like the native Xenomai Support as suggested on
>> http://www.evidence.eu.com/scilabscicos-code-generator-xenomai.html
>
>
>  From what I understand from this post:
> http://www.xenomai.org/pipermail/xenomai-help/2008-09/msg00077.html
>
> This code generator does not use the RTAI skin, but the POSIX skin.

Hello everybody.

I'm Claudio, the author of the original email.

As you have seen, our web page allows to download the ScicosPack, which 
works with the Xenomai POSIX skin.

Actually, during the last years, we have not maintained such software, 
mainly due to the lack of feedback or specific requests from 
universities or companies. For some recent project based on the x86 
platform we have used RTAI + Scicos + Comedi. On our embedded platforms, 
instead, we usually prefer Xenomai, but we didn't have any request for 
code generation, yet.

@Markus: can you please give me more details about what you are looking 
for ? If I've understood, you work at the university. Indeed, we are a 
spin-off company of the university (Scuola Sant'Anna, Pisa, Italy) and 
we are very interested in continuing our relationship with research 
institutions.

Best regards,

	Claudio

