Message-ID: <4D24D3C0.8080205@domain.hid>
Date: Wed, 05 Jan 2011 21:25:36 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4D20D7A7.2090003@domain.hid> <4D21A5CF.9000107@domain.hid>
	<4D24D30E.7060108@domain.hid>
In-Reply-To: <4D24D30E.7060108@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Build issue with rtcan and I-pipe for linux
	2.6.36 on powerpc.
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: Wolfgang Grandegger <wg@domain.hid>, Xenomai core <Xenomai-core@domain.hid>

Jan Kiszka wrote:
> Am 03.01.2011 11:32, Wolfgang Grandegger wrote:
>> Hi Gilles,
>>
>> the attached patch fixes the issue.
>>
> 
> Nothing critical, but I think we should consistently wrap the other way
> around
> 
> #if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,36)
> #define platform_device of_device
> #endif
> 
> and update the users to the new style.

Err... Am I missing the obvious here? If you include
<linux/platform_device.h> on powerpc you then get a massive mess prior
to 2.6.36.

-- 
					    Gilles.

