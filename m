Message-ID: <459B8382.7060508@domain.hid>
Date: Wed, 03 Jan 2007 11:20:50 +0100
From: Markus Franke <Markus.Franke@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] parallelport module for measuring external
	interrupt latency
References: <459B6DAD.4030406@domain.hid>
	<459B7C6C.9030401@domain.hid>
In-Reply-To: <459B7C6C.9030401@domain.hid>
Content-Type: multipart/mixed; boundary="------------090604050400010209060106"
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
--------------090604050400010209060106
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Jan Kiszka wrote:
>>// ISR
>>int parport_isr(xnintr_t* cookie)
>>{
>>	rdtsc(t_end);
>>	
>>	outb(0x00,SPPDATAPORT);
>>	
>>#ifdef DEBUG
>>	printk(KERN_INFO "parport_latency: Interrupt fired!!!\n");
>>	printk(KERN_INFO "parport_latency: interruptcount before = %d!!!\n",atomic_read(&interruptcount));
>>#endif
>>	
>>	atomic_inc(&interruptcount);
>>
>>#ifdef DEBUG
>>	printk(KERN_INFO "parport_latency: interruptcount after= %d!!!\n",atomic_read(&interruptcount));
>>#endif
>>
>>	wake_up_interruptible(&intlatpar_queue);
> 
> 
> This is a hard-RT IRQ handler, thus any scheduling Linux service is
> strictly forbidden.
> 
> [Reminds me of the I-pipe debugging service that can catch such faults
> but still needs some integration work...]

Ok I understand. But somehow I have to notify the read()-call that it
can compute the latency value. Do you have any suggestions how to do that?

>>	if(register_chrdev(INTLAT_DEV_MAJOR,INTLAT_DEV_NAME,&intlat_fops) < 0) 
>>	{
>>		printk(KERN_WARNING "intlat: parport_latency(): register_chrdev() failed.\n");
>>		rt_intr_disable(&intr);
>>		return -1;
>>	}
> 
> 
> Hmm, a Linux character device for this purpose... I guess you should
> study the existing irqbench test a bit first. And if you don't see why
> something is done the way it is - ask here.

Yes of course I have already studied the irqbench test but it uses the
RTDM skin. I also know that this skin should be used for developing hard
realtime drivers. But I just need to measure latencies and I don't want
to develop a huge realtime driver. I just need some values for
comparison with the driver working on plain linux. I was wondering
whether it is possible to rewrite the driver working on plain linux by
using the Xenomai native API.
Why isn't it possible to use a Linux character device. I just want to
transfer the latency values to the user space task which is out of any
realtime context I think.

Thanks in advance,

Markus Franke

--------------090604050400010209060106
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


--------------090604050400010209060106--

