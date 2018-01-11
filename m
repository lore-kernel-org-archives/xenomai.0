References: <0e3bd82f06324467932a33ca3ffe4085@ocnapvsw3301.ocr.priv>
From: "Simone M. Zucchi" <simone.zucchi@utpvision.it>
Message-ID: <ffea3d58-bdb2-cc1b-d3d5-35e8a614477c@utpvision.it>
Date: Thu, 11 Jan 2018 17:16:37 +0100
MIME-Version: 1.0
In-Reply-To: <0e3bd82f06324467932a33ca3ffe4085@ocnapvsw3301.ocr.priv>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] Xenomai 3.0.6 high latency
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

I've had the same behaviour (far worst actually). I found out it was 
GNOME power savings plugin.
It seems that when monitor goes into standby latency get bricked.
I resolved by disabling the power saving plugin for all the users 
manually through dconf-editor:

dconf-editor => gnome.settings-daemon.plugins.power => active false

This should be suffice, but I usually disable everything else too:

#ambient-enabled false
#idle-brightness MIN
#idle-dim false
#power-button-action nothing
#priority MIN
#sleep-inactive-ac-timeout 0
#sleep-inactive-ac-type nothing
#sleep-inactive-battery-timeout 0
#sleep-inactive-battery-type nothing

Give that a try. The monitor will shut anyway (blank screen) but won't 
power saves though.

Simone

On 01/11/2018 04:37 PM, Fazio Maurizio wrote:
> Hello, I just installed xenomai 3.0.6 in a 3.18.20 patched kernel.
> The operating system is x86_64 Centos 7 .
>
> I executed the latency test and after about 15 minutes, the  result shows that the worst latency time is 148.570 us...
>
> Before this test I executed the autotune application with default options. As result the  /proc/xenomai/clock/coreclk is configured as follow:
>
> gravity: irq=0 kernel=999 user=499
> devices: timer=lapic, clock=tsc
>   status: on
>    setup: 113
>    ticks: 17651229689992 (100d bf468888)
>
> Have you some advices?
>
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
> ————————————————————————————————–——————
> HELICOPTERS/AERONAUTICS/ELECTRONICS, DEFENCE & SECURITY SYSTEMS/SPACE ————————————————————————————————–——————
>
>
>
>
>
> Company General Use
>
> Il presente messaggio e-mail e ogni suo allegato devono intendersi indirizzati esclusivamente al destinatario indicato e considerarsi dal contenuto strettamente riservato e confidenziale. Se non siete l'effettivo destinatario o avete ricevuto il messaggio e-mail per errore, siete pregati di avvertire immediatamente il mittente e di cancellare il suddetto messaggio e ogni suo allegato dal vostro sistema informatico. Qualsiasi utilizzo, diffusione, copia o archiviazione del presente messaggio da parte di chi non ne è il destinatario è strettamente proibito e può dar luogo a responsabilità di carattere civile e penale punibili ai sensi di legge.
> Questa e-mail ha valore legale solo se firmata digitalmente ai sensi della normativa vigente.
>
> The contents of this email message and any attachments are intended solely for the addressee(s) and contain confidential and/or privileged information.
> If you are not the intended recipient of this message, or if this message has been addressed to you in error, please immediately notify the sender and then delete this message and any attachments from your system. If you are not the intended recipient, you are hereby notified that any use, dissemination, copying, or storage of this message or its attachments is strictly prohibited. Unauthorized disclosure and/or use of information contained in this email message may result in civil and criminal liability. “
> This e-mail has legal value according to the applicable laws only if it is digitally signed by the sender
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> https://xenomai.org/mailman/listinfo/xenomai

