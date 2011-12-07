Message-ID: <4EDF7A34.2020701@domain.hid>
Date: Wed, 07 Dec 2011 15:37:40 +0100
From: Kurt Geebelen <kurt.geebelen@domain.hid>
MIME-Version: 1.0
References: <4ED8EEB1.1040904@domain.hid> <4EDE5AFA.2050503@domain.hid>
In-Reply-To: <4EDE5AFA.2050503@domain.hid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] Xenomai installation: high latencies
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi all,

Sorry for taking so long to respond, I didn't have time to work on it.=20
SMI's didn't appear to be the problem, and I also am not using the=20
nvidia binary driver.

I tried disabling USB in the BIOS, and that helped! My latencies are now=20
under 6 microseconds. Since I don't need USB (I'm using a PS/2 mouse and=20
keyboard now), I'll use it like this.

Thanks for the help,
Best,
Kurt

Op 6/12/2011 19:12, Gilles Chanteperdrix schreef:
> On 12/02/2011 04:28 PM, Kurt Geebelen wrote:
>> Dear all,
>>
>> I've tried installing Xenomai, following these instructions:
>>
>> http://www.xenomai.org/index.php/Building_Debian_packages
>>
>> but then for the latest version (xenomai 2.6.0, and kernel 2.6.38.8 an=
d
>> for 64 bit) .
>>
>> For configuring the kernel, I followed these instructions:
>>
>> http://www.xenomai.org/index.php/Configuring_x86_kernels
>>
>> All that is stated on these websites works without problems, and I am
>> able to boot in the installed xenomai kernel. However, when I perform
>> the latency-test (latency in /usr/lib/xenomai), I get latencies of mor=
e
>> than 1400 microseconds.
>>
>> The system I have is the following:
>>
>> Dell=E2=84=A2 Precision=E2=84=A2 T1500
>> One=C2=AE Intel=E2=84=A2 Core i7-860 (2.8GHz, 8MB L3, 95W, Quad Core)
>> 6GB DDR3 non-ECC Memory (1333MHz, 3x2GB)
>> 512MB PCIe x16 NVIDIA Quadro FX 580 Graphics Card
>> Intel Solid-State Drive 320 Series 120GB
>>
>> I have tried reinstalling the kernel several times, but I always end u=
p
>> with high latencies.
>> I also have consulted with others, who followed the same guidelines as=
 I
>> did, and their latencies are about 100 times lower.
>>
>> Is there somebody who knows what the problem might be? Might it be a
>> hardware-related problem?
> It is already written in the URL you mention, but I will repeat it
> nevertheless, if enabling SMI workaround, have you checked the kernel
> logs to see whether the SMI workaround actually works?
>

