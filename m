Message-ID: <000c01c9545c$8b090b80$0f01a8c0@domain.hid>
From: "Daniele Pagani" <danielepagani@domain.hid>
References: <002701c953bd$0899eec0$0f01a8c0@domain.hid>
	<4933F0A8.4020406@domain.hid>
	<006901c953c4$11e18ea0$0f01a8c0@domain.hid>
	<4933FDDE.5060007@domain.hid>
Date: Tue, 2 Dec 2008 10:01:18 +0100
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0009_01C95464.EB86C2B0"
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

This is a multi-part message in MIME format.

------=_NextPart_000_0009_01C95464.EB86C2B0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit

Dear Philippe,

I've tried, anyway I receive errors.

In attachment, my makefile and error executing it.

Bf537 - uClinux-dist-2008R1.5-RC3.

Best regards,
Daniele.


----- Original Message ----- 
From: "Philippe Gerum" <rpm@xenomai.org>
To: "Daniele Pagani" <danielepagani@domain.hid>
Cc: <xenomai@xenomai.org>
Sent: Monday, December 01, 2008 4:08 PM
Subject: Re: [Xenomai-help] xenomai on Blackfin BF537


> Daniele Pagani wrote:
>> Dear Philippe,
>>
>> thank you very much for your very fast answer.
>>
>> Anyway, please consider that I'm newbie about the matter,
>> so,
>> where I need to write these lines?
>>
>> I find in:
>> /mnt/uClinux-dist-2008R1.5-RC3/staging/usr/bin
>> the xeno-config command.
>>
>> Then, I run:
>> ./xeno-config --xeno-cflags
>> ./xeno-config --xeno-ldflags
>>
>
> As you may have noticed, those commands output a set of compilation and 
> link
> flags. Copy&paste this output verbatim respectively to the CFLAGS and 
> LDFLAGS
> variables from your Makefile to build your application.
>
>> Then, what I need to do?
>> Do I need to recompile the kernel?
>>
>
> No.
>
>> Best regards,
>> Daniele.
>>
>> ----- Original Message ----- From: "Philippe Gerum" <rpm@xenomai.org>
>> To: "Daniele Pagani" <danielepagani@domain.hid>
>> Cc: <xenomai@xenomai.org>
>> Sent: Monday, December 01, 2008 3:11 PM
>> Subject: Re: [Xenomai-help] xenomai on Blackfin BF537
>>
>>
>>> Daniele Pagani wrote:
>>>>
>>>> Dear Sirs,
>>>> I'm using Xenomai with uclinux-dist-2008R1.5 on bf537.
>>>>
>>>> Then, it is possible to use native api with a fdpic elf format?
>>>>
>>>> I receive warning like "relocation references a different segment".
>>>>
>>>> I compile with bfin-linux-uclibc-gcc .... -lnative.
>>>>
>>>
>>> We do use the fdpic format for all libs on blackfin.
>>>
>>> xeno-config --cflags
>>> xeno-config --ldflags
>>>
>>> should be used to get the proper compilation/link flags.
>>>
>>>> In my code I create 2 real time tasks.
>>>>
>>>> All works fine when I use flat format, but now I need to use fdpic elf
>>>> format and I receive errors.x
>>>>
>>>> Best regards,
>>>> Daniele.
>>>>
>>>>
>>>> ------------------------------------------------------------------------
>>>>
>>>> _______________________________________________
>>>> Xenomai-help mailing list
>>>> Xenomai-help@domain.hid
>>>> https://mail.gna.org/listinfo/xenomai-help
>>>
>>>
>>> -- 
>>> Philippe.
>>>
>>>
>>>
>>> -- 
>>> No virus found in this incoming message.
>>> Checked by AVG.
>>> Version: 7.5.552 / Virus Database: 270.9.12/1821 - Release Date:
>>> 30/11/2008 17.53
>>>
>>>
>>
>>
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

------=_NextPart_000_0009_01C95464.EB86C2B0
Content-Type: application/octet-stream;
	name="Makefile"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="Makefile"

