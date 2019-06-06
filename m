Subject: Re: Round-Trip Time Requester with Xenomai / RTnet on Beaglebone Black
References: <CAEmXcAzOL4M-JRUWgm3mjmz+bQ=nHc-QW5dr-iBc24RXXu5CTg@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <320b1c56-047f-764f-036a-d3302ddbd0f4@siemens.com>
Date: Thu, 6 Jun 2019 08:06:07 +0200
MIME-Version: 1.0
In-Reply-To: <CAEmXcAzOL4M-JRUWgm3mjmz+bQ=nHc-QW5dr-iBc24RXXu5CTg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: danwe <daniel.wenninger92@gmail.com>, xenomai@xenomai.org

On 05.06.19 12:30, danwe via Xenomai wrote:
> Hello,
> 
> I am using two Beaglebone Black with Linux kernel version 3.8.13 and
> Xenomai version 2.6.3. I have built the Kernel with Xenomai and RTnet with

Why did you choose these old versions? The problem might be unrelated, but it's 
now impossible for us to reproduce easily.

Where did you get the RTnet Ethernet driver from? It's not upstream as far as I 
know. Was that source the reason for this version choice?

> buildroot. At the moment I am trying to use the provided source-files
> "rtt-sender" and "rtt-responder" for sending some "Round-Trip Time Request".
> I have changed my destination IP in "rtt-responder" to my destination BBB.
> I did not do any other changes. Then I did run "rtt-responder" on BBB2 and
> "rtt-sender" on BBB1 but I always get the following error:
> [image: image.png]

Better copy&paste the text from the console than taking screenshots.

The error messages could indicate that those tools are trying to use regular 
Linux sockets, not RTnet ones. Did you compile them manually, or where they 
built by the Xenomai build system? Check if they refer to symbols like 
"__wrap_socket", rather than just "socket".

Jan

> Can anyone tell me why I do get that error?
> In order to this I need to say that both BBB's get a random MAC-Adress
> after each boot. That means I need to tell each BBB which MAC adress
> belongs to which IP-Adress. For example BBB1 has IP 192.168.127.10 with MAC
> AA:AA:AA:AA:AA and BBB2 has IP 192.168.127.11 with MAC BB:BB:BB:BB:BB I
> need to execute the following commands:
> 
> For BBB1: rtroute add 192.168.127.11 BB:BB:BB:BB:BB dev rteth0
> For BBB2: rtroute add 192.168.127.10 AA:AA:AA:AA:AA dev rteth0
> 
> Now it is possible to send rtpings with the command: rtping 192.168.127.10
> or rtping 192.168.127.11. Depens on which BBB you want to send the ping.
> 
> So my idea was it is only possible to run the "rtt-sender" and
> "rtt-responder" file when my BBB's know which MAC belongs to which IP.
> 
> But there is still the error, that the Network is unreachable. Why?
> 
> You can find the source-files enclosed.
> 
> Kind Regards
> -------------- next part --------------
> A non-text attachment was scrubbed...
> Name: image.png
> Type: image/png
> Size: 13271 bytes
> Desc: not available
> URL: <http://xenomai.org/pipermail/xenomai/attachments/20190605/8613c6ca/attachment.png>
> -------------- next part --------------
> A non-text attachment was scrubbed...
> Name: rtt-sender.c
> Type: application/octet-stream
> Size: 9879 bytes
> Desc: not available
> URL: <http://xenomai.org/pipermail/xenomai/attachments/20190605/8613c6ca/attachment.obj>
> -------------- next part --------------
> A non-text attachment was scrubbed...
> Name: rtt-responder.c
> Type: application/octet-stream
> Size: 5705 bytes
> Desc: not available
> URL: <http://xenomai.org/pipermail/xenomai/attachments/20190605/8613c6ca/attachment-0001.obj>
> 

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

