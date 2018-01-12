MIME-Version: 1.0
In-Reply-To: <ba9c8a11a5c84e8a883096a5859f4ce0@ocnapvsw3301.ocr.priv>
References: <0e3bd82f06324467932a33ca3ffe4085@ocnapvsw3301.ocr.priv>
 <16361_1515687408_5A578DF0_16361_2622_1_ffea3d58-bdb2-cc1b-d3d5-35e8a614477c@utpvision.it>
 <0728c0c5a202411db337cb9d6f866a22@ocnapvsw3301.ocr.priv>
 <13737_1515764197_5A58B9E5_13737_14946_1_f44ed317-e90e-472c-8527-4654404781f1@siemens.com>
 <ba9c8a11a5c84e8a883096a5859f4ce0@ocnapvsw3301.ocr.priv>
From: Greg Gallagher <greg@embeddedgreg.com>
Date: Fri, 12 Jan 2018 10:50:00 -0500
Message-ID: <CALLqZ8TcX32M-dy4WyQCjp2_jcjWYnHxeA+BnN-D923bokKOuQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] R: R: Xenomai 3.0.6 high latency
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Fazio Maurizio <maurizio.fazio@leonardocompany.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi,
  I configured a xenomai 3 system on a x86 i7 not too long ago, I got
really got latency results. Here is what I did when I configured my
system:
Menu config options:

* Power management and ACPI options
  --> CPU Frequency scaling
      --> CPU Frequency scaling (Disable)
  --> ACPI (Advanced Configuration and Power Interface) Support
      --> Processor (Disable)
  --> CPU Idle
      --> CPU idle PM support (Disable)
* Pocessor type and features
  --> Enable maximum number of SMP processors and NUMA nodes (Disable)
  // Ref : http://xenomai.org/pipermail/xenomai/2017-September/037718.html
  --> Processor family
      --> Core 2/newer Xeon (if "cat /proc/cpuinfo | grep family"
returns 6, set as Generic otherwise)
  // Xenomai will issue a warning about CONFIG_MIGRATION, disable
those in this order
  --> Transparent Hugepage Support (Disable)
  --> Allow for memory compaction (Disable)
  --> Contiguous Memory Allocation (Disable)
  --> Allow for memory compaction
    --> Page Migration (Disable)

I also followed the steps here:
https://xenomai.org/2014/06/dealing-with-x86-smi-troubles/

There was a print in the dmesg for my system telling me I didn't have
the SMI work around applied.

Hope this helps, take a look at the Xenomai website for help with
getting started using the ipipe tracer if you want to start debugging
software latency.

-Greg

On Fri, Jan 12, 2018 at 8:58 AM, Fazio Maurizio
<maurizio.fazio@leonardocompany.com> wrote:
> Hello,
> Following are the system informations:
> - OS: Centos 7 64 bit with Gnome 3.14.2 Version
> - Processor:   Intel=C2=AE Xeon(R) CPU E5-2630 v3 @ 2.40GHz =C3=97 32
> - Graphics: Gallium 0.4 on llvmpipe (LLVM 3.8, 256 bits) I patched 3.18.2=
0 kernel with Xenomai 3.0.6...
> For more details I attach the kernel configuration file...
>
> I built Xenomai with the following configure option:
> configure --enable-smp --enable-dlopen-libs --enable-pshared
>
> I disabled the following system services:
> upower.service - Daemon for power management tuned.service - Dynamic Syst=
em Tuning Daemon smartd.service - Self Monitoring and Reporting Technology =
(SMART) Daemon firewalld.service - firewalld - dynamic firewall daemon
>
> As Simone Zucchi wrote before... I disabled the gnome power management dc=
onf-editor =3D> gnome.settings-daemon.plugins.power =3D> active false
>
> in grub2 I configured the following kernel parameters:
> apm=3Doff xenomai.msi=3Ddisabled xenomai.sysheap_size=3D2048
>
> Latency grows when I launch applications like kdevelop or similar, or whe=
n the I return from the lock screen...
> I simply launch the [XENOMAI FOLDER]/bin/latency application... can I tra=
ce this built in application?
>
> Thanks in advance
> Maurizio Fazio
>
> Chief Technical Office / Aircraft Systems Software Engineer
>
>
>
> Leonardo S.p.A.
> C.so Francia, 426 - Torino - 10146 - Italy Tel. +39 011 756 3308 / 3761
>
> maurizio.fazio@leonardocompany.com
> www.leonardocompany.com
>
> =E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=
=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=
=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=
=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=93=
=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94
> HELICOPTERS/AERONAUTICS/ELECTRONICS, DEFENCE & SECURITY SYSTEMS/SPACE =E2=
=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=
=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=
=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=
=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=93=E2=80=
=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94
>
>
>
> Company General Use
>
>
> Il presente messaggio e-mail e ogni suo allegato devono intendersi indiri=
zzati esclusivamente al destinatario indicato e considerarsi dal contenuto =
strettamente riservato e confidenziale. Se non siete l'effettivo destinatar=
io o avete ricevuto il messaggio e-mail per errore, siete pregati di avvert=
ire immediatamente il mittente e di cancellare il suddetto messaggio e ogni=
 suo allegato dal vostro sistema informatico. Qualsiasi utilizzo, diffusion=