#define CC=0A=
CC =3D bfin-linux-uclibc-gcc=0A=
CFLAGS =3D -O2 -fno-jump-tables =
-I/mnt/uClinux-dist-2008R1.5-RC3/staging/usr/include =
-L/mnt/uClinux-dist-2008R1.5-RC3/staging/usr/lib =0A=
=0A=
#declare a target (app) and list its dependants=0A=
# specify the rule to build the target=0A=
=0A=
app: sport.o inizializza.o net.o audio.o coeff_iir.o Scaler_Render.o =
BiquadCascade32_Render.o Delay_Render.o AGCLimiterCore_Render.o =
ClipAsym_Render.o AGCNMaxAbs_Render.o AGCNMultiplier_Render.o =
AMF_ToStereo_Render.o AMF_ToMono_Render.o=0A=
#	$(CC) $(CFLAGS) -o app sport.o inizializza.o net.o audio.o coeff_iir.o =
Scaler_Render.o BiquadCascade32_Render.o Delay_Render.o =
AGCLimiterCore_Render.o ClipAsym_Render.o AGCNMaxAbs_Render.o =
AGCNMultiplier_Render.o AMF_ToStereo_Render.o AMF_ToMono_Render.o -lm =
-lpthread=0A=
	$(CC) -D_GNU_SOURCE -D_REENTRANT -D__XENO__ $(CFLAGS)  -o app sport.o =
inizializza.o net.o audio.o coeff_iir.o Scaler_Render.o =
BiquadCascade32_Render.o Delay_Render.o AGCLimiterCore_Render.o =
ClipAsym_Render.o AGCNMaxAbs_Render.o AGCNMultiplier_Render.o =
AMF_ToStereo_Render.o AMF_ToMono_Render.o -lm -lpthread -lnative=0A=
=0A=
sport.o: sport.c=0A=
	$(CC) -D_GNU_SOURCE -D_REENTRANT -D__XENO__ $(CFLAGS)  -c sport.c=0A=
=0A=
inizializza.o: inizializza.c=0A=
	$(CC) -D_GNU_SOURCE -D_REENTRANT -D__XENO__ $(CFLAGS) -c inizializza.c=0A=
=0A=
net.o: net.c=0A=
	$(CC)  -D_GNU_SOURCE -D_REENTRANT -D__XENO__ -c net.c=0A=
=0A=
audio.o: audio.c=0A=
	$(CC) -D_GNU_SOURCE -D_REENTRANT -D__XENO__ $(CFLAGS) -c audio.c=0A=
=0A=
coeff_iir.o: coeff_iir.c=0A=
	$(CC) $(CFLAGS)  -c coeff_iir.c=0A=
=0A=
Scaler_Render.o: Scaler_Render.s=0A=
	$(CC) $(CFLAGS)  -c Scaler_Render.s=0A=
=0A=
BiquadCascade32_Render.o: BiquadCascade32_Render.s=0A=
	$(CC) $(CFLAGS)  -c BiquadCascade32_Render.s=0A=
=0A=
Delay_Render.o: Delay_Render.s=0A=
	$(CC) $(CFLAGS)  -c Delay_Render.s=0A=
=0A=
AGCLimiterCore_Render.o: AGCLimiterCore_Render.s=0A=
	$(CC) $(CFLAGS)  -c AGCLimiterCore_Render.s=0A=
=0A=
ClipAsym_Render.o: ClipAsym_Render.s=0A=
	$(CC) $(CFLAGS)  -c ClipAsym_Render.s=0A=
=0A=
AGCNMaxAbs_Render.o: AGCNMaxAbs_Render.s=0A=
	$(CC) $(CFLAGS)  -c AGCNMaxAbs_Render.s=0A=
=0A=
AGCNMultiplier_Render.o: AGCNMultiplier_Render.s=0A=
	$(CC) $(CFLAGS)  -c AGCNMultiplier_Render.s=0A=
=0A=
AMF_ToMono_Render.o: AMF_ToMono_Render.s=0A=
	$(CC) $(CFLAGS)  -c AMF_ToMono_Render.s=0A=
=0A=
AMF_ToStereo_Render.o: AMF_ToStereo_Render.s=0A=
	$(CC) $(CFLAGS)  -c AMF_ToStereo_Render.s=0A=

------=_NextPart_000_0009_01C95464.EB86C2B0
Content-Type: application/octet-stream;
	name="error.make"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="error.make"

