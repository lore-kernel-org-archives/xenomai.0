Message-ID: <006901c953c4$11e18ea0$0f01a8c0@domain.hid>
From: "Daniele Pagani" <danielepagani@domain.hid>
References: <002701c953bd$0899eec0$0f01a8c0@domain.hid>
	<4933F0A8.4020406@domain.hid>
Date: Mon, 1 Dec 2008 15:49:51 +0100
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] xenomai on Blackfin BF537
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai@xenomai.org

Dear Philippe,

thank you very much for your very fast answer.

Anyway, please consider that I'm newbie about the matter,
so,
where I need to write these lines?

I find in:
/mnt/uClinux-dist-2008R1.5-RC3/staging/usr/bin
the xeno-config command.

Then, I run:
./xeno-config --xeno-cflags
./xeno-config --xeno-ldflags

Then, what I need to do?
Do I need to recompile the kernel?

Best regards,
Daniele.

----- Original Message ----- 
From: "Philippe Gerum" <rpm@xenomai.org>
To: "Daniele Pagani" <danielepagani@domain.hid>
Cc: <xenomai@xenomai.org>
Sent: Monday, December 01, 2008 3:11 PM
Subject: Re: [Xenomai-help] xenomai on Blackfin BF537


> Daniele Pagani wrote:
>>
>> Dear Sirs,
>> I'm using Xenomai with uclinux-dist-2008R1.5 on bf537.
>>
>> Then, it is possible to use native api with a fdpic elf format?
>>
>> I receive warning like "relocation references a different segment".
>>
>> I compile with bfin-linux-uclibc-gcc .... -lnative.
>>
>
> We do use the fdpic format for all libs on blackfin.
>
> xeno-config --cflags
> xeno-config --ldflags
>
> should be used to get the proper compilation/link flags.
>
>> In my code I create 2 real time tasks.
>>
>> All works fine when I use flat format, but now I need to use fdpic elf
>> format and I receive errors.x
>>
>> Best regards,
>> Daniele.
>>
>>
>> ------------------------------------------------------------------------
>>
>> _______________________________________________
>> Xenomai-help mailing list
>> Xenomai-help@domain.hid
>> https://mail.gna.org/listinfo/xenomai-help
>
>
> -- 
> Philippe.
>
>
>
> -- 
> No virus found in this incoming message.
> Checked by AVG.
> Version: 7.5.552 / Virus Database: 270.9.12/1821 - Release Date: 
> 30/11/2008 17.53
>
> 