e, copia o archiviazione del presente messaggio da parte di chi non ne =C3=
=A8 il destinatario =C3=A8 strettamente proibito e pu=C3=B2 dar luogo a res=
ponsabilit=C3=A0 di carattere civile e penale punibili ai sensi di legge.
> Questa e-mail ha valore legale solo se firmata digitalmente ai sensi dell=
a normativa vigente.
>
> The contents of this email message and any attachments are intended solel=
y for the addressee(s) and contain confidential and/or privileged informati=
on.
> If you are not the intended recipient of this message, or if this message=
 has been addressed to you in error, please immediately notify the sender a=
nd then delete this message and any attachments from your system. If you ar=
e not the intended recipient, you are hereby notified that any use, dissemi=
nation, copying, or storage of this message or its attachments is strictly =
prohibited. Unauthorized disclosure and/or use of information contained in =
this email message may result in civil and criminal liability. =E2=80=9C
> This e-mail has legal value according to the applicable laws only if it i=
s digitally signed by the sender
> -----Messaggio originale-----
> Da: Jan Kiszka [mailto:jan.kiszka@siemens.com]
> Inviato: venerd=C3=AC 12 gennaio 2018 14:37
> A: Fazio Maurizio; Simone M. Zucchi; xenomai@xenomai.org
> Oggetto: Re: R: Xenomai 3.0.6 high latency
>
> On 2018-01-12 10:51, Fazio Maurizio wrote:
>> Hello,
>> I applied your solution. I launched again the latency test but again wor=
st case was 164us...
>> I monitored the test for a while and I noticed these behaviors:
>> - When I launched the console application the worst latency grew over 10=
0 us...
>> - After a while the monitor has gone to black screen and then I moved
>> the mouse... even in this case  the worst latency grew over 100us
>>
>> Have you any idea?
>>
>
> You didn't specify enough details of your hardware platform and configura=
tion yet. Maybe the latencies are related to hw effects, thus not much that=
 software can contribute to.
>
> Typical sources:
>  - system management mode (BIOS)
>     -> disable SMI, if possible, via the related Xenomai logic
>  - contentions on graphic operations, specifically with built-in GPUs
>     -> head-less operation, possibly also a different graphic mode
>        (framebuffer instead of DRM)
>  - aggressive power management
>     -> disable in the kernel, watch out for suspicious BIOS settings
>
> Software-related latencies can be identified by using tracing, ftrace wit=
h event tracing (trace-cmd, kernelshark) or the ipipe function tracer. Spec=
ifically, use the latency benchmark to stop the latter when a new maximum a=
rrives. If you share the trace, the community may help with analyzing.
>
> Jan
>
> --
> Siemens AG, Corporate Technology, CT RDA IOT SES-DE Corporate Competence =
Center Embedded Linux
>
> -------------- next part --------------
> A non-text attachment was scrubbed...
> Name: config-3.18.20
> Type: application/octet-stream
> Size: 138948 bytes
> Desc: config-3.18.20
> URL: <http://xenomai.org/pipermail/xenomai/attachments/20180112/7773eff7/=
attachment.obj>
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> https://xenomai.org/mailman/listinfo/xenomai

