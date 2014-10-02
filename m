MIME-Version: 1.0
In-Reply-To: <CANdzn7MgUYd6mBXu=W1joLXw1OHhw1x45FsstXsN4DwYey4CGw@mail.gmail.com>
References: <CANdzn7OYs4n0qjvpdKXM72cZM=AMy_1sBEVP7_P8S-56FJot3A@mail.gmail.com>
 <0d060e3cb01fa61faf28a22cf770bfd7@grandegger.com>
 <CANdzn7PYpjy-4h5upYf=39L-t+5dSQ0W1h6oW+UOHGJ+2=XJcg@mail.gmail.com>
 <CANdzn7OmiO_7T2bQN-VH=hwBAnz7TRQBtyn=hZaknB5CfxZRTw@mail.gmail.com>
 <CAKuM+oJ=SPaUGiUWMX2+8NwtEOSCtLOf+0EX9osyOQ0Oze2gpQ@mail.gmail.com>
 <CANdzn7MgUYd6mBXu=W1joLXw1OHhw1x45FsstXsN4DwYey4CGw@mail.gmail.com>
Date: Thu, 2 Oct 2014 16:16:11 +0300
Message-ID: <CANdzn7M1hz-7bprLOk=J2CYGp7vy+3gG0+x9jpN-a7pvSLoFrQ@mail.gmail.com>
From: Jason Sarantopoulos <jasonsaras@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] Xenomai and CAN
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?UTF-8?Q?Adolfo_Rodr=C3=ADguez_Tsouroukdissian?= <adolfo.rodriguez@pal-robotics.com>
Cc: xenomai <xenomai@xenomai.org>

Hi again,

I have a project in my mind, but I am not very sure if it's feasible. I
have the PCAN-PCI with the Xenomai patched kernel. I want to communicate
with a robot in real time via CAN bus, so I guess I have to write an
application that will send and receive CAN messages. But I want this
application to be connected with ROS, which is not real time. Is it
possible to write an application in C++ to control the robot in real time,
but also integrated with ROS, in case I want to communicate with other
devices via ROS?

For instance, having a real time control loop for the robot, but in the
same time be able to communicate via ROS if I want to, would be great.

I just need to know if it is possible and if there are any tutorials or
some kind of guidance.

Regards,
-- 
*Jason Sarantopoulos*
