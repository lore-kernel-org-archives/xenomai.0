Message-ID: <4B3B6957.4090901@domain.hid>
Date: Wed, 30 Dec 2009 15:53:11 +0100
From: "Alessio Margan @ IIT" <alessio.margan@domain.hid>
MIME-Version: 1.0
References: <729c4a400912260654vf4f99d1ta6105bdace1b4098@domain.hid>		<4B3917BF.5070600@domain.hid>	<729c4a400912281740g17ccf7bcn5d2fd7f63e08c2bd@domain.hid>
	<4B39BE8D.8060503@domain.hid>
In-Reply-To: <4B39BE8D.8060503@domain.hid>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Subject: [Xenomai-core]  [PATCH] Sensoray 526 analogy driver
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Xenomai-core@domain.hid

Hi,

I start test the sensoray driver.
I've got problem with analogy_config :
1) it seems that board_name as defined have some problem, changed to 
"a4l_s526" seems better

    #define BOARD_NAME "Sensoray Model 526"
    ...
    .board_name = BOARD_NAME
2) I should be able to set as parameters io_port and irq (seems not 
used), using comedi I do comedi_config  /dev/comedi0 s526 0xDC0,0x7
for the moment I set S526_DEFAULT_ADDRESS to my configuration

with this modifications seems to work.

analogy_config -v analogy0 a4l_s526

cat /proc/analogy/drivers
--  Analogy drivers --
| idx | driver name
|  00 | a4l_s526

cat /proc/analogy/devices
--  Analogy devices --
| idx | status | driver
|  00 | Linked | a4l_s526
|  01 | Unused | No driver
|  02 | Unused | No driver
|  03 | Unused | No driver
|  04 | Unused | No driver
|  05 | Unused | No driver
|  06 | Unused | No driver
|  07 | Unused | No driver
|  08 | Unused | No driver
|  09 | Unused | No driver

cat /proc/analogy/00-a4l_s526
--  Subdevices --
| idx | type
|  00 | Counter subdevice
|  01 | Analog input subdevice
|  02 | Analog output subdevice
|  03 | Digital input/output subdevice

Alessio

-- 

ISTITUTO ITALIANO
DI TECNOLOGIA

Alessio Margan
/Senior Technician/
mail me <mailto:alessio.margan@domain.hid>

Via Morego, 30 16163 Genova 
<http://maps.google.com/maps?f=q&hl=en&geocode=&q=via+morego,+30+genova&sll=37.0625,-95.677068&sspn=85.420533,191.601563&ie=UTF8&ll=44.474913,8.907037&spn=0.004685,0.011652&t=h&z=17&iwloc=addr>

www.iit.it <http://www.iit.it>

*Legal Disclaimer*
This electronic message contains information that is confidential. The 
information is intended for the use of the addressee only. If you are 
not the addressee we would appreciate your notification in this respect. 
Please note that any disclosure, copy, distribution or use of the 
contents of this message is prohibited and may be unlawful. We have 
taken every reasonable precaution to ensure that any kind of attachment 
to this e-mail has been swept for viruses. However, we cannot accept 
liability for any damage sustained as a result of software viruses and 
would advise you to carry out your own virus checks before opening any 
attachment.     
*Avvertenza legale*
Questo messaggio Email contiene informazioni confidenziali riservate ai 
soli destinatari. Qualora  veniate in possesso di tali informazioni 
senza essere definito come destinatario vi reghiamo di leggere le 
seguenti note. Ogni apertura, copia, distribuzione del contenuto del 
messaggio e dei suoi allegati è proibito e potrebbe violare le presenti 
leggi. Abbiamo attivato ogni possibile e ragionevole precauzione per 
assicurare che gli allegati non contengano virus. Comunque non 
assumeremo alcuna responsabilità per ogni eventuale danno causato da 
virus software e simili in quanto è onere del destinatario verificarne 
l’assenza in ogni allegato attuando propri indipendenti controlli.


