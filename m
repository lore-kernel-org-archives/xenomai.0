Message-ID: <4B9DF4A7.1000102@domain.hid>
Date: Mon, 15 Mar 2010 09:49:43 +0100
From: Daniele Nicolodi <daniele@domain.hid>
MIME-Version: 1.0
References: <4B990EF1.1000400@domain.hid> <4B9ADF5C.5060306@domain.hid>
In-Reply-To: <4B9ADF5C.5060306@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Experimenting with Analogy. Bugs found?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Alexis Berlemont <berlemont.hauw@domain.hid>
Cc: xenomai@xenomai.org

Alexis Berlemont wrote:
> Hi,
> 
> Daniele Nicolodi wrote:
>> Hello. I'm testing Analogy on my x86 system with a NI 6251 ADC board (I
>> can test with other NI ADCs if it useful to someone).
>>
>> The lack of overview documentation is making my progress slow, but I
>> have a couple of acquisition routines working quite well.
> 
> Which documentation are talking about ? For me the docs are:
> - the Doxygen doc (Xenomai API -> modules -> Analogy API):
> http://www.xenomai.org/documentation/xenomai-2.5/html/api/index.html
> - the wiki pages in the section "Device Drivers':
> http://www.xenomai.org/index.php/Driver_documentation
> 
> Are you talking about these ones. Where did you see TRI_WAKE_EOS was not 
> supported ?


Hi, I'm refering exactly to this documentation. When I say that overview
documentation is missing I'm referring to the fact that there isn't a
document that describes which are the steps you need to perform to set
up an acquisition, and why you need to do so. I think that the most
under documented API section is the one about getting devices,
subdevices and channels properties and capabilities. I can try to find
some spare time to help on this.

About the TRIG_WAKE_EOS, I'm referring to this page:

http://www.xenomai.org/documentation/xenomai-2.5/html/api/group__async1__lib.html

It says:

#define 	TRIG_WAKE_EOS   0x0020
 	Trigger not implemented yet.

And there are no other mentions of it in the documentation.

Cheers,
-- 
Daniele


