Message-ID: <4C35DB9B.4010902@domain.hid>
Date: Thu, 08 Jul 2010 16:07:23 +0200
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <1278577080.S.5424.32919.F.H.TkdpbGxlcyBDaGFudGVwZXJkcml4AFJlOiBbWGVub21haS1oZWxwXSBUZXN0aW5nIFJUTmV0IGluIFhlbm8_.f4-234-246.old.1278596771.3702@domain.hid>
In-Reply-To: <1278577080.S.5424.32919.F.H.TkdpbGxlcyBDaGFudGVwZXJkcml4AFJlOiBbWGVub21haS1oZWxwXSBUZXN0aW5nIFJUTmV0IGluIFhlbm8_.f4-234-246.old.1278596771.3702@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Testing RTNet in Xenomai
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: prakash srinivasan <asprakash_83@domain.hid>
Cc: xenomai@xenomai.org

On 07/08/2010 03:46 PM, prakash srinivasan wrote:
> 
> 
>> To install Xenomai, please follow the installation instructions. You
> 
>>
> 
>> will find them in the README.INSTALL file in Xenomai sources
> 
>>
> 
>> distribution, or online:
> 
>>
> 
>> http://www.xenomai.org/documentation/xenomai-2.5/README.INSTALL
> 
> 
> 
> Dear Gilles,
> 
>      Thanks for the info. I justed followed the document, http://download.intel.com/design/intarch/papers/322386.pdf Coz I am also testing in the same ARCH. I followed the steps. Everything was fine without any issues and tested the xenomai-2.4.6 as they mentioned in the doc.
> 
>      But I have doubt that there is no modules created after it was installed successfully in /usr/xenomai/. I just like to know whether xenomai installation will create any "modules" folder in /usr/xenomai/ or not?. Like in RTAI mechanism(loading .ko modules one by one manually) is not necessary in xenomai?. Since I am new to xenomai, I found that I have zero .ko modules in my installation directory, /usr/xenomai. In other words I am not aware of Xenomai installed file structure. Do I need to load any modules to test RTNet in xenomai?.

Xenomai is integrated into the kernel tree and you have the option to
link Xenomai interfaces and drivers statically or dynamically (as
modules). So it depends on your kernel configuration. By default
everything is compiled statically! You should see Xenomai related output
when your system boots. Then, you just need to load the RTnet modules.

Wolfgang.

