Message-ID: <50CCF66E.1060107@linux-kernel.net>
Date: Sat, 15 Dec 2012 23:15:10 +0100
From: Wolfgang Mauerer <wm@linux-kernel.net>
MIME-Version: 1.0
References: <50C9FCAE.7020507@ucv.cl>
	<50CC6607.6080506__19747.5351779305$1355572777$gmane$org@xenomai.org>
In-Reply-To: <50CC6607.6080506__19747.5351779305$1355572777$gmane$org@xenomai.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] Question about Xenomai,  Posix and Java
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: hector.vargas@ucv.cl
Cc: xenomai@xenomai.org

On 15/12/2012 12:59, Gilles Chanteperdrix wrote:
> On 12/13/2012 05:05 PM, Héctor Vargas wrote:
> 
>> Hi everyone,
>>
>> I want to create an application where a control task (real time control 
>> of a DC motor) developed in Xenomai (posix skin) can be controlled from 
>> a Java interface (GUI). The idea is to create a middle task between the 
>> xenomai control task and the Java application working as a gateway by 
>> using TCP sockets. Before starting to work on it I would like to know if 
>> someone has already done something like this. It is possible to do it?.
> 
> 
> I do not see why it would not work (RTnet has everything needed AFAIK).
> But why not invoking the Xenomai code from the Java code as JNI ?
> 
we have also made good experiences with an architecture that uses
a lock-free/wait-free communication scheme between non-RT and RT
components, see
http://www.linuxtag.org/2012/fileadmin/www.linuxtag.org/slides/Gernot%20Hillier%20+%20Wolfgang%20Mauerer%20+%20Jan%20Sawallisch%20-%20Android_%20real-time%20for%20the%20rest%20of%20us.p416.pdf

(the paper is about Java in the sense of Android and real-time in the
sense of preempt_rt, but the scheme is immediately transferable to
Java/Xenomai)

Cheers, Wolfgang

