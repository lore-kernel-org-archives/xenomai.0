Message-ID: <511CD812.9040407@control.lth.se>
Date: Thu, 14 Feb 2013 13:26:58 +0100
From: Anders Blomdell <anders.blomdell@control.lth.se>
MIME-Version: 1.0
References: <A7B6C93529C6D844895F37ADAB8DF0AC5D7097AB@ictsrv010.ICT.TUWIEN.AC.AT>
In-Reply-To: <A7B6C93529C6D844895F37ADAB8DF0AC5D7097AB@ictsrv010.ICT.TUWIEN.AC.AT>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Analogy DIO execution time and timing behavior
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Martin Pongratz <pongratz@ict.tuwien.ac.at>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 2013-02-14 12:33, Martin Pongratz wrote:
> Hello,
>
> I'm planning to use a NI DAQ-card (PCI-622x) with Xenomai and Analogy.
Expensive digital out :-;, wouldn't a parallell-port card do the trick?

>
> The idea is to synchronize a camera setup with a robot. The robot is controlled via UDP-packets that are transmitted periodically with a cycle-time of 1 ms. The initiator of this communication is the robot controller (KUKA FRI setup with LWR 4+ robot). With every 20th datagram a camera setup shall be triggered via the DAQ-card. The delay between the data-transfer and the trigger-activation should be minimal or at least known with a reasonable small jitter (magnitudes smaller than 1 ms).
>
> But before buying the card I'd like to have some information about the timing-performance of this setup:
>
> 1)      What execution time (or magnitude of execution time) for DIO, especially output, from command execution until change of signal on the output can be achieved?
>
> 2)      How much jitter in this execution time can be expected?
10-50 us in my experience (provided you get the Ethernet packets via RTNet)

>
> Thanks and BR
> Martin Pongratz
> --
> DI Martin Pongratz
> University Assistant
>
> Robotics & Automation Group
> Vienna University of Technology
> Institute of Computer Technology
> phn +43 1 58801 38435
> fax +43 1 58801 38499
> http://www.ict.tuwien.ac.at<http://www.ict.tuwien.ac.at/>
>
> DVR:0005886
>
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> http://www.xenomai.org/mailman/listinfo/xenomai
>


-- 
Anders Blomdell                  Email: anders.blomdell@control.lth.se
Department of Automatic Control
Lund University                  Phone:    +46 46 222 4625
P.O. Box 118                     Fax:      +46 46 138118
SE-221 00 Lund, Sweden


