Message-ID: <49050219.4050805@domain.hid>
Date: Mon, 27 Oct 2008 00:49:45 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <66014.68232.qm@domain.hid>
In-Reply-To: <66014.68232.qm@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] trap exceptions in user
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gabriele Moabiti <gabmoa@domain.hid>
Cc: Jan Kiszka <jan.kiszka@domain.hid>, Xenomai help <xenomai@xenomai.org>

Gabriele Moabiti wrote:
> Gilles Chanteperdrix wrote:
>> Gabriele Moabiti wrote:
>>> (...) I consider now ManageCustomExceptions a function that do
>>> nothing. (...) INT 0 (divide error) or 16 (fpu exception) The
>>> system hangs.
>> It will not work. It is because you have to handle the exception. 
>> Otherwise, when returning to user-space, your programs tries the
>> faulty exception again, triggers the handler, which does nothing,
>> and loops indefinitely...
>> 
> 
> so the int 1 and 3 are instead signed as traps with the old CS:EIP
> points past instruction causing exception...
> 
> Sorry for the question (I have always done it directly in asm
> reprogramming customizing the IDT), do I have to change the eip of
> the pt_regs structure passed to the function?

Errr no. You probably know better than me the details of exception
handling (I trust Linux and/or Xenomai exception handling for my
everyday usage), however, if your code contains an instruction which
uses FPU, you should enable FPU and let the program retry that
instruction, otherwise, if you skip this instruction, you will never
know its result.

-- 
					    Gilles.

