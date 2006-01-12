Message-ID: <43C61D87.1080301@domain.hid>
Date: Thu, 12 Jan 2006 10:12:39 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <43C61CC6.5090802@domain.hid>
In-Reply-To: <43C61CC6.5090802@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Re: Xenomai broken on Linux 2.4
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Wolfgang Grandegger <wg@domain.hid>
Cc: xenomai@xenomai.org


Hi Wolfgang,

Wolfgang Grandegger wrote:
> Hi Philippe,
> 
> I just realized that recent changes in ksrc/arch/powerpc/switch.S have 
> broken the build of Xenomai with linuxppc_2_4_devel on PPC:
> 
>  #include <asm/offsets.h> does not exist
>  Symbols like SAVE_NVGPRS do not exist
>

Ok, thanks for the info. I'm going to fix and check the 2.4/ppc port today.

> For the time being, I will stick with an older version for testing RTnet 
> (where I'm currently debugging "floating point used in kernel" errors on 
> the MPC8260),
> 
> Thanks.
> 
> Wolfgang.
> 


-- 

Philippe.

