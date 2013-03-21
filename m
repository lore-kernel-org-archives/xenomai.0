Message-ID: <514B563D.70603@bollue.de>
Date: Thu, 21 Mar 2013 19:49:33 +0100
From: Kai Bollue <mlist1@bollue.de>
MIME-Version: 1.0
References: <A46EF8CF1BBB8E4B8A27B73E177C4664EA5CA7@MAIL-SINTERS-01.sinters-int.fr>
In-Reply-To: <A46EF8CF1BBB8E4B8A27B73E177C4664EA5CA7@MAIL-SINTERS-01.sinters-int.fr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Informations about Xenomai
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

On 21.03.2013 16:52, Younes CHALABI wrote:
> Hello,
>
> I have seen on the website, that Xenomai supports the i.MX27 and i.MX6 by Freescale.
>
> I need this complementary informations :
> - Is it possible to interface Matlab Simulink models ?
>

That depends on the target - and what you mean by "interface". In 
general, the "Mathworks Real-Time Workshop" (or now "Simulink Coder", I 
think)  generates C code. Thus, as long as you have a C compiler for the 
target architecture you should be able to use it.
How convenient the workflow is of code generation, compilation, transfer 
to the target hardware, test and debugging, is another question - and 
one I cannot answer.
We have some experience with generated code only on the x86 machine 
running Simulink itself. Here you can generate a shared library from 
your model by a key stroke, dynamically link it into a Xenomai process 
and then use it in real time context.


Regards,
Kai




