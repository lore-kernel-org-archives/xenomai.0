Message-ID: <50598097.8010005@iit.it>
Date: Wed, 19 Sep 2012 10:21:43 +0200
From: "Alessio Margan @ IIT" <alessio.margan@iit.it>
MIME-Version: 1.0
References: <5053404B.9000006@iit.it> <50537A5F.5030301@xenomai.org>
	<5058D81A.9070305@xenomai.org>
In-Reply-To: <5058D81A.9070305@xenomai.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] segfault using rt_printf service
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
Cc: xenomai <xenomai@xenomai.org>

On 09/18/2012 10:22 PM, Gilles Chanteperdrix wrote:
> On 09/14/2012 08:41 PM, Gilles Chanteperdrix wrote:
>
>> On 09/14/2012 04:33 PM, Alessio Margan @ IIT wrote:
>>
>>> Hi all,
>>>
>>> I'm switching from xenomai 2.5.6 to 2.6.1 using
>>> adeos-ipipe-2.6.38.8-x86-2.11-01.patch
>>> In this test I have 2 threads :
>>> - rx_udp receive udp packets from dsp boards at 1kHz
>>> - boards_test send udp packets at 1kHz
>>>
>>> I got segfault in printer_loop thread, the point is that if I change env
>>> var RT_PRINT_PERIOD to about 10 or 1000 (default is 100 ms) I do not
>>> have segfault.
>>>
>>> Any suggestion ?
>>
>> Could you try the following patch?
>>
>> diff --git a/src/skins/common/rt_print.c b/src/skins/common/rt_print.c
>> index a9fce78..376330b 100644
>> --- a/src/skins/common/rt_print.c
>> +++ b/src/skins/common/rt_print.c
>> @@ -163,9 +163,9 @@ static int vprint_to_buffer(FILE *stream, int priority, unsigned int mode,
>>   	if (mode == RT_PRINT_MODE_FORMAT) {
>>   		if (stream != RT_PRINT_SYSLOG_STREAM) {
>>   			/* We do not need the terminating \0 */
>> -			res = vsnprintf(head->data, len + 1, format, args);
>> +			res = vsnprintf(head->data, len, format, args);
>>
>> -			if (res<  len + 1) {
>> +			if (res<  len) {
>>   				/* Text was written completely, res contains its
>>   				   length */
>>   				len = res;
>>
>>
>
> ping ?
>
Hi,
thanks for the patch !
since now seems to work ... I just let the systems run; without the 
patch after few seconds It crashes.

Regards
Alessio

-- 

ISTITUTO ITALIANO
DI TECNOLOGIA

Alessio Margan
/Senior Technician/
/Advanced Robotics/

Via Morego, 30 16163 Genova 
<http://maps.google.com/maps?f=q&hl=en&geocode=&q=via+morego,+30+genova&sll=37.0625,-95.677068&sspn=85.420533,191.601563&ie=UTF8&ll=44.474913,8.907037&spn=0.004685,0.011652&t=h&z=17&iwloc=addr>
alessio.margan[at]iit <mailto:alessio.margan@iit.it>

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

