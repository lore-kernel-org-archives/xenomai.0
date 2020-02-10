Date: Mon, 10 Feb 2020 22:21:39 +0100
From: Henning Schild <henning.schild@siemens.com>
Subject: Re: Migrate project from Debian 8 Xenomai 2.x to Debain 9 Xenomai 3.x
Message-ID: <20200210222139.1cead1a2@md1za8fc.ad001.siemens.net>
In-Reply-To: <23edaf750b0b41ef9a129bbaf2758d9f@RCDC-MAIL09.corp.diehl.com>
References: <23edaf750b0b41ef9a129bbaf2758d9f@RCDC-MAIL09.corp.diehl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Carsten EHRMANN via Xenomai <xenomai@xenomai.org>
Cc: Carsten EHRMANN <Carsten.Ehrmann@diehl.com>

Hi,

coming from xenomai 2.x and debian8 i would advice to skip debian9 and
go for debian10 right away. You will probably face the same issues and
possibly more, but why go for oldstable if you invest today?
Depending on your timeline you might even want to look at debian11.
There is no ipipe-5.4.y yet but you can assume that this version will
be supported eventually. In the meantime you could try debian11 with
4.19.

regards,
Henning

On Mon, 10 Feb 2020 12:03:32 +0000
Carsten EHRMANN via Xenomai <xenomai@xenomai.org> wrote:

> Hello,
>=20
>=20
> Because of new PC hardware I have to use debain 9 and Xenomai 3.
> Xenomai is running on the system, I run the testsuite scripts. I
> found a migration document on xenomai.org and changed the
> includepaths and so on in my sourcecode. But now when I want to
> compile the code I got this error In file included from
> ./CSRTPosixQue.h:20:0, from ./CSRTTask.h:20, from main.cpp:26:
> /usr/xenomai/include/trank/native/task.h: In function 'int
> rt_task_notify(RT_TASK*, rt_sigset_t)':
> /usr/xenomai/include/trank/native/task.h:41:64: error:
> 'trank_warning' was not declared in this scope
> trank_warning("in-kernel native API is gone, rebase over RTDM");
>=20
> But this "trank_warning" is defined in trank.h which is included
>=20
>=20
> Mit freundlichen Gr=C3=BC=C3=9Fen / Best regards
> Carsten Ehrmann
> T-S092 Industrial Engineering / Test Engineering & Software
>=20
> Diehl Metering
> Industriestr. 13
> 91522 Ansbach
> Germany
>=20
> Phone: +49 981 1806-252
> E-Mail: carsten.ehrmann@diehl.com<mailto:carsten.ehrmann@diehl.com>
> Web:
> www.diehl.com/metering<../../../../../metzan/AppData/Local/Temp/notesE05E=
9E/www.diehl.com/metering>
>=20
>=20
>=20
> _________________________________________________________________________=
________________________________
> Bitte =C3=BCberlegen Sie, ob Sie diese Nachricht wirklich ausdrucken
> m=C3=BCssen/ before printing, think about environmental responsibility.
> Diehl Metering GmbH, Industriestra=C3=9Fe 13, 91522 Ansbach Telefon + 49
> 981 1806 0, Telefax +49 981 1806 615 Sitz der Gesellschaft: Ansbach,
> Registergericht: Ansbach HRB 69 Gesch=C3=A4ftsf=C3=BChrer: Dr. Christof B=
osbach
> (Sprecher), Thomas Gastner, Jean-Fran=C3=A7ois Marguet Der Inhalt der
> vorstehenden E-Mail ist nicht rechtlich bindend. Diese E-Mail enth=C3=A4lt
> vertrauliche und/oder rechtlich gesch=C3=BCtzte Informationen. Informieren
> Sie uns bitte, wenn Sie diese E-Mail f=C3=A4lschlicherweise erhalten
> haben. Bitte l=C3=B6schen Sie in diesem Fall die Nachricht. Jede
> unerlaubte Form der Reproduktion, Bekanntgabe, =C3=84nderung, Verteilung
> und/oder Publikation dieser E-Mail ist strengstens untersagt. The
> contents of the above mentioned e-mail is not legally binding. This
> e-mail contains confidential and/or legally protected information.
> Please inform us if you have received this e-mail by mistake and
> delete it in such a case. Each unauthorized reproduction, disclosure,
> alteration, distribution and/or publication of this e-mail is
> strictly prohibited. Informationen zum Datenschutz finden Sie auf
> unserer Homepage.
> https://www.diehl.com/metering/de/diehl-metering/data-protection
> Information about data protection can be found on our homepage.
> https://www.diehl.com/metering/en/diehl-metering/data-protection


