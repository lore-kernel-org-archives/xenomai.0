Message-ID: <d6c8ef150805270431j24e99d94n1bdd56ada3eb5ff9@domain.hid>
Date: Tue, 27 May 2008 13:31:55 +0200
From: "Bosko Radivojevic" <bosko.radivojevic@domain.hid>
In-Reply-To: <d6c8ef150805261047y660c853fwb398d344d8b3b540@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <d6c8ef150805231056n3a9ea030jada65bd5a7c2a2c0@domain.hid>
	<d6c8ef150805260626o3ba03d42sce1100bab89540a5@domain.hid>
	<d6c8ef150805260929yeb4e263o618c446cdd96856b@domain.hid>
	<2ff1a98a0805260947q4587700era0e5af4527a26cfc@domain.hid>
	<2ff1a98a0805260959wded8f38tf266d11a921f9c04@domain.hid>
	<d6c8ef150805261004l58f0c832n735e68dd91eb1123@domain.hid>
	<2ff1a98a0805261014o5900fc40i61332fdb19a8ea08@domain.hid>
	<d6c8ef150805261016q7250012cxcb0f15aa8ae817fd@domain.hid>
	<2ff1a98a0805261021s1d369a23ic63451e9b87b68b6@domain.hid>
	<d6c8ef150805261047y660c853fwb398d344d8b3b540@domain.hid>
Subject: Re: [Xenomai-help] Interrupt priorities and handling problems
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-help <xenomai@xenomai.org>

Hi Gilles,

problem with Ethernet activity seems to be caused by hardware.
According to datasheet each PIO peripheral (A, B & C) has its own, but
only one, Interrupt line. In my case, both Ethernet and sync signal
were connected on PIO B peripheral. I did some quick tests using IRQ1
line, but I still need to double check.

Problem with two interrupts is still unresolved, but I have a
"feeling" :) it is also caused by hardware. It looks sync signal has
too 'sharp' edges.

Anyway, I'll send report later. If you see anything unusual on frozen*
files I've sent, please let me know. Thanks.

Regards,
Bosko

