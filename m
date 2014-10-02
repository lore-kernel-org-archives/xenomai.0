MIME-Version: 1.0
Sender: dofo79@gmail.com
In-Reply-To: <CANdzn7M1hz-7bprLOk=J2CYGp7vy+3gG0+x9jpN-a7pvSLoFrQ@mail.gmail.com>
References: <CANdzn7OYs4n0qjvpdKXM72cZM=AMy_1sBEVP7_P8S-56FJot3A@mail.gmail.com>
 <0d060e3cb01fa61faf28a22cf770bfd7@grandegger.com>
 <CANdzn7PYpjy-4h5upYf=39L-t+5dSQ0W1h6oW+UOHGJ+2=XJcg@mail.gmail.com>
 <CANdzn7OmiO_7T2bQN-VH=hwBAnz7TRQBtyn=hZaknB5CfxZRTw@mail.gmail.com>
 <CAKuM+oJ=SPaUGiUWMX2+8NwtEOSCtLOf+0EX9osyOQ0Oze2gpQ@mail.gmail.com>
 <CANdzn7MgUYd6mBXu=W1joLXw1OHhw1x45FsstXsN4DwYey4CGw@mail.gmail.com>
 <CANdzn7M1hz-7bprLOk=J2CYGp7vy+3gG0+x9jpN-a7pvSLoFrQ@mail.gmail.com>
Date: Thu, 2 Oct 2014 17:15:38 +0200
Message-ID: <CAKuM+o+SRFk-FYC=Fc1N9sZu=WjOe3+P5ZTXDZZvhx9nS6TgWg@mail.gmail.com>
From: =?UTF-8?Q?Adolfo_Rodr=C3=ADguez_Tsouroukdissian?=
 <adolfo.rodriguez@pal-robotics.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Xenomai and CAN
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jason Sarantopoulos <jasonsaras@gmail.com>
Cc: xenomai <xenomai@xenomai.org>

On Thu, Oct 2, 2014 at 3:16 PM, Jason Sarantopoulos <jasonsaras@gmail.com>
wrote:

> Hi again,
>
> I have a project in my mind, but I am not very sure if it's feasible. I
> have the PCAN-PCI with the Xenomai patched kernel. I want to communicate
> with a robot in real time via CAN bus, so I guess I have to write an
> application that will send and receive CAN messages. But I want this
> application to be connected with ROS, which is not real time. Is it
> possible to write an application in C++ to control the robot in real time=
,
> but also integrated with ROS, in case I want to communicate with other
> devices via ROS?
>
> For instance, having a real time control loop for the robot, but in the
> same time be able to communicate via ROS if I want to, would be great.
>

Jason,

The ROS side of the question is pretty much out of the scope of this list.
Still, what you want is possible. If you're interested in leveraging
robotics-specific projects that can play nice with Xenomai and ROS,
consider taking a look at the Orocos RTT and/or ros_control projects.


> I just need to know if it is possible and if there are any tutorials or
> some kind of guidance.
>

Orocos RTT has very comprehensive documentation [1]. You can find a general
overview of ros_control in this talk [2,3] (disclaimer: I gave the talk).

[1]
http://people.mech.kuleuven.be/~orocos/pub/stable/documentation/rtt/v1.0.x/=
doc-xml/orocos-components-manual.html
[2] slides:
http://roscon.ros.org/2014/wp-content/uploads/2014/07/ros_control_an_overvi=
ew.pdf
[3] video: https://vimeo.com/107507546

Hope this helps,


> Regards,
> --
> *Jason Sarantopoulos*
>

--=20
Adolfo Rodr=C3=ADguez Tsouroukdissian
Senior robotics engineer
adolfo.rodriguez@pal-robotics.com
http://www.pal-robotics.com

PAL ROBOTICS S.L
c/ Pujades 77-79, 4=C2=BA4=C2=AA
08005 Barcelona, Spain.

CONFIDENTIALITY NOTICE: This e-mail and the accompanying document(s) may
contain confidential information which is privileged and intended only for
the individual or entity to whom they are addressed.  If you are not the
intended recipient, you are hereby notified that any disclosure, copying,
distribution or use of this e-mail and/or accompanying document(s) is
strictly prohibited.  If you have received this e-mail in error, please
immediately notify the sender at the above e-mail address.
