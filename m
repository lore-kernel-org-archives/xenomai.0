In-Reply-To: <43C61D87.1080301@domain.hid>
References: <43C61CC6.5090802@domain.hid> <43C61D87.1080301@domain.hid>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=ISO-8859-1; delsp=yes; format=flowed
Message-Id: <BCC969F7-8D97-46BD-A314-2153708D71AE@openwide.fr>
Content-Transfer-Encoding: quoted-printable
From: Stelian Pop <stelian.pop@domain.hid>
Subject: Re: [Xenomai-core] Re: Xenomai broken on Linux 2.4
Date: Thu, 12 Jan 2006 10:56:40 +0100
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org


Le 12 janv. 06 =E0 10:12, Philippe Gerum a =E9crit :

>
> Hi Wolfgang,
>
> Wolfgang Grandegger wrote:
>> Hi Philippe,
>> I just realized that recent changes in ksrc/arch/powerpc/switch.S =20
>> have broken the build of Xenomai with linuxppc_2_4_devel on PPC:
>>  #include <asm/offsets.h> does not exist
>>  Symbols like SAVE_NVGPRS do not exist
>>
>
> Ok, thanks for the info. I'm going to fix and check the 2.4/ppc =20
> port today.

2.6/ppc build fails in the same way. Correcting it to <linux/asm-=20
offsets.h> fixes fixes it.

Stelian.


