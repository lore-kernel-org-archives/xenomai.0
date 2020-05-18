Subject: Re: R: About RTNet setup
References: <97020454f0464394b9128a7620d8d631@axelsw.it>
 <cf47f625-f978-6f19-6512-d8af176cb6c7@siemens.com>
 <f22c83fb4b1243358c3bea5cbeb06e11@axelsw.it>
 <51be0a78a78643a08fad60d41dcef953@axelsw.it>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <d23bceea-708f-92e1-5794-7cfe339feda9@siemens.com>
Date: Mon, 18 May 2020 12:43:37 +0200
MIME-Version: 1.0
In-Reply-To: <51be0a78a78643a08fad60d41dcef953@axelsw.it>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Marco Tessore <marco.tessore@axelsw.it>, "Xenomai@xenomai.org" <Xenomai@xenomai.org>

On 18.05.20 12:19, Marco Tessore wrote:
> Sorry Jan, just one more question:
> I've implemented a simple task that send a packet,
> and then receive a response.
> I know the response come back, on the network, in couple of useconds.
> But, from the send to the receive I measure 100 ms.
> You know why this delay:
> Is the send or the receive slow?
> You know there's some parameter to adjust?

Check if RX interrupts are coming for the NIC. After that RX IRQ, the 
RTnet stack manager is running. That's an in-kernel Xenomai thread. It 
will wake up your application blocking on a receive. You can follow that 
likely via an ftrace (e.g. kernelshark) recording of "cobalt" events.

Jan

> 
> Thank you
> Marco
> 
> 
> Marco Tessore
> 
> AXEL S.r.l.
> Via del Cannino, 3
> 21020 Crosio della Valle (VA) - ITALY
> Tel: +39 0332 949600
> Fax: +39 0332 969315
> E-mail: marco.tessore@axelsw.it
> Web site: www.axelsoftware.it
> 
> Le informazioni contenute in questo messaggio e negli eventuali allegati sono riservate e ad uso esclusivo del destinatario. Qualora abbiate ricevuto questo messaggio per errore, siete cortesemente pregati di darne immediata comunicazione al mittente e di provvedere alla sua distruzione. Grazie.
> (Regolamento Europeo Protezione dei Dati n. 2016/679 (“GDPR”)/D. Lgs 30.6.2003 n. 196)
> 
> The information contained in this e-mail and any attachments are confidential and are intended for the use of the individual or entity to which they are addressed. If you are not among the named recipients, please notify the sender immediately by reply e-mail and then delete this message from your system. Thank you.
> (Decree 196/2003 and Regulation (EU) 2016/679)
> 
> 
> -----Messaggio originale-----
> Da: Marco Tessore
> Inviato: lunedì 18 maggio 2020 11:13
> A: 'Jan Kiszka' <jan.kiszka@siemens.com>; Xenomai@xenomai.org
> Oggetto: R: About RTNet setup
> 
> Thank you Jan
> 
> 
> Marco Tessore
> 
> AXEL S.r.l.
> Via del Cannino, 3
> 21020 Crosio della Valle (VA) - ITALY
> Tel: +39 0332 949600
> Fax: +39 0332 969315
> E-mail: marco.tessore@axelsw.it
> Web site: www.axelsoftware.it
> 
> Le informazioni contenute in questo messaggio e negli eventuali allegati sono riservate e ad uso esclusivo del destinatario. Qualora abbiate ricevuto questo messaggio per errore, siete cortesemente pregati di darne immediata comunicazione al mittente e di provvedere alla sua distruzione. Grazie.
> (Regolamento Europeo Protezione dei Dati n. 2016/679 (“GDPR”)/D. Lgs 30.6.2003 n. 196)
> 
> The information contained in this e-mail and any attachments are confidential and are intended for the use of the individual or entity to which they are addressed. If you are not among the named recipients, please notify the sender immediately by reply e-mail and then delete this message from your system. Thank you.
> (Decree 196/2003 and Regulation (EU) 2016/679)
> 
> 
> -----Messaggio originale-----
> Da: Jan Kiszka <jan.kiszka@siemens.com>
> Inviato: lunedì 18 maggio 2020 10:57
> A: Marco Tessore <marco.tessore@axelsw.it>; Xenomai@xenomai.org
> Oggetto: Re: About RTNet setup
> 
> On 15.05.20 15:15, Marco Tessore via Xenomai wrote:
>> Good morning,
>> I'm working in a project where I need send and receive RAW ethernet packet in realtime.
>> I'm using a Xenomai 3.1 porting on an Ubuntu machine.
>> RTNet is enabled in the kernel as modules.
>>
>> The problem is that I don't really know how to setup the network in userspace.
>>
>> If this mailing list is not appropriate for the issue please tell me where I can write.
>>
>> The results of  rtifconfig is:
>> rteth0    Medium: Ethernet  Hardware address: 6C:B3:11:52:4C:E9
>>             IP address: 192.168.178.142  Broadcast address: 192.168.178.255
>>             UP BROADCAST RUNNING  MTU: 1500
>>             RX packets:0 errors:0 dropped:0 overruns:0 frame:0
>>             TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
>>             collisions:0
>>             RX bytes:0 (0.0 b)  TX bytes:0 (0.0 b)
>>
>> rtlo      Medium: Local Loopback
>>             IP address: 127.0.0.1
>>             UP LOOPBACK RUNNING  MTU: 1500
>>
>> So I tried rtping to ping another machine, in my network: that machine is not a realtime one, and rtping response is that there's no route to host.
>> The first question is: does the other machine need to run rtnet as well to respond to the rtping protocol, or it's simply a realtime implementation of the standard ping?
> 
> No, but ARP resolution of RTnet nodes work only on explicit request. You need to run "rtroute solicit <ip>" for that, or the other side needs to ping you.
> 
>>
>> The second question is: to send and receive custom ethernet frames
>> from a userspace process, What is the best configuration of rtnet.conf ? I don't really need rt-tcpip and I don't know how TDMA works.
>>
> 
> You don't rtnet.conf and the setup tool then. Just load the rtnet, rt_packet, and rt-<driver> modules (provided you unbound the target interface from the Linux driver already), run rtifconfig on the rteth0 interface, and then you can use AF_PACKET sockets from your RT applications.
> 
>> Third question is about the API to use: I'm trying to see the examples, but I'have some troubles to actually implement this.
> 
> See demo/posix/cobalt/eth_p_all.c or
> testsuite/smokey/net_packet_raw/packet_raw.c (not self-standing, though) for examples. Study "man 7 packet" for the raw interface (RTnet is widely compatible).
> 
> HTH,
> Jan
> 
> --
> Siemens AG, Corporate Technology, CT RDA IOT SES-DE Corporate Competence Center Embedded Linux
> 


-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

