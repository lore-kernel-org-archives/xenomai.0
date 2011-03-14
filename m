Message-ID: <4D7E81D3.5030008@domain.hid>
Date: Mon, 14 Mar 2011 22:00:03 +0100
From: Johann Obermayr <johann.obermayr@domain.hid>
MIME-Version: 1.0
References: <4D7DF910.5000706@domain.hid> <1300108652.2105.11.camel@domain.hid>
In-Reply-To: <1300108652.2105.11.camel@domain.hid>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai-help] xnshadow_call_mayday no signal_handler call
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
To: rpm@xenomai.org
Cc: xenomai@xenomai.org

Am 14.03.2011 14:17, schrieb Philippe Gerum:
> On Mon, 2011-03-14 at 12:16 +0100, Johann Obermayr wrote:
>> Hello,
>>
>> if i call xnshadow_call_mayday for a realtime task with prio=0, the
>> signal_handler
>> is not called.
> It does not make sense to call it for such thread. Besides,
> xnshadow_call_mayday() is an internal interface, with strict calling
> context requirements, so you are not supposed to use it at all.
>
We have a high priority watchdog task.
This task stop some other without domain switch.
But i can't stop a rt-task (prio=0).


>> Xenomai 2.5.6, linux kernel 2.6.32.15. gcc 4.3.3


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


