Message-ID: <44465A4A.8070609@domain.hid>
Date: Wed, 19 Apr 2006 17:42:02 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] strangeness at kernel configuration
References: <20060418144146.GA4482@domain.hid>
	<20060418153508.GB4482@domain.hid>
	<44450DDF.9080205@domain.hid>
	<20060419152914.GB13542@domain.hid>
In-Reply-To: <20060419152914.GB13542@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Luotao Fu <l.fu@domain.hid>
Cc: xenomai@xenomai.org

Luotao Fu wrote:
> Hi Philipe,
> 
> On Tue, Apr 18, 2006 at 06:03:43PM +0200, Philippe Gerum wrote:
> 
>>Luotao Fu wrote:
>>Your configuration works perfectly here over #944. You might want to 
>>restart building from a freshly patched kernel anew, there seems to be 
>>something badly broken in your current tree, perhaps some mismatching 
>>modules that have not been recompiled properly?
>>
>>-- 
>>
>>Philippe.
> 
> Thanx for testing. I, however could locate the problem at the APIC
> Timer function in the kernel: With 
> ......
> CONFIG_X86_UP_APIC=y
> CONFIG_X86_UP_IOAPIC=y
> CONFIG_X86_LOCAL_APIC=y
> CONFIG_X86_IO_APIC=y
> ......
> I could reproduce the problem (loading rtdm driver causes oops, cannot run
> any application using native or posix skin) reliably on my machine. 
> (Celeron 733MHz. 256MB RAM...a normal PC) Shutting off the APIC stuffs,
> however, solves the problem........ Have I overlooked
> anything or does Xenomai have problems with the apic controller on
> celeron (since it seems to work for you)?

There is no known issue with the [IO-]APIC (I actually tested your 
config on a PIII Celeron), it's even recommended to use it with Xenomai. 
The symptoms you describe are typical of a build problem, e.g. module / 
static kernel mismatching and so on, but unfortunately, I have no clue 
since I cannot reproduce it on any x86 I have at hand.

-- 

Philippe.

