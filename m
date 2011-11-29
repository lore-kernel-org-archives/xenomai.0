Message-ID: <4ED554A7.6010703@domain.hid>
Date: Tue, 29 Nov 2011 22:54:47 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAOiFVFtm0DPpuo2uopycHAZ1i-CKJKwxcwMpXHw-BvSY_mKZNA@mail.gmail.com>
In-Reply-To: <CAOiFVFtm0DPpuo2uopycHAZ1i-CKJKwxcwMpXHw-BvSY_mKZNA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] =?utf-8?q?=C2=AB_help_with_xenomai_in_QEMU?=
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Adriano Campos <adrianoribeirocampos@domain.hid>
Cc: xenomai@xenomai.org

On 11/29/2011 09:02 PM, Adriano Campos wrote:
> hello,
> 
> First question: is there something wrong with the mail-list of
> Xenomai? I send messages but they do not appear in the list.

Some mails which do not make it to the list go to the spambox, for
instance when using quoted printable or HTML instead of plain text, or
because they contain many capitals.

> 
> My question:I am developing a project with Xenomai, ADEOS and ARM.
>   In this first phase want to simulate the platform in the QEMU
>   emulator. Can you tell me if you already did something like that or
>   think it's possible.
>   I am using buildroot to build the system and I'm in trouble because
>   QEMU to work I have to choose "arm926t" in the "target arquitecture
>   variant" and "menu Xenomai ARM CPU TYPE" I do not know what to choose.
>   If I choose "GENERIC ARM" gives the following error when compiling.
>   hal.h: 91:2: error: # error "Unsupported ARM machine"
>   If I choose in the menu "Xenomai ARM CPU TYPE" another option QEMU
>   crash when booting.

Already answered, see:
https://mail.gna.org/public/adeos-main/2011-11/msg00015.html

-- 
                                                                Gilles.

