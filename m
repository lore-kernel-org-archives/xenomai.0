References: <5a8c1128.0721240a.9bf50.bc31@mx.google.com>
From: alessio margan <alessio.margan@iit.it>
Message-ID: <6a753ece-74f3-4236-3172-057eb6862a0d@iit.it>
Date: Tue, 20 Feb 2018 15:14:18 +0100
MIME-Version: 1.0
In-Reply-To: <5a8c1128.0721240a.9bf50.bc31@mx.google.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Subject: Re: [Xenomai] [was Nvidia TX1/TX2 Boards] rpi rtnet
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Greg Gallagher <greg@embeddedgreg.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi,


On 20/02/2018 13:14, Greg Gallagher wrote:
> Hi,
>     The RPI images I've been working on are close to being ready to share. I have a couple bcm2835 issues I'm working through. I haven't made my way to the RTNET drivers yet. Are you looking to evaluate RTNET on an arm based board?
yes
we use xenomai3+rtnet for our robotics platform based on ethercat (raw 
socket, no tcp/udp ) but for some application we use also tcp and udp.
At the moment we use COM-express form factor boards with x86_64 arch 
with intel network chip that works with fine with rtnet.

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


