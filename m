From: <ajohn@post.cz>
Subject: Migration from Xenomai v2 to v3  w/ Mercury kernel possible ?
Date: Thu, 30 May 2019 02:03:00 +0200 (CEST)
Message-Id: <jPR.3teSK.63VQ6z6W8Et.1Sxnsq@seznam.cz>
Mime-Version: 1.0 (szn-mime-2.0.43)
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org


Hi,




I am going to migrate older Xenomai v2 application to Xenomai v3.




While still learning all the impressive improvements of Xenomai v3, I 
struggle to figure out if it would be possible to migrate Xenomai v2 
application (x86-64, native skin, + few RTDM drivers) to be executable on =

both the Mercury and Cobalt kernels keeping the same app's source code. =





I am thinking about having the Mercury variant for non real-time dev&
debbuging on common distribution kernel while the Cobalt version would run=
 
on dedicated hardware with patched/tuned kernel.




I wonder if old style Xenomai v2 RTDM drivers and "native" application may=
 
compile and run with Mercury after some adaptations.



I learned the Cobalt base environment with v2 "native" compatibility 
requires something like

configure --core=3Dcobalt

and compilation w/ xeno-config =E2=80=93native

That seems to be viable migration path.





But for Mercury - which xeno-config settings to use for user space app and=
 
for RTDM driver/module when neither --native nor --rtdm nor =E2=80=93compa=
t switches
are applicable ?




Loking at web resources like=C2=A0https://xenomai.org/documentation/xenoma=
i-3/
html/MIGRATION/(https://xenomai.org/documentation/xenomai-3/html/MIGRATION=
/)
 but no luck so far.




Thanks for any hint.

Robie
