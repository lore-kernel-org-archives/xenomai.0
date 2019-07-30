MIME-Version: 1.0
From: Michael Smith <2michael.smith@gmail.com>
Date: Tue, 30 Jul 2019 15:07:12 +0200
Message-ID: <CANWkrRNq5k0sRnu2QZm5O_VQdkOHXO+Nc9T7WyDmUUMNuwH1zQ@mail.gmail.com>
Subject: Linux UDP and RTNet
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Xenomai@xenomai.org" <xenomai@xenomai.org>

Hi I've got a RTNet setup running with a TDMA-based network.
At the same time I try to send normal UDP packets on another non
real-time Linux NIC.
I get the error message "No route to host" when I try to do this.
As soon as I stop RTNet the non real-time NIC is able to send the UDP
packet normally.

I assume because RTNet is UDP based it sees all UDP packets as RTNet bound.
Is there a way arround this? Is it possible to send a non real-time
UDP packet on a 2nd non real-time NIC while RTNet is running?
I assume maybe by using rtroute something like this can work, but I'm
not sure how this will be done.

Thanks
Michael Smith

