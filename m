From: Johannes Holtz <johannes.holtz@compador.de>
Subject: RTnet default behavior
Message-ID: <b89e46e4-45b8-1fc1-cb0d-2c4d44b07eb7@compador.de>
Date: Fri, 18 Oct 2019 16:10:43 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi ,

I inherited a project where the RTnet stack is loaded manually at boot 
time. To be specific. Instead of using the rtnet command line programs 
the rtnet.ko kernel object as well as the necessary drivers are loaded 
with insmod. The devices are then brought up with rtifconfig and rtroute.

The network consist of 7 PCs (all with the same boot time mechanism) 
with pre-defined IPs. The setup works and initializes in an 
asynchronized way (like a typical non-RT network).

I'm investigating some performance problems and I don't know whats is 
really going on since no config is used. How is determined which 
participant is acting as Master and how the slots are distributed? What 
are the default values?

Also: The RTmac readme says a slot "transmits a single packet of up to a 
specific maximum size". I like to know what that size is and what the 
behavior is when I have many much smaller datagrams queued. Will they be 
distributed over as many cycles? And also what happens if I send a 
datagram which is much bigger. Is there an MTU?

Cheers,

Johannes




