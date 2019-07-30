Subject: Re: Linux UDP and RTNet
References: <CANWkrRNq5k0sRnu2QZm5O_VQdkOHXO+Nc9T7WyDmUUMNuwH1zQ@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <b43d0dd5-c4bf-4145-f155-b05dfbbf903e@siemens.com>
Date: Tue, 30 Jul 2019 16:24:24 +0200
MIME-Version: 1.0
In-Reply-To: <CANWkrRNq5k0sRnu2QZm5O_VQdkOHXO+Nc9T7WyDmUUMNuwH1zQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
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
To: Michael Smith <2michael.smith@gmail.com>, "Xenomai@xenomai.org" <xenomai@xenomai.org>

On 30.07.19 15:07, Michael Smith via Xenomai wrote:
> Hi I've got a RTNet setup running with a TDMA-based network.
> At the same time I try to send normal UDP packets on another non
> real-time Linux NIC.

How do you try this? With a Xenomai application that opens a UDP socket? Then
you have to ensure that it does that using the non-RT APIs, e.g. by wrapping the
socket call: __STD(socket(...));

Jan

> I get the error message "No route to host" when I try to do this.
> As soon as I stop RTNet the non real-time NIC is able to send the UDP
> packet normally.
> 
> I assume because RTNet is UDP based it sees all UDP packets as RTNet bound.
> Is there a way arround this? Is it possible to send a non real-time
> UDP packet on a 2nd non real-time NIC while RTNet is running?
> I assume maybe by using rtroute something like this can work, but I'm
> not sure how this will be done.
> 
> Thanks
> Michael Smith
> 

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

