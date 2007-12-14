Date: Fri, 14 Dec 2007 19:44:12 +0000 (GMT)
From: Michael Trimarchi <trimarchimichael@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1787781866-1197661452=:28041"
Message-ID: <410198.28041.qm@domain.hid>
Subject: Re: [Adeos-main] at91sam9260
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: adeos-main@gna.org

--0-1787781866-1197661452=:28041
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

=0AHi,=0A=0A+#define PICK_SPINUNLOCK_IRQ_RAW(lock)                         =
 \=0A+do {                                                                 =
  \=0A+       if (TYPE_EQUAL((lock), __ipipe_spinlock_t)) {                =
   \=0A+               __ipipe_spin_lock_irq(&((__ipipe_spinlock_t *)(lock)=
)->__raw_lock); \=0A+       } else if (TYPE_EQUAL(lock, spinlock_t))       =
                 \=0A+               __raw_spin_unlock(&((spinlock_t *)(loc=
k))->raw_lock);   \=0A+               local_irq_enable();                  =
                   \=0A+} while (0)=0A=0AWho can me explain this in the off=
icial adeos-ipipe-2.6.20-arm-1.7-06.patch ?=0AI don't understand=0A=0ARegar=
ds Michael=0A=0A=0A=0A=0A=0A      ___________________________________ =0AL'=
email della prossima generazione? Puoi averla con la nuova Yahoo! Mail: =0A=
http://it.docs.yahoo.com/nowyoucan.html
--0-1787781866-1197661452=:28041
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><head><style type=3D"text/css"><!-- DIV {margin:0px;} --></style></he=
ad><body><div style=3D"font-family:times new roman, new york, times, serif;=
font-size:10pt"><div style=3D"font-family: times new roman,new york,times,s=
erif; font-size: 10pt;"><br>Hi,<br><br>+#define PICK_SPINUNLOCK_IRQ_RAW(loc=
k)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; \<br>+do {&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; if (TYPE_EQUAL((lock), __ipipe_spinlock_t))
 {&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __ipipe_spin_lock_irq(&=
amp;((__ipipe_spinlock_t *)(lock))-&gt;__raw_lock); \<br>+&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; } else if (TYPE_EQUAL(lock, spinlock_t))&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>+&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __raw_spin=
_unlock(&amp;((spinlock_t *)(lock))-&gt;raw_lock);&nbsp;&nbsp; \<br>+&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;
 local_irq_enable();&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; \<br>+} while (0)<br><br>Who can me explain this in the officia=
l adeos-ipipe-2.6.20-arm-1.7-06.patch ?<br>I don't understand<br><br>Regard=
s Michael<br><br></div></div><br>=0A=0A=0A      <hr size=3D1><font face=3D"=
Arial" size=3D"2">L'email della prossima generazione? Puoi averla con la <a=
 href=3D"http://us.rd.yahoo.com/mail/it/taglines/gmail/nowyoucan/nextgen/*h=
ttp://it.docs.yahoo.com/nowyoucan.html">Nuova Yahoo! Mail</a></font></body>=
</html>
--0-1787781866-1197661452=:28041--

