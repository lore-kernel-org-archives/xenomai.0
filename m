MIME-Version: 1.0
From: Ashok kumar <ashokkumar.bb@gmail.com>
Date: Fri, 22 Jun 2018 19:01:50 +0530
Message-ID: <CAFUnMkm7qKccN+s19LPXH2++BOBfO=qvBYrtt=csKm5=e=XUDg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Xenomai] rtping not pinging in rtnet
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Xenomai@xenomai.org" <xenomai@xenomai.org>

Hi,

I have installed xenomai-3.0.5 and enabled rtnet
in /usr/xenomai/sbin
I started rtnet
rtnet start and I did

./rtifconfig and the output is

rteth0    Medium: Ethernet  Hardware address: 68:05:CA:2D:B4:0E
          IP address: 192.168.0.5  Broadcast address: 192.168.0.255
          UP BROADCAST RUNNING  MTU: 1500

rtlo      Medium: Local Loopback
          IP address: 127.0.0.1
          UP LOOPBACK RUNNING  MTU: 1500

but when I executed rtping to other system rtping is not working
./rtping 192.168.0.4

Real-time PING 192.168.0.4 56(84) bytes of data.
ioctl: No route to host

at the same time when the other system pings with rtnet system,

After other system pings or establishes connection my rtnet system gets
communication and starts pinging using ./rtping 192.168.0.4

I need to ping rtnet system without getting error

*Real-time PING 192.168.0.4 56(84) bytes of data.*
*ioctl: No route to host*


*kindly help me to solve this issue*


Thank you
Ashokkumar
