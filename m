From: "Bradley Valdenebro Peter (DC-AE/EHP2)"
 <Peter.BradleyValdenebro@boschrexroth.nl>
Date: Thu, 30 Aug 2018 09:49:46 +0000
Message-ID: <d3673e3b3ef541a59dc6df0e9f884558@boschrexroth.nl>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] IPC between RT and nRT
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hello all,
We work in motion control. We execute our system on a zynq-7020. We are doi=
ng some redesign on our system.

We have our control loop executing as a Xenomai RT thread at 8kHz. This is =
our highest priority thread.
We have the need to transfer around 512 bytes every sample from the Xenomai=
 RT task to a Linux NR task that will later send that info through Ethernet=
 using UDP.
We are currently using RT pipes to transfer that data but we would like to =
reduce the processing time of the data  as much as possible.

We see RT pipes as the only mechanism for RT-nRT communication. Is there a =
reason for this?
Is using shared memory between RT and nRT or other kind of IPC better suite=
d for this?
By using shared memory I guess we would force some secondary switches but i=
t might be worthwhile, right?

What is your opinion on this?

Best regards,

Peter Bradley
