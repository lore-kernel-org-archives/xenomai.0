Message-ID: <44883438.1090709@domain.hid>
Date: Thu, 08 Jun 2006 16:29:12 +0200
From: Nicola Pace <nicola@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] rt_receive / rt_reply
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

After an rt_receive, is it possible to defer the rt_reply to a later 
time and in the meantime to do other rt_receive ? In other words, is the 
following sequence right ?

rt_receive
  ... something received from Task A
rt_receive
  ... something received from Task B
rt_receive
  ... something received from Task C
      reply to Task A
      reply to Task C
    .
    .
    .. and so on  .

Regards
 

-- 
*Ing. Nicola Pace *
Technical Department
*

TDEMACNO Spa (VICENZA)

* <http://www.tdemacno.it> tel: 0444 343555
fax: 0444 343509
mail: nicola@domain.hid
Skype:
*
Riservatezza / Confidentiality*/
In ottemperanza al D.L. n. 196 del 30/6/2003 in materia di protezione 
dei dati personali, le informazioni contenute in questo messaggio sono 
strettamente riservate ed esclusivamente indirizzate al destinatario 
indicato (oppure alla persona responsabile di rimetterlo al 
destinatario). Vogliate tener presente che qualsiasi uso, riproduzione o 
divulgazione di questo messaggio e' vietata. Nel caso in cui aveste 
ricevuto questa mail/fax per errore, vogliate cortesemente avvertire il 
mittente e distruggere il presente messaggio.
Accordingly to italian law D.L. 196/2003 concerning privacy, if you are 
not the adressee (or responsible for delivery of the message to such 
person) you are hereby notified that any disclosure, reproduction, 
distribution or other dissemination or use of this communication is 
strictly prohibited. If you have received this message in error, you 
should destroy it and please notify us by email. /

