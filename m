Message-ID: <4D79F0ED.6080101@domain.hid>
Date: Fri, 11 Mar 2011 10:52:45 +0100
From: Johann Obermayr <johann.obermayr@domain.hid>
MIME-Version: 1.0
References: <4D79DD32.4050307@domain.hid> <4D79E28B.3090004@domain.hid>
In-Reply-To: <4D79E28B.3090004@domain.hid>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
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
To: gilles.chanteperdrix@xenomai.org
Cc: xenomai@xenomai.org

Am 11.03.2011 09:51, schrieb Gilles Chanteperdrix:
> Johann Obermayr wrote:
>> void task_waiter_do(void *data)
>> {
>>       rt_printf("task_waiter_do started\n");
>>       while(task_waiter_flag == 0)
>>           ; // rt_task_sleep( DELAYMS(1) );
>>       rt_printf("task_waiter_do finished\n");
>> }
> What happens if you uncomment the rt_task_sleep here ?
we have some shared code from another RT OS.
And in this code there are some while(hw_state) ;  loops.

> Could you please give us some more information:
> http://www.xenomai.org/index.php/Request_for_information
>
> Do you have priority coupling enabled?
Yes.


We use xenomai 2.5.5.2 and linux kernel 2.6.32.15. gcc 4.3.3

Here you have some more details.
a kernel module have a watchdog checker for some 'user-tasks'
if a 'user-task' have a while loop, than the kernel module will suspend
the user-task and call also the mayday function.

But on some other errorhandling, we have a high priortity watchdog task 
control the 'user'-tasks.
On error the watchdog task suspend all user-tasks. (this work correct)
Than the watchdog-task switch off the user-task watchdog.
Make errorhandling and some other function (dump user-task stack)
Than the watchdog task will delete some user-task.
But if a user-task is in a while loop, the system hangs.
in user mode we have no mayday function.
it's look like, that when watchdog-task call rt_task_delete(user_task) , 
the user_task continue running.
Is this so ?

    Thanks
       Jimmy

-- 
Mit freundlichen Grüßen, best regards
     Johann Obermayr

Software Entwicklung
________________________________________________
SIGMATEK GmbH&  Co KG
Sigmatekstraße 1
5112 Lamprechtshausen
Österreich / Austria

Tel.  :  +43 / 6274/ 43 21-0   (Durchwahl leider nicht möglich)
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


