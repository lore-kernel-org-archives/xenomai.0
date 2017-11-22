References: <a3111b21e04e43bea8ddcd531f698074@ocnapvsw3301.ocr.priv>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <395d4699-e04a-c026-861d-b9866b13bb57@xenomai.org>
Date: Wed, 22 Nov 2017 17:54:28 +0100
MIME-Version: 1.0
In-Reply-To: <a3111b21e04e43bea8ddcd531f698074@ocnapvsw3301.ocr.priv>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] Updating from 3.0.5 to 3.0.6
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Fazio Maurizio <maurizio.fazio@leonardocompany.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 11/22/2017 09:42 AM, Fazio Maurizio wrote:
> I have a stupid question…

no prob. I'm still looking for smart answers.

> I would like to upgrade my current xenomai 3.0.5 based system to xenomai 3.0.6…
> I need to repatch the kernel with the prepare-kernel script or I can only rebuild and execute a make install?
> 

re-patching is always better, first to get the version stamp right, and
also in case kernel files have appeared/disappeared between versions
(although this does not frequently happen between close maintenance
releases).

> 
> Maurizio Fazio
> 
> Chief Technical Office / Aircraft Systems
> Software Engineer
> 
> 
> 
> Leonardo S.p.A.
> C.so Francia, 426 - Torino - 10146 - Italy
> Tel. +39 011 756 3308 / 3761
> cell. +39 328 3488070
> maurizio.fazio@leonardocompany.com
> www.leonardocompany.com
> 
> ————————————————————————————————–——————
> HELICOPTERS/AERONAUTICS/ELECTRONICS, DEFENCE & SECURITY SYSTEMS/SPACE
> ————————————————————————————————–——————
> 
> 
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
> 


-- 
Philippe.

