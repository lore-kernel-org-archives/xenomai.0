Message-ID: <45D30687.1090201@domain.hid>
Date: Wed, 14 Feb 2007 13:54:31 +0100
From: Markus Franke <Markus.Franke@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] CONFIG_PREEMPT & irqbench
References: <45D25145.3000407@domain.hid>	
	<45D2CE27.5040303@domain.hid>
	<45D2DD6E.5030800@domain.hid>	
	<45D2E468.3080402@domain.hid>
	<45D2E86C.2010200@domain.hid>
	<b647ffbd0702140410r14617bdbt58f60cd9049c52af@domain.hid>
In-Reply-To: <b647ffbd0702140410r14617bdbt58f60cd9049c52af@domain.hid>
Content-Type: multipart/mixed; boundary="------------050202030101070303090606"
Reply-To: Markus.Franke@domain.hid
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

This is a multi-part message in MIME format.
--------------050202030101070303090606
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Dmitry Adamushko wrote:
> On 14/02/07, Markus Franke <Markus.Franke@domain.hid> wrote:
> 
>> Jan Kiszka wrote:
>> > Of course, irqloop runs in *primary* mode to be able to handle the
>> > events deterministically. So it is not directly affected by
>> CONFIG_PREEMPT.
>>
>> If I start irqloop in User-Mode, a thread is simply created via Linux
>> system call pthread_create() which interacts with the
>> xeno_irqbench-driver via ioctl(). But then I don't understand why
>> irqloop is running in Primary (Xenomai) Mode? Because of the interaction
>> with the RTDM-based driver?
>> I am just wondering because I can't see something like rt_task_create().
> 
> 
> There is life beyond the native skin. e.g. the posix one.

Thank you very much for this hint. :-)
Now I got it.

> After all, Xenomai is all about skins (layers implementing various RT
> API interfaces).
> 
> So pthread_create() as well as ioctl() you may see in irqloop are
> implemented ("shadowed") by the posix skin.

Actually I should know this.

Regards,
Markus


--------------050202030101070303090606
Content-Type: text/x-vcard; charset=utf-8;
 name="Markus.Franke.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="Markus.Franke.vcf"

begin:vcard
fn:Markus Franke
n:Franke;Markus
adr;quoted-printable:;;Vettersstra=C3=9Fe 64/722;Chemnitz;Saxony;09126;Germany
email;internet:Markus.Franke@domain.hid
x-mozilla-html:FALSE
url:http://www.tu-chemnitz.de/~franm
version:2.1
end:vcard


--------------050202030101070303090606--

