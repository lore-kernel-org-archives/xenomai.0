Message-ID: <45869247.6020704@domain.hid>
Date: Mon, 18 Dec 2006 14:06:15 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [PATCH] ADEOS IPIPE PPC patches upgrade
References: <458685C6.40204@domain.hid>
	<20061218134917.c76ac833.benjamin.zores@domain.hid>
In-Reply-To: <20061218134917.c76ac833.benjamin.zores@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Benjamin Zores <benjamin.zores@domain.hid>
Cc: xenomai@xenomai.org

Benjamin Zores wrote:
> On Mon, 18 Dec 2006 13:12:54 +0100
> Wolfgang Grandegger <wg@domain.hid> wrote:
> 
>> Hallo,
>>
>> attached is patch for Xenomai upgrading the ADEOS IPIPE patches for the 
>> PPC tree. Here is the ChangeLog entry:
>>
>> 2006-12-18  Wolfgang Grandegger  <wg@domain.hid>
>>
>>          * ksrc/arch/powerpc/patches: Upgrade to 2.6.14-ppc-1.5-02,
>>          2.6.18-ppc-1.5-01 and 2.6.19-ppc-1.5-01. These patches fix
>>          the problems with PIC for Galileo's GT64260 reported by Antonio
>>          Barbalace and add support for 2.6.19.
> 
> Hi,
> 
> Got the same for 2.6.19 on powerpc arch ?
> Or should I try to port it as I did for 2.6.18 ?

I don't understand your questions. These patches are for the PPC tree. 
The POWERPC is still not supported. Do you already have a working port 
for the PowerPC tree 2.6.18?

Wolfgang.