bfin-linux-uclibc-gcc -D_GNU_SOURCE -D_REENTRANT -D__XENO__ -O2 =
-fno-jump-tables -I/mnt/uClinux-dist-2008R1.5-RC3/staging/usr/include =
-L/mnt/uClinux-dist-2008R1.5-RC3/staging/usr/lib   -o app sport.o =
inizializza.o net.o audio.o coeff_iir.o Scaler_Render.o =
BiquadCascade32_Render.o Delay_Render.o AGCLimiterCore_Render.o =
ClipAsym_Render.o AGCNMaxAbs_Render.o AGCNMultiplier_Render.o =
AMF_ToStereo_Render.o AMF_ToMono_Render.o -lm -lpthread -lnative=0A=
/opt/uClinux/bfin-linux-uclibc/lib/gcc/bfin-linux-uclibc/4.1.2/../../../.=
./bfin-linux-uclibc/bin/ld: libnative_la-task.o: cannot link non-fdpic =
object file into fdpic executable=0A=
/opt/uClinux/bfin-linux-uclibc/lib/gcc/bfin-linux-uclibc/4.1.2/../../../.=
./bfin-linux-uclibc/bin/ld: failed to merge target specific data of file =
/mnt/uClinux-dist-2008R1.5-RC3/staging/usr/lib/libnative.a(libnative_la-t=
ask.o)=0A=
/opt/uClinux/bfin-linux-uclibc/lib/gcc/bfin-linux-uclibc/4.1.2/../../../.=
./bfin-linux-uclibc/bin/ld: libnative_la-init.o: cannot link non-fdpic =
object file into fdpic executable=0A=
/opt/uClinux/bfin-linux-uclibc/lib/gcc/bfin-linux-uclibc/4.1.2/../../../.=
./bfin-linux-uclibc/bin/ld: failed to merge target specific data of file =
/mnt/uClinux-dist-2008R1.5-RC3/staging/usr/lib/libnative.a(libnative_la-i=
nit.o)=0A=
/opt/uClinux/bfin-linux-uclibc/lib/gcc/bfin-linux-uclibc/4.1.2/../../../.=
./bfin-linux-uclibc/bin/ld: libnative_la-timer.o: cannot link non-fdpic =
object file into fdpic executable=0A=
/opt/uClinux/bfin-linux-uclibc/lib/gcc/bfin-linux-uclibc/4.1.2/../../../.=
./bfin-linux-uclibc/bin/ld: failed to merge target specific data of file =
/mnt/uClinux-dist-2008R1.5-RC3/staging/usr/lib/libnative.a(libnative_la-t=
imer.o)=0A=
/mnt/uClinux-dist-2008R1.5-RC3/staging/usr/lib/libnative.a(libnative_la-t=
ask.o): In function `rt_task_sigharden':=0A=
../../../../xenomai-2.4.0/src/skins/native/task.c:48: warning: warning: =
relocation references a different segment=0A=
../../../../xenomai-2.4.0/src/skins/native/task.c:48: warning: warning: =
relocation references a different segment=0A=
/mnt/uClinux-dist-2008R1.5-RC3/staging/usr/lib/libnative.a(libnative_la-t=
ask.o): In function `rt_task_start':=0A=
../../../../xenomai-2.4.0/src/skins/native/task.c:150: warning: warning: =
relocation references a different segment=0A=
../../../../xenomai-2.4.0/src/skins/native/task.c:150: warning: warning: =
relocation references a different segment=0A=
/mnt/uClinux-dist-2008R1.5-RC3/staging/usr/lib/libnative.a(libnative_la-t=
ask.o): In function `rt_task_bind':=0A=
../../../../xenomai-2.4.0/src/skins/native/task.c:175: warning: warning: =
relocation references a different segment=0A=
../../../../xenomai-2.4.0/src/skins/native/task.c:175: warning: warning: =
relocation references a different segment=0A=
/mnt/uClinux-dist-2008R1.5-RC3/staging/usr/lib/libnative.a(libnative_la-t=
ask.o): In function `rt_task_suspend':=0A=
../../../../xenomai-2.4.0/src/skins/native/task.c:181: warning: warning: =
relocation references a different segment=0A=
../../../../xenomai-2.4.0/src/skins/native/task.c:181: warning: warning: =
relocation references a different segment=0A=
/mnt/uClinux-dist-2008R1.5-RC3/staging/usr/lib/libnative.a(libnative_la-t=
ask.o): In function `rt_task_resume':=0A=
../../../../xenomai-2.4.0/src/skins/native/task.c:186: warning: warning: =
relocation references a different segment=0A=
../../../../xenomai-2.4.0/src/skins/native/task.c:186: warning: warning: =
relocation references a different segment=0A=
/mnt/uClinux-dist-2008R1.5-RC3/staging/usr/lib/libnative.a(libnative_la-t=
ask.o): In function `rt_task_yield':=0A=
../../../../xenomai-2.4.0/src/skins/native/task.c:208: warning: warning: =
relocation references a different segment=0A=
../../../../xenomai-2.4.0/src/skins/native/task.c:208: warning: warning: =
relocation references a different segment=0A=
/mnt/uClinux-dist-2008R1.5-RC3/staging/usr/lib/libnative.a(libnative_la-t=
ask.o): In function `rt_task_set_periodic':=0A=
../../../../xenomai-2.4.0/src/skins/native/task.c:213: warning: warning: =
relocation references a different segment=0A=
../../../../xenomai-2.4.0/src/skins/native/task.c:213: warning: warning: =
relocation references a different segment=0A=
/mnt/uClinux-dist-2008R1.5-RC3/staging/usr/lib/libnative.a(libnative_la-t=
ask.o): In function `rt_task_wait_period':=0A=
../../../../xenomai-2.4.0/src/skins/native/task.c:220: warning: warning: =
relocation references a different segment=0A=
../../../../xenomai-2.4.0/src/skins/native/task.c:220: warning: warning: =
relocation references a different segment=0A=
/mnt/uClinux-dist-2008R1.5-RC3/staging/usr/lib/libnative.a(libnative_la-t=
ask.o): In function `rt_task_set_priority':=0A=
../../../../xenomai-2.4.0/src/skins/native/task.c:226: warning: warning: =
relocation references a different segment=0A=
../../../../xenomai-2.4.0/src/skins/native/task.c:226: warning: warning: =
relocation references a different segment=0A=
/mnt/uClinux-dist-2008R1.5-RC3/staging/usr/lib/libnative.a(libnative_la-t=
ask.o): In function `rt_task_sleep':=0A=
../../../../xenomai-2.4.0/src/skins/native/task.c:232: warning: warning: =
relocation references a different segment=0A=
../../../../xenomai-2.4.0/src/skins/native/task.c:232: warning: warning: =
relocation references a different segment=0A=
/mnt/uClinux-dist-2008R1.5-RC3/staging/usr/lib/libnative.a(libnative_la-t=
ask.o): In function `rt_task_sleep_until':=0A=
../../../../xenomai-2.4.0/src/skins/native/task.c:238: warning: warning: =
relocation references a different segment=0A=
../../../../xenomai-2.4.0/src/skins/native/task.c:238: warning: warning: =
relocation references a different segment=0A=
/mnt/uClinux-dist-2008R1.5-RC3/staging/usr/lib/libnative.a(libnative_la-t=
ask.o): In function `rt_task_unblock':=0A=
../../../../xenomai-2.4.0/src/skins/native/task.c:245: warning: warning: =
relocation references a different segment=0A=
../../../../xenomai-2.4.0/src/skins/native/task.c:245: warning: warning: =
relocation references a different segment=0A=
/mnt/uClinux-dist-2008R1.5-RC3/staging/usr/lib/libnative.a(libnative_la-t=
ask.o): In function `rt_task_inquire':=0A=
../../../../xenomai-2.4.0/src/skins/native/task.c:250: warning: warning: =
relocation references a different segment=0A=
../../../../xenomai-2.4.0/src/skins/native/task.c:250: warning: warning: =
relocation references a different segment=0A=
/mnt/uClinux-dist-2008R1.5-RC3/staging/usr/lib/libnative.a(libnative_la-t=
ask.o): In function `rt_task_notify':=0A=
../../../../xenomai-2.4.0/src/skins/native/task.c:256: warning: warning: =
relocation references a different segment=0A=
../../../../xenomai-2.4.0/src/skins/native/task.c:256: warning: warning: =
relocation references a different segment=0A=
/mnt/uClinux-dist-2008R1.5-RC3/staging/usr/lib/libnative.a(libnative_la-t=
ask.o): In function `rt_task_set_mode':=0A=
../../../../xenomai-2.4.0/src/skins/native/task.c:265: warning: warning: =
relocation references a different segment=0A=
../../../../xenomai-2.4.0/src/skins/native/task.c:265: warning: warning: =
relocation references a different segment=0A=
../../../../xenomai-2.4.0/src/skins/native/task.c:274: warning: warning: =
relocation references a different segment=0A=
../../../../xenomai-2.4.0/src/skins/native/task.c:274: warning: warning: =
relocation references a different segment=0A=
/mnt/uClinux-dist-2008R1.5-RC3/staging/usr/lib/libnative.a(libnative_la-t=
ask.o): In function `rt_task_slice':=0A=
../../../../xenomai-2.4.0/src/skins/native/task.c:302: warning: warning: =
relocation references a different segment=0A=
../../../../xenomai-2.4.0/src/skins/native/task.c:302: warning: warning: =
relocation references a different segment=0A=
/mnt/uClinux-dist-2008R1.5-RC3/staging/usr/lib/libnative.a(libnative_la-t=
ask.o): In function `rt_task_send':=0A=
../../../../xenomai-2.4.0/src/skins/native/task.c:317: warning: warning: =
relocation references a different segment=0A=
../../../../xenomai-2.4.0/src/skins/native/task.c:317: warning: warning: =
relocation references a different segment=0A=
/mnt/uClinux-dist-2008R1.5-RC3/staging/usr/lib/libnative.a(libnative_la-t=
ask.o): In function `rt_task_receive':=0A=
../../../../xenomai-2.4.0/src/skins/native/task.c:324: warning: warning: =
relocation references a different segment=0A=
../../../../xenomai-2.4.0/src/skins/native/task.c:324: warning: warning: =
relocation references a different segment=0A=
/mnt/uClinux-dist-2008R1.5-RC3/staging/usr/lib/libnative.a(libnative_la-t=
ask.o): In function `rt_task_reply':=0A=
../../../../xenomai-2.4.0/src/skins/native/task.c:330: warning: warning: =
relocation references a different segment=0A=
../../../../xenomai-2.4.0/src/skins/native/task.c:330: warning: warning: =
relocation references a different segment=0A=
/mnt/uClinux-dist-2008R1.5-RC3/staging/usr/lib/libnative.a(libnative_la-t=
ask.o): In function `rt_task_join':=0A=
../../../../xenomai-2.4.0/src/skins/native/task.c:311: warning: warning: =
relocation references a different segment=0A=
/mnt/uClinux-dist-2008R1.5-RC3/staging/usr/lib/libnative.a(libnative_la-t=
ask.o): In function `rt_task_self':=0A=
../../../../xenomai-2.4.0/src/skins/native/task.c:284: warning: warning: =
relocation references a different segment=0A=
../../../../xenomai-2.4.0/src/skins/native/task.c:284: warning: warning: =
relocation references a different segment=0A=
../../../../xenomai-2.4.0/src/skins/native/task.c:284: warning: warning: =
relocation references a different segment=0A=
../../../../xenomai-2.4.0/src/skins/native/task.c:289: warning: warning: =
relocation references a different segment=0A=
../../../../xenomai-2.4.0/src/skins/native/task.c:292: warning: warning: =
relocation references a different segment=0A=
../../../../xenomai-2.4.0/src/skins/native/task.c:292: warning: warning: =
relocation references a different segment=0A=
../../../../xenomai-2.4.0/src/skins/native/task.c:295: warning: warning: =
relocation references a different segment=0A=
/mnt/uClinux-dist-2008R1.5-RC3/staging/usr/lib/libnative.a(libnative_la-t=
ask.o): In function `rt_task_delete':=0A=
../../../../xenomai-2.4.0/src/skins/native/task.c:199: warning: warning: =
relocation references a different segment=0A=
../../../../xenomai-2.4.0/src/skins/native/task.c:199: warning: warning: =
relocation references a different segment=0A=
../../../../xenomai-2.4.0/src/skins/native/task.c:194: warning: warning: =
relocation references a different segment=0A=
/mnt/uClinux-dist-2008R1.5-RC3/staging/usr/lib/libnative.a(libnative_la-t=
ask.o): In function `rt_task_shadow':=0A=
../../../../xenomai-2.4.0/src/skins/native/task.c:159: warning: warning: =
relocation references a different segment=0A=
../../../../xenomai-2.4.0/src/skins/native/task.c:161: warning: warning: =
relocation references a different segment=0A=
../../../../xenomai-2.4.0/src/skins/native/task.c:161: warning: warning: =
relocation references a different segment=0A=
../../../../xenomai-2.4.0/src/skins/native/task.c:161: warning: warning: =
relocation references a different segment=0A=
../../../../xenomai-2.4.0/src/skins/native/task.c:167: warning: warning: =
relocation references a different segment=0A=
../../../../xenomai-2.4.0/src/skins/native/task.c:169: warning: warning: =
relocation references a different segment=0A=
../../../../xenomai-2.4.0/src/skins/native/task.c:169: warning: warning: =
relocation references a different segment=0A=
/mnt/uClinux-dist-2008R1.5-RC3/staging/usr/lib/libnative.a(libnative_la-t=
ask.o): In function `rt_task_create':=0A=
../../../../xenomai-2.4.0/src/skins/native/task.c:128: warning: warning: =
relocation references a different segment=0A=
../../../../xenomai-2.4.0/src/skins/native/task.c:135: warning: warning: =
relocation references a different segment=0A=
../../../../xenomai-2.4.0/src/skins/native/task.c:139: warning: warning: =
relocation references a different segment=0A=
../../../../xenomai-2.4.0/src/skins/native/task.c:135: warning: warning: =
relocation references a different segment=0A=
../../../../xenomai-2.4.0/src/skins/native/task.c:137: warning: warning: =
relocation references a different segment=0A=
/mnt/uClinux-dist-2008R1.5-RC3/staging/usr/lib/libnative.a(libnative_la-t=
ask.o): In function `rt_task_trampoline':=0A=
../../../../xenomai-2.4.0/src/skins/native/task.c:66: warning: warning: =
relocation references a different segment=0A=
../../../../xenomai-2.4.0/src/skins/native/task.c:67: warning: warning: =
relocation references a different segment=0A=
../../../../xenomai-2.4.0/src/skins/native/task.c:67: warning: warning: =
relocation references a different segment=0A=
../../../../xenomai-2.4.0/src/skins/native/task.c:71: warning: warning: =
relocation references a different segment=0A=
../../../../xenomai-2.4.0/src/skins/native/task.c:73: warning: warning: =
relocation references a different segment=0A=
../../../../xenomai-2.4.0/src/skins/native/task.c:73: warning: warning: =
relocation references a different segment=0A=
../../../../xenomai-2.4.0/src/skins/native/task.c:73: warning: warning: =
relocation references a different segment=0A=
../../../../xenomai-2.4.0/src/skins/native/task.c:79: warning: warning: =
relocation references a different segment=0A=
../../../../xenomai-2.4.0/src/skins/native/task.c:81: warning: warning: =
relocation references a different segment=0A=
../../../../xenomai-2.4.0/src/skins/native/task.c:81: warning: warning: =
relocation references a different segment=0A=
../../../../xenomai-2.4.0/src/skins/native/task.c:100: warning: warning: =
relocation references a different segment=0A=
/mnt/uClinux-dist-2008R1.5-RC3/staging/usr/lib/libnative.a(libnative_la-i=
nit.o): In function `xeno_bind_skin':=0A=
../../../../xenomai-2.4.0/include/asm-generic/bits/bind.h:61: warning: =
warning: relocation references a different segment=0A=
/mnt/uClinux-dist-2008R1.5-RC3/staging/usr/lib/libnative.a(libnative_la-i=
nit.o): In function `__init_xeno_interface':=0A=
../../../../xenomai-2.4.0/src/skins/native/init.c:44: warning: warning: =
relocation references a different segment=0A=
../../../../xenomai-2.4.0/src/skins/native/init.c:44: warning: warning: =
relocation references a different segment=0A=
/mnt/uClinux-dist-2008R1.5-RC3/staging/usr/lib/libnative.a(libnative_la-i=
nit.o): In function `xeno_bind_skin':=0A=
../../../../xenomai-2.4.0/include/asm-generic/bits/bind.h:63: warning: =
warning: relocation references a different segment=0A=
/mnt/uClinux-dist-2008R1.5-RC3/staging/usr/lib/libnative.a(libnative_la-i=
nit.o): In function `__init_xeno_interface':=0A=
../../../../xenomai-2.4.0/src/skins/native/init.c:55: warning: warning: =
relocation references a different segment=0A=
../../../../xenomai-2.4.0/src/skins/native/init.c:55: warning: warning: =
relocation references a different segment=0A=
../../../../xenomai-2.4.0/src/skins/native/init.c:55: warning: warning: =
relocation references a different segment=0A=
/mnt/uClinux-dist-2008R1.5-RC3/staging/usr/lib/libnative.a(libnative_la-i=
nit.o): In function `xeno_bind_skin':=0A=
../../../../xenomai-2.4.0/include/asm-generic/bits/bind.h:41: warning: =
relocation references symbol not defined in the module=0A=
/opt/uClinux/bfin-linux-uclibc/lib/gcc/bfin-linux-uclibc/4.1.2/../../../.=
./bfin-linux-uclibc/bin/ld: final link failed: Nonrepresentable section =
on output=0A=
collect2: ld returned 1 exit status=0A=
make: *** [app] Error 1=0A=

------=_NextPart_000_0009_01C95464.EB86C2B0--


