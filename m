From: alessio margan <alessio.margan@iit.it>
Subject: open XDDP from nrt thread
Message-ID: <fea9dfd7-d28e-da96-f230-2a585da5cc84@iit.it>
Date: Wed, 2 Oct 2019 10:08:20 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi all,

it seems that at some point ( following branch next up to rc1) something 
is changed regarding XDDP .

I've got a process that spawn 2 rt-thread and a nrt-thread, one of the 
2rt  produce data that the nrt consume using an XDDP

Since 4.14.89-xeno-ipipe-stableVx everything works, now on rc1 I can not 
open the pipes as usual.

There is something I have missed ?

These are the pipes

ls -la /proc/xenomai/registry/rtipc/xddp/
total 0
dr-xr-xr-x 2 root root 0 ott  2 09:06 .
dr-xr-xr-x 3 root root 0 ott  2 09:06 ..
lrwxrwxrwx 1 root root 9 ott  2 09:06 debugOut -> /dev/rtp3
lrwxrwxrwx 1 root root 9 ott  2 09:06 emergency -> /dev/rtp0
lrwxrwxrwx 1 root root 9 ott  2 09:06 NoNe@Motor_id_1 -> /dev/rtp4
lrwxrwxrwx 1 root root 9 ott  2 09:06 repl_in -> /dev/rtp1
lrwxrwxrwx 1 root root 9 ott  2 09:06 repl_out -> /dev/rtp2

TIA

Alessio

-- 

ISTITUTO ITALIANO DI TECNOLOGIA

Alessio Margan
Chief Technician
Advanced Robotics Department

alessio.margan@iit.it
Via Morego 30, 16163 Genova
Tel. +39 010 71781-754

www.iit.it

Legal Disclaimer
This electronic message contains information that is confidential. The information is intended for the use of the addressee only.
If you are not the addressee we would appreciate your notification in this respect.
Please note that any disclosure, copy, distribution or use of the contents of this message is prohibited and may be unlawful.
We have taken every reasonable precaution to ensure that any kind of attachment to this e-mail has been swept for viruses.
However, we cannot accept liability for any damage sustained as a result of software viruses
and would advise you to carry out your own virus checks before opening any attachment.
Avvertenza legale
Questo messaggio Email contiene informazioni confidenziali riservate ai soli destinatari.
Qualora  veniate in possesso di tali informazioni senza essere definito come destinatario vi reghiamo di leggere le seguenti note.
Ogni apertura, copia, distribuzione del contenuto del messaggio e dei suoi allegati è proibito e potrebbe violare le presenti leggi.
Abbiamo attivato ogni possibile e ragionevole precauzione per assicurare che gli allegati non contengano virus.
Comunque non assumeremo alcuna responsabilità per ogni eventuale danno causato da virus software e simili
in quanto è onere del destinatario verificarne l’assenza in ogni allegato attuando propri indipendenti controlli.


