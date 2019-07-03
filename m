Subject: Re: fail clocktest -C CLOCK_HOST_REALTIME
References: <fa7df77f-23f9-4cc2-cc2e-aa1f9d4010bc@iit.it>
 <b2696236-4ba3-c9b0-a22f-9210f83cd163@siemens.com>
 <bdab9339-22bb-1da3-8453-e79bfeb204b2@iit.it>
 <611371d4-437c-b269-e8e6-4081174b247b@siemens.com>
From: alessio margan <alessio.margan@iit.it>
Message-ID: <160cc29c-d596-33bd-a7c1-b7a785f5800a@iit.it>
Date: Wed, 3 Jul 2019 20:42:35 +0200
MIME-Version: 1.0
In-Reply-To: <611371d4-437c-b269-e8e6-4081174b247b@siemens.com>
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
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi,

ok, it is also fine for me.

Alessio

On 03/07/19 20:27, Jan Kiszka wrote:
> On 03.07.19 20:22, alessio margan via Xenomai wrote:
>> Hi,
>>
>> now I have the proper config
>>
>> (base) embedded@com-exp:/usr/src/linux-4.14.89-xeno-stable-v3.0.x$ 
>> cat .config | grep HOSTRT
>> CONFIG_XENO_OPT_HOSTRT=y
>> CONFIG_IPIPE_HAVE_HOSTRT=y
>>
>> .. it 's compiling, I let you know
>
> My own test already succeed. Waiting for your ok, then I'll role out 
> 4.14.132 with this fixed. And 4.19.57 as well.
>
> Jan
>
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


