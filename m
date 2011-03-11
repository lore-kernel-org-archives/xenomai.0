Message-ID: <4D79F29B.6020207@domain.hid>
Date: Fri, 11 Mar 2011 10:59:55 +0100
From: Johann Obermayr <johann.obermayr@domain.hid>
MIME-Version: 1.0
References: <4D79DD32.4050307@domain.hid> <4D79E28B.3090004@domain.hid>
	<4D79E43D.2040807@domain.hid>
In-Reply-To: <4D79E43D.2040807@domain.hid>
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] rt_task_delete trouble
Reply-To: johann.obermayr@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: jan.kiszka@domain.hid
Cc: xenomai@xenomai.org

Am 11.03.2011 09:58, schrieb Jan Kiszka:
> On 2011-03-11 09:51, Gilles Chanteperdrix wrote:
>> Johann Obermayr wrote:
>>> void task_waiter_do(void *data)
>>> {
>>>       rt_printf("task_waiter_do started\n");
>>>       while(task_waiter_flag =3D=3D 0)
>>>           ; // rt_task_sleep( DELAYMS(1) );
>>>       rt_printf("task_waiter_do finished\n");
>>> }
>> What happens if you uncomment the rt_task_sleep here ?
>>
> Given how often users make this mistake, should we enable the watchdog
> by default?
>
> Jan
>
We have a watchdog, and your watchdod-task suspend the user-task=20
(task_waiter_do).
the sample show this problem.
The task_worker_do is a watchdog. he control some other 'user-task'.
In your project, the watchdog startup the watchdog-task.
the task_worker_do suspend the user-task.
the task_worker_do will delete the user-task.

if the user-task have only while(1); than the machine will hang.
if the user-task have in the while a sleep or other function,
the task_worker_do can delete the task_waiter, and all work correct.

   Jimmy

--=20
Mit freundlichen Gr=FC=DFen, best regards
     Johann Obermayr

Software Entwicklung
________________________________________________
SIGMATEK GmbH&  Co KG
Sigmatekstra=DFe 1
5112 Lamprechtshausen
=D6sterreich / Austria

Tel.  :  +43 / 6274/ 43 21-0   (Durchwahl leider nicht m=F6glich)
Fax   :  +43 / 6274/ 43 21-18  (bzw 300 im Werk 2 )
E-Mail: johann.obermayr@domain.hid
http://www.sigmatek-automation.com
****************************Please note:********************************
  This email and all attachments are confidential and intended solely for
  the person or entity to whom it is addressed. If you are not the named
  addressee you must not make this email and all attachments accessible
  to any other person. If you have received this email in error please
  delete it together with all attachments.
************************************************************************


