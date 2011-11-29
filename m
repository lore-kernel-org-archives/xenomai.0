Message-ID: <4ED4E3C3.1080803@domain.hid>
Date: Tue, 29 Nov 2011 14:53:07 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <mailman.61.1322564420.6727.adeos-main@gna.org>
	<CAOiFVFtS6y727K5vhEXX2v9TU9saJpGA2=ww_5Eb_dS4K3aeQw@domain.hid>
In-Reply-To: <CAOiFVFtS6y727K5vhEXX2v9TU9saJpGA2=ww_5Eb_dS4K3aeQw@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Adeos-main] Adeos-main Digest, Vol 74, Issue 4
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/options/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Adriano Campos <adrianoribeirocampos@domain.hid>
Cc: adeos-main@gna.org

On 11/29/2011 02:20 PM, Adriano Campos wrote:
> hello all,
> 
> I am developing a project with Xenomai, ADEOS and ARM.
> 
> In this first phase want to simulate the platform in the QEMU emulator. Can
> you tell me if you already did something like that or think it's possible.
> 
> I am using buildroot to build the system and I'm in trouble because QEMU to
> work I have to choose "arm926t" in the "target arquitecture variant" and
> "menu Xenomai ARM CPU TYPE" I do not know what to choose. If I choose "
> GENERIC ARM" gives the following error when compiling.
> 
> hal.h: 91:2: error: # error "Unsupported ARM machine"
> 
> If I choose in the menu "Xenomai ARM CPU TYPE" another option QEMU crash
> when booting.

You may find the list of ARM SOCs supported by Xenomai here:
http://www.xenomai.org/index.php/Embedded_Device_Support#ARM

You have to select one of these processors to have a system running
correctly with Xenomai.

-- 
					    Gilles.

