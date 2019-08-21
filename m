Subject: Re: RTNet - vnic0 question
References: <CAPm8-H6txhsFDDepfGEG48S1anF03F1=tBsEiLfkRiPHi7KKxA@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <7f20a51d-e1c2-b95e-ab17-d18338bbcec2@siemens.com>
Date: Wed, 21 Aug 2019 18:59:25 +0200
MIME-Version: 1.0
In-Reply-To: <CAPm8-H6txhsFDDepfGEG48S1anF03F1=tBsEiLfkRiPHi7KKxA@mail.gmail.com>
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
To: Laurentiu-Cristian Duca <laurentiu.duca@gmail.com>, xenomai <xenomai@xenomai.org>

On 21.08.19 16:20, Laurentiu-Cristian Duca via Xenomai wrote:
> Hello rtnet community,
> 
>    I successfully tested the examples rtt-sender and rtt-responder
> within a rtnet made from one beaglebone black and one qemu-x86_64-8139too,
> with tdma and also with nomac.

Are we talking about some legacy Xenomai or even RTnet version? Or where did you 
get the examples from? They are not part of RTnet in Xenomai 3.

> 
>    I have noted that the presence of vnic0 as an up and fully
> configured interface is mandatory,
> even if rteth0 is up and fully configured.
> Otherwise the rtt-sender announces "sendto failed: Network is unreachable".
> Could anybody tell me why is this happening?
> 
>    I have also noted that if I disable vnic0 (ifconfig vnic0 down),
> rtping works if rteth0 is up and fully configured.
> Why does not work rtt-sender in this case?
> Could it be a problem with rtnet drivers?

I bet your examples are falling back to normal network here, and that is 
provided between your test nodes via the vnics. This leads to my first question: 
Where did you pick the examples up, how did you build them etc.? Also, did you 
make sure that rtudp was loaded?

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

