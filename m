From: Carsten EHRMANN <Carsten.Ehrmann@diehl.com>
Subject: Migrate project from Debian 8 Xenomai 2.x to Debain 9 Xenomai 3.x
Date: Mon, 10 Feb 2020 12:03:32 +0000
Message-ID: <23edaf750b0b41ef9a129bbaf2758d9f@RCDC-MAIL09.corp.diehl.com>
Content-Language: de-DE
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hello,


Because of new PC hardware I have to use debain 9 and Xenomai 3. Xenomai =
is running on the system, I run the testsuite scripts. I found a migratio=
n document on xenomai.org and changed the includepaths and so on in my so=
urcecode. But now when I want to compile the code I got this error
In file included from ./CSRTPosixQue.h:20:0,
             from ./CSRTTask.h:20,
             from main.cpp:26:
/usr/xenomai/include/trank/native/task.h: In function =27int rt_task_noti=
fy(RT_TASK*, rt_sigset_t)=27:
/usr/xenomai/include/trank/native/task.h:41:64: error: =27trank_warning=
=27 was not declared in this scope
trank_warning(=22in-kernel native API is gone, rebase over RTDM=22);

But this =22trank_warning=22 is defined in trank.h which is included


Mit freundlichen Gr=FC=DFen / Best regards
Carsten Ehrmann
T-S092 Industrial Engineering / Test Engineering & Software

Diehl Metering
Industriestr. 13
91522 Ansbach
Germany

Phone: +49 981 1806-252
E-Mail: carsten.ehrmann@diehl.com<mailto:carsten.ehrmann@diehl.com>
Web: www.diehl.com/metering<../../../../../metzan/AppData/Local/Temp/note=
sE05E9E/www.diehl.com/metering>



_________________________________________________________________________=
________________________________
Bitte =FCberlegen Sie, ob Sie diese Nachricht wirklich ausdrucken m=FCsse=
n/ before printing, think about environmental responsibility.
Diehl Metering GmbH, Industriestra=DFe 13, 91522 Ansbach
Telefon + 49 981 1806 0, Telefax +49 981 1806 615
Sitz der Gesellschaft: Ansbach, Registergericht: Ansbach HRB 69
Gesch=E4ftsf=FChrer: Dr. Christof Bosbach (Sprecher), Thomas Gastner, Jea=
n-Fran=E7ois Marguet
Der Inhalt der vorstehenden E-Mail ist nicht rechtlich bindend. Diese E-M=
ail enth=E4lt vertrauliche und/oder rechtlich gesch=FCtzte Informationen.=
 Informieren Sie uns bitte, wenn Sie diese E-Mail f=E4lschlicherweise erh=
alten haben. Bitte l=F6schen Sie in diesem Fall die Nachricht. Jede unerl=
aubte Form der Reproduktion, Bekanntgabe, =C4nderung, Verteilung und/oder=
 Publikation dieser E-Mail ist strengstens untersagt.
The contents of the above mentioned e-mail is not legally binding. This e=
-mail contains confidential and/or legally protected information. Please =
inform us if you have received this e-mail by mistake and delete it in su=
ch a case. Each unauthorized reproduction, disclosure, alteration, distri=
bution and/or publication of this e-mail is strictly prohibited.
Informationen zum Datenschutz finden Sie auf unserer Homepage.
https://www.diehl.com/metering/de/diehl-metering/data-protection
Information about data protection can be found on our homepage.
https://www.diehl.com/metering/en/diehl-metering/data-protection
