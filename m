References: <1400788012.41259.YahooMailNeo@web171603.mail.ir2.yahoo.com>
 <1401734780.6508.YahooMailNeo@web171606.mail.ir2.yahoo.com>
 <53A3E8FE.5020005@xenomai.org>
 <1403519510.94410.YahooMailNeo@web171601.mail.ir2.yahoo.com>
 <1403555262.58217.YahooMailNeo@web171601.mail.ir2.yahoo.com>
 <1404233289.69461.YahooMailNeo@web171605.mail.ir2.yahoo.com>
 <53BCF270.3010303@xenomai.org>
Message-ID: <1405365539.41980.YahooMailNeo@web171603.mail.ir2.yahoo.com>
Date: Mon, 14 Jul 2014 20:18:59 +0100
From: Matthias Schneider <ma30002000@yahoo.de>
In-Reply-To: <53BCF270.3010303@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] FreeRTOS skin #2
Reply-To: Matthias Schneider <ma30002000@yahoo.de>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, "xenomai@xenomai.org" <xenomai@xenomai.org>

=0A=0A=0A=0A----- Original Message -----=0A> From: Philippe Gerum <rpm@xeno=
mai.org>=0A> To: Matthias Schneider <ma30002000@yahoo.de>; "xenomai@xenomai=
.org" <xenomai@xenomai.org>=0A> Cc: =0A> Sent: Wednesday, July 9, 2014 9:42=
 AM=0A> Subject: Re: [Xenomai] FreeRTOS skin #2=0A> =0A> On 07/01/2014 06:4=
8 PM, Matthias Schneider wrote:=0A>>  Please find enclosed another calling =
the check_processors() only when =0A> starting=0A>>  the scheduler and reme=
mbering its output. It is also adapted to the latest =0A> changes.=0A>>  An=
y comments will be appreciated.=0A>> =0A> =0A> - clusters allowing key dups=
 are available using the *_dup() call form=0A> - vTaskEndScheduler() can be=
 simplified, and should not panic if it =0A> cannot lock a vanishing thread=
 pulled from the task list.=0A>=A0=0A> --=A0=0A=0A> Philippe.=0A>=0A=0AThe =
vTaskEndScheduler() patch unfortunately now leads to a frozen=0AvTaskStartS=
cheduler() function when shutting down in some tests.=0A=0AThis is probably=
 due to freertos_scheduler.tasklist_end_cond not being=0Atriggered when the=
 list gets empty in vTaskEndScheduler() ? also,=A0=0Afreertos_scheduler.num=
_tasks seems not to be decremented when removing=0Aelemets from the list vi=
a pvlist_pop_entry().=0A=0AEven when calling pthread_cond_signal() at the e=
nd of vTaskEndScheduler(),=0AI still get the freeze. Any idea?=0A

