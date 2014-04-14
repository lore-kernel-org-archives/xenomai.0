MIME-Version: 1.0
Date: Mon, 14 Apr 2014 17:00:35 +0100
Message-ID: <CAEbDrgmNLfVeJPDBznzLBdZzm7zh94moOxduObAKznH-+2rz3Q@mail.gmail.com>
From: Gregory Dymarek <gregd72002@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Xenomai] Xenomai and USB input
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi,

I'm trying to understand the impact of using USB device as input for
Xenomai implementation.

The setup is:
- controller running linux 3.10 (xenomai 2.6) on ARM
- GPIO output
- GPIO input
- USB input

My current thinking is to create 4 threads, one of each: the
controller, GPIO out, GPIO in, USB in.

The controller, GPIO input and output have to be pretty much in sync
and running together at the same rate (i.e. 50Hz). There is no hard
constrain on the USB input but would need to be read at least at half
the rate of the controller rate.

How does reading the USB device affect the setup, are there any
problems with it?
Also, could someone provide some guidelines on what the best setup
would be please?

Thanks,
Gregory

